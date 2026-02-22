package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {

    // ✅ Load driver rõ ràng (đỡ lỗi mơ hồ)
    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            System.out.println(">>> SQLServer JDBC Driver loaded OK");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(">>> Missing mssql-jdbc jar in WEB-INF/lib or Tomcat/lib", e);
        }
    }

    // Connection string with UTF-8 support
    private static final String URL =
        "jdbc:sqlserver://localhost:1433;" +
        "databaseName=AdminUser;" +
        "encrypt=true;" +
        "trustServerCertificate=true;" +
        "sendStringParametersAsUnicode=true;" +
        "characterEncoding=UTF-8;";

    private static final String USER = "sa";
    private static final String PASS = "MinhHieu2816@"; // mật khẩu SQL Server của user sa

    public static Connection getConnection() throws Exception {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
