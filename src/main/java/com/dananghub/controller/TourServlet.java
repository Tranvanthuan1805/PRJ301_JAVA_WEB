package com.dananghub.controller;

import com.dananghub.dao.TourDAO;
import com.dananghub.dao.CategoryDAO;
import com.dananghub.entity.Tour;
import com.dananghub.entity.Category;
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
                case "add" -> showAddForm(request, response);
                case "edit" -> editTour(request, response);
                case "delete" -> deleteTour(request, response);
                case "search" -> searchTours(request, response);
                default -> listTours(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        try {
            if ("create".equals(action)) {
                createTour(request, response);
            } else if ("update".equals(action)) {
                updateTour(request, response);
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

        List<Tour> allTours = tourDAO.findAll();

        if (search != null && !search.trim().isEmpty()) {
            final String query = search.toLowerCase();
            allTours = allTours.stream()
                .filter(t -> t.getTourName().toLowerCase().contains(query) ||
                             (t.getStartLocation() != null && t.getStartLocation().toLowerCase().contains(query)))
                .collect(Collectors.toList());
            request.setAttribute("searchQuery", search);
        }

        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                int catId = Integer.parseInt(categoryIdStr);
                allTours = allTours.stream()
                    .filter(t -> t.getCategory() != null && t.getCategory().getCategoryId() == catId)
                    .collect(Collectors.toList());
                request.setAttribute("selectedCategory", catId);
            } catch (NumberFormatException e) {}
        }

        if (sortBy != null && !sortBy.isEmpty()) {
            switch (sortBy) {
                case "name" -> allTours.sort((t1, t2) -> t1.getTourName().compareTo(t2.getTourName()));
                case "price_asc" -> allTours.sort((t1, t2) -> Double.compare(t1.getPrice(), t2.getPrice()));
                case "price_desc" -> allTours.sort((t1, t2) -> Double.compare(t2.getPrice(), t1.getPrice()));
            }
            request.setAttribute("sortBy", sortBy);
        }

        int totalTours = allTours.size();
        int totalPages = (int) Math.ceil((double) totalTours / toursPerPage);
        int startIndex = (page - 1) * toursPerPage;
        int endIndex = Math.min(startIndex + toursPerPage, totalTours);
        List<Tour> tours = allTours.subList(startIndex, endIndex);

        List<Category> categories = categoryDAO.findAll();

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
        double seasonalPrice = tourService.calculateSeasonalPrice(tour);

        request.setAttribute("tour", tour);
        request.setAttribute("seasonalPrice", seasonalPrice);

        String customerIdParam = request.getParameter("customerId");
        if (customerIdParam != null) {
            tourService.logTourView(Integer.parseInt(customerIdParam), id);
        }

        request.getRequestDispatcher("/jsp/tour-view.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> categories = categoryDAO.findAll();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/tour-form.jsp").forward(request, response);
    }

    private void editTour(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Tour tour = tourDAO.findById(id);
        List<Category> categories = categoryDAO.findAll();
        request.setAttribute("tour", tour);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/tour-form.jsp").forward(request, response);
    }

    private void createTour(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Tour tour = new Tour();
        tour.setTourName(request.getParameter("tourName"));
        tour.setDescription(request.getParameter("description"));
        tour.setPrice(Double.parseDouble(request.getParameter("price")));
        tour.setDuration(request.getParameter("duration"));
        tour.setStartLocation(request.getParameter("startLocation"));
        tour.setImageUrl(request.getParameter("imageUrl"));
        tour.setActive(true);

        String categoryId = request.getParameter("categoryId");
        if (categoryId != null && !categoryId.isEmpty()) {
            Category cat = categoryDAO.findById(Integer.parseInt(categoryId));
            tour.setCategory(cat);
        }

        tourDAO.create(tour);
        response.sendRedirect("tour?action=list&success=created");
    }

    private void updateTour(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("tourId"));
        Tour tour = tourDAO.findById(id);
        if (tour != null) {
            tour.setTourName(request.getParameter("tourName"));
            tour.setDescription(request.getParameter("description"));
            tour.setPrice(Double.parseDouble(request.getParameter("price")));
            tour.setDuration(request.getParameter("duration"));
            tour.setStartLocation(request.getParameter("startLocation"));
            tour.setImageUrl(request.getParameter("imageUrl"));

            String categoryId = request.getParameter("categoryId");
            if (categoryId != null && !categoryId.isEmpty()) {
                Category cat = categoryDAO.findById(Integer.parseInt(categoryId));
                tour.setCategory(cat);
            }

            tourDAO.update(tour);
        }
        response.sendRedirect("tour?action=view&id=" + id + "&success=updated");
    }

    private void deleteTour(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        tourDAO.delete(id);
        response.sendRedirect("tour?action=list&success=deleted");
    }

    private void searchTours(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Tour> tours = tourDAO.search(keyword);
        request.setAttribute("tours", tours);
        request.setAttribute("searchQuery", keyword);
        request.getRequestDispatcher("/jsp/tour-list.jsp").forward(request, response);
    }
}
