package com.dananghub.controller;

import com.dananghub.dao.OrderDAO;
import com.dananghub.dao.BookingDAO;
import com.dananghub.dao.ActivityDAO;
import com.dananghub.dao.CouponDAO;
import com.dananghub.entity.*;
import com.dananghub.dao.SubscriptionDAO;

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
    private final CouponDAO couponDAO = new CouponDAO();

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
        double subtotal = 0;
        for (CartItem item : cart) {
            subtotal += item.getTotalPrice();
        }

        // Apply coupon discount
        double discount = 0;
        Coupon coupon = (Coupon) session.getAttribute("appliedCoupon");
        if (coupon != null && coupon.isValid(subtotal)) {
            discount = coupon.calculateDiscount(subtotal);
        }
        double total = subtotal - discount;

        request.setAttribute("cartTotal", total);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("couponDiscount", discount);
        request.setAttribute("appliedCoupon", coupon);
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
            double subtotal = 0;
            for (CartItem item : cart) {
                subtotal += item.getTotalPrice();
            }

            // Apply coupon if present
            double discount = 0;
            Coupon coupon = (Coupon) session.getAttribute("appliedCoupon");
            if (coupon != null && coupon.isValid(subtotal)) {
                discount = coupon.calculateDiscount(subtotal);
                couponDAO.incrementUsage(coupon.getCouponId());
            }
            double total = subtotal - discount;

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

                // Clear cart & coupon
                session.removeAttribute("cart");
                session.removeAttribute("cartTotal");
                session.removeAttribute("appliedCoupon");
                session.removeAttribute("couponDiscount");

                // Generate transaction code and QR
                String transCode = "ORD" + System.currentTimeMillis() + "U" + user.getUserId();
                String bankAcc = "2806281106";
                String bankName = "MB";
                long amountInt = Math.round(total);

                // Save PaymentTransaction to DB for SePay matching
                PaymentTransaction payTrans = new PaymentTransaction();
                payTrans.setUserId(user.getUserId());
                payTrans.setOrderId(orderId);
                payTrans.setAmount((double) amountInt);
                payTrans.setTransactionCode(transCode);
                payTrans.setStatus("Pending");
                payTrans.setCreatedDate(new java.util.Date());
                new SubscriptionDAO().createTransaction(payTrans);

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
