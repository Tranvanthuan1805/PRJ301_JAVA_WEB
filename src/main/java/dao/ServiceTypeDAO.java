package dao;

import model.ServiceType;
import util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class cho ServiceType
 * 
 * @author Student
 */
public class ServiceTypeDAO {

    /**
     * Lấy tất cả loại dịch vụ
     */
    public static List<ServiceType> getAllServiceTypes() {
        List<ServiceType> list = new ArrayList<>();
        String sql = "SELECT ServiceTypeID, ServiceTypeName, Description FROM ServiceType ORDER BY ServiceTypeID";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                ServiceType st = new ServiceType();
                st.setServiceTypeID(rs.getInt("ServiceTypeID"));
                st.setServiceTypeName(rs.getString("ServiceTypeName"));
                st.setDescription(rs.getString("Description"));
                list.add(st);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy loại dịch vụ theo ID
     */
    public static ServiceType getServiceTypeByID(int id) {
        String sql = "SELECT ServiceTypeID, ServiceTypeName, Description FROM ServiceType WHERE ServiceTypeID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    ServiceType st = new ServiceType();
                    st.setServiceTypeID(rs.getInt("ServiceTypeID"));
                    st.setServiceTypeName(rs.getString("ServiceTypeName"));
                    st.setDescription(rs.getString("Description"));
                    return st;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
