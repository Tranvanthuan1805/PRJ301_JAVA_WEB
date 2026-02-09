package controller;

import model.entity.dao.BookingDAO;
import model.entity.dao.OrderDAO;
import model.entity.Cart;
import model.entity.CartItem;
import model.entity.Order;
import model.entity.Booking;
import model.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/customer/checkout")
public class CheckoutServlet extends HttpServlet {
    private BookingDAO bookingDAO = new BookingDAO();
    private OrderDAO orderDAO = new OrderDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart_obj");

        if (currentUser == null || cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // 1. Create Order Master
            Order order = new Order();
            order.setCustomerId(currentUser.getUserId());
            order.setTotalAmount(cart.getTotalValue());
            order.setOrderStatus("Completed");
            order.setOrderDate(new Timestamp(System.currentTimeMillis()));

            int orderId = orderDAO.createOrder(order);
            if (orderId == -1) throw new Exception("Failed to create order");

            // 2. Create Bookings (Line Items)
            for (CartItem item : cart.getItems()) {
                Booking b = new Booking();
                b.setOrderId(orderId);
                b.setTourId(item.getTour().getTourId());
                b.setTourDate(item.getTravelDate());
                b.setQuantity(item.getQuantity());
                b.setSubTotal(item.getTotalPrice());
                b.setBookingStatus("Confirmed");
                
                bookingDAO.createBooking(b);
            }

            // 3. Clear Cart
            cart.clear();
            session.setAttribute("cart_count", 0);
            
            request.setAttribute("orderId", orderId);
            request.getRequestDispatcher("/views/cart-booking/confirmation.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
