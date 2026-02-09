package servlet;

import dao.SupplierDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Supplier;
import util.DatabaseConnection;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

/**
 * Debug Servlet để test database connection và data loading
 */
@WebServlet(name = "DebugServlet", urlPatterns = {"/debug"})
public class DebugServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>Debug - TourManager</title>");
        out.println("<style>body{font-family:Arial;margin:20px;} .success{color:green;} .error{color:red;} .info{color:blue;}</style>");
        out.println("</head><body>");
        out.println("<h1>🔍 TourManager Debug</h1>");
        
        // Test 1: Basic Connection
        out.println("<h2>1. Database Connection Test</h2>");
        try {
            Connection conn = DatabaseConnection.getConnection();
            if (conn != null && !conn.isClosed()) {
                out.println("<p class='success'>✅ Database connection: SUCCESS</p>");
                
                // Get database name
                String dbName = conn.getCatalog();
                out.println("<p class='info'>📊 Connected to database: <strong>" + dbName + "</strong></p>");
                
                conn.close();
            } else {
                out.println("<p class='error'>❌ Database connection: FAILED</p>");
            }
        } catch (Exception e) {
            out.println("<p class='error'>❌ Connection Error: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        }
        
        // Test 2: Check if table exists
        out.println("<h2>2. Table Existence Check</h2>");
        try (Connection conn = DatabaseConnection.getConnection()) {
            if (conn != null) {
                Statement stmt = conn.createStatement();
                
                // Check Suppliers table
                ResultSet rs = stmt.executeQuery(
                    "SELECT COUNT(*) as TableCount FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Suppliers'"
                );
                
                if (rs.next() && rs.getInt("TableCount") > 0) {
                    out.println("<p class='success'>✅ Table 'Suppliers' exists</p>");
                    
                    // Count records
                    ResultSet countRs = stmt.executeQuery("SELECT COUNT(*) as RecordCount FROM Suppliers");
                    if (countRs.next()) {
                        int count = countRs.getInt("RecordCount");
                        out.println("<p class='info'>📊 Total records: <strong>" + count + "</strong></p>");
                        
                        if (count == 0) {
                            out.println("<p class='error'>⚠️ Table is empty! Please run database script.</p>");
                        }
                    }
                } else {
                    out.println("<p class='error'>❌ Table 'Suppliers' does not exist!</p>");
                    out.println("<p>Please run: <code>database/simple_database.sql</code></p>");
                }
            }
        } catch (Exception e) {
            out.println("<p class='error'>❌ Table check error: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        }
        
        // Test 3: Raw SQL Query with JOINs
        out.println("<h2>3. Raw SQL Query Test (with JOINs)</h2>");
        try (Connection conn = DatabaseConnection.getConnection()) {
            if (conn != null) {
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(
                    "SELECT TOP 3 s.SupplierID, s.SupplierCode, s.SupplierName, " +
                    "st.ServiceTypeName as ServiceType, cs.StatusName as Status " +
                    "FROM Suppliers s " +
                    "LEFT JOIN ServiceTypes st ON s.ServiceTypeID = st.ServiceTypeID " +
                    "LEFT JOIN CooperationStatus cs ON s.StatusID = cs.StatusID " +
                    "ORDER BY s.SupplierID"
                );
                
                out.println("<p class='success'>✅ Raw SQL query with JOINs: SUCCESS</p>");
                out.println("<table border='1' style='border-collapse:collapse;'>");
                out.println("<tr><th>ID</th><th>Code</th><th>Name</th><th>Service Type</th><th>Status</th></tr>");
                
                boolean hasData = false;
                while (rs.next()) {
                    hasData = true;
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("SupplierID") + "</td>");
                    out.println("<td>" + rs.getString("SupplierCode") + "</td>");
                    out.println("<td>" + rs.getString("SupplierName") + "</td>");
                    out.println("<td>" + rs.getString("ServiceType") + "</td>");
                    out.println("<td>" + rs.getString("Status") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
                
                if (!hasData) {
                    out.println("<p class='error'>⚠️ No data returned from JOIN query!</p>");
                    out.println("<p>This suggests the foreign key relationships are not set up correctly.</p>");
                }
            }
        } catch (Exception e) {
            out.println("<p class='error'>❌ Raw SQL with JOINs error: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        }
        
        // Test 4: DAO Test
        out.println("<h2>4. SupplierDAO Test</h2>");
        try {
            SupplierDAO dao = new SupplierDAO();
            List<Supplier> suppliers = dao.selectAllSuppliers();
            
            if (suppliers != null) {
                out.println("<p class='success'>✅ DAO test: SUCCESS</p>");
                out.println("<p class='info'>📊 DAO returned: <strong>" + suppliers.size() + "</strong> suppliers</p>");
                
                if (suppliers.size() > 0) {
                    out.println("<h3>Sample Data:</h3>");
                    out.println("<ul>");
                    for (int i = 0; i < Math.min(3, suppliers.size()); i++) {
                        Supplier s = suppliers.get(i);
                        out.println("<li><strong>" + s.getSupplierName() + "</strong> (" + s.getServiceType() + ") - " + s.getStatus() + "</li>");
                    }
                    out.println("</ul>");
                } else {
                    out.println("<p class='error'>⚠️ DAO returned empty list!</p>");
                }
            } else {
                out.println("<p class='error'>❌ DAO returned null!</p>");
            }
        } catch (Exception e) {
            out.println("<p class='error'>❌ DAO error: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        }
        
        // Navigation
        out.println("<hr>");
        out.println("<h3>🔗 Navigation</h3>");
        out.println("<p>");
        out.println("<a href='" + request.getContextPath() + "/'>Dashboard</a> | ");
        out.println("<a href='" + request.getContextPath() + "/supplier?action=list'>Suppliers</a> | ");
        out.println("<a href='" + request.getContextPath() + "/test-database'>Full Test</a>");
        out.println("</p>");
        
        out.println("</body></html>");
    }
}