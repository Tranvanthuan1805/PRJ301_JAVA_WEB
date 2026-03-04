package com.dananghub.controller;

import com.dananghub.dao.TourDAO;
import com.dananghub.entity.Tour;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/admin/tours/add")
public class AdminTourAddServlet extends HttpServlet {
    
    private final TourDAO tourDAO = new TourDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Forward to add form
        request.getRequestDispatcher("/admin/tour-add.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        try {
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
                request.getRequestDispatcher("/admin/tour-add.jsp").forward(request, response);
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
                request.getRequestDispatcher("/admin/tour-add.jsp").forward(request, response);
                return;
            }
            
            // Validate capacity
            if (currentCapacity > maxCapacity) {
                request.setAttribute("error", "Số người đã đặt không được vượt quá số người tối đa");
                request.getRequestDispatcher("/admin/tour-add.jsp").forward(request, response);
                return;
            }
            
            // Create tour object
            Tour tour = new Tour();
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
            
            // Save to database
            tourDAO.save(tour);
            
            // Redirect to tours list with success message
            response.sendRedirect(request.getContextPath() + "/admin/tours?success=added");
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Giá trị số không hợp lệ");
            request.getRequestDispatcher("/admin/tour-add.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/admin/tour-add.jsp").forward(request, response);
        }
    }
}
