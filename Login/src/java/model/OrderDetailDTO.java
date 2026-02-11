package model;

import java.util.Date;

/**
 * OrderDetailDTO - Data Transfer Object for displaying order with related info
 * Combines Order + Tour + Username for view layer
 */
public class OrderDetailDTO {
    
    // Order info
    private int orderId;
    private Date orderDate;
    private int numberOfPeople;
    private double totalPrice;
    private String status;
    private String paymentStatus;
    private Date updatedAt;
    private String cancelReason;
    
    // User info
    private int userId;
    private String username;
    
    // Tour info
    private int tourId;
    private String tourName;
    private String tourImage;
    private double tourPrice;
    private String tourDuration;
    private String tourLocation;
    
    // ==================== Constructors ====================
    
    public OrderDetailDTO() {
    }
    
    /**
     * Create DTO from Order, Tour, and username
     */
    public OrderDetailDTO(Order order, Tour tour, String username) {
        // Order fields
        this.orderId = order.getOrderId();
        this.orderDate = order.getOrderDate();
        this.numberOfPeople = order.getNumberOfPeople();
        this.totalPrice = order.getTotalPrice();
        this.status = order.getStatus();
        this.paymentStatus = order.getPaymentStatus();
        this.updatedAt = order.getUpdatedAt();
        this.cancelReason = order.getCancelReason();
        this.userId = order.getUserId();
        
        // User fields
        this.username = username;
        
        // Tour fields
        if (tour != null) {
            this.tourId = tour.getTourId();
            this.tourName = tour.getTourName();
            this.tourImage = tour.getImageUrl();
            this.tourPrice = tour.getPrice();
            this.tourDuration = tour.getDuration();
            this.tourLocation = tour.getStartLocation();
        }
    }
    
    // ==================== Helper Methods ====================
    
    /**
     * Get status as enum
     */
    public OrderStatus getStatusEnum() {
        return OrderStatus.fromCode(this.status);
    }
    
    /**
     * Get status display name (Vietnamese)
     */
    public String getStatusDisplayName() {
        return getStatusEnum().getDisplayName();
    }
    
    /**
     * Get Bootstrap badge class for status
     */
    public String getStatusBadgeClass() {
        return getStatusEnum().getBadgeClass();
    }
    
    /**
     * Check if order can be cancelled
     */
    public boolean canCancel() {
        OrderStatus current = getStatusEnum();
        return current == OrderStatus.PENDING || current == OrderStatus.CONFIRMED;
    }
    
    /**
     * Format total price for display
     */
    public String getFormattedTotalPrice() {
        return String.format("%,.0f VND", totalPrice);
    }
    
    /**
     * Format tour price for display
     */
    public String getFormattedTourPrice() {
        return String.format("%,.0f VND", tourPrice);
    }

    // ==================== Getters and Setters ====================
    
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
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

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getTourId() {
        return tourId;
    }

    public void setTourId(int tourId) {
        this.tourId = tourId;
    }

    public String getTourName() {
        return tourName;
    }

    public void setTourName(String tourName) {
        this.tourName = tourName;
    }

    public String getTourImage() {
        return tourImage;
    }

    public void setTourImage(String tourImage) {
        this.tourImage = tourImage;
    }

    public double getTourPrice() {
        return tourPrice;
    }

    public void setTourPrice(double tourPrice) {
        this.tourPrice = tourPrice;
    }

    public String getTourDuration() {
        return tourDuration;
    }

    public void setTourDuration(String tourDuration) {
        this.tourDuration = tourDuration;
    }

    public String getTourLocation() {
        return tourLocation;
    }

    public void setTourLocation(String tourLocation) {
        this.tourLocation = tourLocation;
    }
}
