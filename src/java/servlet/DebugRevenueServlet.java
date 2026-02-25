package servlet;

import dao.TravelRevenueDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.TravelRevenue;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

/**
 * Debug servlet to check TravelRevenue data
 */
@WebServlet(name = "DebugRevenueServlet", urlPatterns = {"/debug-revenue"})
public class DebugRevenueServlet extends HttpServlet {
    
    private TravelRevenueDAO revenueDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        revenueDAO = new TravelRevenueDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html><head><meta charset='UTF-8'><title>Debug Revenue Data</title>");
        out.println("<style>body{font-family:monospace;padding:20px;} table{border-collapse:collapse;margin:20px 0;} th,td{border:1px solid #ddd;padding:8px;text-align:left;} th{background:#f0f0f0;}</style>");
        out.println("</head><body>");
        out.println("<h1>Debug TravelRevenue Data</h1>");
        
        // Test 1: Get latest month/year
        out.println("<h2>1. Latest Month/Year</h2>");
        Map<String, Integer> latestDate = revenueDAO.getLatestMonthYear();
        out.println("<p>Year: " + latestDate.getOrDefault("year", 0) + "</p>");
        out.println("<p>Month: " + latestDate.getOrDefault("month", 0) + "</p>");
        
        int currentYear = latestDate.getOrDefault("year", 2025);
        int currentMonth = latestDate.getOrDefault("month", 1);
        
        // Test 2: Get all revenue (first 10)
        out.println("<h2>2. All Revenue Records (First 10)</h2>");
        List<TravelRevenue> allRevenue = revenueDAO.getAllRevenue();
        out.println("<p>Total records: " + allRevenue.size() + "</p>");
        out.println("<table><tr><th>ID</th><th>Year</th><th>Month</th><th>Category</th><th>Supplier</th><th>Revenue</th><th>Guests</th></tr>");
        for (int i = 0; i < Math.min(10, allRevenue.size()); i++) {
            TravelRevenue r = allRevenue.get(i);
            out.println("<tr>");
            out.println("<td>" + r.getId() + "</td>");
            out.println("<td>" + r.getReportYear() + "</td>");
            out.println("<td>" + r.getReportMonth() + "</td>");
            out.println("<td>" + r.getCategory() + "</td>");
            out.println("<td>" + r.getSupplierName() + "</td>");
            out.println("<td>" + r.getEstimatedRevenueBillion() + "</td>");
            out.println("<td>" + r.getGuestCount() + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
        
        // Test 3: Get hotels by category
        out.println("<h2>3. Hotels by Category (First 10)</h2>");
        List<TravelRevenue> hotels = revenueDAO.getRevenueByCategory("Khách sạn");
        out.println("<p>Total hotel records: " + hotels.size() + "</p>");
        out.println("<table><tr><th>Year</th><th>Month</th><th>Category</th><th>Supplier</th><th>Revenue</th></tr>");
        for (int i = 0; i < Math.min(10, hotels.size()); i++) {
            TravelRevenue h = hotels.get(i);
            out.println("<tr>");
            out.println("<td>" + h.getReportYear() + "</td>");
            out.println("<td>" + h.getReportMonth() + "</td>");
            out.println("<td>" + h.getCategory() + "</td>");
            out.println("<td>" + h.getSupplierName() + "</td>");
            out.println("<td>" + h.getEstimatedRevenueBillion() + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
        
        // Test 4: Get airlines by category
        out.println("<h2>4. Airlines by Category (First 10)</h2>");
        List<TravelRevenue> airlines = revenueDAO.getRevenueByCategory("Hàng không");
        out.println("<p>Total airline records: " + airlines.size() + "</p>");
        out.println("<table><tr><th>Year</th><th>Month</th><th>Category</th><th>Supplier</th><th>Revenue</th></tr>");
        for (int i = 0; i < Math.min(10, airlines.size()); i++) {
            TravelRevenue a = airlines.get(i);
            out.println("<tr>");
            out.println("<td>" + a.getReportYear() + "</td>");
            out.println("<td>" + a.getReportMonth() + "</td>");
            out.println("<td>" + a.getCategory() + "</td>");
            out.println("<td>" + a.getSupplierName() + "</td>");
            out.println("<td>" + a.getEstimatedRevenueBillion() + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
        
        // Test 5: Top hotels by revenue
        out.println("<h2>5. Top 5 Hotels by Revenue (" + currentYear + ")</h2>");
        List<TravelRevenue> topHotels = revenueDAO.getTopHotelsByRevenue(currentYear, 5);
        out.println("<p>Count: " + topHotels.size() + "</p>");
        out.println("<table><tr><th>Supplier</th><th>Total Revenue</th><th>Avg Price</th><th>Total Guests</th></tr>");
        for (TravelRevenue h : topHotels) {
            out.println("<tr>");
            out.println("<td>" + h.getSupplierName() + "</td>");
            out.println("<td>" + h.getEstimatedRevenueBillion() + "</td>");
            out.println("<td>" + h.getAvgHotelPriceVND() + "</td>");
            out.println("<td>" + h.getGuestCount() + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
        
        // Test 6: Top airlines by revenue
        out.println("<h2>6. Top 5 Airlines by Revenue (" + currentYear + ")</h2>");
        List<TravelRevenue> topAirlines = revenueDAO.getTopAirlinesByRevenue(currentYear, 5);
        out.println("<p>Count: " + topAirlines.size() + "</p>");
        out.println("<table><tr><th>Supplier</th><th>Total Revenue</th><th>Avg Ticket</th><th>Total Passengers</th></tr>");
        for (TravelRevenue a : topAirlines) {
            out.println("<tr>");
            out.println("<td>" + a.getSupplierName() + "</td>");
            out.println("<td>" + a.getEstimatedRevenueBillion() + "</td>");
            out.println("<td>" + a.getAvgFlightTicketVND() + "</td>");
            out.println("<td>" + a.getGuestCount() + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
        
        // Test 7: Total revenue by year
        out.println("<h2>7. Total Revenue by Year</h2>");
        out.println("<table><tr><th>Year</th><th>Total Revenue</th></tr>");
        for (int year = 2020; year <= 2025; year++) {
            Double totalRevenue = revenueDAO.getTotalRevenueByYear(year);
            out.println("<tr><td>" + year + "</td><td>" + totalRevenue + "</td></tr>");
        }
        out.println("</table>");
        
        out.println("<hr><p><a href='" + request.getContextPath() + "/'>Back to Dashboard</a></p>");
        out.println("</body></html>");
    }
}
