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

    // ==================== CORE: SePay -> PaymentTransaction -> Process ====================

    public boolean processPayment(SepayTransaction sepay) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            // 1. Find pending PaymentTransaction matching transfer content
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

            // 2. Check amount
            if (sepay.getTransferAmount() < matchedTrans.getAmount()) return false;

            tx.begin();

            // 3. Update PaymentTransaction -> Paid
            matchedTrans.setStatus("Paid");
            matchedTrans.setPaidDate(new Date());
            matchedTrans.setSePayReference(sepay.getReferenceCode());
            matchedTrans.setPaymentGateway(sepay.getGateway());
            em.merge(matchedTrans);

            String transCode = matchedTrans.getTransactionCode();

            // 4. Handle based on prefix
            if (transCode.startsWith("ORD")) {
                // ORDER payment - update Order status
                if (matchedTrans.getOrderId() != null) {
                    com.dananghub.entity.Order order = em.find(com.dananghub.entity.Order.class, matchedTrans.getOrderId());
                    if (order != null) {
                        order.setPaymentStatus("Paid");
                        order.setOrderStatus("Confirmed");
                        order.setUpdatedAt(new Date());
                        em.merge(order);
                    }
                }
            } else if (transCode.startsWith("PRJ")) {
                // SUBSCRIPTION payment - activate plan
                if (matchedTrans.getPlanId() != null) {
                    SubscriptionPlan plan = em.find(SubscriptionPlan.class, matchedTrans.getPlanId());
                    if (plan != null) {
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
                    }
                }
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
}
