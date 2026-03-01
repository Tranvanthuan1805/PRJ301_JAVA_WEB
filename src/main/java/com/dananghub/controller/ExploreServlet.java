package com.dananghub.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ExploreServlet - Guest Tour Exploration for 2026 Tours
 * Uses JDBC to connect to TourManagement database
 */
@WebServlet("/explore")
public class ExploreServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=TourManagement;encrypt=true;trustServerCertificate=true;";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "123456";
    
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
        
        try {
            // Build SQL query
            StringBuilder sql = new StringBuilder(
                "SELECT id, name, destination, startDate, endDate, price, " +
                "maxCapacity, currentCapacity, description " +
                "FROM Tours WHERE YEAR(startDate) = 2026"
            );
            
            List<Object> params = new ArrayList<>();
            
            // Apply search filter
            if (search != null && !search.trim().isEmpty()) {
                sql.append(" AND (name LIKE ? OR destination LIKE ? OR description LIKE ?)");
                String searchPattern = "%" + search.trim() + "%";
                params.add(searchPattern);
                params.add(searchPattern);
                params.add(searchPattern);
                request.setAttribute("search", search);
            }
            
            // Apply available filter
            if ("true".equals(availableOnly)) {
                sql.append(" AND (maxCapacity - currentCapacity) > 0");
                request.setAttribute("availableOnly", true);
            }
            
            // Apply sorting
            if (sortBy != null && !sortBy.trim().isEmpty()) {
                switch (sortBy) {
                    case "name_asc":
                        sql.append(" ORDER BY name ASC");
                        break;
                    case "name_desc":
                        sql.append(" ORDER BY name DESC");
                        break;
                    case "price_asc":
                        sql.append(" ORDER BY price ASC");
                        break;
                    case "price_desc":
                        sql.append(" ORDER BY price DESC");
                        break;
                    default:
                        sql.append(" ORDER BY name ASC");
                }
                request.setAttribute("sort", sortBy);
            } else {
                sql.append(" ORDER BY name ASC");
            }
            
            // Get total count
            int totalTours = getTotalCount(search, availableOnly);
            int totalPages = (int) Math.ceil((double) totalTours / pageSize);
            if (totalPages == 0) totalPages = 1;
            if (page > totalPages) page = totalPages;
            
            // Add pagination
            sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
            params.add((page - 1) * pageSize);
            params.add(pageSize);
            
            // Execute query
            List<TourDTO> tours = executeQuery(sql.toString(), params);
            
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
    
    private int getTotalCount(String search, String availableOnly) throws SQLException {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) FROM Tours WHERE YEAR(startDate) = 2026"
        );
        
        List<Object> params = new ArrayList<>();
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (name LIKE ? OR destination LIKE ? OR description LIKE ?)");
            String searchPattern = "%" + search.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }
        
        if ("true".equals(availableOnly)) {
            sql.append(" AND (maxCapacity - currentCapacity) > 0");
        }
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }
    
    private List<TourDTO> executeQuery(String sql, List<Object> params) throws SQLException {
        List<TourDTO> tours = new ArrayList<>();
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                TourDTO tour = new TourDTO();
                tour.setId(rs.getInt("id"));
                tour.setName(rs.getString("name"));
                tour.setDestination(rs.getString("destination"));
                tour.setStartDate(rs.getDate("startDate"));
                tour.setEndDate(rs.getDate("endDate"));
                tour.setPrice(rs.getDouble("price"));
                tour.setMaxCapacity(rs.getInt("maxCapacity"));
                tour.setCurrentCapacity(rs.getInt("currentCapacity"));
                tour.setDescription(rs.getString("description"));
                tours.add(tour);
            }
        }
        
        return tours;
    }
    
    // Simple DTO class
    public static class TourDTO {
        private int id;
        private String name;
        private String destination;
        private Date startDate;
        private Date endDate;
        private double price;
        private int maxCapacity;
        private int currentCapacity;
        private String description;
        
        public int getAvailableSlots() {
            return maxCapacity - currentCapacity;
        }
        
        // Getters and Setters
        public int getId() { return id; }
        public void setId(int id) { this.id = id; }
        
        public String getName() { return name; }
        public void setName(String name) { this.name = name; }
        
        public String getDestination() { return destination; }
        public void setDestination(String destination) { this.destination = destination; }
        
        public Date getStartDate() { return startDate; }
        public void setStartDate(Date startDate) { this.startDate = startDate; }
        
        public Date getEndDate() { return endDate; }
        public void setEndDate(Date endDate) { this.endDate = endDate; }
        
        public double getPrice() { return price; }
        public void setPrice(double price) { this.price = price; }
        
        public int getMaxCapacity() { return maxCapacity; }
        public void setMaxCapacity(int maxCapacity) { this.maxCapacity = maxCapacity; }
        
        public int getCurrentCapacity() { return currentCapacity; }
        public void setCurrentCapacity(int currentCapacity) { this.currentCapacity = currentCapacity; }
        
        public String getDescription() { return description; }
        public void setDescription(String description) { this.description = description; }
    }
}
