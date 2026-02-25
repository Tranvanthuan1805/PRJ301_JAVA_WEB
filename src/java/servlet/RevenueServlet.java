package servlet;

import dao.TravelRevenueDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.TravelRevenue;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Servlet xử lý quản lý nhà cung cấp (Khách sạn và Hàng không)
 * Dựa trên dữ liệu TravelRevenue
 */
@WebServlet(name = "RevenueServlet", urlPatterns = {"/revenue"})
public class RevenueServlet extends HttpServlet {
    
    private TravelRevenueDAO revenueDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        revenueDAO = new TravelRevenueDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        try {
            switch (action) {
                case "list":
                    listAllRevenue(request, response);
                    break;
                case "hotels":
                    listHotels(request, response);
                    break;
                case "airlines":
                    listAirlines(request, response);
                    break;
                case "monthly":
                    showMonthlyReport(request, response);
                    break;
                case "yearly":
                    showYearlyReport(request, response);
                    break;
                case "compare":
                    showComparison(request, response);
                    break;
                case "viewHotel":
                    viewHotelDetails(request, response);
                    break;
                case "viewAirline":
                    viewAirlineDetails(request, response);
                    break;
                case "deleteHotel":
                    deleteHotel(request, response);
                    break;
                case "deleteAirline":
                    deleteAirline(request, response);
                    break;
                case "editHotel":
                    showEditHotelForm(request, response);
                    break;
                case "editAirline":
                    showEditAirlineForm(request, response);
                    break;
                default:
                    listAllRevenue(request, response);
                    break;
            }
        } catch (Exception e) {
            System.err.println("ERROR in RevenueServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    /**
     * Hiển thị danh sách tất cả doanh thu
     */
    private void listAllRevenue(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("DEBUG: Loading all revenue records");
        
        List<TravelRevenue> revenues = revenueDAO.getAllRevenue();
        request.setAttribute("revenues", revenues);
        request.setAttribute("totalRecords", revenues != null ? revenues.size() : 0);
        
        request.getRequestDispatcher("/revenue/list.jsp").forward(request, response);
    }
    
    /**
     * Hiển thị danh sách khách sạn và thống kê
     */
    private void listHotels(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("DEBUG: Loading hotels data");
        
        // Lấy năm từ parameter hoặc dùng năm mới nhất
        String yearParam = request.getParameter("year");
        int selectedYear = 2025; // Default
        
        if (yearParam != null && !yearParam.isEmpty()) {
            try {
                selectedYear = Integer.parseInt(yearParam);
            } catch (NumberFormatException e) {
                System.err.println("Invalid year parameter: " + yearParam);
            }
        } else {
            // Lấy năm mới nhất từ database
            Map<String, Integer> latestDate = revenueDAO.getLatestMonthYear();
            selectedYear = latestDate.getOrDefault("year", 2025);
        }
        
        // Tạo biến final để dùng trong lambda
        final int year = selectedYear;
        
        // Lấy top khách sạn theo doanh thu
        List<TravelRevenue> topHotels = revenueDAO.getTopHotelsByRevenue(year, 10);
        
        // Lấy tổng doanh thu khách sạn
        List<TravelRevenue> allHotels = revenueDAO.getRevenueByCategory("Khách sạn");
        double hotelTotalRevenue = allHotels.stream()
            .filter(h -> h.getReportYear() == year)
            .mapToDouble(h -> h.getEstimatedRevenueBillion() != null ? h.getEstimatedRevenueBillion() : 0.0)
            .sum();
        
        int hotelTotalGuests = allHotels.stream()
            .filter(h -> h.getReportYear() == year)
            .mapToInt(h -> h.getGuestCount() != null ? h.getGuestCount() : 0)
            .sum();
        
        request.setAttribute("topHotels", topHotels);
        request.setAttribute("totalRevenue", hotelTotalRevenue);
        request.setAttribute("totalGuests", hotelTotalGuests);
        request.setAttribute("selectedYear", year);
        
        request.getRequestDispatcher("/revenue/hotels.jsp").forward(request, response);
    }
    
    /**
     * Hiển thị danh sách hãng hàng không và thống kê
     */
    private void listAirlines(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("DEBUG: Loading airlines data");
        
        // Lấy năm từ parameter hoặc dùng năm mới nhất
        String yearParam = request.getParameter("year");
        int selectedYear = 2025; // Default
        
        if (yearParam != null && !yearParam.isEmpty()) {
            try {
                selectedYear = Integer.parseInt(yearParam);
            } catch (NumberFormatException e) {
                System.err.println("Invalid year parameter: " + yearParam);
            }
        } else {
            // Lấy năm mới nhất từ database
            Map<String, Integer> latestDate = revenueDAO.getLatestMonthYear();
            selectedYear = latestDate.getOrDefault("year", 2025);
        }
        
        // Tạo biến final để dùng trong lambda
        final int year = selectedYear;
        
        // Lấy top hãng hàng không theo doanh thu
        List<TravelRevenue> topAirlines = revenueDAO.getTopAirlinesByRevenue(year, 10);
        
        // Lấy tổng doanh thu hàng không
        List<TravelRevenue> allAirlines = revenueDAO.getRevenueByCategory("Hàng không");
        double airlineTotalRevenue = allAirlines.stream()
            .filter(a -> a.getReportYear() == year)
            .mapToDouble(a -> a.getEstimatedRevenueBillion() != null ? a.getEstimatedRevenueBillion() : 0.0)
            .sum();
        
        int airlineTotalPassengers = allAirlines.stream()
            .filter(a -> a.getReportYear() == year)
            .mapToInt(a -> a.getGuestCount() != null ? a.getGuestCount() : 0)
            .sum();
        
        request.setAttribute("topAirlines", topAirlines);
        request.setAttribute("totalRevenue", airlineTotalRevenue);
        request.setAttribute("totalPassengers", airlineTotalPassengers);
        request.setAttribute("selectedYear", year);
        
        request.getRequestDispatcher("/revenue/airlines.jsp").forward(request, response);
    }
    
    /**
     * Hiển thị báo cáo theo tháng
     */
    private void showMonthlyReport(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("DEBUG: Loading monthly report");
        
        // Lấy năm từ parameter
        String yearParam = request.getParameter("year");
        int year = 2025; // Default
        
        if (yearParam != null && !yearParam.isEmpty()) {
            try {
                year = Integer.parseInt(yearParam);
            } catch (NumberFormatException e) {
                System.err.println("Invalid year parameter: " + yearParam);
            }
        } else {
            Map<String, Integer> latestDate = revenueDAO.getLatestMonthYear();
            year = latestDate.getOrDefault("year", 2025);
        }
        
        // Lấy xu hướng doanh thu theo tháng
        List<Map<String, Object>> monthlyTrend = revenueDAO.getMonthlyRevenueTrend(year);
        
        request.setAttribute("monthlyTrend", monthlyTrend);
        request.setAttribute("selectedYear", year);
        
        request.getRequestDispatcher("/revenue/monthly.jsp").forward(request, response);
    }
    
    /**
     * Hiển thị báo cáo theo năm
     */
    private void showYearlyReport(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("DEBUG: Loading yearly report");
        
        // Tính toán doanh thu cho các năm 2020-2025
        List<Map<String, Object>> yearlyData = new ArrayList<>();
        
        for (int year = 2020; year <= 2025; year++) {
            Double totalRevenue = revenueDAO.getTotalRevenueByYear(year);
            Integer totalGuests = revenueDAO.getTotalGuestsByYear(year);
            
            Map<String, Object> yearData = new java.util.HashMap<>();
            yearData.put("year", year);
            yearData.put("revenue", totalRevenue != null ? totalRevenue : 0.0);
            yearData.put("guests", totalGuests != null ? totalGuests : 0);
            
            yearlyData.add(yearData);
        }
        
        request.setAttribute("yearlyData", yearlyData);
        
        request.getRequestDispatcher("/revenue/yearly.jsp").forward(request, response);
    }
    
    /**
     * Hiển thị trang so sánh chất lượng
     */
    private void showComparison(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("DEBUG: Loading comparison page");
        
        // Lấy category và year từ parameters
        String category = request.getParameter("category");
        if (category == null || category.isEmpty()) {
            category = "hotels";
        }
        
        String yearParam = request.getParameter("year");
        int selectedYear = 2025;
        
        if (yearParam != null && !yearParam.isEmpty()) {
            try {
                selectedYear = Integer.parseInt(yearParam);
            } catch (NumberFormatException e) {
                System.err.println("Invalid year parameter: " + yearParam);
            }
        } else {
            Map<String, Integer> latestDate = revenueDAO.getLatestMonthYear();
            selectedYear = latestDate.getOrDefault("year", 2025);
        }
        
        // Lấy dữ liệu để so sánh
        List<Map<String, Object>> comparisonData = new ArrayList<>();
        
        if ("hotels".equals(category)) {
            List<TravelRevenue> topHotels = revenueDAO.getTopHotelsByRevenue(selectedYear, 10);
            
            // Tìm max values để tính phần trăm
            double maxRevenue = topHotels.stream()
                .mapToDouble(h -> h.getEstimatedRevenueBillion() != null ? h.getEstimatedRevenueBillion() : 0.0)
                .max().orElse(1.0);
            
            double maxPrice = topHotels.stream()
                .filter(h -> h.getAvgHotelPriceVND() != null)
                .mapToDouble(h -> h.getAvgHotelPriceVND().doubleValue())
                .max().orElse(1.0);
            
            int maxGuests = topHotels.stream()
                .mapToInt(h -> h.getGuestCount() != null ? h.getGuestCount() : 0)
                .max().orElse(1);
            
            for (TravelRevenue hotel : topHotels) {
                Map<String, Object> item = new java.util.HashMap<>();
                
                double revenue = hotel.getEstimatedRevenueBillion() != null ? hotel.getEstimatedRevenueBillion() : 0.0;
                double price = hotel.getAvgHotelPriceVND() != null ? hotel.getAvgHotelPriceVND().doubleValue() : 0.0;
                int guests = hotel.getGuestCount() != null ? hotel.getGuestCount() : 0;
                
                // Tính điểm chất lượng (0-100)
                double revenueScore = (revenue / maxRevenue) * 40; // 40% weight
                double priceScore = (price / maxPrice) * 30; // 30% weight (giá cao = chất lượng cao)
                double guestScore = ((double) guests / maxGuests) * 30; // 30% weight
                int qualityScore = (int) Math.round(revenueScore + priceScore + guestScore);
                
                item.put("supplierName", hotel.getSupplierName());
                item.put("estimatedRevenueBillion", revenue);
                item.put("avgHotelPriceVND", hotel.getAvgHotelPriceVND());
                item.put("guestCount", guests);
                item.put("qualityScore", qualityScore);
                
                // Tính phần trăm cho progress bars
                item.put("revenuePercent", (int) ((revenue / maxRevenue) * 100));
                item.put("pricePercent", (int) ((price / maxPrice) * 100));
                item.put("guestPercent", (int) (((double) guests / maxGuests) * 100));
                
                // Xác định class cho màu sắc
                item.put("revenueClass", getMetricClass((revenue / maxRevenue) * 100));
                item.put("priceClass", getMetricClass((price / maxPrice) * 100));
                item.put("guestClass", getMetricClass(((double) guests / maxGuests) * 100));
                
                comparisonData.add(item);
            }
            
        } else if ("airlines".equals(category)) {
            List<TravelRevenue> topAirlines = revenueDAO.getTopAirlinesByRevenue(selectedYear, 10);
            
            // Tìm max values
            double maxRevenue = topAirlines.stream()
                .mapToDouble(a -> a.getEstimatedRevenueBillion() != null ? a.getEstimatedRevenueBillion() : 0.0)
                .max().orElse(1.0);
            
            double maxPrice = topAirlines.stream()
                .filter(a -> a.getAvgFlightTicketVND() != null)
                .mapToDouble(a -> a.getAvgFlightTicketVND().doubleValue())
                .max().orElse(1.0);
            
            int maxPassengers = topAirlines.stream()
                .mapToInt(a -> a.getGuestCount() != null ? a.getGuestCount() : 0)
                .max().orElse(1);
            
            for (TravelRevenue airline : topAirlines) {
                Map<String, Object> item = new java.util.HashMap<>();
                
                double revenue = airline.getEstimatedRevenueBillion() != null ? airline.getEstimatedRevenueBillion() : 0.0;
                double price = airline.getAvgFlightTicketVND() != null ? airline.getAvgFlightTicketVND().doubleValue() : 0.0;
                int passengers = airline.getGuestCount() != null ? airline.getGuestCount() : 0;
                
                // Tính điểm chất lượng
                double revenueScore = (revenue / maxRevenue) * 40;
                double priceScore = (price / maxPrice) * 30;
                double passengerScore = ((double) passengers / maxPassengers) * 30;
                int qualityScore = (int) Math.round(revenueScore + priceScore + passengerScore);
                
                item.put("supplierName", airline.getSupplierName());
                item.put("estimatedRevenueBillion", revenue);
                item.put("avgFlightTicketVND", airline.getAvgFlightTicketVND());
                item.put("guestCount", passengers);
                item.put("qualityScore", qualityScore);
                
                item.put("revenuePercent", (int) ((revenue / maxRevenue) * 100));
                item.put("pricePercent", (int) ((price / maxPrice) * 100));
                item.put("guestPercent", (int) (((double) passengers / maxPassengers) * 100));
                
                item.put("revenueClass", getMetricClass((revenue / maxRevenue) * 100));
                item.put("priceClass", getMetricClass((price / maxPrice) * 100));
                item.put("guestClass", getMetricClass(((double) passengers / maxPassengers) * 100));
                
                comparisonData.add(item);
            }
        }
        
        request.setAttribute("comparisonData", comparisonData);
        request.setAttribute("category", category);
        request.setAttribute("selectedYear", selectedYear);
        
        request.getRequestDispatcher("/revenue/compare.jsp").forward(request, response);
    }
    
    /**
     * Hiển thị chi tiết khách sạn
     */
    private void viewHotelDetails(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String hotelName = request.getParameter("name");
        String yearParam = request.getParameter("year");
        int year = 2025;
        
        if (yearParam != null && !yearParam.isEmpty()) {
            try {
                year = Integer.parseInt(yearParam);
            } catch (NumberFormatException e) {
                System.err.println("Invalid year parameter: " + yearParam);
            }
        }
        
        System.out.println("DEBUG: Viewing hotel details: " + hotelName + " for year " + year);
        
        // Lấy dữ liệu chi tiết
        List<TravelRevenue> monthlyData = revenueDAO.getHotelDetailsByYear(hotelName, year);
        
        // Tính tổng
        double totalRevenue = monthlyData.stream()
            .mapToDouble(h -> h.getEstimatedRevenueBillion() != null ? h.getEstimatedRevenueBillion() : 0.0)
            .sum();
        
        int totalGuests = monthlyData.stream()
            .mapToInt(h -> h.getGuestCount() != null ? h.getGuestCount() : 0)
            .sum();
        
        double avgPrice = monthlyData.stream()
            .filter(h -> h.getAvgHotelPriceVND() != null)
            .mapToDouble(h -> h.getAvgHotelPriceVND().doubleValue())
            .average()
            .orElse(0.0);
        
        request.setAttribute("hotelName", hotelName);
        request.setAttribute("selectedYear", year);
        request.setAttribute("monthlyData", monthlyData);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalGuests", totalGuests);
        request.setAttribute("avgPrice", avgPrice);
        request.setAttribute("recordCount", monthlyData.size());
        
        request.getRequestDispatcher("/revenue/view-hotel.jsp").forward(request, response);
    }
    
    /**
     * Hiển thị chi tiết hãng hàng không
     */
    private void viewAirlineDetails(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String airlineName = request.getParameter("name");
        String yearParam = request.getParameter("year");
        int year = 2025;
        
        if (yearParam != null && !yearParam.isEmpty()) {
            try {
                year = Integer.parseInt(yearParam);
            } catch (NumberFormatException e) {
                System.err.println("Invalid year parameter: " + yearParam);
            }
        }
        
        System.out.println("DEBUG: Viewing airline details: " + airlineName + " for year " + year);
        
        // Lấy dữ liệu chi tiết
        List<TravelRevenue> monthlyData = revenueDAO.getAirlineDetailsByYear(airlineName, year);
        
        // Tính tổng
        double totalRevenue = monthlyData.stream()
            .mapToDouble(a -> a.getEstimatedRevenueBillion() != null ? a.getEstimatedRevenueBillion() : 0.0)
            .sum();
        
        int totalPassengers = monthlyData.stream()
            .mapToInt(a -> a.getGuestCount() != null ? a.getGuestCount() : 0)
            .sum();
        
        double avgTicketPrice = monthlyData.stream()
            .filter(a -> a.getAvgFlightTicketVND() != null)
            .mapToDouble(a -> a.getAvgFlightTicketVND().doubleValue())
            .average()
            .orElse(0.0);
        
        request.setAttribute("airlineName", airlineName);
        request.setAttribute("selectedYear", year);
        request.setAttribute("monthlyData", monthlyData);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalPassengers", totalPassengers);
        request.setAttribute("avgTicketPrice", avgTicketPrice);
        request.setAttribute("recordCount", monthlyData.size());
        
        request.getRequestDispatcher("/revenue/view-airline.jsp").forward(request, response);
    }
    
    /**
     * Xóa khách sạn
     */
    private void deleteHotel(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String hotelName = request.getParameter("name");
        System.out.println("DEBUG: Deleting hotel: " + hotelName);
        
        boolean success = revenueDAO.deleteSupplier(hotelName);
        
        if (success) {
            request.getSession().setAttribute("message", "Đã xóa khách sạn '" + hotelName + "' thành công!");
            request.getSession().setAttribute("messageType", "success");
        } else {
            request.getSession().setAttribute("message", "Lỗi khi xóa khách sạn '" + hotelName + "'!");
            request.getSession().setAttribute("messageType", "danger");
        }
        
        response.sendRedirect(request.getContextPath() + "/revenue?action=hotels");
    }
    
    /**
     * Xóa hãng hàng không
     */
    private void deleteAirline(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String airlineName = request.getParameter("name");
        System.out.println("DEBUG: Deleting airline: " + airlineName);
        
        boolean success = revenueDAO.deleteSupplier(airlineName);
        
        if (success) {
            request.getSession().setAttribute("message", "Đã xóa hãng hàng không '" + airlineName + "' thành công!");
            request.getSession().setAttribute("messageType", "success");
        } else {
            request.getSession().setAttribute("message", "Lỗi khi xóa hãng hàng không '" + airlineName + "'!");
            request.getSession().setAttribute("messageType", "danger");
        }
        
        response.sendRedirect(request.getContextPath() + "/revenue?action=airlines");
    }
    
    /**
     * Helper method để xác định class màu sắc dựa trên phần trăm
     */
    private String getMetricClass(double percent) {
        if (percent >= 80) return "metric-excellent";
        if (percent >= 60) return "metric-good";
        if (percent >= 40) return "metric-average";
        return "metric-poor";
    }
    
    /**
     * Hiển thị form chỉnh sửa khách sạn
     */
    private void showEditHotelForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String hotelName = request.getParameter("name");
        System.out.println("DEBUG: Loading edit form for hotel: " + hotelName);
        
        // Lấy tất cả dữ liệu của khách sạn (tất cả các năm)
        List<TravelRevenue> monthlyData = revenueDAO.getAllHotelData(hotelName);
        
        request.setAttribute("hotelName", hotelName);
        request.setAttribute("monthlyData", monthlyData);
        
        request.getRequestDispatcher("/revenue/edit-hotel.jsp").forward(request, response);
    }
    
    /**
     * Hiển thị form chỉnh sửa hãng hàng không
     */
    private void showEditAirlineForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String airlineName = request.getParameter("name");
        System.out.println("DEBUG: Loading edit form for airline: " + airlineName);
        
        // Lấy tất cả dữ liệu của hãng hàng không (tất cả các năm)
        List<TravelRevenue> monthlyData = revenueDAO.getAllAirlineData(airlineName);
        
        request.setAttribute("airlineName", airlineName);
        request.setAttribute("monthlyData", monthlyData);
        
        request.getRequestDispatcher("/revenue/edit-airline.jsp").forward(request, response);
    }
    
