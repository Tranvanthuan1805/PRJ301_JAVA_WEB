package controller;

import model.CartItem;
import model.Order;
import model.Payment;
import model.User;
import service.CartService;
import service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet xử lý checkout và thanh toán
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout", "/checkout/*"})
public class CheckoutServlet extends HttpServlet {
    
    private CartService cartService;
    private OrderService orderService;
    
    @Override
    public void init() throws ServletException {
        cartService = new CartService();
        orderService = new OrderService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Hiển thị trang checkout
            showCheckoutPage(request, response);
        } else if (pathInfo.equals("/success")) {
            // Trang thanh toán thành công
            showSuccessPage(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Xử lý đặt tour
            processCheckout(request, response);
        } else if (pathInfo.equals("/payment")) {
            // Xử lý thanh toán
            processPayment(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    /**
     * Hiển thị trang checkout
     */
    private void showCheckoutPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            session.setAttribute("error", "Vui lòng đăng nhập để đặt tour");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        Integer userId = user.getUserId();
        List<CartItem> cartItems;
        double total;
        
        // Check if this is "buy now" (đặt ngay) - check for buyNowTourId parameter
        String tourIdParam = request.getParameter("buyNowTourId");
        String quantityParam = request.getParameter("buyNowQuantity");
        
        if (tourIdParam != null && quantityParam != null) {
            // Đặt ngay - không qua giỏ hàng
            if (tourIdParam.trim().isEmpty() || quantityParam.trim().isEmpty()) {
                session.setAttribute("error", "Thông tin tour không hợp lệ");
                response.sendRedirect(request.getContextPath() + "/tour");
                return;
            }
            
            try {
                int tourId = Integer.parseInt(tourIdParam);
                int quantity = Integer.parseInt(quantityParam);
                
                // Tạo temporary cart item cho buy now
                dao.TourDAO tourDAO = new dao.TourDAO();
                model.Tour tour = tourDAO.getTourById(tourId);
                
                if (tour == null || !tour.isAvailable()) {
                    session.setAttribute("error", "Tour không khả dụng");
                    response.sendRedirect(request.getContextPath() + "/tour");
                    return;
                }
                
                CartItem item = new CartItem();
                item.setTourId(tourId);
                item.setQuantity(quantity);
                item.setTour(tour);
                
                cartItems = java.util.Arrays.asList(item);
                total = tour.getPrice() * quantity;
                
                // Đánh dấu là buy now để xử lý khác
                request.setAttribute("isBuyNow", true);
                request.setAttribute("buyNowTourId", tourId);
                request.setAttribute("buyNowQuantity", quantity);
                
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("error", "Lỗi: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/tour");
                return;
            }
        } else {
            // Checkout từ giỏ hàng bình thường
            CartService.CartValidationResult result = cartService.getCartItemsWithValidation(session, userId);
            cartItems = result.getItems();
            
            if (cartItems.isEmpty()) {
                session.setAttribute("error", "Giỏ hàng trống. Vui lòng thêm tour trước khi đặt.");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            // Kiểm tra có warnings không
            if (result.hasWarnings() || result.hasRemovedItems()) {
                session.setAttribute("error", "Giỏ hàng đã được cập nhật. Vui lòng kiểm tra lại.");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            total = cartService.getCartTotal(session, userId);
        }
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", total);
        request.setAttribute("user", user);
        
        request.getRequestDispatcher("/jsp/checkout.jsp").forward(request, response);
    }
    
    /**
     * Xử lý đặt tour (tạo order)
     */
    private void processCheckout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        try {
            // Lấy thông tin khách hàng
            String customerName = request.getParameter("customerName");
            String customerEmail = request.getParameter("customerEmail");
            String customerPhone = request.getParameter("customerPhone");
            String customerAddress = request.getParameter("customerAddress");
            String notes = request.getParameter("notes");
            String paymentMethod = request.getParameter("paymentMethod");
            
            System.out.println("=== DEBUG CHECKOUT ===");
            System.out.println("Customer: " + customerName);
            System.out.println("Email: " + customerEmail);
            System.out.println("Phone: " + customerPhone);
            System.out.println("Payment Method: " + paymentMethod);
            
            // Validate
            if (customerName == null || customerName.trim().isEmpty() ||
                customerEmail == null || customerEmail.trim().isEmpty() ||
                customerPhone == null || customerPhone.trim().isEmpty()) {
                session.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
                response.sendRedirect(request.getContextPath() + "/checkout");
                return;
            }
            
            // Lấy giỏ hàng hoặc buy now items
            Integer userId = user.getUserId();
            List<CartItem> cartItems;
            
            // Check if this is from "buy now"
            String buyNowTourIdParam = request.getParameter("buyNowTourId");
            String buyNowQuantityParam = request.getParameter("buyNowQuantity");
            
            System.out.println("Buy Now Tour ID: " + buyNowTourIdParam);
            System.out.println("Buy Now Quantity: " + buyNowQuantityParam);
            
            if (buyNowTourIdParam != null && buyNowQuantityParam != null) {
                // Đặt ngay - tạo temporary cart item
                try {
                    int tourId = Integer.parseInt(buyNowTourIdParam);
                    int quantity = Integer.parseInt(buyNowQuantityParam);
                    
                    dao.TourDAO tourDAO = new dao.TourDAO();
                    model.Tour tour = tourDAO.getTourById(tourId);
                    
                    System.out.println("Tour found: " + (tour != null ? tour.getName() : "null"));
                    
                    if (tour == null || !tour.isAvailable()) {
                        session.setAttribute("error", "Tour không khả dụng");
                        response.sendRedirect(request.getContextPath() + "/tour");
                        return;
                    }
                    
                    CartItem item = new CartItem();
                    item.setTourId(tourId);
                    item.setQuantity(quantity);
                    item.setTour(tour);
                    
                    cartItems = java.util.Arrays.asList(item);
                    System.out.println("Created buy now cart item");
                } catch (Exception e) {
                    e.printStackTrace();
                    session.setAttribute("error", "Lỗi: " + e.getMessage());
                    response.sendRedirect(request.getContextPath() + "/checkout");
                    return;
                }
            } else {
                // Checkout từ giỏ hàng bình thường
                cartItems = cartService.getCartItems(session, userId);
                System.out.println("Cart items from database: " + cartItems.size());
                
                if (cartItems.isEmpty()) {
                    session.setAttribute("error", "Giỏ hàng trống");
                    response.sendRedirect(request.getContextPath() + "/cart");
                    return;
                }
            }
            
            System.out.println("Creating order with " + cartItems.size() + " items");
            
            // Tạo đơn hàng
            Order order = orderService.createOrderFromCart(
                userId, cartItems, 
                customerName, customerEmail, customerPhone, customerAddress, 
                notes
            );
            
            System.out.println("Order created: " + (order != null ? order.getOrderCode() : "null"));
            
            if (order == null) {
                session.setAttribute("error", "Không thể tạo đơn hàng. Vui lòng thử lại.");
                response.sendRedirect(request.getContextPath() + "/checkout");
                return;
            }
            
            // Xóa giỏ hàng sau khi đặt thành công (chỉ khi không phải buy now)
            if (buyNowTourIdParam == null) {
                cartService.clearCart(session, userId);
                System.out.println("Cart cleared");
            }
            
            // Xử lý thanh toán dựa trên phương thức
            if ("CASH".equals(paymentMethod)) {
                System.out.println("Processing CASH payment");
                // Thanh toán khi nhận tour - không cần xử lý payment ngay
                // Chỉ cập nhật payment method cho order
                boolean updated = orderService.updateOrderPaymentMethod(order.getId(), paymentMethod);
                System.out.println("Payment method updated: " + updated);
                
                // Load lại order với payment method
                order = orderService.getOrderById(order.getId());
                System.out.println("Order reloaded: " + (order != null));
                
                session.setAttribute("successOrder", order);
                response.sendRedirect(request.getContextPath() + "/checkout/success");
            } else {
                System.out.println("Processing other payment method: " + paymentMethod);
                // Các phương thức khác cần xử lý thanh toán
                session.setAttribute("pendingOrder", order);
                session.setAttribute("selectedPaymentMethod", paymentMethod);
                response.sendRedirect(request.getContextPath() + "/checkout/payment");
            }
            
        } catch (Exception e) {
            System.out.println("=== ERROR IN CHECKOUT ===");
            e.printStackTrace();
            session.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/checkout");
        }
    }
    
    /**
     * Xử lý thanh toán
     */
    private void processPayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Order order = (Order) session.getAttribute("pendingOrder");
        String paymentMethod = (String) session.getAttribute("selectedPaymentMethod");
        
        if (order == null) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Xử lý thanh toán
        Payment payment = orderService.processPayment(order.getId(), paymentMethod);
        
        if (payment != null && "SUCCESS".equals(payment.getPaymentStatus())) {
            // Thanh toán thành công
            session.removeAttribute("pendingOrder");
            session.removeAttribute("selectedPaymentMethod");
            session.setAttribute("successOrder", order);
            session.setAttribute("successPayment", payment);
            
            response.sendRedirect(request.getContextPath() + "/checkout/success");
        } else {
            // Thanh toán thất bại
            session.setAttribute("error", "Thanh toán thất bại. Vui lòng thử lại.");
            response.sendRedirect(request.getContextPath() + "/orders/" + order.getOrderCode());
        }
    }
    
    /**
     * Hiển thị trang thanh toán thành công
     */
    private void showSuccessPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Order order = (Order) session.getAttribute("successOrder");
        Payment payment = (Payment) session.getAttribute("successPayment");
        
        if (order == null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        
        request.setAttribute("order", order);
        request.setAttribute("payment", payment);
        
        // Clear session attributes
        session.removeAttribute("successOrder");
        session.removeAttribute("successPayment");
        
        request.getRequestDispatcher("/jsp/checkout-success.jsp").forward(request, response);
    }
}
