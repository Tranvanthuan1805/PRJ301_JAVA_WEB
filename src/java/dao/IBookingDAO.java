package dao;

import java.util.List;
import java.util.Date;
import model.Booking;
import model.BookingDetailDTO;

public interface IBookingDAO {
    void insertBooking(Booking b);
    List<Booking> getBookingsByUserId(int userId);
    public int getBookedCount(int tourId);
    
    // Lấy 1 booking theo ID
    Booking getBookingById(int bookingId);
    
    // Lấy tất cả booking (Admin)
    List<Booking> getAllBookings();
    
    // Lấy booking theo trạng thái
    List<Booking> getBookingsByStatus(String status);
    
    // Cập nhật trạng thái đơn hàng
    boolean updateBookingStatus(int bookingId, String newStatus);
    
    // Hủy đơn với lý do
    boolean cancelBooking(int bookingId, String reason, double refundAmount);
    
    // Đếm số đơn theo trạng thái
    long countByStatus(String status);
    
    // Lấy tổng doanh thu từ đơn hoàn thành
    double getTotalRevenue();
    
    // Lấy doanh thu trong khoảng thời gian
    double getRevenueByDateRange(Date from, Date to);
    
    // Lấy booking chi tiết (có thông tin Tour, User)
    BookingDetailDTO getBookingDetailById(int bookingId);
    
    // Lấy danh sách chi tiết
    List<BookingDetailDTO> getAllBookingDetails();
    
    // Lấy booking gần đây (pagination)
    List<Booking> getRecentBookings(int limit);
}