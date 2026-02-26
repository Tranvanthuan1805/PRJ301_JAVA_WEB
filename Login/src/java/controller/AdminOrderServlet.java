package controller;

import dao.OrderDAO;
import model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {
    
    private OrderDAO orderDAO;
    
    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (!"ADMIN".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("search".equals(action)) {
            searchOrders(request, response);
        } else if ("view".equals(action)) {
            viewOrder(request, response);
        } else if ("edit".equals(action)) {
            editOrder(request, response);
        } else if ("updateStatus".equals(action)) {
            updateOrderStatus(request, response);
        } else {
            listAllOrders(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (!"ADMIN".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("updateStatus".equals(action)) {
            updateOrderStatus(request, response);
        } else if ("delete".equals(action)) {
            deleteOrder(request, response);
        } else if ("update".equals(action)) {
            updateOrder(request, response);
        }
    }
    
    private void listAllOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get filter parameters
        String statusFilter = request.getParameter("status");
        String paymentFilter = request.getParameter("payment");
        String sortBy = request.getParameter("sortBy");
        String search = request.getParameter("search");
        
        // Get all orders
        List<Order> orders = orderDAO.getAllOrders();
        
        // Apply search filter
        if (search != null && !search.trim().isEmpty()) {
            final String query = search.toLowerCase();
            orders = orders.stream()
                .filter(o -> o.getOrderCode().toLowerCase().contains(query) ||
                           o.getCustomerName().toLowerCase().contains(query) ||
                           o.getCustomerEmail().toLowerCase().contains(query))
                .collect(java.util.stream.Collectors.toList());
            request.setAttribute("searchKeyword", search);
        }
        
        // Apply status filter
        if (statusFilter != null && !statusFilter.equals("all")) {
            final String status = statusFilter;
            orders = orders.stream()
                .filter(o -> status.equals(o.getStatus()))
                .collect(java.util.stream.Collectors.toList());
            request.setAttribute("statusFilter", statusFilter);
        }
        
        // Apply payment filter
        if (paymentFilter != null && !paymentFilter.equals("all")) {
            final String payment = paymentFilter;
            orders = orders.stream()
                .filter(o -> payment.equals(o.getPaymentStatus()))
                .collect(java.util.stream.Collectors.toList());
            request.setAttribute("paymentFilter", paymentFilter);
        }
        
        // Apply sorting
        if (sortBy != null && !sortBy.isEmpty()) {
            switch (sortBy) {
                case "date_desc":
                    orders.sort((o1, o2) -> o2.getCreatedAt().compareTo(o1.getCreatedAt()));
                    break;
                case "date_asc":
                    orders.sort((o1, o2) -> o1.getCreatedAt().compareTo(o2.getCreatedAt()));
                    break;
                case "amount_desc":
                    orders.sort((o1, o2) -> Double.compare(o2.getTotalAmount(), o1.getTotalAmount()));
                    break;
                case "amount_asc":
                    orders.sort((o1, o2) -> Double.compare(o1.getTotalAmount(), o2.getTotalAmount()));
                    break;
            }
            request.setAttribute("sortBy", sortBy);
        }
        
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
    }
    
    private void searchOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Redirect to listAllOrders since it now handles search
        listAllOrders(request, response);
    }
    
    private void viewOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String orderCode = request.getParameter("code");
        Order order = orderDAO.getOrderByCode(orderCode);
        
        if (order == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy đơn hàng");
            return;
        }
        
        request.setAttribute("order", order);
        request.getRequestDispatcher("/admin/order-detail.jsp").forward(request, response);
    }
    
    private void editOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String orderIdParam = request.getParameter("id");
        
        if (orderIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalid");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdParam);
            Order order = orderDAO.getOrderById(orderId);
            
            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/admin/orders?error=notfound");
                return;
            }
            
            request.setAttribute("order", order);
            request.getRequestDispatcher("/admin/order-edit.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalid");
        }
    }
    
    private void updateOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String orderIdParam = request.getParameter("orderId");
        String customerName = request.getParameter("customerName");
        String customerEmail = request.getParameter("customerEmail");
        String customerPhone = request.getParameter("customerPhone");
        String customerAddress = request.getParameter("customerAddress");
        String status = request.getParameter("status");
        String paymentStatus = request.getParameter("paymentStatus");
        String paymentMethod = request.getParameter("paymentMethod");
        String notes = request.getParameter("notes");
        
        if (orderIdParam == null || customerName == null || customerEmail == null || 
            customerPhone == null || status == null || paymentStatus == null) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalid");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdParam);
            
            Order order = new Order();
            order.setId(orderId);
            order.setCustomerName(customerName);
            order.setCustomerEmail(customerEmail);
            order.setCustomerPhone(customerPhone);
            order.setCustomerAddress(customerAddress);
            order.setStatus(status);
            order.setPaymentStatus(paymentStatus);
            order.setPaymentMethod(paymentMethod);
            order.setNotes(notes);
            
            boolean success = orderDAO.updateOrder(order);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/orders?success=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/orders?error=failed");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalid");
        }
    }
    
    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        String orderIdParam = request.getParameter("orderId");
        String newStatus = request.getParameter("status");
        
        if (orderIdParam == null || newStatus == null) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalid");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdParam);
            boolean success = orderDAO.updateOrderStatus(orderId, newStatus);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/orders?success=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/orders?error=failed");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalid");
        }
    }
    
    private void deleteOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        String orderIdParam = request.getParameter("orderId");
        
        if (orderIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalid");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdParam);
            boolean success = orderDAO.deleteOrder(orderId);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/orders?success=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/orders?error=failed");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalid");
        }
    }
}
