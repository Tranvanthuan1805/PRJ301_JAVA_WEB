package userDao;

import java.sql.*;
import model.User;
import dao.DBUtil;
import util.PasswordUtil;

public class UserDAO {

    // 🔐 LOGIN DUY NHẤT
    public User checklogin(String username, String passwordPlain) {

        String sql = """
            SELECT u.UserId, u.Email, u.Username, u.RoleId, r.RoleName
            FROM Users u
            JOIN Roles r ON u.RoleId = r.RoleId
            WHERE (u.Username = ? OR u.Email = ?)
              AND u.PasswordHash = ?
              AND u.IsActive = 1
        """;

        String hash = PasswordUtil.sha256(passwordPlain);

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, username);
            ps.setString(3, hash);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new User(
                    rs.getInt("UserId"),
                    rs.getString("Email"),
                    rs.getString("Username"),
                    rs.getInt("RoleId"),
                    rs.getString("RoleName")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // ===== REGISTER =====
    public boolean existsUsername(String username) {
        String sql = "SELECT 1 FROM Users WHERE Username = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            return ps.executeQuery().next();
        } catch (Exception e) {
            e.printStackTrace();
            return true;
        }
    }

    public boolean registerUser(String username, String passwordPlain) {
        String getRole = "SELECT RoleId FROM Roles WHERE RoleName='USER'";
        String insert = """
            INSERT INTO Users(Username, PasswordHash, RoleId, IsActive)
            VALUES (?, ?, ?, 1)
        """;

        try (Connection con = DBUtil.getConnection()) {

            int roleId;
            try (PreparedStatement ps = con.prepareStatement(getRole);
                 ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return false;
                roleId = rs.getInt("RoleId");
            }

            try (PreparedStatement ps = con.prepareStatement(insert)) {
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
