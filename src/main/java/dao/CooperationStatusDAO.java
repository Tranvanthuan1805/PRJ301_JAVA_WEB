package dao;

import model.CooperationStatus;
import util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class cho CooperationStatus
 * 
 * @author Student
 */
public class CooperationStatusDAO {

    /**
     * Lấy tất cả trạng thái hợp tác
     */
    public static List<CooperationStatus> getAllStatuses() {
        List<CooperationStatus> list = new ArrayList<>();
        String sql = "SELECT StatusID, StatusName, Description FROM CooperationStatus ORDER BY StatusID";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                CooperationStatus cs = new CooperationStatus();
                cs.setStatusID(rs.getInt("StatusID"));
                cs.setStatusName(rs.getString("StatusName"));
                cs.setDescription(rs.getString("Description"));
                list.add(cs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy trạng thái hợp tác theo ID
     */
    public static CooperationStatus getStatusByID(int id) {
        String sql = "SELECT StatusID, StatusName, Description FROM CooperationStatus WHERE StatusID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    CooperationStatus cs = new CooperationStatus();
                    cs.setStatusID(rs.getInt("StatusID"));
                    cs.setStatusName(rs.getString("StatusName"));
                    cs.setDescription(rs.getString("Description"));
                    return cs;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
