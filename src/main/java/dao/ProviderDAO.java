package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Provider;

public class ProviderDAO {
    
    public List<Provider> getAllProviders() {
        List<Provider> list = new ArrayList<>();
        String sql = "SELECT * FROM Providers";
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

    public Provider getProviderById(int id) {
        String sql = "SELECT * FROM Providers WHERE ProviderId = ?";
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

    public boolean createProvider(Provider p) {
        String sql = "INSERT INTO Providers (ProviderId, BusinessName, BusinessLicense, ProviderType, IsVerified, IsActive) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, p.getProviderId());
            ps.setString(2, p.getBusinessName());
            ps.setString(3, p.getBusinessLicense());
            ps.setString(4, p.getProviderType());
            ps.setBoolean(5, p.isVerified());
            ps.setBoolean(6, p.isActive());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateProvider(Provider p) {
        String sql = "UPDATE Providers SET BusinessName=?, BusinessLicense=?, ProviderType=?, IsVerified=?, IsActive=? WHERE ProviderId=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getBusinessName());
            ps.setString(2, p.getBusinessLicense());
            ps.setString(3, p.getProviderType());
            ps.setBoolean(4, p.isVerified());
            ps.setBoolean(5, p.isActive());
            ps.setInt(6, p.getProviderId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteProvider(int id) {
        String sql = "DELETE FROM Providers WHERE ProviderId = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private Provider mapRow(ResultSet rs) throws SQLException {
        Provider p = new Provider();
        p.setProviderId(rs.getInt("ProviderId"));
        p.setBusinessName(rs.getString("BusinessName"));
        p.setBusinessLicense(rs.getString("BusinessLicense"));
        p.setRating(rs.getDouble("Rating"));
        p.setVerified(rs.getBoolean("IsVerified"));
        p.setTotalTours(rs.getInt("TotalTours"));
        p.setProviderType(rs.getString("ProviderType") == null ? "Unknown" : rs.getString("ProviderType"));
        p.setActive(rs.getBoolean("IsActive"));
        return p;
    }
}
