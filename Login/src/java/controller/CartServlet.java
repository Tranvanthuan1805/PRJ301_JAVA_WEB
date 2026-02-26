package controller;

import model.CartItem;
import model.User;
import service.CartService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet xử lý các thao tác với giỏ hàng
 * Endpoints:
 * - GET /cart - Xem giỏ hàng
 * - POST /cart/add - Thêm tour vào giỏ
 * - POST /cart/update - Cập nhật số lượng
 * - POST /cart/remove - Xóa item
 * - POST /cart/clear - Xóa toàn bộ giỏ
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/cart", "/cart/*"})
public class CartServlet extends HttpServlet {
    
    private CartService cartService;
    
    @Override
    public void init() throws ServletException {
        cartService = new CartService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Hiển thị giỏ hàng
            viewCart(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== CartServlet.doPost() called ===");
        System.out.println("Request URI: " + request.getRequestURI());
        System.out.println("Context Path: " + request.getContextPath());
        System.out.println("Servlet Path: " + request.getServletPath());
        System.out.println("Path Info: " + request.getPathInfo());
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null) {
            System.out.println("ERROR: pathInfo is null");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        System.out.println("Routing to: " + pathInfo);
        
        switch (pathInfo) {
            case "/add":
                addToCart(request, response);
                break;
            case "/update":
                updateCart(request, response);
                break;
            case "/remove":
                removeFromCart(request, response);
                break;
            case "/clear":
                clearCart(request, response);
                break;
            default:
                System.out.println("ERROR: Unknown path: " + pathInfo);
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    /**
     * Xem giỏ hàng
     */
    private void viewCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Integer userId = (user != null) ? user.getUserId() : null;
        
        // Lấy danh sách items với validation
        CartService.CartValidationResult result = cartService.getCartItemsWithValidation(session, userId);
        List<CartItem> cartItems = result.getItems();
        
        // Tính tổng
        double total = cartService.getCartTotal(session, userId);
        int itemCount = cartItems.size();
        
        // Thêm thông báo nếu có thay đổi
        if (result.hasWarnings()) {
            StringBuilder warningMsg = new StringBuilder("⚠️ Giỏ hàng đã được cập nhật:\n");
            for (String warning : result.getWarnings()) {
                warningMsg.append("• ").append(warning).append("\n");
            }
            request.setAttribute("cartWarnings", warningMsg.toString());
        }
        
        if (result.hasRemovedItems()) {
            StringBuilder removedMsg = new StringBuilder("❌ Các tour sau đã bị xóa khỏi giỏ hàng:\n");
            for (String removed : result.getRemovedItems()) {
                removedMsg.append("• ").append(removed).append("\n");
            }
            request.setAttribute("cartRemovedItems", removedMsg.toString());
        }
        
        // Set attributes
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", total);
        request.setAttribute("cartItemCount", itemCount);
        
        // Forward to JSP
        request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
    }
    
    /**
     * Thêm tour vào giỏ hàng
     */
    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== CartServlet.addToCart() called ===");
        System.out.println("Request URI: " + request.getRequestURI());
        System.out.println("Context Path: " + request.getContextPath());
        System.out.println("Path Info: " + request.getPathInfo());
        
        try {
            String tourIdParam = request.getParameter("tourId");
            System.out.println("tourId parameter: " + tourIdParam);
            
            if (tourIdParam == null || tourIdParam.isEmpty()) {
                System.out.println("ERROR: tourId is null or empty");
                request.getSession().setAttribute("error", "Thiếu thông tin tour");
                redirectBack(request, response);
                return;
            }
            
            int tourId = Integer.parseInt(tourIdParam);
            int quantity = 1;
            
            String quantityParam = request.getParameter("quantity");
            if (quantityParam != null && !quantityParam.isEmpty()) {
                quantity = Integer.parseInt(quantityParam);
            }
            
            System.out.println("tourId: " + tourId + ", quantity: " + quantity);
            
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            Integer userId = (user != null) ? user.getUserId() : null;
            
            System.out.println("User: " + (user != null ? user.getUsername() : "Guest"));
            System.out.println("UserId: " + userId);
            
            // Validate trước khi thêm
            String validationError = cartService.validateAddToCart(tourId, quantity);
            if (validationError != null) {
                System.out.println("Validation error: " + validationError);
                session.setAttribute("error", validationError);
                redirectBack(request, response);
                return;
            }
            
            boolean success = cartService.addToCart(session, userId, tourId, quantity);
            System.out.println("Add to cart result: " + success);
            
            if (success) {
                // Check if redirect to checkout
                String redirect = request.getParameter("redirect");
                if ("checkout".equals(redirect)) {
                    // Đặt ngay - không cần thông báo, redirect luôn
                    response.sendRedirect(request.getContextPath() + "/checkout");
                    return;
                } else {
                    // Thêm vào giỏ hàng bình thường
                    session.setAttribute("success", "Đã thêm tour vào giỏ hàng");
                }
            } else {
                session.setAttribute("error", "Không thể thêm tour vào giỏ hàng. Vui lòng thử lại.");
            }
            
            redirectBack(request, response);
            
        } catch (NumberFormatException e) {
            System.out.println("NumberFormatException: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("error", "Dữ liệu không hợp lệ");
            redirectBack(request, response);
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            redirectBack(request, response);
        }
    }
    
    /**
     * Redirect về trang trước đó
     */
    private void redirectBack(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/tours");
        }
    }
    
    /**
     * Cập nhật số lượng trong giỏ hàng
     */
    private void updateCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int tourId = Integer.parseInt(request.getParameter("tourId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            Integer userId = (user != null) ? user.getUserId() : null;
            
            // Validate số lượng mới
            if (quantity > 0) {
                String validationError = cartService.validateAddToCart(tourId, quantity);
                if (validationError != null) {
                    session.setAttribute("error", "⚠️ " + validationError);
                    response.sendRedirect(request.getContextPath() + "/cart");
                    return;
                }
            }
            
            boolean success = cartService.updateQuantity(session, userId, tourId, quantity);
            
            if (success) {
                if (quantity == 0) {
                    session.setAttribute("success", "✅ Đã xóa tour khỏi giỏ hàng");
                } else {
                    session.setAttribute("success", "✅ Đã cập nhật số lượng");
                }
            } else {
                session.setAttribute("error", "❌ Không thể cập nhật giỏ hàng");
            }
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Dữ liệu không hợp lệ");
        }
        
        response.sendRedirect(request.getContextPath() + "/cart");
    }
    
    /**
     * Xóa item khỏi giỏ hàng
     */
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int tourId = Integer.parseInt(request.getParameter("tourId"));
            
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            Integer userId = (user != null) ? user.getUserId() : null;
            
            boolean success = cartService.removeFromCart(session, userId, tourId);
            
            if (success) {
                session.setAttribute("success", "Đã xóa tour khỏi giỏ hàng");
            } else {
                session.setAttribute("error", "Không thể xóa tour");
            }
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Dữ liệu không hợp lệ");
        }
        
        response.sendRedirect(request.getContextPath() + "/cart");
    }
    
    /**
     * Xóa toàn bộ giỏ hàng
     */
    private void clearCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Integer userId = (user != null) ? user.getUserId() : null;
        
        boolean success = cartService.clearCart(session, userId);
        
        if (success) {
            session.setAttribute("success", "Đã xóa toàn bộ giỏ hàng");
        } else {
            session.setAttribute("error", "Không thể xóa giỏ hàng");
        }
        
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
