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
            case "setqty" -> setQuantity(request, response, session);
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
        int currentInCart = 0;
        CartItem existingItem = null;

        for (CartItem item : cart) {
            if (item.getTour().getTourId() == tourId) {
                currentInCart = item.getQuantity();
                existingItem = item;
                found = true;
                break;
            }
        }

        int maxPeople = tour.getMaxPeople();
        int totalQty = currentInCart + qty;

        if (totalQty > maxPeople) {
            int availableSlots = maxPeople - currentInCart;
            session.setAttribute("error", "❌ Không thể thêm! Tour \"" + tour.getTourName() + 
                "\" chỉ còn " + availableSlots + " chỗ trống. Bạn đang có " + currentInCart + " chỗ trong giỏ.");
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null ? referer : request.getContextPath() + "/cart");
            return;
        }

        if (found && existingItem != null) {
            existingItem.setQuantity(totalQty);
        } else {
            CartItem newItem = new CartItem(tour, qty, new Date());
            cart.add(newItem);
        }

        session.setAttribute("cart", cart);
        session.setAttribute("success", "✅ Đã thêm \"" + tour.getTourName() + "\" (" + qty + " chỗ) vào giỏ hàng!");

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
                    int maxPeople = item.getTour().getMaxPeople();
                    int oldQty = item.getQuantity();
                    
                    if (newQty <= 0) {
                        // Xóa item khỏi giỏ
                        cart.removeIf(i -> i.getTour().getTourId() == tourId);
                        session.setAttribute("success", "Đã xóa \"" + item.getTour().getTourName() + "\" khỏi giỏ hàng!");
                    } else if (newQty > maxPeople) {
                        // Vượt quá số chỗ - KHÔNG thay đổi quantity, chỉ lưu error
                        session.removeAttribute("success");
                        String errorMsg = "❌ Vượt quá sức chứa! Tour này chỉ có tối đa " + maxPeople + " chỗ. Hiện tại bạn đã chọn " + oldQty + " chỗ.";
                        session.setAttribute("cartError_" + tourId, errorMsg);
                    } else {
                        // Bình thường - cập nhật và hiển thị success
                        item.setQuantity(newQty);
                        session.removeAttribute("cartError_" + tourId);
                        String action = delta > 0 ? "tăng" : "giảm";
                        session.setAttribute("success", "Đã " + action + " số lượng \"" + item.getTour().getTourName() + 
                            "\" thành " + newQty + " chỗ.");
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

    private void setQuantity(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        String tourIdStr = request.getParameter("id");
        String qtyStr = request.getParameter("qty");
        
        if (tourIdStr == null || qtyStr == null) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        try {
            int tourId = Integer.parseInt(tourIdStr);
            int newQty = Integer.parseInt(qtyStr);
            
            @SuppressWarnings("unchecked")
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart != null) {
                for (CartItem item : cart) {
                    if (item.getTour().getTourId() == tourId) {
                        int maxPeople = item.getTour().getMaxPeople();
                        int oldQty = item.getQuantity();
                        
                        if (newQty <= 0) {
                            // Xóa item khỏi giỏ
                            cart.removeIf(i -> i.getTour().getTourId() == tourId);
                            session.removeAttribute("cartError_" + tourId);
                            session.setAttribute("success", "Đã xóa \"" + item.getTour().getTourName() + "\" khỏi giỏ hàng!");
                        } else if (newQty > maxPeople) {
                            // Vượt quá số chỗ - KHÔNG thay đổi quantity, chỉ lưu error
                            session.removeAttribute("success");
                            String errorMsg = "❌ Vượt quá sức chứa! Tour này chỉ có tối đa " + maxPeople + " chỗ. Hiện tại bạn đã chọn " + oldQty + " chỗ.";
                            session.setAttribute("cartError_" + tourId, errorMsg);
                            // Trả về JSON response để frontend xử lý
                            response.setContentType("application/json");
                            response.getWriter().write("{\"success\":false,\"message\":\"" + errorMsg + "\",\"currentQty\":" + oldQty + ",\"maxPeople\":" + maxPeople + "}");
                            return;
                        } else {
                            // Bình thường - cập nhật và hiển thị success
                            item.setQuantity(newQty);
                            session.removeAttribute("cartError_" + tourId);
                            session.setAttribute("success", "Đã cập nhật số lượng \"" + item.getTour().getTourName() + 
                                "\" thành " + newQty + " chỗ.");
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
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Số lượng không hợp lệ");
        }
        // Dùng forward thay vì redirect để giữ session attributes
        showCart(request, response, session);
    }
}
