package com.dananghub.controller;

import com.dananghub.dao.TourDAO;
import com.dananghub.dao.CategoryDAO;
import com.dananghub.entity.Tour;
import com.dananghub.entity.Category;
import com.dananghub.entity.User;
import com.dananghub.service.TourService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/tour")
public class TourServlet extends HttpServlet {

    private TourService tourService;
    private TourDAO tourDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        tourService = new TourService();
        tourDAO = new TourDAO();
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "view" -> viewTour(request, response);
                case "search" -> searchTours(request, response);
                default -> listTours(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error: " + e.getMessage(), e);
        }
    }

    private void listTours(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int page = 1, toursPerPage = 12;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try { page = Math.max(1, Integer.parseInt(pageParam)); } catch (NumberFormatException e) { page = 1; }
        }

        String search = request.getParameter("search");
        String sortBy = request.getParameter("sortBy");
        String categoryIdStr = request.getParameter("categoryId");
        String availableOnly = request.getParameter("available");

        List<Tour> allTours = tourDAO.findAll();

        // Search filter
        if (search != null && !search.trim().isEmpty()) {
            final String query = search.toLowerCase();
            allTours = allTours.stream()
                .filter(t -> t.getTourName().toLowerCase().contains(query) ||
                             (t.getDestination() != null && t.getDestination().toLowerCase().contains(query)) ||
                             (t.getStartLocation() != null && t.getStartLocation().toLowerCase().contains(query)) ||
                             (t.getShortDesc() != null && t.getShortDesc().toLowerCase().contains(query)))
                .collect(Collectors.toList());
            request.setAttribute("searchQuery", search);
        }

        // Category filter
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                int catId = Integer.parseInt(categoryIdStr);
                allTours = allTours.stream()
                    .filter(t -> t.getCategory() != null && t.getCategory().getCategoryId() == catId)
                    .collect(Collectors.toList());
                request.setAttribute("selectedCategory", catId);
            } catch (NumberFormatException e) {}
        }

        // Available filter (còn chỗ trống)
        if ("true".equals(availableOnly)) {
            allTours = allTours.stream()
                .filter(t -> t.getMaxPeople() > 0)
                .collect(Collectors.toList());
            request.setAttribute("availableOnly", true);
        }

        // Sort
        if (sortBy != null && !sortBy.isEmpty()) {
            switch (sortBy) {
                case "name_asc" -> allTours.sort((t1, t2) -> t1.getTourName().compareToIgnoreCase(t2.getTourName()));
                case "name_desc" -> allTours.sort((t1, t2) -> t2.getTourName().compareToIgnoreCase(t1.getTourName()));
                case "price_asc" -> allTours.sort((t1, t2) -> Double.compare(t1.getPrice(), t2.getPrice()));
                case "price_desc" -> allTours.sort((t1, t2) -> Double.compare(t2.getPrice(), t1.getPrice()));
                case "newest" -> allTours.sort((t1, t2) -> {
                    if (t2.getCreatedAt() == null) return -1;
                    if (t1.getCreatedAt() == null) return 1;
                    return t2.getCreatedAt().compareTo(t1.getCreatedAt());
                });
            }
            request.setAttribute("sortBy", sortBy);
        }

        int totalTours = allTours.size();
        int totalPages = (int) Math.ceil((double) totalTours / toursPerPage);
        page = Math.min(page, Math.max(1, totalPages));
        int startIndex = (page - 1) * toursPerPage;
        int endIndex = Math.min(startIndex + toursPerPage, totalTours);
        List<Tour> tours = startIndex < totalTours ? allTours.subList(startIndex, endIndex) : List.of();

        List<Category> categories = categoryDAO.findAll();

        // Check user role
        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;
        request.setAttribute("isLoggedIn", user != null);
        request.setAttribute("isAdmin", user != null && user.getRole() != null && "ADMIN".equals(user.getRole().getRoleName()));

        request.setAttribute("tours", tours);
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalTours", totalTours);
        request.getRequestDispatcher("/jsp/tour-list.jsp").forward(request, response);
    }

    private void viewTour(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Tour tour = tourDAO.findById(id);
        if (tour == null) {
            response.sendRedirect("tour");
            return;
        }
        double seasonalPrice = tourService.calculateSeasonalPrice(tour);

        request.setAttribute("tour", tour);
        request.setAttribute("seasonalPrice", seasonalPrice);

        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;
        request.setAttribute("isLoggedIn", user != null);

        if (user != null) {
            try { tourService.logTourView(user.getUserId(), id); } catch (Exception ignored) {}
        }

        request.getRequestDispatcher("/detail.jsp").forward(request, response);
    }

    private void searchTours(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        if (keyword != null && !keyword.isEmpty()) {
            request.setAttribute("search", keyword);
        }
        listTours(request, response);
    }
}
