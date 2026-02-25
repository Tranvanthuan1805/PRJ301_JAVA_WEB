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

@WebServlet(name = "TestDataServlet", urlPatterns = {"/test-data"})
public class TestDataServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html><head><meta charset='UTF-8'><title>Test Data</title></head><body>");
        out.println("<h1>Test Database Connection & Data</h1>");
        
        try {
            TravelRevenueDAO dao = new TravelRevenueDAO();
            
            // Test 1: Get all revenue
            out.println("<h2>Test 1: Get All Revenue</h2>");
            List<TravelRevenue> allRevenue = dao.getAllRevenue();
            out.println("<p>Total records: " + allRevenue.size() + "</p>");
            
            if (!allRevenue.isEmpty()) {
                out.println("<table border='1' style='border-collapse: collapse;'>");
                out.println("<tr><th>ID</th><th>Year</th><th>Month</th><th>Category</th><th>Supplier</th><th>Revenue</th></tr>");
                for (int i = 0; i < Math.min(10, allRevenue.size()); i++) {
                    TravelRevenue r = allRevenue.get(i);
                    out.println("<tr>");
                    out.println("<td>" + r.getId() + "</td>");
                    out.println("<td>" + r.getReportYear() + "</td>");
                    out.println("<td>" + r.getReportMonth() + "</td>");
                    out.println("<td>" + r.getCategory() + "</td>");
                    out.println("<td>" + r.getSupplierName() + "</td>");
                    out.println("<td>" + r.getEstimatedRevenueBillion() + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            }
            
            // Test 2: Total revenue all years
            out.println("<h2>Test 2: Total Revenue All Years</h2>");
            Double totalRevenue = dao.getTotalRevenueAllYears();
            out.println("<p>Total Revenue: " + totalRevenue + " tỷ VNĐ</p>");
            
            // Test 3: Total guests all years
            out.println("<h2>Test 3: Total Guests All Years</h2>");
            Integer totalGuests = dao.getTotalGuestsAllYears();
            out.println("<p>Total Guests: " + totalGuests + "</p>");
            
            // Test 4: Top hotels
            out.println("<h2>Test 4: Top Hotels (All Years)</h2>");
            List<TravelRevenue> topHotels = dao.getTopHotelsByRevenueAllYears(5);
            out.println("<p>Top hotels count: " + topHotels.size() + "</p>");
            if (!topHotels.isEmpty()) {
                out.println("<ul>");
                for (TravelRevenue hotel : topHotels) {
                    out.println("<li>" + hotel.getSupplierName() + " - " + hotel.getEstimatedRevenueBillion() + " tỷ VNĐ</li>");
                }
                out.println("</ul>");
            }
            
            // Test 5: Top airlines
            out.println("<h2>Test 5: Top Airlines (All Years)</h2>");
            List<TravelRevenue> topAirlines = dao.getTopAirlinesByRevenueAllYears(5);
            out.println("<p>Top airlines count: " + topAirlines.size() + "</p>");
            if (!topAirlines.isEmpty()) {
                out.println("<ul>");
                for (TravelRevenue airline : topAirlines) {
                    out.println("<li>" + airline.getSupplierName() + " - " + airline.getEstimatedRevenueBillion() + " tỷ VNĐ</li>");
                }
                out.println("</ul>");
            }
            
            // Test 6: Check categories
            out.println("<h2>Test 6: Check Categories in Database</h2>");
            List<TravelRevenue> hotels = dao.getRevenueByCategory("Khách sạn");
            out.println("<p>Hotels found: " + hotels.size() + "</p>");
            
            List<TravelRevenue> airlines = dao.getRevenueByCategory("Hàng không");
            out.println("<p>Airlines found: " + airlines.size() + "</p>");
            
            out.println("<h2 style='color: green;'>✓ All tests completed!</h2>");
            
        } catch (Exception e) {
            out.println("<h2 style='color: red;'>ERROR: " + e.getMessage() + "</h2>");
            out.println("<pre>");
            e.printStackTrace(out);
            out.println("</pre>");
        }
        
        out.println("<br><br><a href='" + request.getContextPath() + "/'>Back to Dashboard</a>");
        out.println("</body></html>");
    }
}
