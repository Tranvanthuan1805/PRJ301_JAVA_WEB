package com.dananghub.controller;

import com.dananghub.dao.TourDAO;
import com.dananghub.entity.Tour;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/admin/tours/edit")
public class AdminTourEditServlet extends HttpServlet {
    
    private final TourDAO tourDAO = new TourDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String idParam = request.getParameter("id");
        
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/tours");
            return;
        }
        
        try {
            int tourId = Integer.parseInt(idParam);
            Tour tour = tourDAO.findById(tourId);
            
            if (tour == null) {
                response.sendRedirect(request.getContextPath() + "/admin/tours");
                return;
            }
            
            request.setAttribute("tour", tour);
            request.getRequestDispatcher("/admin/tour-edit.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/tours");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        try {
            // Get tour ID
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/tours");
                return;
            }
            
            int tourId = Integer.parseInt(idParam);
            Tour tour = tourDAO.findById(tourId);
            
            if (tour == null) {
                response.sendRedirect(request.getContextPath() + "/admin/tours");
                return;
            }
            
            // Get form parameters
            String name = request.getParameter("name");
            String destination = request.getParameter("destination");
            String priceStr = request.getParameter("price");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String maxCapacityStr = request.getParameter("maxCapacity");
            String currentCapacityStr = request.getParameter("currentCapacity");
            String description = request.getParameter("description");
            
            // Validate required fields
            if (name == null || name.trim().isEmpty() ||
                destination == null || destination.trim().isEmpty() ||
                priceStr == null || priceStr.trim().isEmpty() ||
                startDateStr == null || startDateStr.trim().isEmpty() ||
                endDateStr == null || endDateStr.trim().isEmpty() ||
                maxCapacityStr == null || maxCapacityStr.trim().isEmpty()) {
                
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
                request.setAttribute("tour", tour);
                request.getRequestDispatcher("/admin/tour-edit.jsp").forward(request, response);
                return;
            }
            
            // Parse values
            double price = Double.parseDouble(priceStr);
            int maxCapacity = Integer.parseInt(maxCapacityStr);
            int currentCapacity = 0;
            if (currentCapacityStr != null && !currentCapacityStr.trim().isEmpty()) {
                currentCapacity = Integer.parseInt(currentCapacityStr);
            }
            
            // Parse dates
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = sdf.parse(startDateStr);
            Date endDate = sdf.parse(endDateStr);
            
            // Validate dates
            if (endDate.before(startDate)) {
                request.setAttribute("error", "Ngày kết thúc phải sau ngày khởi hành");
                request.setAttribute("tour", tour);
                request.getRequestDispatcher("/admin/tour-edit.jsp").forward(request, response);
                return;
            }
            
            // Validate capacity
            if (currentCapacity > maxCapacity) {
                request.setAttribute("error", "Số người đã đặt không được vượt quá số người tối đa");
                request.setAttribute("tour", tour);
                request.getRequestDispatcher("/admin/tour-edit.jsp").forward(request, response);
                return;
            }
            
            // Update tour object
            tour.setName(name.trim());
            tour.setDestination(destination.trim());
            tour.setPrice(price);
            tour.setStartDate(startDate);
            tour.setEndDate(endDate);
            tour.setMaxCapacity(maxCapacity);
            tour.setCurrentCapacity(currentCapacity);
            if (description != null && !description.trim().isEmpty()) {
                tour.setDescription(description.trim());
            }
            
            // Update in database
            boolean success = tourDAO.update(tour);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/tours?success=updated");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi cập nhật tour");
                request.setAttribute("tour", tour);
                request.getRequestDispatcher("/admin/tour-edit.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Giá trị số không hợp lệ");
            request.getRequestDispatcher("/admin/tour-edit.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/admin/tour-edit.jsp").forward(request, response);
        }
    }
}
