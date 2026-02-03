import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

class SupabaseJDBCConnect {

    public static void main(String[] args) {

        // ────────────────────────────────────────────────────────
        
        String url = "jdbc:postgresql://aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres?pgbouncer=true&prepareThreshold=0";

       
        String username = "postgres.pijkmopqomgqvchiqsda";

        
        String password = "Lephuocsang2005";
        // ────────────────────────────────────────────────────────

        try (Connection conn = DriverManager.getConnection(url, username, password)) {
            
            System.out.println("KẾT NỐI THÀNH CÔNG VỚI SUPABASE!");
            
          
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT version()")) {
                
                while (rs.next()) {
                    System.out.println("PostgreSQL version: " + rs.getString(1));
                }
            }

        } catch (SQLException e) {
            System.err.println("Kết nối thất bại!");
            e.printStackTrace();
        }
    }
}
