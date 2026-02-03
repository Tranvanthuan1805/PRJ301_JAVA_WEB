package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Tour;
import dao.DBUtil;

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
        return null; // Not found
    }

    private Tour mapRow(ResultSet rs) throws SQLException {
        return new Tour(
            rs.getInt("TourId"),
            rs.getString("TourName"),
            rs.getString("Description"),
            rs.getDouble("Price"),
            rs.getString("ImageUrl"),
            rs.getString("Duration"),
            rs.getString("StartLocation"),
            rs.getTimestamp("CreatedAt"),
            rs.getString("Itinerary"),
            rs.getString("Transport"),
            rs.getString("ShortDesc"),
            rs.getInt("MaxPeople")
        );
    }
}
