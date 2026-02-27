package dao;

import model.CustomerActivity;
import dao.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for Customer Activity tracking
 */
public class CustomerActivityDAO {
    
    /**
     * Get activities for a specific customer
     */
    public List<CustomerActivity> getActivitiesByCustomerId(int customerId, int limit) throws Exception {
        List<CustomerActivity> list = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM CustomerActivity " +
                     "WHERE CustomerId = ? ORDER BY CreatedAt DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            ps.setInt(2, customerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToActivity(rs));
                }
            }
        }
        return list;
    }
    
    /**
     * Filter activities by action type
     */
    public List<CustomerActivity> filterByActionType(int customerId, String actionType, int limit) throws Exception {
        List<CustomerActivity> list = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM CustomerActivities " +
                     "WHERE customer_id = ? AND action_type = ? ORDER BY created_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            ps.setInt(2, customerId);
            ps.setString(3, actionType);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToActivity(rs));
                }
            }
        }
        return list;
    }
    
    /**
     * Add new activity
     */
    public boolean addActivity(CustomerActivity activity) throws Exception {
        String sql = "INSERT INTO CustomerActivity (CustomerId, ActionType, ActionDetails, CreatedAt) " +
                     "VALUES (?, ?, ?, GETDATE())";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, activity.getCustomerId());
            ps.setNString(2, activity.getActionType());
            ps.setNString(3, activity.getDescription());
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Get activity count by customer
     */
    public int getActivityCount(int customerId) throws Exception {
        String sql = "SELECT COUNT(*) FROM CustomerActivity WHERE CustomerId = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, customerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    /**
     * Get count by action type
     */
    public int getCountByActionType(int customerId, String actionType) throws Exception {
        String sql = "SELECT COUNT(*) FROM CustomerActivity " +
                     "WHERE CustomerId = ? AND ActionType = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, customerId);
            ps.setString(2, actionType);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    /**
     * Count activities by customer ID (alias for getActivityCount)
     */
    public int countActivitiesByCustomerId(int customerId) throws Exception {
        return getActivityCount(customerId);
    }
    
    /**
     * Count activities by type (alias for getCountByActionType)
     */
    public int countActivitiesByType(int customerId, String actionType) throws Exception {
        return getCountByActionType(customerId, actionType);
    }
    
    /**
     * Map ResultSet to CustomerActivity object
     */
    private CustomerActivity mapResultSetToActivity(ResultSet rs) throws SQLException {
        CustomerActivity activity = new CustomerActivity();
        activity.setId(rs.getInt("Id"));
        activity.setCustomerId(rs.getInt("CustomerId"));
        activity.setActionType(rs.getString("ActionType"));
        activity.setDescription(rs.getNString("ActionDetails"));  // Use getNString for NVARCHAR
        activity.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return activity;
    }
}
