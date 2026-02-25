package servlet;

import dao.TravelRevenueDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.TravelRevenue;
import util.DatabaseConnection;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

/**
 * Servlet để test database connection và dữ liệu TravelRevenue
 */
@WebServlet(name = "TestDatabaseConnectionServlet", urlPatterns = {"/test-db-connection"})
public class TestDatabaseConnectionServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Database Connection Test</title>");
        out.println("<style>");
        out.println("body { font-family: Arial, sans-serif; margin: 40px; }");
        out.println(".success { color: green; font-weight: bold; }");
        out.println(".error { color: red; font-weight: bold; }");
        out.println(".info { color: blue; }");
        out.println("table { border-collapse: collapse; width: 100%; margin-top: 20px; }");
        out.println("th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }");
        out.println("th { background-color: #4CAF50; color: white; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        
        out.println("<h1>Database Connection Test - TravelRevenue System</h1>");
        out.println("<hr>");
        
        // Test 1: Database Connection
        out.println("<h2>Test 1: Database Connection</h2>");
        try {
            Connection conn = DatabaseConnection.getConnection();
            if (conn != null && !conn.isClosed()) {
                out.println("<p class='success'>✓ Database connection successful!</p>");
                out.println("<p class='info'>Connection: " + conn.toString() + "</p>");
                conn.close();
            } else {
                out.println("<p class='error'>✗ Database connection failed - connection is null or closed</p>");
            }
        } catch (Exception e) {
            out.println("<p class='error'>✗ Database connection error: " + e.getMessage() + "</p>");
            out.println("<pre>");
            e.printStackTrace(out);
            out.println("</pre>");
        }
        
        // Test 2: TravelRevenueDAO - Load All Revenue
        out.println("<h2>Test 2: TravelRevenueDAO - Load All Revenue Records</h2>");
        try {
            TravelRevenueDAO dao = new TravelRevenueDAO();
            List<TravelRevenue> revenues = dao.getAllRevenue();
            
            if (revenues != null) {
                out.println("<p class='success'>✓ Successfully loaded " + revenues.size() + " revenue records</p>");
                
                if (revenues.size() > 0) {
                    out.println("<p class='info'>Showing first 10 records:</p>");
                    out.println("<table>");
                    out.println("<tr>");
                    out.println("<th>ID</th>");
                    out.println("<th>Month/Year</th>");
                    out.println("<th>Category</th>");
                    out.println("<th>Supplier Name</th>");
                    out.println("<th>Revenue (Billion)</th>");
                    out.println("<th>Guest Count</th>");
                    out.println("</tr>");
                    
                    int count = 0;
                    for (TravelRevenue r : revenues) {
                        if (count >= 10) break;
                        out.println("<tr>");
                        out.println("<td>" + r.getId() + "</td>");
                        out.println("<td>" + r.getReportMonth() + "/" + r.getReportYear() + "</td>");
                        out.println("<td>" + r.getCategory() + "</td>");
                        out.println("<td>" + r.getSupplierName() + "</td>");
                        out.println("<td>" + (r.getEstimatedRevenueBillion() != null ? r.getEstimatedRevenueBillion() : "N/A") + "</td>");
                        out.println("<td>" + (r.getGuestCount() != null ? r.getGuestCount() : "N/A") + "</td>");
                        out.println("</tr>");
                        count++;
                    }
                    
                    out.println("</table>");
                } else {
                    out.println("<p class='error'>✗ No revenue records found in database!</p>");
                    out.println("<p>Please run the database setup script:</p>");
                    out.println("<ol>");
                    out.println("<li>database/TravelRevenue.sql</li>");
                    out.println("</ol>");
                }
            } else {
                out.println("<p class='error'>✗ Revenue list is null</p>");
            }
        } catch (Exception e) {
            out.println("<p class='error'>✗ Error loading revenue records: " + e.getMessage() + "</p>");
            out.println("<pre>");
            e.printStackTrace(out);
            out.println("</pre>");
        }
        
        // Test 3: Latest Month/Year
        out.println("<h2>Test 3: Get Latest Month/Year</h2>");
        try {
            TravelRevenueDAO dao = new TravelRevenueDAO();
            Map<String, Integer> latestDate = dao.getLatestMonthYear();
            
            if (latestDate != null && !latestDate.isEmpty()) {
                int year = latestDate.getOrDefault("year", 0);
                int month = latestDate.getOrDefault("month", 0);
                out.println("<p class='success'>✓ Latest data: " + month + "/" + year + "</p>");
            } else {
                out.println("<p class='error'>✗ No latest date found</p>");
            }
        } catch (Exception e) {
            out.println("<p class='error'>✗ Error: " + e.getMessage() + "</p>");
        }
        
        // Test 4: Revenue Statistics
        out.println("<h2>Test 4: Revenue Statistics for 2025</h2>");
        try {
            TravelRevenueDAO dao = new TravelRevenueDAO();
            
            Double totalRevenue = dao.getTotalRevenueByYear(2025);
            Integer totalGuests = dao.getTotalGuestsByYear(2025);
            
            out.println("<p class='info'>Total Revenue 2025: " + (totalRevenue != null ? totalRevenue : 0.0) + " billion VND</p>");
            out.println("<p class='info'>Total Guests 2025: " + (totalGuests != null ? totalGuests : 0) + "</p>");
        } catch (Exception e) {
            out.println("<p class='error'>✗ Error: " + e.getMessage() + "</p>");
        }
        
        // Test 5: Top Hotels
        out.println("<h2>Test 5: Top 5 Hotels by Revenue (2025)</h2>");
        try {
            TravelRevenueDAO dao = new TravelRevenueDAO();
            List<TravelRevenue> topHotels = dao.getTopHotelsByRevenue(2025, 5);
            
            if (topHotels != null && topHotels.size() > 0) {
                out.println("<p class='success'>✓ Found " + topHotels.size() + " hotels</p>");
                out.println("<table>");
                out.println("<tr><th>Rank</th><th>Hotel Name</th><th>Revenue (Billion)</th><th>Guests</th></tr>");
                int rank = 1;
                for (TravelRevenue h : topHotels) {
                    out.println("<tr>");
                    out.println("<td>" + rank++ + "</td>");
                    out.println("<td>" + h.getSupplierName() + "</td>");
                    out.println("<td>" + (h.getEstimatedRevenueBillion() != null ? h.getEstimatedRevenueBillion() : "N/A") + "</td>");
                    out.println("<td>" + (h.getGuestCount() != null ? h.getGuestCount() : "N/A") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            } else {
                out.println("<p class='error'>✗ No hotel data found for 2025</p>");
            }
        } catch (Exception e) {
            out.println("<p class='error'>✗ Error: " + e.getMessage() + "</p>");
        }
        
        // Test 6: Top Airlines
        out.println("<h2>Test 6: Top 5 Airlines by Revenue (2025)</h2>");
        try {
            TravelRevenueDAO dao = new TravelRevenueDAO();
            List<TravelRevenue> topAirlines = dao.getTopAirlinesByRevenue(2025, 5);
            
            if (topAirlines != null && topAirlines.size() > 0) {
                out.println("<p class='success'>✓ Found " + topAirlines.size() + " airlines</p>");
                out.println("<table>");
                out.println("<tr><th>Rank</th><th>Airline Name</th><th>Revenue (Billion)</th><th>Passengers</th></tr>");
                int rank = 1;
                for (TravelRevenue a : topAirlines) {
                    out.println("<tr>");
                    out.println("<td>" + rank++ + "</td>");
                    out.println("<td>" + a.getSupplierName() + "</td>");
                    out.println("<td>" + (a.getEstimatedRevenueBillion() != null ? a.getEstimatedRevenueBillion() : "N/A") + "</td>");
                    out.println("<td>" + (a.getGuestCount() != null ? a.getGuestCount() : "N/A") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            } else {
                out.println("<p class='error'>✗ No airline data found for 2025</p>");
            }
        } catch (Exception e) {
            out.println("<p class='error'>✗ Error: " + e.getMessage() + "</p>");
        }
        
        out.println("<hr>");
        out.println("<p><a href='" + request.getContextPath() + "/'>Back to Dashboard</a></p>");
        
        out.println("</body>");
        out.println("</html>");
    }
}
