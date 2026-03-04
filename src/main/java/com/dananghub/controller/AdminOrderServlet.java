package com.dananghub.controller;

import com.dananghub.dao.OrderDAO;
import com.dananghub.entity.Order;
import com.dananghub.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {
    
    private OrderDAO orderDAO = new OrderDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"ADMIN".equals(user.getRoleName())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        try {
            String statusFilter = request.getParameter("status");
            List<Order> orders;
            
            if (statusFilter != null && !statusFilter.isEmpty() && !"all".equals(statusFilter)) {
                orders = orderDAO.findByStatus(statusFilter);
            } else {
                orders = orderDAO.findAll();
            }
            
            long pendingCount = orderDAO.countByStatus("Pending");
            long confirmedCount = orderDAO.countByStatus("Confirmed");
            long completedCount = orderDAO.countByStatus("Completed");
            long cancelledCount = orderDAO.countByStatus("Cancelled");
            
            request.setAttribute("orders", orders);
            request.setAttribute("pendingCount", pendingCount);
            request.setAttribute("confirmedCount", confirmedCount);
            request.setAttribute("completedCount", completedCount);
            request.setAttribute("cancelledCount", cancelledCount);
            request.setAttribute("statusFilter", statusFilter);
            
            request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error: " + e.getMessage());
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"ADMIN".equals(user.getRoleName())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        
        try {
            if ("confirm".equals(action)) {
                orderDAO.updateStatus(orderId, "Confirmed");
                response.sendRedirect(request.getContextPath() + "/admin/orders?msg=success");
            } else if ("complete".equals(action)) {
                orderDAO.updateStatus(orderId, "Completed");
                orderDAO.updatePaymentStatus(orderId, "Paid");
                response.sendRedirect(request.getContextPath() + "/admin/orders?msg=success");
            } else if ("cancel".equals(action)) {
                orderDAO.updateStatus(orderId, "Cancelled");
                response.sendRedirect(request.getContextPath() + "/admin/orders?msg=success");
            } else if ("delete".equals(action)) {
                orderDAO.delete(orderId);
                response.sendRedirect(request.getContextPath() + "/admin/orders?msg=success");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/orders");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=update_failed");
        }
    }
}
