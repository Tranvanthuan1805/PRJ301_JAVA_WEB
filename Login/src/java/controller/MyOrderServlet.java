package controller;

import dao.OrderDAO;
import model.Order;
import model.OrderDetailDTO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * MyOrderServlet - User Order History Controller
 * URL: /my-orders
 * 
 * Handles user's own order operations:
 * - View own order history
 * - View order details
 * - Cancel pending orders
 */
@WebServlet(name = "MyOrderServlet", urlPatterns = {"/my-orders"})
public class MyOrderServlet extends HttpServlet {
    
    private final OrderDAO orderDAO = new OrderDAO();
    
    // ==================== GET Requests ====================
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check user authentication
        User user = getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) action = "list";
        
        try {
            switch (action) {
                case "view" -> viewOrderDetail(request, response, user);
                default -> listMyOrders(request, response, user);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            listMyOrders(request, response, user);
        }
    }
    
    // ==================== POST Requests ====================
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check user authentication
        User user = getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) action = "";
        
        try {
            switch (action) {
                case "cancel" -> cancelMyOrder(request, response, user);
                default -> response.sendRedirect("my-orders");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("my-orders?error=process_failed");
        }
    }
    
    // ==================== Action Handlers ====================
    
    /**
     * List user's own orders
     */
    private void listMyOrders(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        
        List<OrderDetailDTO> orders = orderDAO.getOrderDetailsByUserId(user.userId);
        
        // Count user's orders by status
        long pendingCount = orders.stream().filter(o -> "Pending".equals(o.getStatus())).count();
        long confirmedCount = orders.stream().filter(o -> "Confirmed".equals(o.getStatus())).count();
        long completedCount = orders.stream().filter(o -> "Completed".equals(o.getStatus())).count();
        long cancelledCount = orders.stream().filter(o -> "Cancelled".equals(o.getStatus())).count();
        
        request.setAttribute("orders", orders);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("confirmedCount", confirmedCount);
        request.setAttribute("completedCount", completedCount);
        request.setAttribute("cancelledCount", cancelledCount);
        request.setAttribute("user", user);
        
        request.getRequestDispatcher("/views/order-management/my-orders.jsp").forward(request, response);
    }
    
    /**
     * View single order detail (only if belongs to user)
     */
    private void viewOrderDetail(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("my-orders");
            return;
        }
        
        int orderId = Integer.parseInt(idStr);
        OrderDetailDTO order = orderDAO.getOrderDetailById(orderId);
        
        // Security check: only show if order belongs to this user
        if (order == null || order.getUserId() != user.userId) {
            request.setAttribute("error", "Không tìm thấy đơn hàng hoặc bạn không có quyền xem đơn hàng này.");
            listMyOrders(request, response, user);
            return;
        }
        
        request.setAttribute("order", order);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/views/order-management/my-order-detail.jsp").forward(request, response);
    }
    
    /**
     * Cancel user's own pending order
     */
    private void cancelMyOrder(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String reason = request.getParameter("cancelReason");
        
        // Security check: verify order belongs to this user
        Order order = orderDAO.getOrderById(orderId);
        if (order == null || order.getUserId() != user.userId) {
            response.sendRedirect("my-orders?error=unauthorized");
            return;
        }
        
        // Check if order can be cancelled
        if (!order.canCancel()) {
            response.sendRedirect("my-orders?error=cannot_cancel");
            return;
        }
        
        if (reason == null || reason.trim().isEmpty()) {
            reason = "Hủy bởi khách hàng";
        }
        
        boolean success = orderDAO.cancelOrder(orderId, reason);
        
        if (success) {
            response.sendRedirect("my-orders?msg=order_cancelled");
        } else {
            response.sendRedirect("my-orders?error=cancel_failed");
        }
    }
    
    // ==================== Helper Methods ====================
    
    /**
     * Get logged in user from session
     */
    private User getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        return (User) session.getAttribute("user");
    }
}
