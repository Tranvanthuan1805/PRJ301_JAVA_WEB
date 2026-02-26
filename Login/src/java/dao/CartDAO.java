package dao;

import model.CartItem;
import model.Tour;
import util.DBUtil;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO để quản lý giỏ hàng trong database
 * Chỉ dùng cho user đã đăng nhập
 */
public class CartDAO {
    
    /**
     * Thêm tour vào giỏ hàng
     * Nếu tour đã tồn tại, tăng quantity
     */
    public boolean addToCart(int userId, int tourId, int quantity) {
        String checkSql = "SELECT id, quantity FROM Cart WHERE userId = ? AND tourId = ?";
        String insertSql = "INSERT INTO Cart (userId, tourId, quantity) VALUES (?, ?, ?)";
        String updateSql = "UPDATE Cart SET quantity = quantity + ? WHERE userId = ? AND tourId = ?";
        
        try (Connection conn = DBUtil.getConnection()) {
            // Kiểm tra xem item đã tồn tại chưa
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, userId);
                checkStmt.setInt(2, tourId);
                ResultSet rs = checkStmt.executeQuery();
                
                if (rs.next()) {
                    // Item đã tồn tại, update quantity
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                        updateStmt.setInt(1, quantity);
                        updateStmt.setInt(2, userId);
                        updateStmt.setInt(3, tourId);
                        return updateStmt.executeUpdate() > 0;
                    }
                } else {
                    // Item chưa tồn tại, insert mới
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                        insertStmt.setInt(1, userId);
                        insertStmt.setInt(2, tourId);
                        insertStmt.setInt(3, quantity);
                        return insertStmt.executeUpdate() > 0;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Lấy tất cả items trong giỏ hàng của user
     */
    public List<CartItem> getCartItems(int userId) {
        List<CartItem> items = new ArrayList<>();
        String sql = "SELECT c.id, c.userId, c.tourId, c.quantity, c.addedAt, " +
                    "t.id as tour_id, t.name, t.destination, t.startDate, t.endDate, " +
                    "t.price, t.maxCapacity, t.currentCapacity, t.description " +
                    "FROM Cart c " +
                    "INNER JOIN Tours t ON c.tourId = t.id " +
                    "WHERE c.userId = ? " +
                    "ORDER BY c.addedAt DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                CartItem item = new CartItem();
                item.setId(rs.getInt("id"));
                item.setUserId(rs.getInt("userId"));
                item.setTourId(rs.getInt("tourId"));
                item.setQuantity(rs.getInt("quantity"));
                
                Timestamp timestamp = rs.getTimestamp("addedAt");
                if (timestamp != null) {
                    item.setAddedAt(timestamp.toLocalDateTime());
                }
                
                // Tạo Tour object
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
                
                item.setTour(tour);
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return items;
    }
    
    /**
     * Cập nhật số lượng của một item
     */
    public boolean updateQuantity(int userId, int tourId, int quantity) {
        if (quantity <= 0) {
            return removeFromCart(userId, tourId);
        }
        
        String sql = "UPDATE Cart SET quantity = ? WHERE userId = ? AND tourId = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, quantity);
            stmt.setInt(2, userId);
            stmt.setInt(3, tourId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Xóa một item khỏi giỏ hàng
     */
    public boolean removeFromCart(int userId, int tourId) {
        String sql = "DELETE FROM Cart WHERE userId = ? AND tourId = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, tourId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Xóa toàn bộ giỏ hàng của user
     */
    public boolean clearCart(int userId) {
        String sql = "DELETE FROM Cart WHERE userId = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            return stmt.executeUpdate() >= 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Đếm số lượng items trong giỏ hàng
     */
    public int getCartItemCount(int userId) {
        String sql = "SELECT COUNT(*) as count FROM Cart WHERE userId = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    /**
     * Tính tổng giá trị giỏ hàng
     */
    public double getCartTotal(int userId) {
        String sql = "SELECT SUM(c.quantity * t.price) as total " +
                    "FROM Cart c " +
                    "INNER JOIN Tours t ON c.tourId = t.id " +
                    "WHERE c.userId = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    /**
     * Kiểm tra xem tour có trong giỏ hàng không
     */
    public boolean isInCart(int userId, int tourId) {
        String sql = "SELECT id FROM Cart WHERE userId = ? AND tourId = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, tourId);
            ResultSet rs = stmt.executeQuery();
            
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
