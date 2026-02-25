package servlet;

import dao.TravelRevenueDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.TravelRevenue;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Servlet để xử lý Dashboard và cung cấp dữ liệu thống kê doanh thu du lịch
 */
@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard", "/"})
public class DashboardServlet extends HttpServlet {
    
    private TravelRevenueDAO revenueDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        revenueDAO = new TravelRevenueDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("=== DashboardServlet.doGet() called ===");
        System.out.println("Request URI: " + request.getRequestURI());
        System.out.println("Context Path: " + request.getContextPath());
        
        try {
            // Lấy tháng/năm mới nhất
            Map<String, Integer> latestDate = revenueDAO.getLatestMonthYear();
            int currentYear = latestDate.getOrDefault("year", 2025);
            int currentMonth = latestDate.getOrDefault("month", 1);
            
            request.setAttribute("currentYear", currentYear);
            request.setAttribute("currentMonth", currentMonth);
            
            // Lấy dữ liệu thống kê
            loadDashboardStats(request, currentYear, currentMonth);
            
            // Lấy top khách sạn và hãng hàng không
            loadTopProviders(request, currentYear);
            
            // Lấy dữ liệu xu hướng doanh thu theo tháng
            loadMonthlyTrend(request, currentYear);
            
            System.out.println("=== Dashboard data loaded successfully ===");
            
            // Forward đến trang index.jsp
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("ERROR in DashboardServlet.doGet: " + e.getMessage());
            e.printStackTrace();
            
            // Set default values để tránh null
            request.setAttribute("totalRevenue", 0.0);
            request.setAttribute("totalGuests", 0);
            request.setAttribute("cheapestHotelPrice", BigDecimal.ZERO);
            request.setAttribute("cheapestFlightPrice", BigDecimal.ZERO);
            request.setAttribute("topHotels", new ArrayList<>());
            request.setAttribute("topAirlines", new ArrayList<>());
            
            // Nếu có lỗi, vẫn forward với dữ liệu mặc định
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
    
    /**
     * Tải dữ liệu thống kê cho dashboard
     */
    private void loadDashboardStats(HttpServletRequest request, int year, int month) {
        try {
            System.out.println("DEBUG: Loading dashboard stats - ALL YEARS (2020-2025)");
            
            // Tổng doanh thu TẤT CẢ các năm (2020-2025)
            Double totalRevenue = revenueDAO.getTotalRevenueAllYears();
            request.setAttribute("totalRevenue", totalRevenue != null ? totalRevenue : 0.0);
            System.out.println("DEBUG: Total revenue (ALL YEARS) = " + totalRevenue);
            
            // Tổng số khách/hành khách TẤT CẢ các năm
            Integer totalGuests = revenueDAO.getTotalGuestsAllYears();
            request.setAttribute("totalGuests", totalGuests != null ? totalGuests : 0);
            System.out.println("DEBUG: Total guests (ALL YEARS) = " + totalGuests);
            
            // Giá khách sạn rẻ nhất tháng hiện tại
            BigDecimal cheapestHotel = revenueDAO.getCheapestHotelPrice(year, month);
            request.setAttribute("cheapestHotelPrice", cheapestHotel != null ? cheapestHotel : BigDecimal.ZERO);
            System.out.println("DEBUG: Cheapest hotel price = " + cheapestHotel);
            
            // Giá vé máy bay rẻ nhất tháng hiện tại
            BigDecimal cheapestFlight = revenueDAO.getCheapestFlightTicket(year, month);
            request.setAttribute("cheapestFlightPrice", cheapestFlight != null ? cheapestFlight : BigDecimal.ZERO);
            System.out.println("DEBUG: Cheapest flight price = " + cheapestFlight);
            
        } catch (Exception e) {
            System.err.println("ERROR in loadDashboardStats: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("totalRevenue", 0.0);
            request.setAttribute("totalGuests", 0);
            request.setAttribute("cheapestHotelPrice", BigDecimal.ZERO);
            request.setAttribute("cheapestFlightPrice", BigDecimal.ZERO);
        }
    }
    
    /**
     * Tải top khách sạn và hãng hàng không
     */
    private void loadTopProviders(HttpServletRequest request, int year) {
        try {
            System.out.println("DEBUG: Loading top providers - ALL YEARS (2020-2025)");
            
            // Top 5 khách sạn theo doanh thu TẤT CẢ các năm
            List<TravelRevenue> topHotels = revenueDAO.getTopHotelsByRevenueAllYears(5);
            request.setAttribute("topHotels", topHotels != null ? topHotels : new ArrayList<>());
            System.out.println("DEBUG: Top hotels count (ALL YEARS) = " + (topHotels != null ? topHotels.size() : 0));
            
            // Top 5 hãng hàng không theo doanh thu TẤT CẢ các năm
            List<TravelRevenue> topAirlines = revenueDAO.getTopAirlinesByRevenueAllYears(5);
            request.setAttribute("topAirlines", topAirlines != null ? topAirlines : new ArrayList<>());
            System.out.println("DEBUG: Top airlines count (ALL YEARS) = " + (topAirlines != null ? topAirlines.size() : 0));
            
        } catch (Exception e) {
            System.err.println("ERROR in loadTopProviders: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("topHotels", new ArrayList<>());
            request.setAttribute("topAirlines", new ArrayList<>());
        }
    }
    
    /**
     * Tải xu hướng doanh thu theo tháng
     */
    private void loadMonthlyTrend(HttpServletRequest request, int year) {
        try {
            System.out.println("DEBUG: Loading monthly trend for year " + year);
            
            List<Map<String, Object>> monthlyTrend = revenueDAO.getMonthlyRevenueTrend(year);
            request.setAttribute("monthlyTrend", monthlyTrend != null ? monthlyTrend : new ArrayList<>());
            System.out.println("DEBUG: Monthly trend data points = " + (monthlyTrend != null ? monthlyTrend.size() : 0));
            
        } catch (Exception e) {
            System.err.println("ERROR in loadMonthlyTrend: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("monthlyTrend", new ArrayList<>());
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}