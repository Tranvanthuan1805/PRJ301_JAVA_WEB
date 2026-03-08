package com.dananghub.dao;

import com.dananghub.entity.Wishlist;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * DAO cho Wishlist - Quản lý danh sách tour yêu thích
 */
public class WishlistDAO {

    private static final Logger logger = Logger.getLogger(WishlistDAO.class.getName());

    // Thêm tour vào wishlist
    public boolean add(Wishlist wishlist) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(wishlist);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            logger.log(Level.SEVERE, "Error adding to wishlist", e);
            return false;
        } finally {
            em.close();
        }
    }

    // Xóa khỏi wishlist
    public boolean remove(int wishlistId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Wishlist w = em.find(Wishlist.class, wishlistId);
            if (w != null) {
                em.remove(w);
                tx.commit();
                return true;
            }
            tx.rollback();
            return false;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            logger.log(Level.SEVERE, "Error removing from wishlist", e);
            return false;
        } finally {
            em.close();
        }
    }

    // Xóa tour khỏi wishlist theo userId + tourId
    public boolean removeByUserAndTour(int userId, int tourId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            int count = em.createQuery(
                "DELETE FROM Wishlist w WHERE w.user.userId = :uid AND w.tour.tourId = :tid"
            ).setParameter("uid", userId).setParameter("tid", tourId).executeUpdate();
            tx.commit();
            return count > 0;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            logger.log(Level.SEVERE, "Error removing from wishlist", e);
            return false;
        } finally {
            em.close();
        }
    }

    // Lấy danh sách wishlist của user
    public List<Wishlist> findByUserId(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT w FROM Wishlist w JOIN FETCH w.tour WHERE w.user.userId = :uid ORDER BY w.addedAt DESC",
                Wishlist.class
            ).setParameter("uid", userId).getResultList();
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error finding wishlist by user", e);
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    // Kiểm tra tour đã có trong wishlist chưa
    public boolean exists(int userId, int tourId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Long count = em.createQuery(
                "SELECT COUNT(w) FROM Wishlist w WHERE w.user.userId = :uid AND w.tour.tourId = :tid",
                Long.class
            ).setParameter("uid", userId).setParameter("tid", tourId).getSingleResult();
            return count > 0;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error checking wishlist existence", e);
            return false;
        } finally {
            em.close();
        }
    }

    // Đếm số tour trong wishlist
    public long countByUser(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT COUNT(w) FROM Wishlist w WHERE w.user.userId = :uid",
                Long.class
            ).setParameter("uid", userId).getSingleResult();
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error counting wishlist", e);
            return 0;
        } finally {
            em.close();
        }
    }
}
