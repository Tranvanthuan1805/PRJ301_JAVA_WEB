package dao;

import model.CustomerActivity;
import util.DBUtil;
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
        String sql = "SELECT TOP (?) * FROM CustomerActivities " +
                     "WHERE customer_id = ? ORDER BY created_at DESC";
        
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
        String sql = "INSERT INTO CustomerActivities (customer_id, action_type, description, metadata) " +
                     "VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, activity.getCustomerId());
            ps.setString(2, activity.getActionType());
            ps.setString(3, activity.getDescription());
            ps.setString(4, activity.getMetadata());
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Get activity count by customer
     */
    public int getActivityCount(int customerId) throws Exception {
        String sql = "SELECT COUNT(*) FROM CustomerActivities WHERE customer_id = ?";
        
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
        String sql = "SELECT COUNT(*) FROM CustomerActivities " +
                     "WHERE customer_id = ? AND action_type = ?";
        
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
        activity.setId(rs.getInt("id"));
        activity.setCustomerId(rs.getInt("customer_id"));
        activity.setActionType(rs.getString("action_type"));
        activity.setDescription(rs.getNString("description"));  // Use getNString for NVARCHAR
        activity.setMetadata(rs.getString("metadata"));
        activity.setCreatedAt(rs.getTimestamp("created_at"));
        return activity;
    }
}
