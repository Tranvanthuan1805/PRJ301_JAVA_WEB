package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Booking;

public class BookingDAO {
    
    public boolean createBooking(Booking b) {
        String sql = "INSERT INTO Bookings(OrderId, TourId, Quantity, SubTotal, BookingStatus, BookingDate) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, b.getOrderId());
            ps.setInt(2, b.getTourId());
            ps.setInt(3, b.getQuantity());
            ps.setDouble(4, b.getSubTotal());
            ps.setString(5, b.getBookingStatus() != null ? b.getBookingStatus() : "Pending");
            ps.setTimestamp(6, b.getTourDate());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Booking> getBookingsByOrder(int orderId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM Bookings WHERE OrderId = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while(rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private Booking mapRow(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setBookingId(rs.getInt("BookingId"));
        b.setOrderId(rs.getInt("OrderId"));
        b.setTourId(rs.getInt("TourId"));
        b.setTourDate(rs.getTimestamp("BookingDate"));
        b.setQuantity(rs.getInt("Quantity"));
        b.setSubTotal(rs.getDouble("SubTotal"));
        b.setBookingStatus(rs.getString("BookingStatus"));
        return b;
    }
}
