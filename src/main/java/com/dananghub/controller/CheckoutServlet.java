package com.dananghub.controller;

import com.dananghub.dao.OrderDAO;
import com.dananghub.dao.BookingDAO;
import com.dananghub.dao.ActivityDAO;
import com.dananghub.entity.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final BookingDAO bookingDAO = new BookingDAO();
    private final ActivityDAO activityDAO = new ActivityDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            session.setAttribute("error", "Vui lòng đăng nhập để thanh toán");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Calculate total
        double total = 0;
        for (CartItem item : cart) {
            total += item.getTotalPrice();
        }
        request.setAttribute("cartTotal", total);
        request.setAttribute("user", user);

        request.getRequestDispatcher("/views/checkout/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        try {
            // Get customer info from form
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String notes = request.getParameter("notes");

            // Calculate total
            double total = 0;
            for (CartItem item : cart) {
                total += item.getTotalPrice();
            }

            // Create order
            Order order = new Order();
            order.setCustomer(user);
            order.setTotalAmount(total);
            order.setOrderStatus("Pending");
            order.setPaymentStatus("Unpaid");
            order.setOrderDate(new Date());
            order.setUpdatedAt(new Date());

            int orderId = orderDAO.create(order);

            if (orderId > 0) {
                Order savedOrder = orderDAO.findById(orderId);

                // Create bookings for each cart item
                for (CartItem item : cart) {
                    Booking booking = new Booking();
                    booking.setOrder(savedOrder);
                    booking.setTour(item.getTour());
                    booking.setQuantity(item.getQuantity());
                    booking.setSubTotal(item.getTotalPrice());
                    booking.setBookingDate(item.getTravelDate() != null ? item.getTravelDate() : new Date());
                    bookingDAO.create(booking);
                }

                // Log interaction
                InteractionHistory ih = new InteractionHistory(
                    user.getUserId(),
                    "Đặt đơn hàng #" + orderId + " - " + cart.size() + " tour(s) - Tổng: " + String.format("%,.0f", total) + "đ"
                );
                activityDAO.logInteraction(ih);

                // Clear cart
                session.removeAttribute("cart");
                session.removeAttribute("cartTotal");

                // Generate transaction code and QR
                String transCode = "EZT" + System.currentTimeMillis() + "U" + user.getUserId();
                String bankAcc = "2806281106";
                String bankName = "MB";
                long amountInt = Math.round(total);
                String qrUrl = String.format("https://qr.sepay.vn/img?acc=%s&bank=%s&amount=%d&des=%s",
                        bankAcc, bankName, amountInt, transCode);

                request.setAttribute("order", savedOrder);
                request.setAttribute("orderId", orderId);
                request.setAttribute("transCode", transCode);
                request.setAttribute("qrUrl", qrUrl);
                request.setAttribute("amount", amountInt);
                request.setAttribute("totalFormatted", String.format("%,d", amountInt));

                request.getRequestDispatcher("/views/checkout/payment-checkout.jsp").forward(request, response);
            } else {
                session.setAttribute("error", "Lỗi khi tạo đơn hàng. Vui lòng thử lại.");
                response.sendRedirect(request.getContextPath() + "/cart");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
}
