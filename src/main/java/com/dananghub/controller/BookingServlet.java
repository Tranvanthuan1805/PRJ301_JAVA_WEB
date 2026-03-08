package com.dananghub.controller;

import com.dananghub.dao.TourDAO;
import com.dananghub.dao.BookingDAO;
import com.dananghub.dao.OrderDAO;
import com.dananghub.dao.ActivityDAO;
import com.dananghub.dao.CouponDAO;
import com.dananghub.entity.*;
import com.dananghub.dao.SubscriptionDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Date;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

    private final TourDAO tourDAO = new TourDAO();
    private final OrderDAO orderDAO = new OrderDAO();
    private final BookingDAO bookingDAO = new BookingDAO();
    private final ActivityDAO activityDAO = new ActivityDAO();
    private final CouponDAO couponDAO = new CouponDAO();

    /**
     * GET: Hiện trang form đặt tour (chọn số người, ngày)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            session.setAttribute("error", "Vui lòng đăng nhập để đặt tour");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String tourIdParam = request.getParameter("id");
        if (tourIdParam == null) {
            tourIdParam = request.getParameter("tourId");
        }
        if (tourIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/tour");
            return;
        }

        int tourId = Integer.parseInt(tourIdParam);
        Tour tour = tourDAO.findById(tourId);

        if (tour == null) {
            session.setAttribute("error", "Tour không tồn tại");
            response.sendRedirect(request.getContextPath() + "/tour");
            return;
        }

        request.setAttribute("tour", tour);
        request.getRequestDispatcher("/views/booking/booking-form.jsp").forward(request, response);
    }

    /**
     * POST: Xử lý đặt tour → tạo order → hiện trang QR thanh toán
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String tourIdParam = request.getParameter("tourId");
        String numberOfPeopleParam = request.getParameter("numberOfPeople");

        if (tourIdParam == null || numberOfPeopleParam == null) {
            session.setAttribute("error", "Vui lòng điền đầy đủ thông tin");
            response.sendRedirect(request.getContextPath() + "/tour");
            return;
        }

        try {
            int tourId = Integer.parseInt(tourIdParam);
            int numberOfPeople = Integer.parseInt(numberOfPeopleParam);

            if (numberOfPeople <= 0) {
                session.setAttribute("error", "Số lượng người phải lớn hơn 0");
                response.sendRedirect(request.getContextPath() + "/booking?id=" + tourId);
                return;
            }

            Tour tour = tourDAO.findById(tourId);
            if (tour == null) {
                session.setAttribute("error", "Tour không tồn tại");
                response.sendRedirect(request.getContextPath() + "/tour");
                return;
            }

            double subtotal = tour.getPrice() * numberOfPeople;

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

                // Create booking
                Booking booking = new Booking();
                booking.setOrder(savedOrder);
                booking.setTour(tour);
                booking.setQuantity(numberOfPeople);
                booking.setSubTotal(subtotal);
                booking.setBookingDate(new Date());
                bookingDAO.create(booking);

                // Log interaction
                InteractionHistory ih = new InteractionHistory(
                    user.getUserId(),
                    "Đặt tour: " + tour.getTourName() + " - " + numberOfPeople +
                    " người - " + String.format("%,.0f", total) + "đ"
                );
                activityDAO.logInteraction(ih);

                // Clear coupon
                session.removeAttribute("appliedCoupon");
                session.removeAttribute("couponDiscount");

                // Generate QR info - MB Bank: 2806281106
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

                request.setAttribute("tour", tour);
                request.setAttribute("order", savedOrder);
                request.setAttribute("orderId", orderId);
                request.setAttribute("transCode", transCode);
                request.setAttribute("qrUrl", qrUrl);
                request.setAttribute("amount", amountInt);
                request.setAttribute("totalFormatted", String.format("%,d", amountInt));
                request.setAttribute("numberOfPeople", numberOfPeople);
                request.setAttribute("subtotal", subtotal);
                request.setAttribute("discount", discount);

                request.getRequestDispatcher("/views/checkout/payment-checkout.jsp").forward(request, response);
            } else {
                session.setAttribute("error", "Lỗi khi tạo đơn hàng. Vui lòng thử lại.");
                response.sendRedirect(request.getContextPath() + "/booking?id=" + tourId);
            }

        } catch (NumberFormatException e) {
            session.setAttribute("error", "Thông tin không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/tour");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/tour");
        }
    }
}
