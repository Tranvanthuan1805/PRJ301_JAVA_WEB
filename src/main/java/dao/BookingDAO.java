package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Booking;

public class BookingDAO {
    
    public boolean createBooking(Booking b) {
        String sql = "INSERT INTO Bookings(UserId, TourId, NumberOfPeople, TotalPrice, Status) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, b.getUserId());
            ps.setInt(2, b.getTourId());
            ps.setInt(3, b.getNumberOfPeople());
            ps.setDouble(4, b.getTotalPrice());
            ps.setString(5, "Pending");
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Booking> getBookingsByUser(int userId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM Bookings WHERE UserId = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while(rs.next()) {
                    list.add(new Booking(
                        rs.getInt("BookingId"),
                        rs.getInt("UserId"),
                        rs.getInt("TourId"),
                        rs.getTimestamp("BookingDate"),
                        rs.getInt("NumberOfPeople"),
                        rs.getDouble("TotalPrice"),
                        rs.getString("Status")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
