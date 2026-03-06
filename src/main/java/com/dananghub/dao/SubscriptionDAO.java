package com.dananghub.dao;

import com.dananghub.entity.PaymentTransaction;
import com.dananghub.entity.ProviderSubscription;
import com.dananghub.entity.SepayTransaction;
import com.dananghub.entity.SubscriptionPlan;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class SubscriptionDAO {

    // ==================== SubscriptionPlan ====================

    public List<SubscriptionPlan> findAllPlans() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT p FROM SubscriptionPlan p WHERE p.isActive = true ORDER BY p.price",
                SubscriptionPlan.class)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public SubscriptionPlan findPlanById(int planId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(SubscriptionPlan.class, planId);
        } finally {
            em.close();
        }
    }

    public SubscriptionPlan findPlanByCode(String planCode) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT p FROM SubscriptionPlan p WHERE p.planCode = :code",
                SubscriptionPlan.class)
                .setParameter("code", planCode)
                .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    // ==================== ProviderSubscription ====================

    public ProviderSubscription findActiveSubscription(int providerId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            List<ProviderSubscription> results = em.createQuery(
                "SELECT s FROM ProviderSubscription s WHERE s.provider.providerId = :pid " +
                "AND s.isActive = true AND s.endDate > :now ORDER BY s.plan.price DESC",
                ProviderSubscription.class)
                .setParameter("pid", providerId)
                .setParameter("now", new Date())
                .setMaxResults(1)
                .getResultList();
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    public List<ProviderSubscription> findByProvider(int providerId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT s FROM ProviderSubscription s WHERE s.provider.providerId = :pid ORDER BY s.startDate DESC",
                ProviderSubscription.class)
                .setParameter("pid", providerId)
                .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    public boolean createSubscription(ProviderSubscription sub) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(sub);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean updateSubscription(ProviderSubscription sub) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(sub);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // ==================== PaymentTransaction ====================

    public boolean createTransaction(PaymentTransaction pt) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(pt);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public PaymentTransaction findTransactionByCode(String code) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT t FROM PaymentTransaction t WHERE t.transactionCode = :code",
                PaymentTransaction.class)
                .setParameter("code", code)
                .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    // ==================== SePay ====================

    public boolean saveSepayTransaction(SepayTransaction st) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            SepayTransaction existing = em.find(SepayTransaction.class, st.getId());
            if (existing == null) {
                em.persist(st);
            }
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // ==================== CORE: SePay -> PaymentTransaction -> Activate Subscription ====================

    public boolean processPayment(SepayTransaction sepay) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            // 1. Tim PaymentTransaction dang Pending khop voi noi dung chuyen khoan
            String content = sepay.getContent();
            if (content == null) content = "";

            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DAY_OF_YEAR, -3);
            Date cutoff = cal.getTime();

            List<PaymentTransaction> pendingList = em.createQuery(
                "SELECT t FROM PaymentTransaction t WHERE t.status = 'Pending' AND t.createdDate > :cutoff",
                PaymentTransaction.class)
                .setParameter("cutoff", cutoff)
                .getResultList();

            PaymentTransaction matchedTrans = null;
            for (PaymentTransaction t : pendingList) {
                if (t.getTransactionCode() != null && content.contains(t.getTransactionCode())) {
                    matchedTrans = t;
                    break;
                }
            }

            if (matchedTrans == null) return false;

            // 2. Kiem tra so tien
            if (sepay.getTransferAmount() < matchedTrans.getAmount()) return false;

            tx.begin();

            // 3. Cap nhat PaymentTransaction -> Paid
            matchedTrans.setStatus("Paid");
            matchedTrans.setPaidDate(new Date());
            matchedTrans.setSePayReference(sepay.getReferenceCode());
            matchedTrans.setPaymentGateway(sepay.getGateway());
            em.merge(matchedTrans);

            // 4. Tao/Kich hoat ProviderSubscription
            SubscriptionPlan plan = em.find(SubscriptionPlan.class, matchedTrans.getPlanId());

            cal = Calendar.getInstance();
            cal.add(Calendar.DAY_OF_YEAR, plan.getDurationDays());

            ProviderSubscription sub = new ProviderSubscription();
            sub.setProvider(em.find(com.dananghub.entity.Provider.class, matchedTrans.getUserId()));
            sub.setPlan(plan);
            sub.setStartDate(new Date());
            sub.setEndDate(cal.getTime());
            sub.setStatus("Active");
            sub.setPaymentStatus("Paid");
            sub.setAmount(matchedTrans.getAmount());
            sub.setActive(true);

            em.persist(sub);

            tx.commit();
            return true;

        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // ==================== Subscription Expiry ====================

    public int deactivateExpiredSubscriptions() {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            int count = em.createQuery(
                "UPDATE ProviderSubscription s SET s.isActive = false, s.status = 'Expired' " +
                "WHERE s.isActive = true AND s.endDate < :now")
                .setParameter("now", new Date())
                .executeUpdate();
            tx.commit();
            return count;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }
}
