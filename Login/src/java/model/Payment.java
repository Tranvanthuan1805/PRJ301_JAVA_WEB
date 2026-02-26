package model;

import java.time.LocalDateTime;

/**
 * Model đại diện cho thanh toán
 */
public class Payment {
    private int id;
    private int orderId;
    private String paymentCode;
    private double amount;
    private String paymentMethod; // CASH, BANK_TRANSFER, CREDIT_CARD, MOMO, VNPAY
    private String paymentStatus; // PENDING, SUCCESS, FAILED, CANCELLED
    private String transactionId;
    private LocalDateTime paymentDate;
    private LocalDateTime createdAt;
    
    public Payment() {}
    
    /**
     * Lấy tên phương thức thanh toán
     */
    public String getPaymentMethodName() {
        switch (paymentMethod) {
            case "CASH": return "Tiền mặt";
            case "BANK_TRANSFER": return "Chuyển khoản";
            case "CREDIT_CARD": return "Thẻ tín dụng";
            case "MOMO": return "Ví MoMo";
            case "VNPAY": return "VNPay";
            default: return paymentMethod;
        }
    }
    
    /**
     * Lấy status badge text
     */
    public String getStatusBadge() {
        switch (paymentStatus) {
            case "PENDING": return "Đang xử lý";
            case "SUCCESS": return "Thành công";
            case "FAILED": return "Thất bại";
            case "CANCELLED": return "Đã hủy";
            default: return paymentStatus;
        }
    }
    
    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    
    public String getPaymentCode() { return paymentCode; }
    public void setPaymentCode(String paymentCode) { this.paymentCode = paymentCode; }
    
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
    
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    
    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
    
    public String getTransactionId() { return transactionId; }
    public void setTransactionId(String transactionId) { this.transactionId = transactionId; }
    
    public LocalDateTime getPaymentDate() { return paymentDate; }
    public void setPaymentDate(LocalDateTime paymentDate) { this.paymentDate = paymentDate; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
