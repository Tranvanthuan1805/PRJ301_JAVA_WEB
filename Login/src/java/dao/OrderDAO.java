package dao;

import model.Order;
import model.OrderItem;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO để quản lý đơn đặt tour
 */
public class OrderDAO {
    
    /**
     * Tạo đơn hàng mới
     */
    public int createOrder(Order order) {
        String sql = "INSERT INTO Orders (userId, orderCode, customerName, customerEmail, " +
                    "customerPhone, customerAddress, totalAmount, status, paymentStatus, notes) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, order.getUserId());
            stmt.setString(2, order.getOrderCode());
            stmt.setString(3, order.getCustomerName());
            stmt.setString(4, order.getCustomerEmail());
            stmt.setString(5, order.getCustomerPhone());
            stmt.setString(6, order.getCustomerAddress());
            stmt.setDouble(7, order.getTotalAmount());
            stmt.setString(8, order.getStatus());
            stmt.setString(9, order.getPaymentStatus());
            stmt.setString(10, order.getNotes());
            
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
     * Thêm item vào đơn hàng
     */
    public boolean addOrderItem(OrderItem item) {
        String sql = "INSERT INTO OrderItems (orderId, tourId, tourName, tourPrice, quantity, subtotal) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, item.getOrderId());
            stmt.setInt(2, item.getTourId());
            stmt.setString(3, item.getTourName());
            stmt.setDouble(4, item.getTourPrice());
            stmt.setInt(5, item.getQuantity());
            stmt.setDouble(6, item.getSubtotal());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Lấy đơn hàng theo ID
     */
    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM Orders WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Order order = mapResultSetToOrder(rs);
                // Load items
                order.setItems(getOrderItems(orderId));
                return order;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Lấy đơn hàng theo order code
     */
    public Order getOrderByCode(String orderCode) {
        String sql = "SELECT * FROM Orders WHERE orderCode = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, orderCode);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Order order = mapResultSetToOrder(rs);
                order.setItems(getOrderItems(order.getId()));
                return order;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Lấy danh sách đơn hàng của user
     */
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE userId = ? ORDER BY createdAt DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Order order = mapResultSetToOrder(rs);
                order.setItems(getOrderItems(order.getId()));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return orders;
    }
    
    /**
     * Lấy items của đơn hàng
     */
    public List<OrderItem> getOrderItems(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT * FROM OrderItems WHERE orderId = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setId(rs.getInt("id"));
                item.setOrderId(rs.getInt("orderId"));
                item.setTourId(rs.getInt("tourId"));
                item.setTourName(rs.getString("tourName"));
                item.setTourPrice(rs.getDouble("tourPrice"));
                item.setQuantity(rs.getInt("quantity"));
                item.setSubtotal(rs.getDouble("subtotal"));
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return items;
    }
    
    /**
     * Cập nhật thông tin đơn hàng (không bao gồm order code)
     */
    public boolean updateOrder(Order order) {
        String sql = "UPDATE Orders SET customerName = ?, customerEmail = ?, " +
                    "customerPhone = ?, customerAddress = ?, status = ?, " +
                    "paymentStatus = ?, paymentMethod = ?, notes = ?, updatedAt = GETDATE() " +
                    "WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setNString(1, order.getCustomerName());
            stmt.setString(2, order.getCustomerEmail());
            stmt.setString(3, order.getCustomerPhone());
            stmt.setNString(4, order.getCustomerAddress());
            stmt.setString(5, order.getStatus());
            stmt.setString(6, order.getPaymentStatus());
            stmt.setString(7, order.getPaymentMethod());
            stmt.setNString(8, order.getNotes());
            stmt.setInt(9, order.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Cập nhật trạng thái đơn hàng
     */
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE Orders SET status = ?, updatedAt = GETDATE() WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Cập nhật trạng thái thanh toán
     */
    public boolean updatePaymentStatus(int orderId, String paymentStatus, String paymentMethod) {
        String sql = "UPDATE Orders SET paymentStatus = ?, paymentMethod = ?, updatedAt = GETDATE() WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, paymentStatus);
            stmt.setString(2, paymentMethod);
            stmt.setInt(3, orderId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Hủy đơn hàng
     */
    public boolean cancelOrder(int orderId) {
        return updateOrderStatus(orderId, "CANCELLED");
    }
    
    /**
     * Map ResultSet to Order object
     */
    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setUserId(rs.getInt("userId"));
        order.setOrderCode(rs.getString("orderCode"));
        order.setCustomerName(rs.getString("customerName"));
        order.setCustomerEmail(rs.getString("customerEmail"));
        order.setCustomerPhone(rs.getString("customerPhone"));
        order.setCustomerAddress(rs.getString("customerAddress"));
        order.setTotalAmount(rs.getDouble("totalAmount"));
        order.setStatus(rs.getString("status"));
        order.setPaymentStatus(rs.getString("paymentStatus"));
        order.setPaymentMethod(rs.getString("paymentMethod"));
        order.setNotes(rs.getString("notes"));
        
        Timestamp createdAt = rs.getTimestamp("createdAt");
        if (createdAt != null) {
            order.setCreatedAt(createdAt.toLocalDateTime());
        }
        
        Timestamp updatedAt = rs.getTimestamp("updatedAt");
        if (updatedAt != null) {
            order.setUpdatedAt(updatedAt.toLocalDateTime());
        }
        
        return order;
    }
    
    /**
     * Generate unique order code
     */
    public String generateOrderCode() {
        return "ORD" + System.currentTimeMillis();
    }
    
    /**
     * Lấy tất cả đơn hàng (cho admin)
     */
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders ORDER BY createdAt DESC";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Order order = mapResultSetToOrder(rs);
                order.setItems(getOrderItems(order.getId()));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return orders;
    }
    
    /**
     * Tìm kiếm đơn hàng theo order code hoặc customer name
     */
    public List<Order> searchOrders(String keyword) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE orderCode LIKE ? OR customerName LIKE ? ORDER BY createdAt DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Order order = mapResultSetToOrder(rs);
                order.setItems(getOrderItems(order.getId()));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return orders;
    }
    
    /**
     * Xóa đơn hàng (xóa cả OrderItems và Payments liên quan)
     */
    public boolean deleteOrder(int orderId) {
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);
            
            // 1. Xóa Payments trước
            String deletePayments = "DELETE FROM Payments WHERE orderId = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deletePayments)) {
                stmt.setInt(1, orderId);
                stmt.executeUpdate();
            }
            
            // 2. Xóa OrderItems
            String deleteItems = "DELETE FROM OrderItems WHERE orderId = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteItems)) {
                stmt.setInt(1, orderId);
                stmt.executeUpdate();
            }
            
            // 3. Xóa Order
            String deleteOrder = "DELETE FROM Orders WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteOrder)) {
                stmt.setInt(1, orderId);
                int rows = stmt.executeUpdate();
                
                if (rows > 0) {
                    conn.commit();
                    return true;
                }
            }
            
            conn.rollback();
            return false;
            
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
