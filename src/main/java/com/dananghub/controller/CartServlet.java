package com.dananghub.controller;

import com.dananghub.dao.CartDAO;
import com.dananghub.dao.TourDAO;
import com.dananghub.entity.Cart;
import com.dananghub.entity.Tour;
import com.dananghub.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?redirect=cart");
            return;
        }
        
        try {
            CartDAO cartDAO = new CartDAO();
            List<Cart> cartList = cartDAO.findByUserId(user.getUserId());
            
            double grandTotal = 0;
            Map<Tour, Integer> cartItems = new HashMap<>();
            
            for (Cart cart : cartList) {
                cartItems.put(cart.getTour(), cart.getQuantity());
                grandTotal += cart.getTour().getPrice() * cart.getQuantity();
            }
            
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("grandTotal", grandTotal);
            request.setAttribute("cartCount", cartList.size());
            
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
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
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            handleAddToCart(request, response);
        } else if ("addAndCheckout".equals(action)) {
            handleAddAndCheckout(request, response);
        } else if ("remove".equals(action)) {
            handleRemoveFromCart(request, response);
        } else if ("update".equals(action)) {
            handleUpdateQuantity(request, response);
        } else if ("clear".equals(action)) {
            handleClearCart(request, response);
        } else {
            doGet(request, response);
        }
    }
    
    private void handleAddToCart(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        try {
            int tourId = Integer.parseInt(request.getParameter("tourId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            TourDAO tourDAO = new TourDAO();
            Tour tour = tourDAO.findById(tourId);
            
            if (tour != null) {
                // Check available slots
                int availableSlots = tour.getAvailableSlots();
                
                // Check current quantity in cart
                CartDAO cartDAO = new CartDAO();
                Cart existingCart = cartDAO.findByUserAndTour(user.getUserId(), tourId);
                int currentQuantityInCart = (existingCart != null) ? existingCart.getQuantity() : 0;
                int totalQuantity = currentQuantityInCart + quantity;
                
                if (availableSlots <= 0) {
                    session.setAttribute("message", "Tour '" + tour.getName() + "' đã hết chỗ!");
                    session.setAttribute("messageType", "error");
                } else if (totalQuantity > availableSlots) {
                    // Don't add, just show error
                    session.setAttribute("message", "Tour '" + tour.getName() + "' chỉ còn " + availableSlots + " chỗ! " + 
                                                   (currentQuantityInCart > 0 ? "(Bạn đã có " + currentQuantityInCart + " trong giỏ hàng)" : ""));
                    session.setAttribute("messageType", "error");
                } else {
                    cartDAO.addOrUpdate(user, tour, quantity);
                    session.setAttribute("message", "Đã thêm tour vào giỏ hàng!");
                    session.setAttribute("messageType", "success");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "Lỗi: " + e.getMessage());
            session.setAttribute("messageType", "error");
        }
        
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/explore");
        }
    }
    
    private void handleAddAndCheckout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        try {
            int tourId = Integer.parseInt(request.getParameter("tourId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            TourDAO tourDAO = new TourDAO();
            Tour tour = tourDAO.findById(tourId);
            
            if (tour != null) {
                // Check available slots
                int availableSlots = tour.getAvailableSlots();
                
                // Check current quantity in cart
                CartDAO cartDAO = new CartDAO();
                Cart existingCart = cartDAO.findByUserAndTour(user.getUserId(), tourId);
                int currentQuantityInCart = (existingCart != null) ? existingCart.getQuantity() : 0;
                int totalQuantity = currentQuantityInCart + quantity;
                
                if (totalQuantity > availableSlots) {
                    session.setAttribute("message", "Tour '" + tour.getName() + "' chỉ còn " + availableSlots + " chỗ!");
                    session.setAttribute("messageType", "error");
                    response.sendRedirect(request.getContextPath() + "/explore");
                    return;
                }
                
                cartDAO.addOrUpdate(user, tour, quantity);
            }
            
            response.sendRedirect(request.getContextPath() + "/checkout");
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "Lỗi: " + e.getMessage());
            session.setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/explore");
        }
    }
    
    private void handleRemoveFromCart(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        try {
            int tourId = Integer.parseInt(request.getParameter("tourId"));
            
            CartDAO cartDAO = new CartDAO();
            cartDAO.remove(user.getUserId(), tourId);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        response.sendRedirect(request.getContextPath() + "/cart");
    }
    
    private void handleUpdateQuantity(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        try {
            int tourId = Integer.parseInt(request.getParameter("tourId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            if (quantity <= 0) {
                // Remove from cart if quantity is 0 or negative
                CartDAO cartDAO = new CartDAO();
                cartDAO.remove(user.getUserId(), tourId);
            } else {
                // Validate capacity
                TourDAO tourDAO = new TourDAO();
                Tour tour = tourDAO.findById(tourId);
                
                if (tour != null) {
                    int availableSlots = tour.getAvailableSlots();
                    
                    if (quantity > availableSlots) {
                        // Reset to max available or 1
                        int validQuantity = Math.max(1, Math.min(availableSlots, 1));
                        
                        CartDAO cartDAO = new CartDAO();
                        cartDAO.updateQuantity(user.getUserId(), tourId, validQuantity);
                        
                        session.setAttribute("message", "Tour '" + tour.getName() + "' chỉ còn " + availableSlots + " chỗ! Đã reset về " + validQuantity);
                        session.setAttribute("messageType", "warning");
                    } else {
                        CartDAO cartDAO = new CartDAO();
                        cartDAO.updateQuantity(user.getUserId(), tourId, quantity);
                    }
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        response.sendRedirect(request.getContextPath() + "/cart");
    }
    
    private void handleClearCart(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        try {
            CartDAO cartDAO = new CartDAO();
            cartDAO.clearCart(user.getUserId());
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
