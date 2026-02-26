package dao;

import model.AbandonedCart;
import model.Tour;
import util.DBUtil;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO để quản lý abandoned carts
 */
public class AbandonedCartDAO {
    
    /**
     * Tạo abandoned cart record
     */
    public int createAbandonedCart(AbandonedCart cart) {
        String sql = "INSERT INTO AbandonedCarts (userId, sessionId, tourId, quantity, " +
                    "addedAt, lastViewedAt, abandonedAt) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            if (cart.getUserId() != null) {
                stmt.setInt(1, cart.getUserId());
            } else {
                stmt.setNull(1, Types.INTEGER);
            }
            stmt.setString(2, cart.getSessionId());
            stmt.setInt(3, cart.getTourId());
            stmt.setInt(4, cart.getQuantity());
            stmt.setTimestamp(5, Timestamp.valueOf(cart.getAddedAt()));
            stmt.setTimestamp(6, Timestamp.valueOf(cart.getLastViewedAt()));
            
            if (cart.getAbandonedAt() != null) {
                stmt.setTimestamp(7, Timestamp.valueOf(cart.getAbandonedAt()));
            } else {
                stmt.setNull(7, Types.TIMESTAMP);
            }
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return -1;
    }
    
    /**
     * Lấy abandoned carts chưa gửi reminder
     */
    public List<AbandonedCart> getAbandonedCartsForReminder() {
        List<AbandonedCart> carts = new ArrayList<>();
        String sql = "SELECT ac.*, t.id as tour_id, t.name, t.destination, t.startDate, t.endDate, " +
                    "t.price, t.maxCapacity, t.currentCapacity, t.description " +
                    "FROM AbandonedCarts ac " +
                    "INNER JOIN Tours t ON ac.tourId = t.id " +
                    "WHERE ac.reminderSent = 0 AND ac.converted = 0 " +
                    "AND ac.abandonedAt IS NOT NULL " +
                    "AND DATEDIFF(HOUR, ac.abandonedAt, GETDATE()) >= 24 " +
                    "ORDER BY ac.abandonedAt ASC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                AbandonedCart cart = mapResultSetToAbandonedCart(rs);
                carts.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return carts;
    }
    
    /**
     * Lấy tất cả abandoned carts (cho analytics)
     */
    public List<AbandonedCart> getAllAbandonedCarts(int limit) {
        List<AbandonedCart> carts = new ArrayList<>();
        String sql = "SELECT TOP (?) ac.*, t.id as tour_id, t.name, t.destination, t.startDate, t.endDate, " +
                    "t.price, t.maxCapacity, t.currentCapacity, t.description " +
                    "FROM AbandonedCarts ac " +
                    "INNER JOIN Tours t ON ac.tourId = t.id " +
                    "WHERE ac.converted = 0 " +
                    "ORDER BY ac.abandonedAt DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                AbandonedCart cart = mapResultSetToAbandonedCart(rs);
                carts.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return carts;
    }
    
    /**
     * Lấy abandoned carts theo priority
     */
    public List<AbandonedCart> getAbandonedCartsByPriority(String priority, int limit) {
        // Implement logic dựa trên getPriorityLevel() của model
        return getAllAbandonedCarts(limit);
    }
    
    /**
     * Đánh dấu reminder đã gửi
     */
    public boolean markReminderSent(int cartId) {
        String sql = "UPDATE AbandonedCarts SET reminderSent = 1, reminderSentAt = GETDATE() WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, cartId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Đánh dấu đã convert (đã đặt tour)
     */
    public boolean markConverted(int cartId, int orderId) {
        String sql = "UPDATE AbandonedCarts SET converted = 1, convertedAt = GETDATE(), orderId = ? WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            stmt.setInt(2, cartId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Lấy abandoned cart statistics
     */
    public AbandonedCartStats getStatistics() {
        String sql = "SELECT " +
                    "COUNT(*) as totalAbandoned, " +
                    "SUM(CASE WHEN converted = 1 THEN 1 ELSE 0 END) as totalConverted, " +
                    "SUM(CASE WHEN reminderSent = 1 THEN 1 ELSE 0 END) as totalReminderSent, " +
                    "AVG(DATEDIFF(HOUR, abandonedAt, GETDATE())) as avgHoursAbandoned " +
                    "FROM AbandonedCarts " +
                    "WHERE abandonedAt IS NOT NULL";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                AbandonedCartStats stats = new AbandonedCartStats();
                stats.totalAbandoned = rs.getInt("totalAbandoned");
                stats.totalConverted = rs.getInt("totalConverted");
                stats.totalReminderSent = rs.getInt("totalReminderSent");
                stats.avgHoursAbandoned = rs.getDouble("avgHoursAbandoned");
                
                if (stats.totalAbandoned > 0) {
                    stats.conversionRate = (double) stats.totalConverted / stats.totalAbandoned * 100;
                }
                
                return stats;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return new AbandonedCartStats();
    }
    
    /**
     * Map ResultSet to AbandonedCart
     */
    private AbandonedCart mapResultSetToAbandonedCart(ResultSet rs) throws SQLException {
        AbandonedCart cart = new AbandonedCart();
        cart.setId(rs.getInt("id"));
        
        int userId = rs.getInt("userId");
        if (!rs.wasNull()) {
            cart.setUserId(userId);
        }
        
        cart.setSessionId(rs.getString("sessionId"));
        cart.setTourId(rs.getInt("tourId"));
        cart.setQuantity(rs.getInt("quantity"));
        
        Timestamp addedAt = rs.getTimestamp("addedAt");
        if (addedAt != null) {
            cart.setAddedAt(addedAt.toLocalDateTime());
        }
        
        Timestamp lastViewedAt = rs.getTimestamp("lastViewedAt");
        if (lastViewedAt != null) {
            cart.setLastViewedAt(lastViewedAt.toLocalDateTime());
        }
        
        Timestamp abandonedAt = rs.getTimestamp("abandonedAt");
        if (abandonedAt != null) {
            cart.setAbandonedAt(abandonedAt.toLocalDateTime());
        }
        
        cart.setReminderSent(rs.getBoolean("reminderSent"));
        
        Timestamp reminderSentAt = rs.getTimestamp("reminderSentAt");
        if (reminderSentAt != null) {
            cart.setReminderSentAt(reminderSentAt.toLocalDateTime());
        }
        
        cart.setConverted(rs.getBoolean("converted"));
        
        Timestamp convertedAt = rs.getTimestamp("convertedAt");
        if (convertedAt != null) {
            cart.setConvertedAt(convertedAt.toLocalDateTime());
        }
        
        int orderId = rs.getInt("orderId");
        if (!rs.wasNull()) {
            cart.setOrderId(orderId);
        }
        
        // Map Tour
        Tour tour = new Tour();
        tour.setId(rs.getInt("tour_id"));
        tour.setName(rs.getString("name"));
        tour.setDestination(rs.getString("destination"));
        tour.setStartDate(rs.getDate("startDate").toLocalDate());
        tour.setEndDate(rs.getDate("endDate").toLocalDate());
        tour.setPrice(rs.getDouble("price"));
        tour.setMaxCapacity(rs.getInt("maxCapacity"));
        tour.setCurrentCapacity(rs.getInt("currentCapacity"));
        tour.setDescription(rs.getString("description"));
        
        cart.setTour(tour);
        
        return cart;
    }
    
    /**
     * Inner class cho statistics
     */
    public static class AbandonedCartStats {
        public int totalAbandoned;
        public int totalConverted;
        public int totalReminderSent;
        public double avgHoursAbandoned;
        public double conversionRate;
    }
}
