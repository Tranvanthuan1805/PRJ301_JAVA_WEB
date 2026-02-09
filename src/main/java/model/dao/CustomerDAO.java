package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.entity.Customer;

public class CustomerDAO {
    
    public List<Customer> getAllCustomers() {
        List<Customer> list = new ArrayList<>();
        String sql = """
            SELECT u.*, 
                   (SELECT COUNT(*) FROM Orders o WHERE o.CustomerId = u.UserId) as TotalOrders,
                   (SELECT SUM(TotalAmount) FROM Orders o WHERE o.CustomerId = u.UserId) as TotalSpent,
                   (SELECT MAX(OrderDate) FROM Orders o WHERE o.CustomerId = u.UserId) as LastBooking
            FROM Users u
            JOIN Roles r ON u.RoleId = r.RoleId
            WHERE r.RoleName = 'CUSTOMER'
        """;
        
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Customer c = mapRow(rs);
                c.setTotalOrders(rs.getInt("TotalOrders"));
                c.setTotalSpent(rs.getDouble("TotalSpent"));
                c.setLastBookingDate(rs.getTimestamp("LastBooking"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Customer getCustomerDetail(int id) {
        String sql = """
            SELECT u.*, 
                   (SELECT COUNT(*) FROM Orders o WHERE o.CustomerId = u.UserId) as TotalOrders,
                   (SELECT SUM(TotalAmount) FROM Orders o WHERE o.CustomerId = u.UserId) as TotalSpent,
                   (SELECT MAX(OrderDate) FROM Orders o WHERE o.CustomerId = u.UserId) as LastBooking
            FROM Users u
            WHERE u.UserId = ?
        """;
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Customer c = mapRow(rs);
                    c.setTotalOrders(rs.getInt("TotalOrders"));
                    c.setTotalSpent(rs.getDouble("TotalSpent"));
                    c.setLastBookingDate(rs.getTimestamp("LastBooking"));
                    return c;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private Customer mapRow(ResultSet rs) throws SQLException {
        Customer c = new Customer();
        c.setUserId(rs.getInt("UserId"));
        c.setEmail(rs.getString("Email"));
        c.setUsername(rs.getString("Username"));
        c.setFullName(rs.getString("FullName"));
        c.setPhoneNumber(rs.getString("PhoneNumber"));
        c.setAvatarUrl(rs.getString("AvatarUrl"));
        c.setActive(rs.getBoolean("IsActive"));
        c.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return c;
    }
}
