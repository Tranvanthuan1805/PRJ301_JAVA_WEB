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
 * Servlet để test kết nối database và debug
 */
@WebServlet(name = "TestDatabaseServlet", urlPatterns = {"/test-db"})
public class TestDatabaseServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html lang='vi'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<title>Database Test - TourManager</title>");
        out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css' rel='stylesheet'>");
        out.println("<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css'>");
        out.println("</head>");
        out.println("<body class='bg-light'>");
        out.println("<div class='container mt-4'>");
        out.println("<div class='row'>");
        out.println("<div class='col-12'>");
        
        out.println("<div class='card shadow'>");
        out.println("<div class='card-header bg-primary text-white'>");
        out.println("<h4 class='mb-0'><i class='fas fa-database me-2'></i>TourManager Database Test</h4>");
        out.println("</div>");
        out.println("<div class='card-body'>");
        
        // Test 1: Basic Connection
        out.println("<h5><i class='fas fa-plug me-2'></i>1. Test Database Connection</h5>");
        try {
            boolean connectionTest = DatabaseConnection.testConnection();
            String dbInfo = DatabaseConnection.getDatabaseInfo();
            
            if (connectionTest) {
                out.println("<div class='alert alert-success'>");
                out.println("<i class='fas fa-check-circle me-2'></i><strong>SUCCESS:</strong> Database connection established!");
                out.println("<br><strong>Info:</strong> " + dbInfo);
                out.println("</div>");
            } else {
                out.println("<div class='alert alert-danger'>");
                out.println("<i class='fas fa-times-circle me-2'></i><strong>FAILED:</strong> Cannot establish database connection!");
                out.println("<br><strong>Info:</strong> " + dbInfo);
                out.println("</div>");
            }
        } catch (Exception e) {
            out.println("<div class='alert alert-danger'>");
            out.println("<i class='fas fa-exclamation-triangle me-2'></i><strong>ERROR:</strong> " + e.getMessage());
            out.println("</div>");
        }
        
        // Test 2: Check Database Schema
        out.println("<h5 class='mt-4'><i class='fas fa-table me-2'></i>2. Check Database Schema</h5>");
        try (Connection conn = DatabaseConnection.getConnection()) {
            if (conn != null) {
                Statement stmt = conn.createStatement();
                
                // Check database name
                ResultSet dbRs = stmt.executeQuery("SELECT DB_NAME() as DatabaseName");
                if (dbRs.next()) {
                    String dbName = dbRs.getString("DatabaseName");
                    out.println("<div class='alert alert-info'>");
                    out.println("<i class='fas fa-info-circle me-2'></i><strong>Connected to database: " + dbName + "</strong>");
                    out.println("</div>");
                }
                
                // Check if Suppliers table exists and get structure
                try {
                    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as TableCount FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Suppliers'");
                    if (rs.next() && rs.getInt("TableCount") > 0) {
                        out.println("<div class='alert alert-success'>");
                        out.println("<i class='fas fa-check me-2'></i><strong>Table 'Suppliers' exists</strong>");
                        out.println("</div>");
                        
                        // Count records
                        ResultSet countRs = stmt.executeQuery("SELECT COUNT(*) as RecordCount FROM Suppliers");
                        if (countRs.next()) {
                            int recordCount = countRs.getInt("RecordCount");
                            out.println("<div class='alert alert-info'>");
                            out.println("<i class='fas fa-chart-bar me-2'></i><strong>Total records: " + recordCount + "</strong>");
                            out.println("</div>");
                        }
                        
                        // Show table structure
                        ResultSet structureRs = stmt.executeQuery(
                            "SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, CHARACTER_MAXIMUM_LENGTH " +
                            "FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Suppliers' " +
                            "ORDER BY ORDINAL_POSITION"
                        );
                        
                        out.println("<h6>Table Structure:</h6>");
                        out.println("<div class='table-responsive'>");
                        out.println("<table class='table table-sm table-bordered'>");
                        out.println("<thead><tr><th>Column</th><th>Type</th><th>Nullable</th><th>Length</th></tr></thead>");
                        out.println("<tbody>");
                        
                        while (structureRs.next()) {
                            out.println("<tr>");
                            out.println("<td><code>" + structureRs.getString("COLUMN_NAME") + "</code></td>");
                            out.println("<td>" + structureRs.getString("DATA_TYPE") + "</td>");
                            out.println("<td>" + structureRs.getString("IS_NULLABLE") + "</td>");
                            out.println("<td>" + (structureRs.getString("CHARACTER_MAXIMUM_LENGTH") != null ? 
                                       structureRs.getString("CHARACTER_MAXIMUM_LENGTH") : "N/A") + "</td>");
                            out.println("</tr>");
                        }
                        
                        out.println("</tbody></table>");
                        out.println("</div>");
                        
                    } else {
                        out.println("<div class='alert alert-warning'>");
                        out.println("<i class='fas fa-exclamation-triangle me-2'></i><strong>Table 'Suppliers' does not exist!</strong>");
                        out.println("<br>Please run the database script: <code>database/simple_database.sql</code> or <code>database/fix_database.sql</code>");
                        out.println("</div>");
                    }
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger'>");
                    out.println("<i class='fas fa-times me-2'></i><strong>Error checking table:</strong> " + e.getMessage());
                    out.println("</div>");
                }
            }
        } catch (Exception e) {
            out.println("<div class='alert alert-danger'>");
            out.println("<i class='fas fa-exclamation-triangle me-2'></i><strong>Connection Error:</strong> " + e.getMessage());
            out.println("</div>");
        }
        
        // Test 3: Test DAO
        out.println("<h5 class='mt-4'><i class='fas fa-code me-2'></i>3. Test SupplierDAO</h5>");
        try {
            SupplierDAO supplierDAO = new SupplierDAO();
            List<Supplier> suppliers = supplierDAO.selectAllSuppliers();
            
            if (suppliers != null) {
                out.println("<div class='alert alert-success'>");
                out.println("<i class='fas fa-check me-2'></i><strong>DAO Test SUCCESS:</strong> Retrieved " + suppliers.size() + " suppliers");
                out.println("</div>");
                
                if (suppliers.size() > 0) {
                    out.println("<h6>Sample Data:</h6>");
                    out.println("<div class='table-responsive'>");
                    out.println("<table class='table table-striped table-sm'>");
                    out.println("<thead><tr><th>ID</th><th>Code</th><th>Name</th><th>Service Type</th><th>Status</th><th>Price</th><th>City</th></tr></thead>");
                    out.println("<tbody>");
                    
                    int count = 0;
                    for (Supplier supplier : suppliers) {
                        if (count >= 5) break; // Show only first 5
                        out.println("<tr>");
                        out.println("<td>" + supplier.getSupplierID() + "</td>");
                        out.println("<td>" + (supplier.getSupplierCode() != null ? supplier.getSupplierCode() : "N/A") + "</td>");
                        out.println("<td>" + supplier.getSupplierName() + "</td>");
                        out.println("<td><span class='badge bg-primary'>" + supplier.getServiceType() + "</span></td>");
                        out.println("<td><span class='badge bg-success'>" + supplier.getStatus() + "</span></td>");
                        out.println("<td>" + (supplier.getBasePrice() != null ? 
                                   String.format("%,.0f VND", supplier.getBasePrice()) : "N/A") + "</td>");
                        out.println("<td>" + (supplier.getCity() != null ? supplier.getCity() : "N/A") + "</td>");
                        out.println("</tr>");
                        count++;
                    }
                    
                    out.println("</tbody></table>");
                    out.println("</div>");
                    
                    if (suppliers.size() > 5) {
                        out.println("<p class='text-muted'>... and " + (suppliers.size() - 5) + " more records</p>");
                    }
                }
            } else {
                out.println("<div class='alert alert-warning'>");
                out.println("<i class='fas fa-exclamation-triangle me-2'></i><strong>DAO returned null</strong>");
                out.println("</div>");
            }
        } catch (Exception e) {
            out.println("<div class='alert alert-danger'>");
            out.println("<i class='fas fa-times me-2'></i><strong>DAO Error:</strong> " + e.getMessage());
            out.println("<br><strong>Stack trace:</strong>");
            out.println("<pre class='mt-2'>");
            e.printStackTrace(out);
            out.println("</pre>");
            out.println("</div>");
        }
        
        // Test 4: Service Type Statistics
        out.println("<h5 class='mt-4'><i class='fas fa-chart-pie me-2'></i>4. Service Type Statistics</h5>");
        try (Connection conn = DatabaseConnection.getConnection()) {
            if (conn != null) {
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(
                    "SELECT ServiceType, COUNT(*) as Count, AVG(BasePrice) as AvgPrice, " +
                    "MIN(BasePrice) as MinPrice, MAX(BasePrice) as MaxPrice " +
                    "FROM Suppliers GROUP BY ServiceType ORDER BY Count DESC"
                );
                
                out.println("<div class='alert alert-success'>");
                out.println("<i class='fas fa-check me-2'></i><strong>Statistics Query SUCCESS</strong>");
                out.println("</div>");
                
                out.println("<div class='table-responsive'>");
                out.println("<table class='table table-bordered table-sm'>");
                out.println("<thead><tr><th>Service Type</th><th>Count</th><th>Avg Price</th><th>Min Price</th><th>Max Price</th></tr></thead>");
                out.println("<tbody>");
                
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td><span class='badge bg-primary'>" + rs.getString("ServiceType") + "</span></td>");
                    out.println("<td><strong>" + rs.getInt("Count") + "</strong></td>");
                    out.println("<td>" + String.format("%,.0f VND", rs.getDouble("AvgPrice")) + "</td>");
                    out.println("<td>" + String.format("%,.0f VND", rs.getDouble("MinPrice")) + "</td>");
                    out.println("<td>" + String.format("%,.0f VND", rs.getDouble("MaxPrice")) + "</td>");
                    out.println("</tr>");
                }
                
                out.println("</tbody></table>");
                out.println("</div>");
            }
        } catch (Exception e) {
            out.println("<div class='alert alert-danger'>");
            out.println("<i class='fas fa-times me-2'></i><strong>Statistics Error:</strong> " + e.getMessage());
            out.println("</div>");
        }
        
        // Navigation
        out.println("<div class='mt-4'>");
        out.println("<a href='" + request.getContextPath() + "/' class='btn btn-primary me-2'>");
        out.println("<i class='fas fa-home me-1'></i>Dashboard");
        out.println("</a>");
        out.println("<a href='" + request.getContextPath() + "/supplier?action=list' class='btn btn-success me-2'>");
        out.println("<i class='fas fa-building me-1'></i>Suppliers");
        out.println("</a>");
        out.println("<a href='" + request.getContextPath() + "/test-connection.jsp' class='btn btn-info'>");
        out.println("<i class='fas fa-flask me-1'></i>Connection Test");
        out.println("</a>");
        out.println("</div>");
        
        out.println("</div>"); // card-body
        out.println("</div>"); // card
        out.println("</div>"); // col
        out.println("</div>"); // row
        out.println("</div>"); // container
        out.println("</body>");
        out.println("</html>");
    }
}