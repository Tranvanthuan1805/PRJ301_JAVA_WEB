package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {

    // ✅ Load driver rõ ràng (đỡ lỗi mơ hồ)
    // ✅ Load PostgreSQL Driver
    static {
        try {
            Class.forName("org.postgresql.Driver");
            System.out.println(">>> PostgreSQL JDBC Driver loaded OK");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(">>> Missing postgresql jar in WEB-INF/lib or Tomcat/lib", e);
        }
    }

    // Supabase Connection String
    private static final String URL =
        "jdbc:postgresql://aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres?pgbouncer=true&prepareThreshold=0";

    private static final String USER = "postgres.pijkmopqomgqvchiqsda";
    private static final String PASS = "Lephuocsang2005"; 

    public static Connection getConnection() throws Exception {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
