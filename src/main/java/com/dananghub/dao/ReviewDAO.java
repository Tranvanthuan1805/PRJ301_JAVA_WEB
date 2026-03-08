package com.dananghub.dao;

import com.dananghub.entity.Review;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;

import java.util.Date;
import java.util.List;

public class ReviewDAO {

    /**
     * Lấy danh sách đánh giá của một tour (mới nhất trước)
     */
    public List<Review> findByTourId(int tourId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT r FROM Review r WHERE r.tour.tourId = :tourId ORDER BY r.createdAt DESC",
                Review.class)
                .setParameter("tourId", tourId)
                .getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Tính rating trung bình của một tour
     */
    public double getAverageRating(int tourId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Double avg = em.createQuery(
                "SELECT AVG(r.rating) FROM Review r WHERE r.tour.tourId = :tourId",
                Double.class)
                .setParameter("tourId", tourId)
                .getSingleResult();
            return avg != null ? Math.round(avg * 10.0) / 10.0 : 0;
        } finally {
            em.close();
        }
    }

    /**
     * Đếm số đánh giá của một tour
     */
    public long getReviewCount(int tourId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Long count = em.createQuery(
                "SELECT COUNT(r) FROM Review r WHERE r.tour.tourId = :tourId",
                Long.class)
                .setParameter("tourId", tourId)
                .getSingleResult();
            return count != null ? count : 0;
        } finally {
            em.close();
        }
    }

    /**
     * Kiểm tra user đã đánh giá tour này chưa
     */
    public Review findByTourAndUser(int tourId, int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT r FROM Review r WHERE r.tour.tourId = :tourId AND r.user.userId = :userId",
                Review.class)
                .setParameter("tourId", tourId)
                .setParameter("userId", userId)
                .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * Thêm đánh giá mới
     */
    public boolean create(Review review) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            review.setCreatedAt(new Date());
            review.setUpdatedAt(new Date());
            em.persist(review);
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

    /**
     * Cập nhật đánh giá
     */
    public boolean update(Review review) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            review.setUpdatedAt(new Date());
            em.merge(review);
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

    /**
     * Thống kê phân bổ rating (1-5 sao)
     */
    public int[] getRatingDistribution(int tourId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            int[] dist = new int[5]; // index 0 = 1 star, ... index 4 = 5 stars
            @SuppressWarnings("unchecked")
            List<Object[]> results = em.createQuery(
                "SELECT r.rating, COUNT(r) FROM Review r WHERE r.tour.tourId = :tourId GROUP BY r.rating")
                .setParameter("tourId", tourId)
                .getResultList();
            for (Object[] row : results) {
                int rating = ((Number) row[0]).intValue();
                int count = ((Number) row[1]).intValue();
                if (rating >= 1 && rating <= 5) {
                    dist[rating - 1] = count;
                }
            }
            return dist;
        } finally {
            em.close();
        }
    }
}
