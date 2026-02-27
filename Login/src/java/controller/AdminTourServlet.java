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

@WebServlet("/admin/tours")
public class AdminTourServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        
        if (username == null || !"ADMIN".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        try {
            listTours(request, response);
        } catch (Exception e) {
            throw new ServletException("Database error", e);
        }
    }
    
    private void listTours(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        TourDAO tourDAO = new TourDAO();
        
        String searchQuery = request.getParameter("search");
        String destinationFilter = request.getParameter("destination");
        String sortBy = request.getParameter("sortBy");
        
        int page = 1;
        int pageSize = 10;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try { page = Integer.parseInt(pageParam); } catch (NumberFormatException e) { page = 1; }
        }
        
        List<Tour> allTours = tourDAO.getAllTours();
        
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            final String query = searchQuery.toLowerCase();
            allTours = allTours.stream()
                .filter(t -> t.getTourName().toLowerCase().contains(query) ||
                           (t.getStartLocation() != null && t.getStartLocation().toLowerCase().contains(query)))
                .collect(Collectors.toList());
        }
        
        if (destinationFilter != null && !destinationFilter.isEmpty() && !destinationFilter.equals("all")) {
            allTours = allTours.stream()
                .filter(t -> t.getStartLocation() != null && t.getStartLocation().equalsIgnoreCase(destinationFilter))
                .collect(Collectors.toList());
        }
        
        if (sortBy != null && !sortBy.isEmpty()) {
            switch (sortBy) {
                case "name":
                    allTours.sort((t1, t2) -> t1.getTourName().compareTo(t2.getTourName()));
                    break;
                case "price":
                    allTours.sort((t1, t2) -> Double.compare(t1.getPrice(), t2.getPrice()));
                    break;
                case "price_desc":
                    allTours.sort((t1, t2) -> Double.compare(t2.getPrice(), t1.getPrice()));
                    break;
            }
        }
        
        int totalTours = allTours.size();
        int totalPages = (int) Math.ceil((double) totalTours / pageSize);
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalTours);
        
        List<Tour> tours = allTours.subList(startIndex, endIndex);
        
        request.setAttribute("tours", tours);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalTours", totalTours);
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("destinationFilter", destinationFilter);
        request.setAttribute("sortBy", sortBy);
        
        request.getRequestDispatcher("/admin/tours.jsp").forward(request, response);
    }
}
