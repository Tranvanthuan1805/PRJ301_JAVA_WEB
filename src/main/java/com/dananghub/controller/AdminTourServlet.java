package com.dananghub.controller;

import com.dananghub.dao.TourDAO;
import com.dananghub.entity.Tour;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/admin/tours")
public class AdminTourServlet extends HttpServlet {
    
    private final TourDAO tourDAO = new TourDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Get filter parameters
        String search = request.getParameter("search");
        String destination = request.getParameter("destination");
        String status = request.getParameter("status");
        String sortBy = request.getParameter("sort");
        
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
        
        // Get all 2026 tours
        List<Tour> allTours = tourDAO.getAll2026Tours();
        
        // Apply search filter
        if (search != null && !search.trim().isEmpty()) {
            final String query = search.toLowerCase().trim();
            allTours = allTours.stream()
                .filter(t -> t.getName().toLowerCase().contains(query) ||
                           (t.getDestination() != null && t.getDestination().toLowerCase().contains(query)))
                .collect(Collectors.toList());
            request.setAttribute("searchQuery", search);
        }
        
        // Apply destination filter
        if (destination != null && !destination.trim().isEmpty() && !"all".equals(destination)) {
            final String dest = destination.trim();
            allTours = allTours.stream()
                .filter(t -> t.getDestination() != null && t.getDestination().equals(dest))
                .collect(Collectors.toList());
            request.setAttribute("destinationFilter", destination);
        }
        
        // Apply status filter
        if (status != null && !status.trim().isEmpty() && !"all".equals(status)) {
            if ("available".equals(status)) {
                allTours = allTours.stream()
                    .filter(t -> t.getCurrentCapacity() < t.getMaxCapacity())
                    .collect(Collectors.toList());
            } else if ("full".equals(status)) {
                allTours = allTours.stream()
                    .filter(t -> t.getCurrentCapacity() >= t.getMaxCapacity())
                    .collect(Collectors.toList());
            }
            request.setAttribute("statusFilter", status);
        }
        
        // Apply sorting
        if (sortBy != null && !sortBy.trim().isEmpty()) {
            switch (sortBy) {
                case "name":
                    allTours.sort((t1, t2) -> t1.getName().compareToIgnoreCase(t2.getName()));
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
                    allTours.sort((t1, t2) -> Integer.compare(
                        t2.getMaxCapacity() - t2.getCurrentCapacity(),
                        t1.getMaxCapacity() - t1.getCurrentCapacity()
                    ));
                    break;
            }
            request.setAttribute("sortBy", sortBy);
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
        
        // Forward to JSP
        request.getRequestDispatcher("/admin/tours.jsp").forward(request, response);
    }
}
