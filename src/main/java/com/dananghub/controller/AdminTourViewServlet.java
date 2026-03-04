package com.dananghub.controller;

import com.dananghub.dao.TourDAO;
import com.dananghub.entity.Tour;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

@WebServlet("/admin/tours/view")
public class AdminTourViewServlet extends HttpServlet {
    
    private final TourDAO tourDAO = new TourDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        
        String idParam = request.getParameter("id");
        
        try (PrintWriter out = response.getWriter()) {
            if (idParam == null || idParam.trim().isEmpty()) {
                out.print("{\"error\":\"Missing tour ID\"}");
                return;
            }
            
            int tourId = Integer.parseInt(idParam);
            Tour tour = tourDAO.findById(tourId);
            
            if (tour == null) {
                out.print("{\"error\":\"Tour not found\"}");
                return;
            }
            
            // Format dates
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            
            // Build JSON manually to avoid dependency issues
            StringBuilder json = new StringBuilder();
            json.append("{");
            json.append("\"id\":").append(tour.getId()).append(",");
            json.append("\"name\":\"").append(escapeJson(tour.getName())).append("\",");
            json.append("\"destination\":\"").append(escapeJson(tour.getDestination())).append("\",");
            json.append("\"startDate\":\"").append(sdf.format(tour.getStartDate())).append("\",");
            json.append("\"endDate\":\"").append(sdf.format(tour.getEndDate())).append("\",");
            json.append("\"price\":").append(tour.getPrice()).append(",");
            json.append("\"maxCapacity\":").append(tour.getMaxCapacity()).append(",");
            json.append("\"currentCapacity\":").append(tour.getCurrentCapacity()).append(",");
            json.append("\"description\":\"").append(escapeJson(tour.getDescription() != null ? tour.getDescription() : "")).append("\"");
            json.append("}");
            
            out.print(json.toString());
            
        } catch (NumberFormatException e) {
            response.getWriter().print("{\"error\":\"Invalid tour ID\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("{\"error\":\"Server error\"}");
        }
    }
    
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}
