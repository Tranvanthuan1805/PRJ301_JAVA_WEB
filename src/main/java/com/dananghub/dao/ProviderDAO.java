package com.dananghub.dao;

import com.dananghub.entity.Provider;
import com.dananghub.entity.ProviderPriceHistory;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;

/**
 * DAO cho quản lý Nhà cung cấp (Provider)
 * Hỗ trợ: Danh sách, Tìm kiếm, Lọc theo loại
 */
public class ProviderDAO {

    /**
     * Lấy tất cả providers đang hoạt động
     */
    public List<Provider> findAllActive() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Provider> query = em.createQuery(
                    "SELECT p FROM Provider p WHERE p.isActive = true ORDER BY p.rating DESC",
                    Provider.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Lấy providers theo loại dịch vụ
     * 
     * @param providerType: Hotel, TourOperator, Transport
     */
    public List<Provider> findByType(String providerType) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Provider> query = em.createQuery(
                    "SELECT p FROM Provider p WHERE p.isActive = true AND p.providerType = :type ORDER BY p.rating DESC",
                    Provider.class);
            query.setParameter("type", providerType);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Tìm kiếm providers theo tên (case-insensitive)
     */
    public List<Provider> searchByName(String keyword) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Provider> query = em.createQuery(
                    "SELECT p FROM Provider p WHERE p.isActive = true AND LOWER(p.businessName) LIKE LOWER(:keyword) ORDER BY p.rating DESC",
                    Provider.class);
            query.setParameter("keyword", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Lấy provider theo ID
     */
    public Provider findById(int providerId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Provider.class, providerId);
        } finally {
            em.close();
        }
    }

    /**
     * Lấy lịch sử giá của một provider
     */
    public List<ProviderPriceHistory> getPriceHistory(int providerId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<ProviderPriceHistory> query = em.createQuery(
                    "SELECT ph FROM ProviderPriceHistory ph WHERE ph.provider.providerId = :providerId ORDER BY ph.changeDate DESC",
                    ProviderPriceHistory.class);
            query.setParameter("providerId", providerId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Lấy lịch sử giá theo loại dịch vụ (cho so sánh)
     */
    public List<ProviderPriceHistory> getPriceHistoryByServiceType(String serviceType) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<ProviderPriceHistory> query = em.createQuery(
                    "SELECT ph FROM ProviderPriceHistory ph WHERE ph.serviceType = :serviceType ORDER BY ph.changeDate DESC",
                    ProviderPriceHistory.class);
            query.setParameter("serviceType", serviceType);
            query.setMaxResults(50); // Giới hạn 50 records
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Lấy providers để so sánh (theo IDs)
     * Bao gồm thông tin email, phone, và giá trung bình
     */
    public List<Provider> findByIds(List<Integer> providerIds) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Provider> query = em.createQuery(
                    "SELECT p FROM Provider p WHERE p.providerId IN :ids",
                    Provider.class);
            query.setParameter("ids", providerIds);
            List<Provider> providers = query.getResultList();

            // Populate transient fields
            for (Provider provider : providers) {
                enrichProviderData(provider, em);
            }

            return providers;
        } finally {
            em.close();
        }
    }

    /**
     * Làm giàu dữ liệu provider với thông tin bổ sung
     */
    private void enrichProviderData(Provider provider, EntityManager em) {
        // Get email and phone from ProviderRegistrations table
        try {
            String businessName = provider.getBusinessName();
            if (businessName == null)
                businessName = "";

            TypedQuery<Object[]> contactQuery = em.createQuery(
                    "SELECT pr.email, pr.phoneNumber FROM ProviderRegistration pr " +
                            "WHERE pr.businessName = :businessName AND pr.status = 'Approved' " +
                            "ORDER BY pr.submittedDate DESC",
                    Object[].class);
            contactQuery.setParameter("businessName", businessName);
            contactQuery.setMaxResults(1);

            List<Object[]> results = contactQuery.getResultList();
            if (!results.isEmpty()) {
                Object[] row = results.get(0);
                provider.setEmail((String) row[0]);
                provider.setPhone((String) row[1]);
            } else {
                // Fallback values
                String safeName = businessName.toLowerCase().replaceAll("\\s+", "");
                if (safeName.isEmpty())
                    safeName = "provider";
                provider.setEmail("contact@" + safeName + ".com");
                provider.setPhone("0236 3 XXX XXX");
            }
        } catch (Exception e) {
            // Fallback values
            provider.setEmail("contact@provider.com");
            provider.setPhone("0236 3 XXX XXX");
        }

        try {
            TypedQuery<Object> avgQuery = em.createQuery(
                    "SELECT AVG(ph.newPrice) FROM ProviderPriceHistory ph " +
                            "WHERE ph.provider.providerId = :providerId",
                    Object.class);
            avgQuery.setParameter("providerId", provider.getProviderId());

            Object result = avgQuery.getSingleResult();
            if (result instanceof Number) {
                provider.setAveragePrice(((Number) result).doubleValue());
            } else {
                provider.setAveragePrice(0.0);
            }
        } catch (Exception e) {
            provider.setAveragePrice(0.0);
        }
    }

    /**
     * Đếm tổng số providers
     */
    public long countAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(p) FROM Provider p WHERE p.isActive = true",
                    Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    /**
     * Lấy top providers theo rating
     */
    public List<Provider> getTopRated(int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Provider> query = em.createQuery(
                    "SELECT p FROM Provider p WHERE p.isActive = true AND p.isVerified = true ORDER BY p.rating DESC",
                    Provider.class);
            query.setMaxResults(limit);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    /**
     * Đồng bộ lại các chỉ số của Provider: TotalTours và Rating
     */
    public void syncStats(int providerId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Provider provider = em.find(Provider.class, providerId);
            if (provider != null) {
                // 1. Tính tổng số tour active
                Long tourCount = em.createQuery(
                    "SELECT COUNT(t) FROM Tour t WHERE t.provider.providerId = :pid AND t.isActive = true", Long.class)
                    .setParameter("pid", providerId)
                    .getSingleResult();
                provider.setTotalTours(tourCount.intValue());

                // 2. Tính Rating trung bình (nếu có review)
                try {
                    Double avgRating = em.createQuery(
                        "SELECT AVG(CAST(r.rating AS double)) FROM Review r WHERE r.tour.provider.providerId = :pid", Double.class)
                        .setParameter("pid", providerId)
                        .getSingleResult();
                    if (avgRating != null) {
                        provider.setRating(avgRating);
                    }
                } catch (Exception ignored) {}

                em.merge(provider);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
