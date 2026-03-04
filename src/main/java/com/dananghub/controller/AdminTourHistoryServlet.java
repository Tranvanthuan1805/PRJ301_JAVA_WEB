package com.dananghub.controller;

import com.dananghub.dao.TourDAO;
import com.dananghub.entity.Tour;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/admin/tour-history")
public class AdminTourHistoryServlet extends HttpServlet {
    
    private final TourDAO tourDAO = new TourDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Get filter parameters
        String search = request.getParameter("search");
        
        // Pagination
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        int pageSize = 10;
        
        // Get historical tours (before 2026)
        List<Tour> allTours = tourDAO.getHistoricalTours();
        
        // Apply search filter
        if (search != null && !search.trim().isEmpty()) {
            final String query = search.toLowerCase().trim();
            allTours = allTours.stream()
                .filter(t -> t.getName().toLowerCase().contains(query) ||
                           (t.getDestination() != null && t.getDestination().toLowerCase().contains(query)))
                .collect(Collectors.toList());
            request.setAttribute("searchQuery", search);
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
        request.setAttribute("allTours", allTours); // For charts
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalTours", totalTours);
        request.setAttribute("pageSize", pageSize);
        
        // Forward to JSP
        request.getRequestDispatcher("/admin/tour-history.jsp").forward(request, response);
    }
}
