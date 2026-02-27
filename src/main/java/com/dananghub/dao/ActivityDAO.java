package com.dananghub.dao;

import com.dananghub.entity.CustomerActivity;
import com.dananghub.entity.InteractionHistory;
import com.dananghub.entity.AILog;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.List;

public class ActivityDAO {

    // ==================== CustomerActivity ====================

    public boolean logActivity(CustomerActivity activity) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(activity);
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

    public List<CustomerActivity> findActivitiesByCustomer(int customerId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT ca FROM CustomerActivity ca WHERE ca.customerId = :cid ORDER BY ca.createdAt DESC",
                CustomerActivity.class)
                .setParameter("cid", customerId)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<CustomerActivity> findActivitiesByCustomer(int customerId, int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT ca FROM CustomerActivity ca WHERE ca.customerId = :cid ORDER BY ca.createdAt DESC",
                CustomerActivity.class)
                .setParameter("cid", customerId)
                .setMaxResults(limit)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<CustomerActivity> filterByActionType(int customerId, String actionType, int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT ca FROM CustomerActivity ca WHERE ca.customerId = :cid AND ca.actionType = :type ORDER BY ca.createdAt DESC",
                CustomerActivity.class)
                .setParameter("cid", customerId)
                .setParameter("type", actionType)
                .setMaxResults(limit)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public long countActivities(int customerId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT COUNT(ca) FROM CustomerActivity ca WHERE ca.customerId = :cid", Long.class)
                .setParameter("cid", customerId)
                .getSingleResult();
        } finally {
            em.close();
        }
    }

    public long countActivitiesByType(int customerId, String actionType) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT COUNT(ca) FROM CustomerActivity ca WHERE ca.customerId = :cid AND ca.actionType = :type",
                Long.class)
                .setParameter("cid", customerId)
                .setParameter("type", actionType)
                .getSingleResult();
        } finally {
            em.close();
        }
    }

    // ==================== InteractionHistory ====================

    public boolean logInteraction(InteractionHistory ih) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(ih);
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

    public List<InteractionHistory> findInteractionsByCustomer(int customerId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT ih FROM InteractionHistory ih WHERE ih.customerId = :cid ORDER BY ih.createdAt DESC",
                InteractionHistory.class)
                .setParameter("cid", customerId)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<InteractionHistory> findRecentInteractions(int customerId, int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT ih FROM InteractionHistory ih WHERE ih.customerId = :cid ORDER BY ih.createdAt DESC",
                InteractionHistory.class)
                .setParameter("cid", customerId)
                .setMaxResults(limit)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<InteractionHistory> findAllInteractions() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT ih FROM InteractionHistory ih ORDER BY ih.createdAt DESC",
                InteractionHistory.class)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public boolean deleteInteraction(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            InteractionHistory ih = em.find(InteractionHistory.class, id);
            if (ih != null) {
                em.remove(ih);
                tx.commit();
                return true;
            }
            tx.rollback();
            return false;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // ==================== AILog ====================

    public boolean logAI(AILog log) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(log);
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

    public List<AILog> findAILogsByUser(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT a FROM AILog a WHERE a.userId = :uid ORDER BY a.createdAt DESC",
                AILog.class)
                .setParameter("uid", userId)
                .getResultList();
        } finally {
            em.close();
        }
    }
}
