package com.dananghub.controller;

import com.dananghub.dao.OrderDAO;
import com.dananghub.dto.OrderDetailDTO;
import com.dananghub.entity.Order;
import com.dananghub.entity.OrderStatus;
import com.dananghub.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderServlet", urlPatterns = {"/admin/orders"})
public class OrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
            response.sendRedirect("orders");
        }
    }

    private void listAllOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<OrderDetailDTO> orders = orderDAO.getAllOrderDetails();

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

    private void viewOrderDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("orders");
            return;
        }

        int orderId = Integer.parseInt(idStr);
        OrderDetailDTO order = orderDAO.getOrderDetail(orderId);

        if (order == null) {
            request.setAttribute("error", "Không tìm thấy đơn hàng #" + orderId);
            listAllOrders(request, response);
            return;
        }

        request.setAttribute("order", order);
        request.setAttribute("statuses", OrderStatus.values());
        request.getRequestDispatcher("/views/order-management/order-detail.jsp").forward(request, response);
    }

    private void filterOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String status = request.getParameter("status");
        List<OrderDetailDTO> filteredOrders;

        if (status == null || status.isEmpty() || "all".equalsIgnoreCase(status)) {
            filteredOrders = orderDAO.getAllOrderDetails();
        } else {
            List<Order> orders = orderDAO.findByStatus(status);
            filteredOrders = new java.util.ArrayList<>();
            for (Order o : orders) {
                OrderDetailDTO dto = orderDAO.getOrderDetail(o.getOrderId());
                if (dto != null) filteredOrders.add(dto);
            }
        }

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

    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("newStatus");

        // Validate status transition
        Order order = orderDAO.findById(orderId);
        if (order != null) {
            OrderStatus current = OrderStatus.fromCode(order.getOrderStatus());
            OrderStatus target = OrderStatus.fromCode(newStatus);
            if (!current.canTransitionTo(target)) {
                response.sendRedirect("orders?action=view&id=" + orderId + "&error=invalid_transition");
                return;
            }
        }

        boolean success = orderDAO.updateStatus(orderId, newStatus);
        if (success) {
            response.sendRedirect("orders?action=view&id=" + orderId + "&msg=status_updated");
        } else {
            response.sendRedirect("orders?action=view&id=" + orderId + "&error=update_failed");
        }
    }

    private void cancelOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String reason = request.getParameter("cancelReason");
        if (reason == null || reason.trim().isEmpty()) reason = "Hủy bởi Admin";
        boolean success = orderDAO.cancelOrder(orderId, reason);
        if (success) {
            response.sendRedirect("orders?msg=order_cancelled");
        } else {
            response.sendRedirect("orders?action=view&id=" + orderId + "&error=cancel_failed");
        }
    }

    private void confirmPayment(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        boolean success = orderDAO.updatePaymentStatus(orderId, "Paid");
        if (success) {
            // Also confirm the order (matches SePay webhook behavior)
            orderDAO.updateStatus(orderId, "Confirmed");
            response.sendRedirect("orders?action=view&id=" + orderId + "&msg=payment_confirmed");
        } else {
            response.sendRedirect("orders?action=view&id=" + orderId + "&error=payment_failed");
        }
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;
        User user = (User) session.getAttribute("user");
        if (user == null) return false;
        return "ADMIN".equalsIgnoreCase(user.getRoleName());
    }
}
