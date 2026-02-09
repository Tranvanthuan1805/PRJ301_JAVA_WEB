package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Lớp kết nối SQL Server - TourManager Database
 * @author TourManager Team
 */
public class DatabaseConnection {
    
    // SQL Server Configuration for TourManager
    private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=TourManager;encrypt=true;trustServerCertificate=true;";
    private static final String USER = "sa"; // Thay đổi theo user SQL Server của bạn
    private static final String PASSWORD = "123456"; // Thay đổi theo password của bạn
    
    // Alternative database name for backward compatibility
    private static final String FALLBACK_URL = "jdbc:sqlserver://localhost:1433;databaseName=ManagerBooking;encrypt=true;trustServerCertificate=true;";
    
    static {
        try {
            Class.forName(DRIVER);
            System.out.println("SQL Server JDBC Driver loaded successfully.");
        } catch (ClassNotFoundException e) {
            System.err.println("SQL Server JDBC Driver not found!");
            e.printStackTrace();
        }
    }
    
    /**
     * Lấy kết nối đến database TourManager
     * @return Connection object
     */
    public static Connection getConnection() {
        try {
            // Try primary database first
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Connected to TourManager database successfully.");
            return conn;
        } catch (SQLException e) {
            System.err.println("Failed to connect to TourManager database, trying fallback...");
            try {
                // Try fallback database
                Connection conn = DriverManager.getConnection(FALLBACK_URL, USER, PASSWORD);
                System.out.println("Connected to ManagerBooking database (fallback) successfully.");
                return conn;
            } catch (SQLException fallbackException) {
                System.err.println("Failed to connect to both databases!");
                System.err.println("Primary error: " + e.getMessage());
                System.err.println("Fallback error: " + fallbackException.getMessage());
                e.printStackTrace();
                return null;
            }
        }
    }
    
    /**
     * Đóng kết nối
     * @param conn Connection object cần đóng
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                System.out.println("Database connection closed successfully.");
            } catch (SQLException e) {
                System.err.println("Error closing database connection: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
    
    /**
     * Kiểm tra kết nối
     * @return true nếu kết nối thành công, false nếu thất bại
     */
    public static boolean testConnection() {
        System.out.println("Testing database connection...");
        try (Connection conn = getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("Database connection test: SUCCESS");
                return true;
            } else {
                System.err.println("Database connection test: FAILED - Connection is null or closed");
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Database connection test: FAILED - " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Lấy thông tin database hiện tại
     * @return Database name hoặc "Unknown" nếu không kết nối được
     */
    public static String getDatabaseInfo() {
        try (Connection conn = getConnection()) {
            if (conn != null) {
                String dbName = conn.getCatalog();
                String dbUrl = conn.getMetaData().getURL();
                return "Database: " + dbName + " | URL: " + dbUrl;
            }
        } catch (SQLException e) {
            System.err.println("Error getting database info: " + e.getMessage());
        }
        return "Database: Unknown | Status: Connection Failed";
    }
}
