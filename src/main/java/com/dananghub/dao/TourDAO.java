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
            return em.createQuery("SELECT t FROM Tour t WHERE t.isActive = true ORDER BY t.createdAt DESC", Tour.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Tour> findAllIncludeInactive() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT t FROM Tour t ORDER BY t.createdAt DESC", Tour.class)
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
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT t FROM Tour t WHERE t.provider.providerId = :pid ORDER BY t.createdAt DESC",
                Tour.class)
                .setParameter("pid", providerId)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Tour> findByCategory(int categoryId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT t FROM Tour t WHERE t.category.categoryId = :cid AND t.isActive = true",
                Tour.class)
                .setParameter("cid", categoryId)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Tour> search(String keyword) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT t FROM Tour t WHERE t.isActive = true AND " +
                "(LOWER(t.tourName) LIKE :kw OR LOWER(t.description) LIKE :kw OR LOWER(t.destination) LIKE :kw)",
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
            Object[] result = (Object[]) em.createQuery(
                "SELECT t.maxPeople, COALESCE(SUM(b.quantity), 0) " +
                "FROM Tour t LEFT JOIN Booking b ON t.tourId = b.tour.tourId " +
                "AND b.bookingStatus = 'Confirmed' AND CAST(b.bookingDate AS date) = CAST(:date AS date) " +
                "WHERE t.tourId = :tid AND t.isActive = true " +
                "GROUP BY t.maxPeople")
                .setParameter("date", travelDate)
                .setParameter("tid", tourId)
                .getSingleResult();

            int max = ((Number) result[0]).intValue();
            int booked = ((Number) result[1]).intValue();
            return (max - booked) >= requestedSlots;
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
