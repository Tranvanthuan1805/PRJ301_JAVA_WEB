package com.dananghub.controller;

import com.dananghub.dao.TourDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/tours/delete")
public class AdminTourDeleteServlet extends HttpServlet {
    
    private final TourDAO tourDAO = new TourDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String idParam = request.getParameter("id");
        
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/tours?error=invalid");
            return;
        }
        
        try {
            int tourId = Integer.parseInt(idParam);
            boolean success = tourDAO.delete(tourId);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/tours?success=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/tours?error=notfound");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/tours?error=invalid");
        }
    }
}
