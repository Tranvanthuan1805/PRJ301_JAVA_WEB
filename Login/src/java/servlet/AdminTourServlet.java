package servlet;

import dao.TourDAO;
import model.Tour;
import util.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/admin/tours")
public class AdminTourServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check admin access
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        
        if (username == null || !"ADMIN".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        try {
            listTours(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
    
    private void listTours(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        Connection conn = DatabaseConnection.getNewConnection();
        TourDAO tourDAO = new TourDAO(conn);
        
        // Get filter parameters
        String searchQuery = request.getParameter("search");
        String destinationFilter = request.getParameter("destination");
        String statusFilter = request.getParameter("status");
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        
        // Get pagination parameters
        int page = 1;
        int pageSize = 10;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        // Get all tours
        List<Tour> allTours = tourDAO.getAllTours();
        
        // Apply search filter
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            final String query = searchQuery.toLowerCase();
            allTours = allTours.stream()
                .filter(t -> t.getName().toLowerCase().contains(query) ||
                           t.getDestination().toLowerCase().contains(query))
                .collect(Collectors.toList());
        }
        
        // Apply destination filter
        if (destinationFilter != null && !destinationFilter.isEmpty() && !destinationFilter.equals("all")) {
            allTours = allTours.stream()
                .filter(t -> t.getDestination().equalsIgnoreCase(destinationFilter))
                .collect(Collectors.toList());
        }
        
        // Apply status filter
        if (statusFilter != null && !statusFilter.isEmpty() && !statusFilter.equals("all")) {
            if (statusFilter.equals("available")) {
                allTours = allTours.stream()
                    .filter(t -> t.getCurrentCapacity() < t.getMaxCapacity())
                    .collect(Collectors.toList());
            } else if (statusFilter.equals("full")) {
                allTours = allTours.stream()
                    .filter(t -> t.getCurrentCapacity() >= t.getMaxCapacity())
                    .collect(Collectors.toList());
            }
        }
        
        // Apply sorting
        if (sortBy != null && !sortBy.isEmpty()) {
            boolean ascending = sortOrder == null || sortOrder.equals("asc");
            
            switch (sortBy) {
                case "name":
                    allTours.sort((t1, t2) -> t1.getName().compareTo(t2.getName()));
                    break;
                case "destination":
                    allTours.sort((t1, t2) -> t1.getDestination().compareTo(t2.getDestination()));
                    break;
                case "price":
                    allTours.sort((t1, t2) -> Double.compare(t1.getPrice(), t2.getPrice()));
                    break;
                case "price_desc":
                    allTours.sort((t1, t2) -> Double.compare(t2.getPrice(), t1.getPrice()));
                    break;
                case "date":
                    allTours.sort((t1, t2) -> t1.getStartDate().compareTo(t2.getStartDate()));
                    break;
                case "available":
                    allTours.sort((t1, t2) -> {
                        int available1 = t1.getMaxCapacity() - t1.getCurrentCapacity();
                        int available2 = t2.getMaxCapacity() - t2.getCurrentCapacity();
                        return Integer.compare(available2, available1); // Descending
                    });
                    break;
            }
        }
        
        // Calculate pagination
        int totalTours = allTours.size();
        int totalPages = (int) Math.ceil((double) totalTours / pageSize);
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalTours);
        
        List<Tour> tours = allTours.subList(startIndex, endIndex);
        
        // Set attributes
        request.setAttribute("tours", tours);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalTours", totalTours);
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("destinationFilter", destinationFilter);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);
        
        request.getRequestDispatcher("/admin/tours.jsp").forward(request, response);
    }
}
