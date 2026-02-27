package controller;

import dao.OrderDAO;
import model.Order;
import model.OrderDetailDTO;
import model.OrderStatus;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * OrderServlet - Admin Order Management Controller
 * URL: /admin/orders
 * 
 * Handles all admin operations for order management:
 * - List all orders
 * - View order details
 * - Filter by status
 * - Update order status
 * - Cancel orders
 * - Confirm payment
 */
@WebServlet(name = "OrderServlet", urlPatterns = {"/admin/orders"})
public class OrderServlet extends HttpServlet {
    
    private final OrderDAO orderDAO = new OrderDAO();
    
    // ==================== GET Requests ====================
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check admin authentication
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) action = "list";
        
        try {
            switch (action) {
                case "view" -> viewOrderDetail(request, response);
                case "filter" -> filterOrders(request, response);
                default -> listAllOrders(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            listAllOrders(request, response);
        }
    }
    
    // ==================== POST Requests ====================
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check admin authentication
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) action = "";
        
        try {
            switch (action) {
                case "updateStatus" -> updateOrderStatus(request, response);
                case "cancel" -> cancelOrder(request, response);
                case "confirmPayment" -> confirmPayment(request, response);
                default -> response.sendRedirect("orders");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý: " + e.getMessage());
            response.sendRedirect("orders");
        }
    }
    
    // ==================== Action Handlers ====================
    
    /**
     * List all orders with statistics
     */
    private void listAllOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<OrderDetailDTO> orders = orderDAO.getAllOrderDetails();
        
        // Statistics
        long pending = orderDAO.countByStatus("Pending");
        long confirmed = orderDAO.countByStatus("Confirmed");
        long completed = orderDAO.countByStatus("Completed");
        long cancelled = orderDAO.countByStatus("Cancelled");
        double totalRevenue = orderDAO.getTotalRevenue();
        
        request.setAttribute("orders", orders);
        request.setAttribute("pendingCount", pending);
        request.setAttribute("confirmedCount", confirmed);
        request.setAttribute("completedCount", completed);
        request.setAttribute("cancelledCount", cancelled);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("statuses", OrderStatus.values());
        
        request.getRequestDispatcher("/views/order-management/order-list.jsp").forward(request, response);
    }
    
    /**
     * View single order detail
     */
    private void viewOrderDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("orders");
            return;
        }
        
        int orderId = Integer.parseInt(idStr);
        OrderDetailDTO order = orderDAO.getOrderDetailById(orderId);
        
        if (order == null) {
            request.setAttribute("error", "Không tìm thấy đơn hàng #" + orderId);
            listAllOrders(request, response);
            return;
        }
        
        request.setAttribute("order", order);
        request.setAttribute("statuses", OrderStatus.values());
        request.getRequestDispatcher("/views/order-management/order-detail.jsp").forward(request, response);
    }
    
    /**
     * Filter orders by status
     */
    private void filterOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String status = request.getParameter("status");
        
        List<OrderDetailDTO> filteredOrders;
        
        if (status == null || status.isEmpty() || "all".equalsIgnoreCase(status)) {
            filteredOrders = orderDAO.getAllOrderDetails();
        } else {
            // Get orders by status and convert to DTO
            List<Order> orders = orderDAO.getOrdersByStatus(status);
            filteredOrders = new ArrayList<>();
            for (Order o : orders) {
                OrderDetailDTO dto = orderDAO.getOrderDetailById(o.getOrderId());
                if (dto != null) filteredOrders.add(dto);
            }
        }
        
        // Statistics (always show all counts)
        long pending = orderDAO.countByStatus("Pending");
        long confirmed = orderDAO.countByStatus("Confirmed");
        long completed = orderDAO.countByStatus("Completed");
        long cancelled = orderDAO.countByStatus("Cancelled");
        double totalRevenue = orderDAO.getTotalRevenue();
        
        request.setAttribute("orders", filteredOrders);
        request.setAttribute("pendingCount", pending);
        request.setAttribute("confirmedCount", confirmed);
        request.setAttribute("completedCount", completed);
        request.setAttribute("cancelledCount", cancelled);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("selectedStatus", status);
        request.setAttribute("statuses", OrderStatus.values());
        
        request.getRequestDispatcher("/views/order-management/order-list.jsp").forward(request, response);
    }
    
    /**
     * Update order status
     */
    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("newStatus");
        
        boolean success = orderDAO.updateOrderStatus(orderId, newStatus);
        
        if (success) {
            response.sendRedirect("orders?action=view&id=" + orderId + "&msg=status_updated");
        } else {
            response.sendRedirect("orders?action=view&id=" + orderId + "&error=update_failed");
        }
    }
    
    /**
     * Cancel an order
     */
    private void cancelOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String reason = request.getParameter("cancelReason");
        
        if (reason == null || reason.trim().isEmpty()) {
            reason = "Hủy bởi Admin";
        }
        
        boolean success = orderDAO.cancelOrder(orderId, reason);
        
        if (success) {
            response.sendRedirect("orders?msg=order_cancelled");
        } else {
            response.sendRedirect("orders?action=view&id=" + orderId + "&error=cancel_failed");
        }
    }
    
    /**
     * Confirm payment for an order
     */
    private void confirmPayment(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        
        boolean success = orderDAO.updatePaymentStatus(orderId, "Paid");
        
        if (success) {
            response.sendRedirect("orders?action=view&id=" + orderId + "&msg=payment_confirmed");
        } else {
            response.sendRedirect("orders?action=view&id=" + orderId + "&error=payment_failed");
        }
    }
    
    // ==================== Helper Methods ====================
    
    /**
     * Check if current user is admin
     */
    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;
        
        User user = (User) session.getAttribute("user");
        if (user == null) return false;
        
        return "ADMIN".equalsIgnoreCase(user.getRoleName());
    }
}
