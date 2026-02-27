package com.dananghub.controller;

import com.dananghub.dao.TourDAO;
import com.dananghub.dao.BookingDAO;
import com.dananghub.dao.OrderDAO;
import com.dananghub.dao.ActivityDAO;
import com.dananghub.entity.*;

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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("book".equals(action)) {
            handleBooking(request, response, user);
        }
    }

    private void handleBooking(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {

        HttpSession session = request.getSession();
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
                response.sendRedirect(request.getContextPath() + "/tour?action=view&id=" + tourId);
                return;
            }

            Tour tour = tourDAO.findById(tourId);
            if (tour == null) {
                session.setAttribute("error", "Tour không tồn tại");
                response.sendRedirect(request.getContextPath() + "/tour");
                return;
            }

            // Tao order
            Order order = new Order();
            order.setCustomer(user);
            order.setTotalAmount(tour.getPrice() * numberOfPeople);
            order.setOrderStatus("Pending");
            order.setPaymentStatus("Unpaid");
            order.setOrderDate(new Date());
            order.setUpdatedAt(new Date());

            int orderId = orderDAO.create(order);

            if (orderId > 0) {
                // Tao booking
                Order savedOrder = orderDAO.findById(orderId);
                Booking booking = new Booking();
                booking.setOrder(savedOrder);
                booking.setTour(tour);
                booking.setQuantity(numberOfPeople);
                booking.setSubTotal(tour.getPrice() * numberOfPeople);
                booking.setBookingDate(new Date());

                bookingDAO.create(booking);

                // Log interaction
                InteractionHistory ih = new InteractionHistory(
                    user.getUserId(),
                    "Đặt tour: " + tour.getTourName() + " - " + numberOfPeople + " người"
                );
                activityDAO.logInteraction(ih);

                session.setAttribute("success", "Đặt tour thành công! Mã đơn hàng: #" + orderId);
            } else {
                session.setAttribute("error", "Lỗi khi tạo đơn hàng");
            }

            response.sendRedirect(request.getContextPath() + "/tour?action=view&id=" + tourId);

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
