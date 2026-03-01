package controller;

import dao.TourDAO;
import model.Tour;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

/**
 * ExploreServlet - Guest Tour Exploration
 * Allows guests to browse 2026 tours with search, filter, and pagination
 */
@WebServlet("/explore")
public class ExploreServlet extends HttpServlet {
    
    private TourDAO tourDAO;
    
    @Override
    public void init() throws ServletException {
        tourDAO = new TourDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Pagination parameters
        int page = 1;
        int pageSize = 12;
        
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.trim().isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        // Filter parameters
        String search = request.getParameter("search");
        String availableOnly = request.getParameter("available");
        String sortBy = request.getParameter("sort");
        
        // Get all active tours
        List<Tour> allTours = tourDAO.getAllActiveTours();
        
        // Apply search filter
        if (search != null && !search.trim().isEmpty()) {
            final String query = search.toLowerCase().trim();
            allTours = allTours.stream()
                .filter(t -> t.getTourName().toLowerCase().contains(query) ||
                           (t.getStartLocation() != null && t.getStartLocation().toLowerCase().contains(query)) ||
                           (t.getDescription() != null && t.getDescription().toLowerCase().contains(query)))
                .collect(Collectors.toList());
            request.setAttribute("search", search);
        }
        
        // Apply available filter (tours with available slots)
        if ("true".equals(availableOnly)) {
            allTours = allTours.stream()
                .filter(t -> t.getMaxPeople() > 0)
                .collect(Collectors.toList());
            request.setAttribute("availableOnly", true);
        }
        
        // Apply sorting
        if (sortBy != null && !sortBy.trim().isEmpty()) {
            switch (sortBy) {
                case "name_asc":
                    allTours.sort((t1, t2) -> t1.getTourName().compareToIgnoreCase(t2.getTourName()));
                    break;
                case "name_desc":
                    allTours.sort((t1, t2) -> t2.getTourName().compareToIgnoreCase(t1.getTourName()));
                    break;
                case "price_asc":
                    allTours.sort((t1, t2) -> Double.compare(t1.getPrice(), t2.getPrice()));
                    break;
                case "price_desc":
                    allTours.sort((t1, t2) -> Double.compare(t2.getPrice(), t1.getPrice()));
                    break;
                default:
                    // Default: A-Z
                    allTours.sort((t1, t2) -> t1.getTourName().compareToIgnoreCase(t2.getTourName()));
            }
            request.setAttribute("sort", sortBy);
        } else {
            // Default sorting: A-Z
            allTours.sort((t1, t2) -> t1.getTourName().compareToIgnoreCase(t2.getTourName()));
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
        
        // Forward to explore page
        request.getRequestDispatcher("/explore.jsp").forward(request, response);
    }
}
