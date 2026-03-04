package com.dananghub.dao;

import com.dananghub.entity.Tour;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.Date;
import java.util.List;

public class TourDAO {

    public List<Tour> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT t FROM Tour t ORDER BY t.id DESC", Tour.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Tour> findAllIncludeInactive() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT t FROM Tour t ORDER BY t.id DESC", Tour.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public Tour findById(int tourId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Tour.class, tourId);
        } finally {
            em.close();
        }
    }

    public List<Tour> findByProvider(int providerId) {
        // Provider không có trong database đơn giản - trả về empty list
        return List.of();
    }

    public List<Tour> findByCategory(int categoryId) {
        // Category không có trong database đơn giản - trả về empty list
        return List.of();
    }

    public List<Tour> getAll2026Tours() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT t FROM Tour t WHERE YEAR(t.startDate) = 2026 ORDER BY t.startDate", 
                Tour.class)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Tour> getHistoricalTours() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT t FROM Tour t WHERE YEAR(t.startDate) < 2026 ORDER BY t.startDate DESC", 
                Tour.class)
                .getResultList();
        } finally {
            em.close();
        }
    }
    public List<Tour> search(String keyword) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT t FROM Tour t WHERE " +
                "(LOWER(t.name) LIKE :kw OR LOWER(t.description) LIKE :kw OR LOWER(t.destination) LIKE :kw)",
                Tour.class)
                .setParameter("kw", "%" + keyword.toLowerCase() + "%")
                .getResultList();
        } finally {
            em.close();
        }
    }

    public boolean checkAvailability(int tourId, Date travelDate, int requestedSlots) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Tour tour = em.find(Tour.class, tourId);
            if (tour == null) return false;
            
            // Kiểm tra availableSlots
            return tour.getAvailableSlots() >= requestedSlots;
        } catch (Exception e) {
            return false;
        } finally {
            em.close();
        }
    }

    public boolean create(Tour tour) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(tour);
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

    public boolean save(Tour tour) {
        return create(tour);
    }

    public boolean update(Tour tour) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(tour);
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

    public boolean delete(int tourId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Tour tour = em.find(Tour.class, tourId);
            if (tour != null) {
                em.remove(tour);
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
}
