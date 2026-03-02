package com.dananghub.controller;

import com.dananghub.dao.OrderDAO;
import com.dananghub.dto.OrderDetailDTO;
import com.dananghub.entity.Order;
import com.dananghub.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MyOrderServlet", urlPatterns = {"/my-orders"})
public class MyOrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
                case "pay" -> payOrder(request, response, user);
                default -> listMyOrders(request, response, user);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            listMyOrders(request, response, user);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "";

        try {
            if ("cancel".equals(action)) {
                cancelMyOrder(request, response, user);
            } else {
                response.sendRedirect("my-orders");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("my-orders?error=process_failed");
        }
    }

    private void listMyOrders(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {

        List<OrderDetailDTO> orders = orderDAO.getOrderDetailsByCustomer(user.getUserId());

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

    private void viewOrderDetail(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("my-orders");
            return;
        }

        int orderId = Integer.parseInt(idStr);
        OrderDetailDTO order = orderDAO.getOrderDetail(orderId);

        if (order == null || order.getUserId() != user.getUserId()) {
            request.setAttribute("error", "Không tìm thấy đơn hàng hoặc bạn không có quyền xem.");
            listMyOrders(request, response, user);
            return;
        }

        request.setAttribute("order", order);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/views/order-management/my-order-detail.jsp").forward(request, response);
    }

    private void cancelMyOrder(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        Order order = orderDAO.findById(orderId);

        if (order == null || order.getCustomerId() != user.getUserId()) {
            response.sendRedirect("my-orders?error=unauthorized");
            return;
        }

        if (!order.canCancel()) {
            response.sendRedirect("my-orders?error=cannot_cancel");
            return;
        }

        String reason = request.getParameter("cancelReason");
        if (reason == null || reason.trim().isEmpty()) reason = "Hủy bởi khách hàng";

        boolean success = orderDAO.cancelOrder(orderId, reason);
        if (success) {
            response.sendRedirect("my-orders?msg=order_cancelled");
        } else {
            response.sendRedirect("my-orders?error=cancel_failed");
        }
    }

    private void payOrder(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("my-orders");
            return;
        }

        int orderId = Integer.parseInt(idStr);
        Order order = orderDAO.findById(orderId);

        if (order == null || order.getCustomerId() != user.getUserId()) {
            response.sendRedirect("my-orders?error=unauthorized");
            return;
        }

        if (!"Pending".equals(order.getOrderStatus())) {
            response.sendRedirect("my-orders?error=already_processed");
            return;
        }

        // Generate QR payment
        String transCode = "EZT" + System.currentTimeMillis() + "U" + user.getUserId();
        String bankAcc = "2806281106";
        String bankName = "MB";
        long amountInt = Math.round(order.getTotalAmount());
        String qrUrl = String.format("https://qr.sepay.vn/img?acc=%s&bank=%s&amount=%d&des=%s",
                bankAcc, bankName, amountInt, transCode);

        request.setAttribute("order", order);
        request.setAttribute("orderId", orderId);
        request.setAttribute("transCode", transCode);
        request.setAttribute("qrUrl", qrUrl);
        request.setAttribute("amount", amountInt);
        request.setAttribute("totalFormatted", String.format("%,d", amountInt));

        request.getRequestDispatcher("/views/checkout/payment-checkout.jsp").forward(request, response);
    }

    private User getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        return (User) session.getAttribute("user");
    }
}
