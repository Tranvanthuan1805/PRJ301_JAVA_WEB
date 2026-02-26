package dao;

import model.CartInteraction;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO để tracking cart interactions
 */
public class CartInteractionDAO {
    
    /**
     * Log interaction
     */
    public boolean logInteraction(CartInteraction interaction) {
        String sql = "INSERT INTO CartInteractions (userId, sessionId, tourId, action, quantity) " +
                    "VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            if (interaction.getUserId() != null) {
                stmt.setInt(1, interaction.getUserId());
            } else {
                stmt.setNull(1, Types.INTEGER);
            }
            stmt.setString(2, interaction.getSessionId());
            stmt.setInt(3, interaction.getTourId());
            stmt.setString(4, interaction.getAction());
            
            if (interaction.getQuantity() != null) {
                stmt.setInt(5, interaction.getQuantity());
            } else {
                stmt.setNull(5, Types.INTEGER);
            }
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Lấy interactions của user/session
     */
    public List<CartInteraction> getInteractions(Integer userId, String sessionId, int limit) {
        List<CartInteraction> interactions = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT TOP (?) * FROM CartInteractions WHERE "
        );
        
        if (userId != null) {
            sql.append("userId = ? ");
        } else {
            sql.append("sessionId = ? ");
        }
        
        sql.append("ORDER BY createdAt DESC");
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            stmt.setInt(1, limit);
            
            if (userId != null) {
                stmt.setInt(2, userId);
            } else {
                stmt.setString(2, sessionId);
            }
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                CartInteraction interaction = new CartInteraction();
                interaction.setId(rs.getInt("id"));
                
                int uid = rs.getInt("userId");
                if (!rs.wasNull()) {
                    interaction.setUserId(uid);
                }
                
                interaction.setSessionId(rs.getString("sessionId"));
                interaction.setTourId(rs.getInt("tourId"));
                interaction.setAction(rs.getString("action"));
                
                int qty = rs.getInt("quantity");
                if (!rs.wasNull()) {
                    interaction.setQuantity(qty);
                }
                
                Timestamp createdAt = rs.getTimestamp("createdAt");
                if (createdAt != null) {
                    interaction.setCreatedAt(createdAt.toLocalDateTime());
                }
                
                interactions.add(interaction);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return interactions;
    }
    
    /**
     * Lấy most viewed tours (cho AI recommendations)
     */
    public List<Integer> getMostViewedTours(int limit) {
        List<Integer> tourIds = new ArrayList<>();
        String sql = "SELECT TOP (?) tourId, COUNT(*) as viewCount " +
                    "FROM CartInteractions " +
                    "WHERE action = 'VIEW' " +
                    "GROUP BY tourId " +
                    "ORDER BY viewCount DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                tourIds.add(rs.getInt("tourId"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return tourIds;
    }
    
    /**
     * Lấy most added to cart tours
     */
    public List<Integer> getMostAddedTours(int limit) {
        List<Integer> tourIds = new ArrayList<>();
        String sql = "SELECT TOP (?) tourId, COUNT(*) as addCount " +
                    "FROM CartInteractions " +
                    "WHERE action = 'ADD' " +
                    "GROUP BY tourId " +
                    "ORDER BY addCount DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                tourIds.add(rs.getInt("tourId"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return tourIds;
    }
}
