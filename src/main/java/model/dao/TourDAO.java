package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.entity.Tour;


public class TourDAO {

    public List<Tour> getAllTours() {
        List<Tour> list = new ArrayList<>();
        String sql = "SELECT * FROM Tours";
        
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Tour getTourById(int id) {
        String sql = "SELECT * FROM Tours WHERE TourId = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean createTour(Tour t) {
        String sql = """
            INSERT INTO Tours (ProviderId, CategoryId, TourName, ShortDesc, Description, Price, MaxPeople, Duration, Transport, StartLocation, ImageUrl, Itinerary, IsActive)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """;
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, t.getProviderId());
            ps.setInt(2, t.getCategoryId());
            ps.setString(3, t.getTourName());
            ps.setString(4, t.getShortDesc());
            ps.setString(5, t.getDescription());
            ps.setDouble(6, t.getPrice());
            ps.setInt(7, t.getMaxPeople());
            ps.setString(8, t.getDuration());
            ps.setString(9, t.getTransport());
            ps.setString(10, t.getStartLocation());
            ps.setString(11, t.getImageUrl());
            ps.setString(12, t.getItinerary());
            ps.setBoolean(13, t.isActive());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateTour(Tour t) {
        String sql = """
            UPDATE Tours SET ProviderId=?, CategoryId=?, TourName=?, ShortDesc=?, Description=?, Price=?, MaxPeople=?, Duration=?, Transport=?, StartLocation=?, ImageUrl=?, Itinerary=?, IsActive=?
            WHERE TourId=?
        """;
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, t.getProviderId());
            ps.setInt(2, t.getCategoryId());
            ps.setString(3, t.getTourName());
            ps.setString(4, t.getShortDesc());
            ps.setString(5, t.getDescription());
            ps.setDouble(6, t.getPrice());
            ps.setInt(7, t.getMaxPeople());
            ps.setString(8, t.getDuration());
            ps.setString(9, t.getTransport());
            ps.setString(10, t.getStartLocation());
            ps.setString(11, t.getImageUrl());
            ps.setString(12, t.getItinerary());
            ps.setBoolean(13, t.isActive());
            ps.setInt(14, t.getTourId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteTour(int id) {
        String sql = "DELETE FROM Tours WHERE TourId = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Checks if a tour is "Open" by verifying its status and current booking slots.
     */
    public boolean checkAvailability(int tourId, Timestamp travelDate, int requestedSlots) {
        String sql = """
            SELECT T.MaxPeople, ISNULL(SUM(B.Quantity), 0) as Booked
            FROM Tours T
            LEFT JOIN Bookings B ON T.TourId = B.TourId AND B.BookingStatus = 'Confirmed' AND CAST(B.BookingDate as DATE) = CAST(? as DATE)
            WHERE T.TourId = ? AND T.IsActive = 1
            GROUP BY T.MaxPeople
        """;
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setTimestamp(1, travelDate);
            ps.setInt(2, tourId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int max = rs.getInt("MaxPeople");
                    int booked = rs.getInt("Booked");
                    return (max - booked) >= requestedSlots;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private Tour mapRow(ResultSet rs) throws SQLException {
        Tour t = new Tour();
        t.setTourId(rs.getInt("TourId"));
        t.setProviderId(rs.getInt("ProviderId"));
        t.setCategoryId(rs.getInt("CategoryId"));
        t.setTourName(rs.getString("TourName"));
        t.setDescription(rs.getString("Description"));
        t.setPrice(rs.getDouble("Price"));
        t.setImageUrl(rs.getString("ImageUrl"));
        t.setDuration(rs.getString("Duration"));
        t.setStartLocation(rs.getString("StartLocation"));
        t.setCreatedAt(rs.getTimestamp("CreatedAt"));
        t.setItinerary(rs.getString("Itinerary"));
        t.setTransport(rs.getString("Transport"));
        t.setShortDesc(rs.getString("ShortDesc"));
        t.setMaxPeople(rs.getInt("MaxPeople"));
        t.setActive(rs.getBoolean("IsActive"));
        return t;
    }
}