    /**
     * Cập nhật thông tin khách sạn
     */
    private void updateHotel(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String originalName = request.getParameter("originalName");
        String newName = request.getParameter("supplierName");
        
        System.out.println("DEBUG: Updating hotel from '" + originalName + "' to '" + newName + "'");
        
        // Cập nhật tên nếu thay đổi
        boolean nameUpdated = true;
        if (!originalName.equals(newName)) {
            nameUpdated = revenueDAO.updateSupplierName(originalName, newName);
        }
        
        if (!nameUpdated) {
            request.getSession().setAttribute("message", "Lỗi khi cập nhật tên khách sạn!");
            request.getSession().setAttribute("messageType", "danger");
            response.sendRedirect(request.getContextPath() + "/revenue?action=hotels");
            return;
        }
        
        // Cập nhật dữ liệu từng tháng
        boolean allUpdated = true;
        java.util.Enumeration<String> paramNames = request.getParameterNames();
        
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            
            if (paramName.startsWith("recordId_")) {
                String recordIdStr = request.getParameter(paramName);
                int recordId = Integer.parseInt(recordIdStr);
                
                String revenueStr = request.getParameter("revenue_" + recordId);
                String priceStr = request.getParameter("price_" + recordId);
                String guestsStr = request.getParameter("guests_" + recordId);
                
                Double revenue = (revenueStr != null && !revenueStr.isEmpty()) ? Double.parseDouble(revenueStr) : null;
                java.math.BigDecimal price = (priceStr != null && !priceStr.isEmpty()) ? new java.math.BigDecimal(priceStr) : null;
                Integer guests = (guestsStr != null && !guestsStr.isEmpty()) ? Integer.parseInt(guestsStr) : null;
                
                boolean updated = revenueDAO.updateHotelRecord(recordId, revenue, price, guests);
                if (!updated) {
                    allUpdated = false;
                }
            }
        }
        
