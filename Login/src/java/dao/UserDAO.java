package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.User;
import util.DBUtil;
import util.PasswordUtil;

public class UserDAO {

    public User login(String username, String passwordPlain) {

        String sql = "SELECT u.UserId, u.Username, r.RoleName " +
                     "FROM Users u JOIN Roles r ON u.RoleId = r.RoleId " +
                     "WHERE u.Username=? AND u.PasswordHash=? AND u.IsActive=1";

        String hash = PasswordUtil.sha256(passwordPlain);

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // ✅ DEBUG: đang connect đúng DB/đúng server không?
            System.out.println(">>> Connected DB = " + con.getCatalog());
            System.out.println(">>> JDBC URL = " + con.getMetaData().getURL());

            ps.setString(1, username);
            ps.setString(2, hash);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    System.out.println(">>> LOGIN MATCH OK for " + username);
                    return new User(
                            rs.getInt("UserId"),
                            rs.getString("Username"),
                            rs.getString("RoleName")
                    );
                } else {
                    // ✅ DEBUG: vì sao không match
                    System.out.println(">>> LOGIN NOT MATCH!");
                    System.out.println(">>> username=" + username);
                    System.out.println(">>> hash=" + hash);
                }
            }

            return null;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
        public boolean existsUsername(String username) {
        String sql = "SELECT 1 FROM Users WHERE Username = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return true; // nếu lỗi DB thì coi như "tồn tại" để tránh tạo bừa
        }
    }
        public boolean registerUser(String username, String passwordPlain) {
        // lấy RoleId của USER
        String getRoleSql = "SELECT RoleId FROM Roles WHERE RoleName = 'USER'";
        String insertSql = "INSERT INTO Users(Username, PasswordHash, RoleId, IsActive) VALUES (?,?,?,1)";
    
        try (Connection con = DBUtil.getConnection()) {

        int roleId;
        try (PreparedStatement psRole = con.prepareStatement(getRoleSql);
             ResultSet rs = psRole.executeQuery()) {
            if (!rs.next()) return false;
            roleId = rs.getInt("RoleId");
        }

        try (PreparedStatement ps = con.prepareStatement(insertSql)) {
            ps.setString(1, username);
            ps.setString(2, PasswordUtil.sha256(passwordPlain));
            ps.setInt(3, roleId);
            return ps.executeUpdate() == 1;
        }

    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}

}
