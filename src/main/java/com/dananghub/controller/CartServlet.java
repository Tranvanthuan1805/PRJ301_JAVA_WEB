package com.dananghub.controller;

import com.dananghub.dao.TourDAO;
import com.dananghub.entity.CartItem;
import com.dananghub.entity.Tour;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    private final TourDAO tourDAO = new TourDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if (action == null) {
            // Show cart page
            showCart(request, response, session);
            return;
        }

        switch (action) {
            case "add" -> addToCart(request, response, session);
            case "remove" -> removeFromCart(request, response, session);
            case "increase" -> changeQuantity(request, response, session, 1);
            case "decrease" -> changeQuantity(request, response, session, -1);
            case "clear" -> {
                session.removeAttribute("cart");
                session.removeAttribute("cartTotal");
                response.sendRedirect(request.getContextPath() + "/cart");
            }
            default -> showCart(request, response, session);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void showCart(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart != null) {
            double total = cart.stream().mapToDouble(CartItem::getTotalPrice).sum();
            request.setAttribute("cartTotal", total);
        }
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        String tourIdStr = request.getParameter("id");
        String qtyStr = request.getParameter("qty");

        if (tourIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/tour");
            return;
        }

        int tourId = Integer.parseInt(tourIdStr);
        int qty = (qtyStr != null) ? Integer.parseInt(qtyStr) : 1;

        Tour tour = tourDAO.findById(tourId);
        if (tour == null) {
            response.sendRedirect(request.getContextPath() + "/tour");
            return;
        }

        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Check if tour already in cart
        boolean found = false;
        for (CartItem item : cart) {
            if (item.getTour().getTourId() == tourId) {
                item.setQuantity(item.getQuantity() + qty);
                found = true;
                break;
            }
        }

        if (!found) {
            CartItem newItem = new CartItem(tour, qty, new Date());
            cart.add(newItem);
        }

        session.setAttribute("cart", cart);
        session.setAttribute("success", "Đã thêm \"" + tour.getTourName() + "\" vào giỏ hàng!");

        // Redirect back to tour page or cart
        String referer = request.getHeader("Referer");
        response.sendRedirect(referer != null ? referer : request.getContextPath() + "/cart");
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        String tourIdStr = request.getParameter("id");
        if (tourIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        int tourId = Integer.parseInt(tourIdStr);

        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart != null) {
            cart.removeIf(item -> item.getTour().getTourId() == tourId);
            if (cart.isEmpty()) {
                session.removeAttribute("cart");
            } else {
                session.setAttribute("cart", cart);
            }
        }
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void changeQuantity(HttpServletRequest request, HttpServletResponse response, HttpSession session, int delta)
            throws IOException {
        String tourIdStr = request.getParameter("id");
        if (tourIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        int tourId = Integer.parseInt(tourIdStr);

        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart != null) {
            for (CartItem item : cart) {
                if (item.getTour().getTourId() == tourId) {
                    int newQty = item.getQuantity() + delta;
                    if (newQty <= 0) {
                        cart.removeIf(i -> i.getTour().getTourId() == tourId);
                    } else {
                        item.setQuantity(newQty);
                    }
                    break;
                }
            }
            if (cart.isEmpty()) {
                session.removeAttribute("cart");
            } else {
                session.setAttribute("cart", cart);
            }
        }
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
