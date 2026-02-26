package controller;

import model.Order;
import model.User;
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
 * Servlet xử lý xem và quản lý đơn hàng
 */
@WebServlet(name = "OrderServlet", urlPatterns = {"/orders", "/orders/*"})
public class OrderServlet extends HttpServlet {
    
    private OrderService orderService;
    
    @Override
    public void init() throws ServletException {
        orderService = new OrderService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            session.setAttribute("error", "Vui lòng đăng nhập để xem đơn hàng");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Danh sách đơn hàng
            showOrderList(request, response, user.getUserId());
        } else {
            // Chi tiết đơn hàng
            String orderCode = pathInfo.substring(1);
            showOrderDetail(request, response, orderCode, user.getUserId());
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
        
        if ("cancel".equals(action)) {
            cancelOrder(request, response, user.getUserId());
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    
    /**
     * Hiển thị danh sách đơn hàng
     */
    private void showOrderList(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        
        List<Order> orders = orderService.getUserOrders(userId);
        
        // Lọc bỏ đơn đã hủy
        orders = orders.stream()
                .filter(o -> !"CANCELLED".equals(o.getStatus()))
                .collect(java.util.stream.Collectors.toList());
        
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/jsp/orders.jsp").forward(request, response);
    }
    
    /**
     * Hiển thị chi tiết đơn hàng
     */
    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response, 
                                 String orderCode, int userId)
            throws ServletException, IOException {
        
        Order order = orderService.getOrderByCode(orderCode);
        
        if (order == null || order.getUserId() != userId) {
            request.getSession().setAttribute("error", "Không tìm thấy đơn hàng");
            response.sendRedirect(request.getContextPath() + "/orders");
            return;
        }
        
        request.setAttribute("order", order);
        request.getRequestDispatcher("/jsp/order-detail.jsp").forward(request, response);
    }
    
    /**
     * Hủy đơn hàng
     */
    private void cancelOrder(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            
            boolean success = orderService.cancelOrder(orderId, userId);
            
            HttpSession session = request.getSession();
            if (success) {
                session.setAttribute("success", "✅ Đã hủy đơn hàng thành công");
            } else {
                session.setAttribute("error", "❌ Không thể hủy đơn hàng này");
            }
            
            response.sendRedirect(request.getContextPath() + "/orders");
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Dữ liệu không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/orders");
        }
    }
}
