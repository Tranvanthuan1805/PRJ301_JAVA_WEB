package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import model.Booking;

public class BookingDAO implements IBookingDAO {
    
    @Override
    public void insertBooking(Booking b) {
        EntityManager em = JPAContext.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(b); // Lưu đơn hàng vào DB
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}