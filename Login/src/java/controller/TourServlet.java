package controller;
import service.TourService;
import model.Tour;
import util.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/tour")
public class TourServlet extends HttpServlet {
    private TourService tourService;
    
    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DatabaseConnection.getNewConnection();
            tourService = new TourService(connection);
        } catch (SQLException e) {
            throw new ServletException("Database connection failed", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if (action == null || action.equals("list")) {
                listTours(request, response);
            } else if (action.equals("add")) {
                showAddForm(request, response);
            } else if (action.equals("view")) {
                viewTour(request, response);
            } else if (action.equals("edit")) {
                editTour(request, response);
            } else if (action.equals("delete")) {
                deleteTour(request, response);
            } else if (action.equals("search")) {
                searchTours(request, response);
            } else if (action.equals("available")) {
                listAvailableTours(request, response);
            } else if (action.equals("featured")) {
                getFeaturedTours(request, response);
            } else if (action.equals("analytics")) {
                getAnalyticsData(request, response);
            } else if (action.equals("current-month")) {
                getCurrentMonthTours(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if (action.equals("create")) {
                createTour(request, response);
            } else if (action.equals("update")) {
                updateTour(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
    
    private void listTours(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        // Pagination parameters
        int page = 1;
        int toursPerPage = 12;
        
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.trim().isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        // Get filter parameters
        String search = request.getParameter("search");
        String destination = request.getParameter("destination");
        String sortBy = request.getParameter("sortBy");
        
        // Get all tours
        List<Tour> allTours = tourService.getAllTours();
        
        // Apply search filter
        if (search != null && !search.trim().isEmpty()) {
            final String query = search.toLowerCase();
            allTours = allTours.stream()
                .filter(t -> t.getTourName().toLowerCase().contains(query) ||
                           (t.getStartLocation() != null && t.getStartLocation().toLowerCase().contains(query)))
                .collect(java.util.stream.Collectors.toList());
            request.setAttribute("searchQuery", search);
        }
        
        // Apply destination filter
        if (destination != null && !destination.trim().isEmpty()) {
            allTours = tourService.searchToursByDestination(destination);
            request.setAttribute("searchDestination", destination);
        }
        
        // Apply sorting
        if (sortBy != null && !sortBy.trim().isEmpty()) {
            switch (sortBy) {
                case "name":
                    allTours.sort((t1, t2) -> t1.getTourName().compareTo(t2.getTourName()));
                    break;
                case "price_asc":
                    allTours.sort((t1, t2) -> Double.compare(t1.getPrice(), t2.getPrice()));
                    break;
                case "price_desc":
                    allTours.sort((t1, t2) -> Double.compare(t2.getPrice(), t1.getPrice()));
                    break;
                case "date":
                    allTours.sort((t1, t2) -> {
                        if (t1.getCreatedAt() == null || t2.getCreatedAt() == null) return 0;
                        return t1.getCreatedAt().compareTo(t2.getCreatedAt());
                    });
                    break;
                case "available":
                    allTours.sort((t1, t2) -> Integer.compare(t2.getMaxPeople(), t1.getMaxPeople()));
                    break;
            }
            request.setAttribute("sortBy", sortBy);
        }
        
        // Calculate pagination
        int totalTours = allTours.size();
        int totalPages = (int) Math.ceil((double) totalTours / toursPerPage);
        
        // Get tours for current page
        int startIndex = (page - 1) * toursPerPage;
        int endIndex = Math.min(startIndex + toursPerPage, totalTours);
        List<Tour> tours = allTours.subList(startIndex, endIndex);
        
        request.setAttribute("tours", tours);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalTours", totalTours);
        request.getRequestDispatcher("/jsp/tour-list.jsp").forward(request, response);
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/tour-form.jsp").forward(request, response);
    }
    
    private void listAvailableTours(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        List<Tour> tours = tourService.getAvailableTours();
        request.setAttribute("tours", tours);
        request.setAttribute("availableOnly", true);
        request.getRequestDispatcher("/jsp/tour-list.jsp").forward(request, response);
    }
    
    private void viewTour(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Tour tour = tourService.getTourById(id);
        
        // Tính giá theo mùa
        double seasonalPrice = tourService.calculateSeasonalPrice(tour);
        request.setAttribute("tour", tour);
        request.setAttribute("seasonalPrice", seasonalPrice);
        
        // Log tour view nếu có customer ID
        String customerIdParam = request.getParameter("customerId");
        if (customerIdParam != null) {
            int customerId = Integer.parseInt(customerIdParam);
            tourService.logTourView(customerId, id);
        }
        
        request.getRequestDispatcher("/jsp/tour-view.jsp").forward(request, response);
    }
    
    private void editTour(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Tour tour = tourService.getTourById(id);
        request.setAttribute("tour", tour);
        request.getRequestDispatcher("/tour-form.jsp").forward(request, response);
    }
    
    private void createTour(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        Tour tour = new Tour();
        tour.setTourName(request.getParameter("name"));
        tour.setStartLocation(request.getParameter("destination"));
        tour.setDuration(request.getParameter("duration"));
        tour.setPrice(Double.parseDouble(request.getParameter("price")));
        tour.setMaxPeople(Integer.parseInt(request.getParameter("maxCapacity")));
        tour.setDescription(request.getParameter("description"));
        
        tourService.createTour(tour);
        response.sendRedirect("tour?action=list&success=created");
    }
    
    private void updateTour(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        Tour tour = new Tour();
        tour.setTourId(Integer.parseInt(request.getParameter("id")));
        tour.setTourName(request.getParameter("name"));
        tour.setStartLocation(request.getParameter("destination"));
        tour.setDuration(request.getParameter("duration"));
        tour.setPrice(Double.parseDouble(request.getParameter("price")));
        tour.setMaxPeople(Integer.parseInt(request.getParameter("maxCapacity")));
        tour.setDescription(request.getParameter("description"));
        
        tourService.updateTour(tour);
        response.sendRedirect("tour?action=view&id=" + tour.getTourId() + "&success=updated");
    }
    
    private void deleteTour(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        tourService.deleteTour(id);
        response.sendRedirect("tour?action=list&success=deleted");
    }
    
    private void searchTours(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        String destination = request.getParameter("destination");
        String monthParam = request.getParameter("month");
        String priceRange = request.getParameter("priceRange");
        
        Integer month = null;
        if (monthParam != null && !monthParam.trim().isEmpty()) {
            try {
                month = Integer.parseInt(monthParam);
            } catch (NumberFormatException e) {
                // Ignore invalid month
            }
        }
        
        List<Tour> tours = tourService.searchTours(destination, month, priceRange);
        
        request.setAttribute("tours", tours);
        request.setAttribute("searchDestination", destination);
        request.setAttribute("searchMonth", month);
        request.setAttribute("searchPriceRange", priceRange);
        
        // Log search nếu có customer ID
        String customerIdParam = request.getParameter("customerId");
        if (customerIdParam != null) {
            int customerId = Integer.parseInt(customerIdParam);
            tourService.logTourSearch(customerId, destination);
        }
        
        request.getRequestDispatcher("/jsp/tour-list.jsp").forward(request, response);
    }
    
    private void getFeaturedTours(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        // Lấy tours nổi bật (giá cao, booking nhiều)
        List<Tour> tours = tourService.getFeaturedTours(6);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        StringBuilder json = new StringBuilder("{\"tours\":[");
        for (int i = 0; i < tours.size(); i++) {
            Tour tour = tours.get(i);
            if (i > 0) json.append(",");
            json.append("{")
                .append("\"id\":").append(tour.getTourId()).append(",")
                .append("\"name\":\"").append(escapeJson(tour.getTourName())).append("\",")
                .append("\"destination\":\"").append(escapeJson(tour.getStartLocation())).append("\",")
                .append("\"price\":").append(tour.getPrice()).append(",")
                .append("\"maxCapacity\":").append(tour.getMaxPeople())
                .append("}");
        }
        json.append("]}");
        
        response.getWriter().write(json.toString());
    }
    
    private void getAnalyticsData(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        // Lấy TẤT CẢ tours (kể cả cũ) để phân tích
        List<Tour> tours = tourService.getAllToursIncludingPast();
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        StringBuilder json = new StringBuilder("{\"tours\":[");
        for (int i = 0; i < tours.size(); i++) {
            Tour tour = tours.get(i);
            if (i > 0) json.append(",");
            json.append("{")
                .append("\"id\":").append(tour.getTourId()).append(",")
                .append("\"name\":\"").append(escapeJson(tour.getTourName())).append("\",")
                .append("\"destination\":\"").append(escapeJson(tour.getStartLocation())).append("\",")
                .append("\"startDate\":\"").append(tour.getCreatedAt()).append("\",")
                .append("\"price\":").append(tour.getPrice()).append(",")
                .append("\"maxCapacity\":").append(tour.getMaxPeople())
                .append("}");
        }
        json.append("]}");
        
        response.getWriter().write(json.toString());
    }
    
    private void getCurrentMonthTours(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        // Lấy tours trong tháng hiện tại
        LocalDate now = LocalDate.now();
        int currentMonth = now.getMonthValue();
        int currentYear = now.getYear();
        
        List<Tour> tours = tourService.getToursByMonth(currentYear, currentMonth);
        
        request.setAttribute("tours", tours);
        request.setAttribute("currentMonth", currentMonth);
        request.setAttribute("currentYear", currentYear);
        request.getRequestDispatcher("/jsp/tour-list.jsp").forward(request, response);
    }
    
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}
