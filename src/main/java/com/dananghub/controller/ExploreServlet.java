package com.dananghub.controller;

import com.dananghub.dao.TourDAO;
import com.dananghub.entity.Tour;
import com.dananghub.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

/**
 * ExploreServlet - Guest Tour Exploration for 2026 Tours
 * Uses JPA/TourDAO instead of JDBC
 */
@WebServlet("/explore")
public class ExploreServlet extends HttpServlet {
    
    private TourDAO tourDAO;
    
    @Override
    public void init() throws ServletException {
        try {
            tourDAO = new TourDAO();
            System.out.println("ExploreServlet: TourDAO initialized successfully");
        } catch (Exception e) {
            System.err.println("ExploreServlet: Failed to initialize TourDAO");
            e.printStackTrace();
            throw new ServletException("Failed to initialize TourDAO", e);
        }
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
        String destination = request.getParameter("destination");
        String availableOnly = request.getParameter("available");
        String sortBy = request.getParameter("sort");
        
        try {
            // Get all active tours
            List<Tour> allTours = tourDAO.findAll();
            
            // Filter by year 2026
            allTours = allTours.stream()
                .filter(t -> {
                    if (t.getStartDate() != null) {
                        Calendar cal = Calendar.getInstance();
                        cal.setTime(t.getStartDate());
                        return cal.get(Calendar.YEAR) == 2026;
                    }
                    return false;
                })
                .collect(Collectors.toList());
            
            // Get unique destinations for dropdown
            List<String> destinations = allTours.stream()
                .map(Tour::getDestination)
                .filter(d -> d != null && !d.trim().isEmpty())
                .distinct()
                .sorted()
                .collect(Collectors.toList());
            
            System.out.println("ExploreServlet: Found " + destinations.size() + " unique destinations");
            for (String dest : destinations) {
                System.out.println("  - " + dest);
            }
            
            request.setAttribute("destinations", destinations);
            
            // Apply destination filter
            if (destination != null && !destination.trim().isEmpty()) {
                allTours = allTours.stream()
                    .filter(t -> destination.equals(t.getDestination()))
                    .collect(Collectors.toList());
                request.setAttribute("destination", destination);
            }
            
            // Apply search filter
            if (search != null && !search.trim().isEmpty()) {
                final String query = search.toLowerCase().trim();
                allTours = allTours.stream()
                    .filter(t -> 
                        (t.getName() != null && t.getName().toLowerCase().contains(query)) ||
                        (t.getDestination() != null && t.getDestination().toLowerCase().contains(query)) ||
                        (t.getDescription() != null && t.getDescription().toLowerCase().contains(query))
                    )
                    .collect(Collectors.toList());
                request.setAttribute("search", search);
            }
            
            // Apply available filter (tours with available slots)
            if ("true".equals(availableOnly)) {
                allTours = allTours.stream()
                    .filter(t -> t.getAvailableSlots() > 0)
                    .collect(Collectors.toList());
                request.setAttribute("availableOnly", true);
            }
            
            // Apply sorting
            if (sortBy != null && !sortBy.trim().isEmpty()) {
                switch (sortBy) {
                    case "name_asc":
                        allTours.sort((t1, t2) -> {
                            String n1 = t1.getName() != null ? t1.getName() : "";
                            String n2 = t2.getName() != null ? t2.getName() : "";
                            return n1.compareToIgnoreCase(n2);
                        });
                        break;
                    case "name_desc":
                        allTours.sort((t1, t2) -> {
                            String n1 = t1.getName() != null ? t1.getName() : "";
                            String n2 = t2.getName() != null ? t2.getName() : "";
                            return n2.compareToIgnoreCase(n1);
                        });
                        break;
                    case "price_asc":
                        allTours.sort((t1, t2) -> Double.compare(t1.getPrice(), t2.getPrice()));
                        break;
                    case "price_desc":
                        allTours.sort((t1, t2) -> Double.compare(t2.getPrice(), t1.getPrice()));
                        break;
                    default:
                        // Default: A-Z
                        allTours.sort((t1, t2) -> {
                            String n1 = t1.getName() != null ? t1.getName() : "";
                            String n2 = t2.getName() != null ? t2.getName() : "";
                            return n1.compareToIgnoreCase(n2);
                        });
                }
                request.setAttribute("sort", sortBy);
            } else {
                // Default sorting: A-Z
                allTours.sort((t1, t2) -> {
                    String n1 = t1.getName() != null ? t1.getName() : "";
                    String n2 = t2.getName() != null ? t2.getName() : "";
                    return n1.compareToIgnoreCase(n2);
                });
            }
            
            // Calculate pagination
            int totalTours = allTours.size();
            int totalPages = (int) Math.ceil((double) totalTours / pageSize);
            if (totalPages == 0) totalPages = 1;
            if (page > totalPages) page = totalPages;
            
            // Get tours for current page
            int startIndex = (page - 1) * pageSize;
            int endIndex = Math.min(startIndex + pageSize, totalTours);
            List<Tour> tours = startIndex < totalTours ? allTours.subList(startIndex, endIndex) : List.of();
            
            // Check user session for Guest vs User logic
            HttpSession session = request.getSession(false);
            boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
            request.setAttribute("isLoggedIn", isLoggedIn);
            
            // Set attributes
            request.setAttribute("tours", tours);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalTours", totalTours);
            request.setAttribute("pageSize", pageSize);
            
            // Forward to JSP
            request.getRequestDispatcher("/explore.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải danh sách tour: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
