package model.dao;

import java.sql.*;
import model.entity.Subscription;

public class SubscriptionDAO {
    
    public boolean createSubscription(Subscription sub) {
        String sql = "INSERT INTO ProviderSubscriptions (ProviderId, PlanName, StartDate, EndDate, IsActive) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, sub.getProviderId());
            ps.setString(2, sub.getPlanName());
            ps.setTimestamp(3, sub.getStartDate());
            ps.setTimestamp(4, sub.getEndDate());
            ps.setBoolean(5, sub.isActive());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Subscription getActiveSubscription(int providerId) {
        String sql = "SELECT TOP 1 * FROM ProviderSubscriptions WHERE ProviderId = ? AND IsActive = 1 AND EndDate > GETDATE() ORDER BY EndDate DESC";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, providerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Subscription s = new Subscription();
                    s.setSubId(rs.getInt("SubId"));
                    s.setProviderId(rs.getInt("ProviderId"));
                    s.setPlanName(rs.getString("PlanName"));
                    s.setStartDate(rs.getTimestamp("StartDate"));
                    s.setEndDate(rs.getTimestamp("EndDate"));
                    s.setActive(rs.getBoolean("IsActive"));
                    return s;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
