package com.dananghub.dao;

import com.dananghub.entity.TourFeedback;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * DAO cho TourFeedback - Quản lý feedback tour đã hoàn thành
 */
public class FeedbackDAO {

    private static final Logger logger = Logger.getLogger(FeedbackDAO.class.getName());

    // Tạo feedback mới
    public boolean create(TourFeedback feedback) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(feedback);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            logger.log(Level.SEVERE, "Error creating feedback", e);
            return false;
        } finally {
            em.close();
        }
    }

    // Cập nhật status feedback
    public boolean updateStatus(int feedbackId, String status) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            TourFeedback fb = em.find(TourFeedback.class, feedbackId);
            if (fb != null) {
                fb.setStatus(status);
                em.merge(fb);
                tx.commit();
                return true;
            }
            tx.rollback();
            return false;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            logger.log(Level.SEVERE, "Error updating feedback status", e);
            return false;
        } finally {
            em.close();
        }
    }

    // Lấy feedback của 1 tour
    public List<TourFeedback> findByTourId(int tourId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT f FROM TourFeedback f WHERE f.tour.tourId = :tid AND f.status = 'APPROVED' ORDER BY f.createdAt DESC",
                TourFeedback.class
            ).setParameter("tid", tourId).getResultList();
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error finding feedback by tour", e);
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    // Kiểm tra user đã feedback cho order chưa
    public boolean hasUserFeedback(int userId, int orderId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Long count = em.createQuery(
                "SELECT COUNT(f) FROM TourFeedback f WHERE f.user.userId = :uid AND f.order.orderId = :oid",
                Long.class
            ).setParameter("uid", userId).setParameter("oid", orderId).getSingleResult();
            return count > 0;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error checking user feedback", e);
            return false;
        } finally {
            em.close();
        }
    }

    // Lấy tất cả feedback (Admin)
    public List<TourFeedback> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT f FROM TourFeedback f ORDER BY f.createdAt DESC",
                TourFeedback.class
            ).getResultList();
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error finding all feedback", e);
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    // Lấy feedback cần duyệt
    public List<TourFeedback> findPending() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT f FROM TourFeedback f WHERE f.status = 'PENDING' ORDER BY f.createdAt DESC",
                TourFeedback.class
            ).getResultList();
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error finding pending feedback", e);
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    // Thống kê rating trung bình theo tour
    public double getAvgRatingByTour(int tourId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Double avg = em.createQuery(
                "SELECT AVG(f.overallRating) FROM TourFeedback f WHERE f.tour.tourId = :tid AND f.status = 'APPROVED'",
                Double.class
            ).setParameter("tid", tourId).getSingleResult();
            return avg != null ? avg : 0;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error getting avg rating", e);
            return 0;
        } finally {
            em.close();
        }
    }

    // Lấy orders đã hoàn thành mà user chưa feedback
    public List<Object[]> getCompletedOrdersWithoutFeedback(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT o, b.tour FROM Order o JOIN Booking b ON b.order.orderId = o.orderId " +
                "WHERE o.customer.userId = :uid AND o.orderStatus = 'Completed' " +
                "AND NOT EXISTS (SELECT f FROM TourFeedback f WHERE f.order.orderId = o.orderId AND f.user.userId = :uid) " +
                "ORDER BY o.orderDate DESC",
                Object[].class
            ).setParameter("uid", userId).getResultList();
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error getting orders without feedback", e);
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    // Thống kê tổng
    public long countAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(f) FROM TourFeedback f", Long.class).getSingleResult();
        } catch (Exception e) { return 0; }
        finally { em.close(); }
    }

    public long countByStatus(String status) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT COUNT(f) FROM TourFeedback f WHERE f.status = :s", Long.class
            ).setParameter("s", status).getSingleResult();
        } catch (Exception e) { return 0; }
        finally { em.close(); }
    }
}
