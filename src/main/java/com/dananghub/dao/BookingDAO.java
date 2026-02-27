package com.dananghub.dao;

import com.dananghub.entity.Booking;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.List;

public class BookingDAO {

    public boolean create(Booking booking) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(booking);
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

    public List<Booking> findByOrder(int orderId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT b FROM Booking b WHERE b.order.orderId = :oid", Booking.class)
                .setParameter("oid", orderId)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Booking> findByTour(int tourId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT b FROM Booking b WHERE b.tour.tourId = :tid", Booking.class)
                .setParameter("tid", tourId)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public boolean updateStatus(int bookingId, String status) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Booking b = em.find(Booking.class, bookingId);
            if (b != null) {
                b.setBookingStatus(status);
                em.merge(b);
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
