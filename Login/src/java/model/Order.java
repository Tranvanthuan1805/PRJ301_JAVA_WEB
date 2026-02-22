package model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Order Entity - Maps to Orders table in database
 * Represents a customer's order for a tour
 */
@Entity
@Table(name = "Orders")
public class Order implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "OrderId")
    private int orderId;
    
    @Column(name = "UserId", nullable = false)
    private int userId;
    
    @Column(name = "TourId", nullable = false)
    private int tourId;
    
    @Column(name = "OrderDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date orderDate;
    
    @Column(name = "NumberOfPeople", nullable = false)
    private int numberOfPeople;
    
    @Column(name = "TotalPrice", nullable = false)
    private double totalPrice;
    
    @Column(name = "Status", length = 20)
    private String status = "Pending";  // Pending, Confirmed, Completed, Cancelled
    
    @Column(name = "PaymentStatus", length = 20)
    private String paymentStatus = "Unpaid";  // Unpaid, Paid, Refunded
    
    @Column(name = "UpdatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedAt;
    
    @Column(name = "CancelReason", length = 500)
    private String cancelReason;

    // ==================== Constructors ====================
    
    public Order() {
        this.orderDate = new Date();
        this.status = "Pending";
        this.paymentStatus = "Unpaid";
    }

    public Order(int userId, int tourId, int numberOfPeople, double totalPrice) {
        this();
        this.userId = userId;
        this.tourId = tourId;
        this.numberOfPeople = numberOfPeople;
        this.totalPrice = totalPrice;
    }

    // ==================== Helper Methods ====================
    
    /**
     * Get status as enum for easier handling
     */
    public OrderStatus getStatusEnum() {
        return OrderStatus.fromCode(this.status);
    }
    
    /**
     * Check if order can be cancelled
     * Only Pending and Confirmed orders can be cancelled
     */
    public boolean canCancel() {
        OrderStatus current = getStatusEnum();
        return current == OrderStatus.PENDING || current == OrderStatus.CONFIRMED;
    }
    
    /**
     * Check if order is completed
     */
    public boolean isCompleted() {
        return "Completed".equalsIgnoreCase(this.status);
    }
    
    /**
     * Check if order is cancelled
     */
    public boolean isCancelled() {
        return "Cancelled".equalsIgnoreCase(this.status);
    }
    
    /**
     * Get badge CSS class for status display
     */
    public String getStatusBadgeClass() {
        return getStatusEnum().getBadgeClass();
    }
    
    /**
     * Get display name for status (Vietnamese)
     */
    public String getStatusDisplayName() {
        return getStatusEnum().getDisplayName();
    }

    // ==================== Getters and Setters ====================
    
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getTourId() {
        return tourId;
    }

    public void setTourId(int tourId) {
        this.tourId = tourId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public int getNumberOfPeople() {
        return numberOfPeople;
    }

    public void setNumberOfPeople(int numberOfPeople) {
        this.numberOfPeople = numberOfPeople;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getCancelReason() {
        return cancelReason;
    }

    public void setCancelReason(String cancelReason) {
        this.cancelReason = cancelReason;
    }
    
    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", userId=" + userId +
                ", tourId=" + tourId +
                ", totalPrice=" + totalPrice +
                ", status='" + status + '\'' +
                '}';
    }
}
