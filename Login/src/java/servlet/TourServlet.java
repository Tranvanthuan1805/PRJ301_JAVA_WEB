package servlet;

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
        // Kiểm tra có tìm kiếm theo destination không
        String destination = request.getParameter("destination");
        List<Tour> tours;
        
        if (destination != null && !destination.trim().isEmpty()) {
            // Tìm kiếm theo destination
            tours = tourService.searchToursByDestination(destination);
            request.setAttribute("searchDestination", destination);
        } else {
            // Lấy tất cả tours
            tours = tourService.getAllTours();
        }
        
        request.setAttribute("tours", tours);
        request.getRequestDispatcher("/tour-list.jsp").forward(request, response);
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
        tour.setName(request.getParameter("name"));
        tour.setDestination(request.getParameter("destination"));
        tour.setStartDate(LocalDate.parse(request.getParameter("startDate")));
        tour.setEndDate(LocalDate.parse(request.getParameter("endDate")));
        tour.setPrice(Double.parseDouble(request.getParameter("price")));
        tour.setMaxCapacity(Integer.parseInt(request.getParameter("maxCapacity")));
        tour.setCurrentCapacity(0); // Bắt đầu với 0
        tour.setDescription(request.getParameter("description"));
        
        tourService.createTour(tour);
        response.sendRedirect("tour?action=list&success=created");
    }
    
    private void updateTour(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        Tour tour = new Tour();
        tour.setId(Integer.parseInt(request.getParameter("id")));
        tour.setName(request.getParameter("name"));
        tour.setDestination(request.getParameter("destination"));
        tour.setStartDate(LocalDate.parse(request.getParameter("startDate")));
        tour.setEndDate(LocalDate.parse(request.getParameter("endDate")));
        tour.setPrice(Double.parseDouble(request.getParameter("price")));
        tour.setMaxCapacity(Integer.parseInt(request.getParameter("maxCapacity")));
        tour.setCurrentCapacity(Integer.parseInt(request.getParameter("currentCapacity")));
        tour.setDescription(request.getParameter("description"));
        
        tourService.updateTour(tour);
        response.sendRedirect("tour?action=view&id=" + tour.getId() + "&success=updated");
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
        List<Tour> tours = tourService.searchToursByDestination(destination);
        
        request.setAttribute("tours", tours);
        request.setAttribute("searchDestination", destination);
        
        // Log search nếu có customer ID
        String customerIdParam = request.getParameter("customerId");
        if (customerIdParam != null) {
            int customerId = Integer.parseInt(customerIdParam);
            tourService.logTourSearch(customerId, destination);
        }
        
        request.getRequestDispatcher("/jsp/tour-list.jsp").forward(request, response);
    }
}