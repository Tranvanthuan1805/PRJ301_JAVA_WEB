package service;

import dao.OrderDAO;
import dao.PaymentDAO;
import dao.TourDAO;
import model.*;
import util.DBUtil;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

/**
 * Service xử lý logic đặt tour và thanh toán
 */
public class OrderService {
    
    private OrderDAO orderDAO;
    private PaymentDAO paymentDAO;
    private TourDAO tourDAO;
    
    public OrderService() {
        this.orderDAO = new OrderDAO();
        this.paymentDAO = new PaymentDAO();
        this.tourDAO = new TourDAO();
    }
    
    /**
     * Tạo đơn hàng từ giỏ hàng
     * @return Order object nếu thành công, null nếu thất bại
     */
    public Order createOrderFromCart(int userId, List<CartItem> cartItems, 
                                     String customerName, String customerEmail, 
                                     String customerPhone, String customerAddress,
                                     String notes) {
        
        if (cartItems == null || cartItems.isEmpty()) {
            return null;
        }
        
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // Start transaction
            
            // 1. Validate tất cả tours còn đủ chỗ
            for (CartItem item : cartItems) {
                Tour tour = tourDAO.getTourById(item.getTourId());
                if (tour == null || !tour.checkAvailability(item.getQuantity())) {
                    conn.rollback();
                    return null;
                }
            }
            
            // 2. Tính tổng tiền
            double totalAmount = cartItems.stream()
                                         .mapToDouble(CartItem::getSubtotal)
                                         .sum();
            
            // 3. Tạo order
            Order order = new Order();
            order.setUserId(userId);
            order.setOrderCode(orderDAO.generateOrderCode());
            order.setCustomerName(customerName);
            order.setCustomerEmail(customerEmail);
            order.setCustomerPhone(customerPhone);
            order.setCustomerAddress(customerAddress);
            order.setTotalAmount(totalAmount);
            order.setStatus("PENDING");
            order.setPaymentStatus("UNPAID");
            order.setNotes(notes);
            
            int orderId = orderDAO.createOrder(order);
            if (orderId <= 0) {
                conn.rollback();
                return null;
            }
            order.setId(orderId);
            
            // 4. Thêm order items
            for (CartItem cartItem : cartItems) {
                OrderItem orderItem = new OrderItem(
                    cartItem.getTourId(),
                    cartItem.getTour().getName(),
                    cartItem.getTour().getPrice(),
                    cartItem.getQuantity()
                );
                orderItem.setOrderId(orderId);
                
                if (!orderDAO.addOrderItem(orderItem)) {
                    conn.rollback();
                    return null;
                }
            }
            
            // 5. Cập nhật currentCapacity của tours
            for (CartItem item : cartItems) {
                if (!tourDAO.updateCapacity(item.getTourId(), item.getQuantity())) {
                    conn.rollback();
                    return null;
                }
            }
            
            conn.commit();
            
            // Load items vào order
            order.setItems(orderDAO.getOrderItems(orderId));
            
            return order;
            
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return null;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    /**
     * Xử lý thanh toán
     */
    public Payment processPayment(int orderId, String paymentMethod) {
        Order order = orderDAO.getOrderById(orderId);
        
        if (order == null || !order.canPay()) {
            return null;
        }
        
        // Tạo payment record
        Payment payment = new Payment();
        payment.setOrderId(orderId);
        payment.setPaymentCode(paymentDAO.generatePaymentCode());
        payment.setAmount(order.getTotalAmount());
        payment.setPaymentMethod(paymentMethod);
        payment.setPaymentStatus("PENDING");
        
        int paymentId = paymentDAO.createPayment(payment);
        if (paymentId <= 0) {
            return null;
        }
        payment.setId(paymentId);
        
        // Simulate payment processing
        // Trong thực tế, đây là nơi tích hợp với payment gateway
        boolean paymentSuccess = simulatePaymentProcessing(paymentMethod);
        
        if (paymentSuccess) {
            // Cập nhật payment status
            String transactionId = "TXN" + System.currentTimeMillis();
            paymentDAO.updatePaymentStatus(paymentId, "SUCCESS", transactionId);
            payment.setPaymentStatus("SUCCESS");
            payment.setTransactionId(transactionId);
            
            // Cập nhật order payment status
            orderDAO.updatePaymentStatus(orderId, "PAID", paymentMethod);
            orderDAO.updateOrderStatus(orderId, "CONFIRMED");
        } else {
            paymentDAO.updatePaymentStatus(paymentId, "FAILED", null);
            payment.setPaymentStatus("FAILED");
        }
        
        return payment;
    }
    
    /**
     * Simulate payment processing
     * Trong thực tế, đây sẽ gọi API của payment gateway
     */
    private boolean simulatePaymentProcessing(String paymentMethod) {
        // Giả lập: 95% success rate
        return Math.random() < 0.95;
    }
    
    /**
     * Hủy đơn hàng
     */
    public boolean cancelOrder(int orderId, int userId) {
        Order order = orderDAO.getOrderById(orderId);
        
        if (order == null || order.getUserId() != userId || !order.canCancel()) {
            return false;
        }
        
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);
            
            // 1. Hủy đơn hàng
            if (!orderDAO.cancelOrder(orderId)) {
                conn.rollback();
                return false;
            }
            
            // 2. Hoàn lại capacity cho tours
            List<OrderItem> items = order.getItems();
            for (OrderItem item : items) {
                if (!tourDAO.updateCapacity(item.getTourId(), -item.getQuantity())) {
                    conn.rollback();
                    return false;
                }
            }
            
            conn.commit();
            return true;
            
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    /**
     * Cập nhật phương thức thanh toán cho order
     */
    public boolean updateOrderPaymentMethod(int orderId, String paymentMethod) {
        return orderDAO.updatePaymentStatus(orderId, "UNPAID", paymentMethod);
    }
    
    /**
     * Lấy đơn hàng theo ID
     */
    public Order getOrderById(int orderId) {
        return orderDAO.getOrderById(orderId);
    }
    
    /**
     * Lấy đơn hàng theo code
     */
    public Order getOrderByCode(String orderCode) {
        return orderDAO.getOrderByCode(orderCode);
    }
    
    /**
     * Lấy danh sách đơn hàng của user
     */
    public List<Order> getUserOrders(int userId) {
        return orderDAO.getOrdersByUserId(userId);
    }
}
