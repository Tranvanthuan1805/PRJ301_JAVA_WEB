package controller;

import dao.TourDAO;
import model.Tour;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

/**
 * AdminTourHistoryServlet - View historical tours (before 2026)
 * Admin only
 */
@WebServlet("/admin/tour-history")
public class AdminTourHistoryServlet extends HttpServlet {
    
    private TourDAO tourDAO;
    
    @Override
    public void init() throws ServletException {
        tourDAO = new TourDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check admin authentication
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        
        if (username == null || !"ADMIN".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Pagination parameters
        int page = 1;
        int pageSize = 20;
        
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.trim().isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        // Search parameter
        String search = request.getParameter("search");
        
        // Get all historical tours
        List<Tour> allTours = tourDAO.getHistoricalTours();
        
        // Apply search filter
        if (search != null && !search.trim().isEmpty()) {
            final String query = search.toLowerCase().trim();
            allTours = allTours.stream()
                .filter(t -> t.getTourName().toLowerCase().contains(query) ||
                           (t.getStartLocation() != null && t.getStartLocation().toLowerCase().contains(query)))
                .collect(Collectors.toList());
            request.setAttribute("search", search);
        }
        
        // Calculate pagination
        int totalTours = allTours.size();
        int totalPages = (int) Math.ceil((double) totalTours / pageSize);
        if (totalPages == 0) totalPages = 1;
        if (page > totalPages) page = totalPages;
        
        // Get tours for current page
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalTours);
        List<Tour> tours = allTours.subList(startIndex, endIndex);
        
        // Set attributes
        request.setAttribute("tours", tours);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalTours", totalTours);
        request.setAttribute("pageSize", pageSize);
        
        // Forward to history page
        request.getRequestDispatcher("/admin/history.jsp").forward(request, response);
    }
}
