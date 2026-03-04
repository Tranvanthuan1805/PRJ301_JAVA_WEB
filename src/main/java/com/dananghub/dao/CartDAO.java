package com.dananghub.dao;

import com.dananghub.entity.Cart;
import com.dananghub.entity.Tour;
import com.dananghub.entity.User;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.List;

public class CartDAO {
    
    public List<Cart> findByUserId(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT c FROM Cart c WHERE c.user.userId = :userId ORDER BY c.addedDate DESC",
                Cart.class)
                .setParameter("userId", userId)
                .getResultList();
        } finally {
            em.close();
        }
    }
    
    public Cart findByUserAndTour(int userId, int tourId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            List<Cart> results = em.createQuery(
                "SELECT c FROM Cart c WHERE c.user.userId = :userId AND c.tour.id = :tourId",
                Cart.class)
                .setParameter("userId", userId)
                .setParameter("tourId", tourId)
                .getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }
    
    public boolean addOrUpdate(User user, Tour tour, int quantity) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            
            List<Cart> existing = em.createQuery(
                "SELECT c FROM Cart c WHERE c.user.userId = :userId AND c.tour.id = :tourId",
                Cart.class)
                .setParameter("userId", user.getUserId())
                .setParameter("tourId", tour.getId())
                .getResultList();
            
            if (!existing.isEmpty()) {
                Cart cart = existing.get(0);
                cart.setQuantity(cart.getQuantity() + quantity);
                em.merge(cart);
            } else {
                Cart cart = new Cart(user, tour, quantity);
                em.persist(cart);
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
    
    public boolean updateQuantity(int userId, int tourId, int quantity) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            
            List<Cart> results = em.createQuery(
                "SELECT c FROM Cart c WHERE c.user.userId = :userId AND c.tour.id = :tourId",
                Cart.class)
                .setParameter("userId", userId)
                .setParameter("tourId", tourId)
                .getResultList();
            
            if (!results.isEmpty()) {
                Cart cart = results.get(0);
                if (quantity > 0) {
                    cart.setQuantity(quantity);
                    em.merge(cart);
                } else {
                    em.remove(cart);
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
    
    public boolean remove(int userId, int tourId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            
            int deleted = em.createQuery(
                "DELETE FROM Cart c WHERE c.user.userId = :userId AND c.tour.id = :tourId")
                .setParameter("userId", userId)
                .setParameter("tourId", tourId)
                .executeUpdate();
            
            tx.commit();
            return deleted > 0;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    
    public boolean clearCart(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            
            em.createQuery("DELETE FROM Cart c WHERE c.user.userId = :userId")
                .setParameter("userId", userId)
                .executeUpdate();
            
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
    
    public int countByUserId(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Long count = em.createQuery(
                "SELECT COUNT(c) FROM Cart c WHERE c.user.userId = :userId",
                Long.class)
                .setParameter("userId", userId)
                .getSingleResult();
            return count != null ? count.intValue() : 0;
        } finally {
            em.close();
        }
    }
}
