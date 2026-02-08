package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Booking;
import model.BookingDetailDTO;
import model.Tour;

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
    
    @Override
    public int getBookedCount(int tourId) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            // Tính tổng số người đã đặt cho tour này, trừ những đơn đã hủy
            String jpql = "SELECT SUM(b.numberOfPeople) FROM Booking b WHERE b.tourId = :tid AND b.status <> 'Cancelled'";
            Query query = em.createQuery(jpql);
            query.setParameter("tid", tourId);
            
            Object result = query.getSingleResult();
            
            // Nếu chưa có ai đặt, hàm SUM sẽ trả về null -> trả về 0
            if (result == null) {
                return 0;
            }
            
            // Chuyển đổi kết quả về int (JPA SUM thường trả về Long)
            return ((Number) result).intValue();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }
    
    @Override
    public Booking getBookingById(int bookingId) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            return em.find(Booking.class, bookingId);
        } finally {
            em.close();
        }
    }
    
    @Override
    public List<Booking> getAllBookings() {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT b FROM Booking b ORDER BY b.bookingDate DESC";
            return em.createQuery(jpql, Booking.class).getResultList();
        } finally {
            em.close();
        }
    }
    
    @Override
    public List<Booking> getBookingsByStatus(String status) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT b FROM Booking b WHERE b.status = :status ORDER BY b.bookingDate DESC";
            return em.createQuery(jpql, Booking.class)
                     .setParameter("status", status)
                     .getResultList();
        } finally {
            em.close();
        }
    }
    
    @Override
    public boolean updateBookingStatus(int bookingId, String newStatus) {
        EntityManager em = JPAContext.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            
            Booking b = em.find(Booking.class, bookingId);
            if (b == null) {
                trans.rollback();
                return false;
            }
            
            b.setStatus(newStatus);
            b.setUpdatedAt(new Date());
            em.merge(b);
            
            trans.commit();
            return true;
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    
    @Override
    public boolean cancelBooking(int bookingId, String reason, double refundAmount) {
        EntityManager em = JPAContext.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            
            Booking b = em.find(Booking.class, bookingId);
            if (b == null) {
                trans.rollback();
                return false;
            }
            
            b.setStatus("Cancelled");
            b.setCancelReason(reason);
            b.setRefundAmount(refundAmount);
            b.setUpdatedAt(new Date());
            
            if (refundAmount > 0) {
                b.setPaymentStatus("REFUNDED");
            }
            
            em.merge(b);
            trans.commit();
            return true;
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    
    @Override
    public long countByStatus(String status) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT COUNT(b) FROM Booking b WHERE b.status = :status";
            return (Long) em.createQuery(jpql)
                            .setParameter("status", status)
                            .getSingleResult();
        } finally {
            em.close();
        }
    }
    
    @Override
    public double getTotalRevenue() {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT COALESCE(SUM(b.totalPrice), 0) FROM Booking b WHERE b.status = 'Completed'";
            Object result = em.createQuery(jpql).getSingleResult();
            return result == null ? 0.0 : ((Number) result).doubleValue();
        } finally {
            em.close();
        }
    }
    
    @Override
    public double getRevenueByDateRange(Date from, Date to) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT COALESCE(SUM(b.totalPrice), 0) FROM Booking b " +
                          "WHERE b.status = 'Completed' AND b.bookingDate BETWEEN :from AND :to";
            Object result = em.createQuery(jpql)
                              .setParameter("from", from)
                              .setParameter("to", to)
                              .getSingleResult();
            return result == null ? 0.0 : ((Number) result).doubleValue();
        } finally {
            em.close();
        }
    }
    
    @Override
    public BookingDetailDTO getBookingDetailById(int bookingId) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            Booking b = em.find(Booking.class, bookingId);
            if (b == null) return null;
            
            Tour t = em.find(Tour.class, b.getTourId());
            
            // Lấy username từ Users table (Native Query vì User entity khác)
            String sql = "SELECT Username FROM Users WHERE UserId = ?";
            Object username = em.createNativeQuery(sql)
                                .setParameter(1, b.getUserId())
                                .getSingleResult();
            
            return new BookingDetailDTO(b, t, username.toString());
        } finally {
            em.close();
        }
    }
    
    @Override
    public List<BookingDetailDTO> getAllBookingDetails() {
        EntityManager em = JPAContext.getEntityManager();
        List<BookingDetailDTO> result = new ArrayList<>();
        try {
            List<Booking> bookings = getAllBookings();
            
            for (Booking b : bookings) {
                Tour t = em.find(Tour.class, b.getTourId());
                
                String sql = "SELECT Username FROM Users WHERE UserId = ?";
                Object username = em.createNativeQuery(sql)
                                    .setParameter(1, b.getUserId())
                                    .getSingleResult();
                
                result.add(new BookingDetailDTO(b, t, username.toString()));
            }
            
            return result;
        } finally {
            em.close();
        }
    }
    
    @Override
    public List<Booking> getRecentBookings(int limit) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT b FROM Booking b ORDER BY b.bookingDate DESC";
            return em.createQuery(jpql, Booking.class)
                     .setMaxResults(limit)
                     .getResultList();
        } finally {
            em.close();
        }
    }
}