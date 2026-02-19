package dao;

import model.Customer;
import util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for Customer Management - JDBC operations
 */
public class CustomerDAO {
    
    /**
     * Get all customers with pagination
     */
    public List<Customer> getAllCustomers(int offset, int limit) throws Exception {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM Customers ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, offset);
            ps.setInt(2, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToCustomer(rs));
                }
            }
        }
        return list;
    }
    
    /**
     * Search customers by name, email, or phone
     */
    public List<Customer> searchCustomers(String keyword, int offset, int limit) throws Exception {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM Customers WHERE " +
                     "full_name LIKE ? OR email LIKE ? OR phone LIKE ? " +
                     "ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            ps.setNString(1, searchPattern);
            ps.setNString(2, searchPattern);
            ps.setNString(3, searchPattern);
            ps.setInt(4, offset);
            ps.setInt(5, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToCustomer(rs));
                }
            }
        }
        return list;
    }
    
    /**
     * Filter customers by status
     */
    public List<Customer> filterByStatus(String status, int offset, int limit) throws Exception {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM Customers WHERE status = ? " +
                     "ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status);
            ps.setInt(2, offset);
            ps.setInt(3, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToCustomer(rs));
                }
            }
        }
        return list;
    }
    
    /**
     * Get customer by ID
     */
    public Customer getCustomerById(int id) throws Exception {
        String sql = "SELECT * FROM Customers WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCustomer(rs);
                }
            }
        }
        return null;
    }
    
    /**
     * Get customer by email
     */
    public Customer getCustomerByEmail(String email) throws Exception {
        String sql = "SELECT * FROM Customers WHERE email = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCustomer(rs);
                }
            }
        }
        return null;
    }
    
    /**
     * Get customer by user ID (for profile lookup)
     */
    public Customer getCustomerByUserId(int userId) throws Exception {
        String sql = "SELECT * FROM Customers WHERE user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCustomer(rs);
                }
            }
        }
        return null;
    }
    
    /**
     * Update customer information
     */
    public boolean updateCustomer(Customer customer) throws Exception {
        String sql = "UPDATE Customers SET full_name = ?, email = ?, phone = ?, " +
                     "address = ?, date_of_birth = ? WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setNString(1, customer.getFullName());
            ps.setNString(2, customer.getEmail());
            ps.setNString(3, customer.getPhone());
            ps.setNString(4, customer.getAddress());
            ps.setDate(5, customer.getDateOfBirth());
            ps.setInt(6, customer.getId());
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Update customer status (lock/unlock)
     */
    public boolean updateCustomerStatus(int customerId, String status) throws Exception {
        String sql = "UPDATE Customers SET status = ? WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status);
            ps.setInt(2, customerId);
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Get total customer count
     */
    public int getTotalCustomers() throws Exception {
        String sql = "SELECT COUNT(*) FROM Customers";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
    
    /**
     * Get total count for search results
     */
    public int getSearchCount(String keyword) throws Exception {
        String sql = "SELECT COUNT(*) FROM Customers WHERE " +
                     "full_name LIKE ? OR email LIKE ? OR phone LIKE ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            ps.setNString(1, searchPattern);
            ps.setNString(2, searchPattern);
            ps.setNString(3, searchPattern);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    /**
     * Get total count by status
     */
    public int getCountByStatus(String status) throws Exception {
        String sql = "SELECT COUNT(*) FROM Customers WHERE status = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    /**
     * Add new customer
     */
    public boolean addCustomer(Customer customer) throws Exception {
        String sql = "INSERT INTO Customers (full_name, email, phone, address, date_of_birth, status, created_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?, GETDATE())";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setNString(1, customer.getFullName());
            ps.setNString(2, customer.getEmail());
            ps.setNString(3, customer.getPhone());
            ps.setNString(4, customer.getAddress());
            ps.setDate(5, customer.getDateOfBirth());
            ps.setNString(6, customer.getStatus());
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Delete customer
     */
    public boolean deleteCustomer(int customerId) throws Exception {
        String sql = "DELETE FROM Customers WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, customerId);
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Map ResultSet to Customer object
     */
    private Customer mapResultSetToCustomer(ResultSet rs) throws SQLException {
        Customer c = new Customer();
        c.setId(rs.getInt("id"));
        
        // Use getNString for NVARCHAR columns
        c.setFullName(rs.getNString("full_name"));
        c.setEmail(rs.getString("email"));
        c.setPhone(rs.getString("phone"));
        c.setAddress(rs.getNString("address"));
        c.setDateOfBirth(rs.getDate("date_of_birth"));
        c.setStatus(rs.getString("status"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        c.setUpdatedAt(rs.getTimestamp("updated_at"));
        return c;
    }
}
