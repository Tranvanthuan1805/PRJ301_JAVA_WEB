package com.dananghub.controller;

import com.dananghub.dao.CartDAO;
import com.dananghub.dao.TourDAO;
import com.dananghub.entity.Cart;
import com.dananghub.entity.Order;
import com.dananghub.entity.Booking;
import com.dananghub.entity.Tour;
import com.dananghub.entity.User;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        try {
            CartDAO cartDAO = new CartDAO();
            List<Cart> cartList = cartDAO.findByUserId(user.getUserId());
            
            if (cartList == null || cartList.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            double grandTotal = 0;
            Map<Tour, Integer> cartItems = new HashMap<>();
            
            for (Cart cart : cartList) {
                cartItems.put(cart.getTour(), cart.getQuantity());
                grandTotal += cart.getTour().getPrice() * cart.getQuantity();
            }
            
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("grandTotal", grandTotal);
            request.setAttribute("user", user);
            
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/cart");
        }
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
        
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        
        try {
            // Get cart items
            CartDAO cartDAO = new CartDAO();
            List<Cart> cartList = cartDAO.findByUserId(user.getUserId());
            
            if (cartList == null || cartList.isEmpty()) {
                session.setAttribute("message", "Giỏ hàng trống!");
                session.setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            // Validate capacity
            TourDAO tourDAO = new TourDAO();
            for (Cart cart : cartList) {
                Tour tour = tourDAO.findById(cart.getTour().getId());
                if (tour == null) {
                    session.setAttribute("message", "Tour không tồn tại!");
                    session.setAttribute("messageType", "error");
                    response.sendRedirect(request.getContextPath() + "/cart");
                    return;
                }
                
                int availableSlots = tour.getAvailableSlots();
                if (availableSlots < cart.getQuantity()) {
                    session.setAttribute("message", "Tour '" + tour.getName() + "' chỉ còn " + availableSlots + " chỗ!");
                    session.setAttribute("messageType", "error");
                    response.sendRedirect(request.getContextPath() + "/cart");
                    return;
                }
            }
            
            // Start transaction
            tx.begin();
            
            // Calculate total
            double grandTotal = 0;
            for (Cart cart : cartList) {
                grandTotal += cart.getTour().getPrice() * cart.getQuantity();
            }
            
            // Create order
            Order order = new Order();
            order.setCustomer(user);
            order.setTotalAmount(grandTotal);
            order.setOrderDate(new Date());
            order.setOrderStatus("Pending");
            order.setPaymentStatus("Unpaid");
            
            em.persist(order);
            em.flush(); // Force insert to get orderId
            
            // Create bookings
            for (Cart cart : cartList) {
                Booking booking = new Booking();
                booking.setOrder(order);
                booking.setTour(cart.getTour());
                booking.setQuantity(cart.getQuantity());
                booking.setSubTotal(cart.getTour().getPrice() * cart.getQuantity());
                booking.setBookingDate(new Date());
                booking.setBookingStatus("Pending");
                
                em.persist(booking);
                
                // Update tour capacity
                Tour tour = em.find(Tour.class, cart.getTour().getId());
                tour.setCurrentCapacity(tour.getCurrentCapacity() + cart.getQuantity());
                em.merge(tour);
            }
            
            tx.commit();
            
            // Clear cart
            cartDAO.clearCart(user.getUserId());
            
            session.setAttribute("message", "Đặt hàng thành công! Mã đơn hàng: #" + order.getOrderId());
            session.setAttribute("messageType", "success");
            response.sendRedirect(request.getContextPath() + "/my-orders");
            
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            session.setAttribute("message", "Lỗi: " + e.getMessage());
            session.setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/checkout");
        } finally {
            em.close();
        }
    }
}
