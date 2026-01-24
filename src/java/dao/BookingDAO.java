package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import java.util.List;
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
    
    @Override 
    public List<Booking> getBookingsByUserId(int userId) {
        EntityManager em = JPAContext.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            // Lấy tất cả booking của userId này, sắp xếp theo ngày
            String jqpl = "SELECT b FROM Booking b WHERE b.userId = :uid ORDER BY b.bookingDate DESC";
            Query query = em.createQuery(jqpl);
            query.setParameter("uid", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}