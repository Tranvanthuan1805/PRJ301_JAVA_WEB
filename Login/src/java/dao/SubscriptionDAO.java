package dao;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import model.PaymentTransaction;
import model.ProviderSubscription;
import model.SePayTransaction;
import model.SubscriptionPlan;
import java.util.Date;
import java.util.Calendar;

public class SubscriptionDAO {

    private static EntityManagerFactory emf;

    static {
        try {
            emf = Persistence.createEntityManagerFactory("SubscriptionPU");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public List<SubscriptionPlan> getAllPlans() {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery("SELECT p FROM SubscriptionPlan p WHERE p.isActive = true", SubscriptionPlan.class)
                     .getResultList();
        } finally {
            em.close();
        }
    }

    public SubscriptionPlan getPlanById(int planId) {
        EntityManager em = getEntityManager();
        try {
            return em.find(SubscriptionPlan.class, planId);
        } finally {
            em.close();
        }
    }

    public ProviderSubscription getCurrentSubscription(int userId) {
        EntityManager em = getEntityManager();
        try {
            // Get highest priced active subscription (Elite > Pro > Explorer)
            List<ProviderSubscription> results = em.createQuery(
                "SELECT s FROM ProviderSubscription s JOIN FETCH s.plan WHERE s.getUserId() = :uid AND s.status = 'Active' AND s.endDate > :now ORDER BY s.plan.price DESC", 
                ProviderSubscription.class)
                .setParameter("uid", userId)
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

    public List<ProviderSubscription> getSubscriptionHistory(int userId) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                "SELECT s FROM ProviderSubscription s JOIN FETCH s.plan WHERE s.getUserId() = :uid ORDER BY s.startDate DESC", 
                ProviderSubscription.class)
                .setParameter("uid", userId)
                .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    public void createTransaction(PaymentTransaction trans) {
        EntityManager em = getEntityManager();
        EntityTransaction et = em.getTransaction();
        try {
            et.begin();
            em.persist(trans);
            et.commit();
        } catch (Exception e) {
            if (et.isActive()) et.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
    
    // Used for checking status from frontend polling
    public PaymentTransaction getTransactionByCode(String code) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery("SELECT t FROM PaymentTransaction t WHERE t.transactionCode = :code", PaymentTransaction.class)
                     .setParameter("code", code)
                     .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public void saveSePayTransaction(SePayTransaction sepayTrans) {
        EntityManager em = getEntityManager();
        EntityTransaction et = em.getTransaction();
        try {
            et.begin();
            // Check if exists to avoid duplicates (idempotency)
            SePayTransaction existing = em.find(SePayTransaction.class, sepayTrans.getId());
            if (existing == null) {
                em.persist(sepayTrans);
            }
            et.commit();
        } catch (Exception e) {
            if (et.isActive()) et.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // This is the core logic: Match SePay -> PaymentTransaction -> Activate Subscription
    public boolean processPayment(SePayTransaction sepay) {
        EntityManager em = getEntityManager();
        EntityTransaction et = em.getTransaction();
        
        try {
            // 1. Find the internal transaction based on content
            String content = sepay.getContent();
            if (content == null) content = "";
            
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DAY_OF_YEAR, -3); // Look back 3 days
            Date cutoff = cal.getTime();
            
            List<PaymentTransaction> pendingList = em.createQuery(
                "SELECT t FROM PaymentTransaction t WHERE t.status = 'Pending' AND t.createdDate > :cutoff", 
                PaymentTransaction.class)
                .setParameter("cutoff", cutoff)
                .getResultList();
                
            PaymentTransaction trans = null;
            for (PaymentTransaction t : pendingList) {
                // Check if the bank transfer content contains our unique transaction code
                // Safety check for null code
                if (t.getTransactionCode() != null && content.contains(t.getTransactionCode())) {
                    trans = t;
                    break;
                }
            }
            
            if (trans == null) {
                return false;
            }

            // 2. Verify Amount
            if (sepay.getTransferAmount() < trans.getAmount()) {
                return false;
            }

            et.begin();

            // 3. Update Transaction to Paid
            trans.setStatus("Paid");
            trans.setPaidDate(new Date());
            trans.setSePayReference(sepay.getReferenceCode());
            trans.setPaymentGateway(sepay.getGateway());
            em.merge(trans);

            // 4. Create/Activate Subscription
            SubscriptionPlan plan = em.find(SubscriptionPlan.class, trans.getPlanId());
            
            // Calculate End Date
            cal.add(Calendar.DAY_OF_YEAR, plan.getDurationDays());
            
            ProviderSubscription sub = new ProviderSubscription();
            sub.setUserId(trans.getUserId());
            sub.setPlan(plan);
            sub.setStartDate(new Date());
            sub.setEndDate(cal.getTime());
            sub.setStatus("Active");
            sub.setPaymentStatus("Paid");
            sub.setAmount(trans.getAmount());
            
            em.persist(sub);
            
            et.commit();
            return true;

        } catch (Exception e) {
            if (et.isActive()) et.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
}
