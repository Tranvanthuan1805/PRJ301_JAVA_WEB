package com.dananghub.dao;

/**
 * ====================================================
 * MODULE 1: QUAN TRI NHA CUNG CAP - Le Phuoc Sang
 * ====================================================
 * DAO cho bang ProviderPriceHistory
 *
 * TODO cho Sang:
 *   1. Hoan thien cac method ben duoi
 *   2. Them method so sanh gia giua cac NCC cung loai dich vu
 *   3. Them method lay gia moi nhat cua 1 NCC
 *   4. Them method thong ke bien dong gia theo thoi gian
 * ====================================================
 */

import com.dananghub.entity.ProviderPriceHistory;
import jakarta.persistence.*;
import java.util.List;

public class ProviderPriceHistoryDAO {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("DaNangTravelHubPU");

    // TODO Sang: Them 1 ban ghi gia moi
    public void insert(ProviderPriceHistory price) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(price);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    // TODO Sang: Lay lich su gia cua 1 NCC
    public List<ProviderPriceHistory> findByProviderId(int providerId) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery(
                "SELECT p FROM ProviderPriceHistory p WHERE p.provider.providerId = :pid ORDER BY p.changeDate DESC",
                ProviderPriceHistory.class
            ).setParameter("pid", providerId).getResultList();
        } finally {
            em.close();
        }
    }

    // TODO Sang: Lay lich su gia theo loai dich vu (de so sanh giua cac NCC)
    public List<ProviderPriceHistory> findByServiceType(String serviceType) {
        // TODO: Implement - SELECT ... WHERE serviceType = ? ORDER BY changeDate
        return null;
    }

    // TODO Sang: So sanh gia giua cac NCC cho cung 1 loai dich vu
    public List<ProviderPriceHistory> comparePrice(String serviceType, String serviceName) {
        // TODO: Implement - GROUP BY providerId, lay gia moi nhat cua moi NCC
        return null;
    }

    // TODO Sang: Lay gia moi nhat cua 1 NCC cho 1 dich vu
    public ProviderPriceHistory getLatestPrice(int providerId, String serviceName) {
        // TODO: Implement - SELECT TOP 1 ... ORDER BY changeDate DESC
        return null;
    }
}
