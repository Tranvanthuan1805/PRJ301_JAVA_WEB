package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.entity.Order;

public class OrderDAO {
    
    public int createOrder(Order order) {
        String sql = "INSERT INTO Orders (CustomerId, TotalAmount, OrderStatus, OrderDate) VALUES (?, ?, ?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, order.getCustomerId());
            ps.setDouble(2, order.getTotalAmount());
            ps.setString(3, order.getOrderStatus());
            ps.setTimestamp(4, order.getOrderDate());
            
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = """
            SELECT o.*, u.FullName 
            FROM Orders o
            JOIN Users u ON o.CustomerId = u.UserId
            ORDER BY o.OrderDate DESC
        """;
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

    public Order getOrderById(int id) {
        String sql = """
            SELECT o.*, u.FullName 
            FROM Orders o
            JOIN Users u ON o.CustomerId = u.UserId
            WHERE o.OrderId = ?
        """;
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE Orders SET OrderStatus = ? WHERE OrderId = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private Order mapRow(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setOrderId(rs.getInt("OrderId"));
        o.setCustomerId(rs.getInt("CustomerId"));
        o.setTotalAmount(rs.getDouble("TotalAmount"));
        o.setOrderStatus(rs.getString("OrderStatus"));
        o.setOrderDate(rs.getTimestamp("OrderDate"));
        o.setCustomerName(rs.getString("FullName"));
        return o;
    }
}
