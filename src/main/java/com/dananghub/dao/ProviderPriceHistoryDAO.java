package com.dananghub.dao;

import com.dananghub.entity.ProviderPriceHistory;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * ====================================================
 * MODULE 1: QUAN TRI NHA CUNG CAP - Le Phuoc Sang
 * ====================================================
 * DAO cho bang ProviderPriceHistory
 * ====================================================
 */
public class ProviderPriceHistoryDAO {

    private static final Logger logger = Logger.getLogger(ProviderPriceHistoryDAO.class.getName());

    // Them 1 ban ghi gia moi
    public void insert(ProviderPriceHistory price) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(price);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive())
                tx.rollback();
            logger.log(Level.SEVERE, "Error inserting price history", e);
        } finally {
            em.close();
        }
    }

    // Lay lich su gia cua 1 NCC
    public List<ProviderPriceHistory> findByProviderId(int providerId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT p FROM ProviderPriceHistory p WHERE p.provider.providerId = :pid ORDER BY p.changeDate DESC",
                    ProviderPriceHistory.class).setParameter("pid", providerId).getResultList();
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error finding price history by provider ID: " + providerId, e);
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    // Lay lich su gia theo loai dich vu (de so sanh giua cac NCC)
    public List<ProviderPriceHistory> findByServiceType(String serviceType) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT p FROM ProviderPriceHistory p WHERE p.serviceType = :type ORDER BY p.changeDate DESC",
                    ProviderPriceHistory.class).setParameter("type", serviceType).getResultList();
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error finding price history by service type: " + serviceType, e);
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    // So sanh gia giua cac NCC cho cung 1 loai dich vu
    public List<ProviderPriceHistory> comparePrice(String serviceType, String serviceName) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // Lay gia moi nhat cua moi provider cho service type va service name cu the
            String jpql = "SELECT p FROM ProviderPriceHistory p " +
                    "WHERE p.serviceType = :type AND p.serviceName = :name " +
                    "AND p.changeDate = (" +
                    "  SELECT MAX(p2.changeDate) FROM ProviderPriceHistory p2 " +
                    "  WHERE p2.provider.providerId = p.provider.providerId " +
                    "  AND p2.serviceType = :type AND p2.serviceName = :name" +
                    ") " +
                    "ORDER BY p.newPrice ASC";

            return em.createQuery(jpql, ProviderPriceHistory.class)
                    .setParameter("type", serviceType)
                    .setParameter("name", serviceName)
                    .getResultList();
        } catch (Exception e) {
            logger.log(Level.SEVERE,
                    "Error comparing prices for service type: " + serviceType + ", service name: " + serviceName, e);
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    // Lay gia moi nhat cua 1 NCC cho 1 dich vu
    public ProviderPriceHistory getLatestPrice(int providerId, String serviceName) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            List<ProviderPriceHistory> results = em.createQuery(
                    "SELECT p FROM ProviderPriceHistory p " +
                            "WHERE p.provider.providerId = :pid AND p.serviceName = :name " +
                            "ORDER BY p.changeDate DESC",
                    ProviderPriceHistory.class)
                    .setParameter("pid", providerId)
                    .setParameter("name", serviceName)
                    .setMaxResults(1)
                    .getResultList();

            return results.isEmpty() ? null : results.get(0);
        } catch (Exception e) {
            logger.log(Level.SEVERE,
                    "Error getting latest price for provider ID: " + providerId + ", service name: " + serviceName, e);
            return null;
        } finally {
            em.close();
        }
    }
}