        if (allUpdated) {
            request.getSession().setAttribute("message", "Đã cập nhật khách sạn '" + newName + "' thành công!");
            request.getSession().setAttribute("messageType", "success");
        } else {
            request.getSession().setAttribute("message", "Cập nhật một số dữ liệu thất bại!");
            request.getSession().setAttribute("messageType", "warning");
        }
        
        response.sendRedirect(request.getContextPath() + "/revenue?action=hotels");
    }
    
    /**
     * Cập nhật thông tin hãng hàng không
     */
    private void updateAirline(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String originalName = request.getParameter("originalName");
        String newName = request.getParameter("supplierName");
        
        System.out.println("DEBUG: Updating airline from '" + originalName + "' to '" + newName + "'");
        
        // Cập nhật tên nếu thay đổi
        boolean nameUpdated = true;
        if (!originalName.equals(newName)) {
            nameUpdated = revenueDAO.updateSupplierName(originalName, newName);
        }
        
        if (!nameUpdated) {
            request.getSession().setAttribute("message", "Lỗi khi cập nhật tên hãng hàng không!");
            request.getSession().setAttribute("messageType", "danger");
            response.sendRedirect(request.getContextPath() + "/revenue?action=airlines");
            return;
        }
        
        // Cập nhật dữ liệu từng tháng
        boolean allUpdated = true;
        java.util.Enumeration<String> paramNames = request.getParameterNames();
        
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            
            if (paramName.startsWith("recordId_")) {
                String recordIdStr = request.getParameter(paramName);
                int recordId = Integer.parseInt(recordIdStr);
                
                String revenueStr = request.getParameter("revenue_" + recordId);
                String ticketPriceStr = request.getParameter("ticketPrice_" + recordId);
                String passengersStr = request.getParameter("passengers_" + recordId);
                
                Double revenue = (revenueStr != null && !revenueStr.isEmpty()) ? Double.parseDouble(revenueStr) : null;
                java.math.BigDecimal ticketPrice = (ticketPriceStr != null && !ticketPriceStr.isEmpty()) ? new java.math.BigDecimal(ticketPriceStr) : null;
                Integer passengers = (passengersStr != null && !passengersStr.isEmpty()) ? Integer.parseInt(passengersStr) : null;
                
                boolean updated = revenueDAO.updateAirlineRecord(recordId, revenue, ticketPrice, passengers);
                if (!updated) {
                    allUpdated = false;
                }
            }
        }
        
        if (allUpdated) {
            request.getSession().setAttribute("message", "Đã cập nhật hãng hàng không '" + newName + "' thành công!");
            request.getSession().setAttribute("messageType", "success");
        } else {
            request.getSession().setAttribute("message", "Cập nhật một số dữ liệu thất bại!");
            request.getSession().setAttribute("messageType", "warning");
        }
        
        response.sendRedirect(request.getContextPath() + "/revenue?action=airlines");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if ("updateHotel".equals(action)) {
                updateHotel(request, response);
            } else if ("updateAirline".equals(action)) {
                updateAirline(request, response);
            } else {
                doGet(request, response);
            }
        } catch (Exception e) {
            System.err.println("ERROR in doPost: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
