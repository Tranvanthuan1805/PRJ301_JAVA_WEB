package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * Model đại diện cho đơn đặt tour
 */
public class Order {
    private int id;
    private int userId;
    private String orderCode;
    private String customerName;
    private String customerEmail;
    private String customerPhone;
    private String customerAddress;
    private double totalAmount;
    private String status; // PENDING, CONFIRMED, CANCELLED, COMPLETED
    private String paymentStatus; // UNPAID, PAID, REFUNDED
    private String paymentMethod;
    private String notes;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // Danh sách items trong đơn hàng
    private List<OrderItem> items = new ArrayList<>();
    
    private static final DateTimeFormatter DATETIME_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    
    public Order() {}
    
    /**
     * Kiểm tra đơn hàng có thể thanh toán không
     */
    public boolean canPay() {
        return "PENDING".equals(status) && "UNPAID".equals(paymentStatus);
    }
    
    /**
     * Kiểm tra đơn hàng có thể hủy không
     */
    public boolean canCancel() {
        return "PENDING".equals(status) || 
               ("CONFIRMED".equals(status) && "UNPAID".equals(paymentStatus));
    }
    
    /**
     * Lấy status badge text
     */
    public String getStatusBadge() {
        switch (status) {
            case "PENDING": return "Chờ xác nhận";
            case "CONFIRMED": return "Đã xác nhận";
            case "CANCELLED": return "Đã hủy";
            case "COMPLETED": return "Hoàn thành";
            default: return status;
        }
    }
    
    /**
     * Lấy status display text (alias for getStatusBadge)
     */
    public String getStatusDisplay() {
        return getStatusBadge();
    }
    
    /**
     * Lấy payment status badge text
     */
    public String getPaymentStatusBadge() {
        switch (paymentStatus) {
            case "UNPAID": return "Chưa thanh toán";
            case "PAID": return "Đã thanh toán";
            case "REFUNDED": return "Đã hoàn tiền";
            default: return paymentStatus;
        }
    }
    
    /**
     * Lấy payment status display text (alias for getPaymentStatusBadge)
     */
    public String getPaymentStatusDisplay() {
        return getPaymentStatusBadge();
    }
    
    /**
     * Lấy màu badge cho status
     */
    public String getStatusColor() {
        switch (status) {
            case "PENDING": return "warning";
            case "CONFIRMED": return "info";
            case "CANCELLED": return "danger";
            case "COMPLETED": return "success";
            default: return "secondary";
        }
    }
    
    /**
     * Lấy màu badge cho payment status
     */
    public String getPaymentStatusColor() {
        switch (paymentStatus) {
            case "UNPAID": return "warning";
            case "PAID": return "success";
            case "REFUNDED": return "info";
            default: return "secondary";
        }
    }
    
    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getOrderCode() { return orderCode; }
    public void setOrderCode(String orderCode) { this.orderCode = orderCode; }
    
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    
    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }
    
    public String getCustomerPhone() { return customerPhone; }
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }
    
    public String getCustomerAddress() { return customerAddress; }
    public void setCustomerAddress(String customerAddress) { this.customerAddress = customerAddress; }
    
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
    
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public String getFormattedCreatedAt() {
        return createdAt != null ? createdAt.format(DATETIME_FORMATTER) : "";
    }
    
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public List<OrderItem> getItems() { return items; }
    public void setItems(List<OrderItem> items) { this.items = items; }
}
