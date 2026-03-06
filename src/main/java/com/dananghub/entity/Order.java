package com.dananghub.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "Orders")
public class Order implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "OrderId")
    private int orderId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "CustomerId", nullable = false)
    private User customer;

    @Column(name = "TotalAmount", nullable = false)
    private Double totalAmount;

    @Column(name = "OrderStatus", length = 50)
    private String orderStatus = "Pending";

    @Column(name = "PaymentStatus", length = 20)
    private String paymentStatus = "Unpaid";

    @Column(name = "CancelReason", length = 500)
    private String cancelReason;

    @Column(name = "OrderDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date orderDate;

    @Column(name = "UpdatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedAt;

    @Column(name = "CouponCode", length = 50)
    private String couponCode;

    @Column(name = "DiscountAmount")
    private Double discountAmount = 0.0;

    @OneToMany(mappedBy = "order", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<Booking> bookings;

    public Order() {
        this.orderDate = new Date();
        this.orderStatus = "Pending";
        this.paymentStatus = "Unpaid";
    }

    // Helper methods
    public boolean canCancel() {
        return "Pending".equalsIgnoreCase(orderStatus) || "Confirmed".equalsIgnoreCase(orderStatus);
    }

    public boolean isCompleted() {
        return "Completed".equalsIgnoreCase(orderStatus);
    }

    public boolean isCancelled() {
        return "Cancelled".equalsIgnoreCase(orderStatus);
    }

    public String getStatusBadgeClass() {
        if (orderStatus == null)
            return "warning";
        return switch (orderStatus) {
            case "Pending" -> "warning";
            case "Confirmed" -> "info";
            case "Completed" -> "success";
            case "Cancelled" -> "danger";
            default -> "secondary";
        };
    }

    public String getStatusDisplayName() {
        if (orderStatus == null)
            return "Chờ xác nhận";
        return switch (orderStatus) {
            case "Pending" -> "Chờ xác nhận";
            case "Confirmed" -> "Đã xác nhận";
            case "Completed" -> "Hoàn thành";
            case "Cancelled" -> "Đã hủy";
            default -> orderStatus;
        };
    }

    public String getFormattedTotalPrice() {
        return String.format("%,.0f VND", totalAmount);
    }

    public int getCustomerId() {
        return customer != null ? customer.getUserId() : 0;
    }

    public String getCustomerName() {
        return customer != null ? customer.getFullName() : "";
    }

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getCancelReason() {
        return cancelReason;
    }

    public void setCancelReason(String cancelReason) {
        this.cancelReason = cancelReason;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public List<Booking> getBookings() {
        return bookings;
    }

    public void setBookings(List<Booking> bookings) {
        this.bookings = bookings;
    }

    public String getCouponCode() {
        return couponCode;
    }

    public void setCouponCode(String couponCode) {
        this.couponCode = couponCode;
    }

    public Double getDiscountAmount() {
        return discountAmount != null ? discountAmount : 0.0;
    }

    public void setDiscountAmount(Double discountAmount) {
        this.discountAmount = discountAmount;
    }

    @Override
    public String toString() {
        return "Order{orderId=" + orderId + ", totalAmount=" + totalAmount + ", discount=" + discountAmount + ", status='" + orderStatus + "'}";
    }
}
