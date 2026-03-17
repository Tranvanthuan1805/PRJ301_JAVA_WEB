package com.dananghub.dto;

import com.dananghub.entity.Order;
import com.dananghub.entity.OrderStatus;
import com.dananghub.entity.Tour;
import java.util.Date;

public class OrderDetailDTO {

    private int orderId;
    private Date orderDate;
    private int numberOfPeople;
    private double totalPrice;
    private String status;
    private String paymentStatus;
    private Date updatedAt;
    private String cancelReason;

    private int userId;
    private String username;

    private int tourId;
    private String tourName;
    private String tourImage;
    private double tourPrice;
    private String tourDuration;
    private String tourLocation;

    public OrderDetailDTO() {}

    public OrderDetailDTO(Order order, Tour tour, String username) {
        this.orderId = order.getOrderId();
        this.orderDate = order.getOrderDate();
        this.totalPrice = order.getTotalAmount();
        this.status = order.getOrderStatus();
        this.paymentStatus = order.getPaymentStatus();
        this.updatedAt = order.getUpdatedAt();
        this.cancelReason = order.getCancelReason();
        this.userId = order.getCustomerId();
        this.username = username;

        if (tour != null) {
            this.tourId = tour.getTourId();
            this.tourName = tour.getTourName();
            this.tourImage = tour.getImageUrl();
            this.tourPrice = tour.getPrice();
            this.tourDuration = tour.getDuration();
            this.tourLocation = tour.getStartLocation();
        }
        
        // Calculate total people if not set
        if (order.getBookings() != null && !order.getBookings().isEmpty()) {
            this.numberOfPeople = order.getBookings().stream()
                    .mapToInt(com.dananghub.entity.Booking::getQuantity)
                    .sum();
            
            // If more than 1 tour, append "+ X more"
            if (order.getBookings().size() > 1) {
                this.tourName += " (và " + (order.getBookings().size() - 1) + " tour khác)";
            }
        }
    }

    // Helper methods
    public OrderStatus getStatusEnum() { return OrderStatus.fromCode(this.status); }
    public String getStatusDisplayName() { return getStatusEnum().getDisplayName(); }
    public String getStatusBadgeClass() { return getStatusEnum().getBadgeClass(); }
    public boolean canCancel() {
        OrderStatus current = getStatusEnum();
        return current == OrderStatus.PENDING || current == OrderStatus.CONFIRMED;
    }
    public String getFormattedTotalPrice() { return String.format("%,.0f VND", totalPrice); }
    public String getFormattedTourPrice() { return String.format("%,.0f VND", tourPrice); }

    // Aliases for JSP compatibility
    public double getTotalAmount() { return totalPrice; }
    public int getQuantity() { return numberOfPeople > 0 ? numberOfPeople : 1; }
    public String getCustomerName() { return username; }
    public String getStatusDisplay() { return getStatusDisplayName(); }

    // Getters and Setters
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }
    public int getNumberOfPeople() { return numberOfPeople; }
    public void setNumberOfPeople(int numberOfPeople) { this.numberOfPeople = numberOfPeople; }
    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
    public String getCancelReason() { return cancelReason; }
    public void setCancelReason(String cancelReason) { this.cancelReason = cancelReason; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public int getTourId() { return tourId; }
    public void setTourId(int tourId) { this.tourId = tourId; }
    public String getTourName() { return tourName; }
    public void setTourName(String tourName) { this.tourName = tourName; }
    public String getTourImage() { return tourImage; }
    public void setTourImage(String tourImage) { this.tourImage = tourImage; }
    public double getTourPrice() { return tourPrice; }
    public void setTourPrice(double tourPrice) { this.tourPrice = tourPrice; }
    public String getTourDuration() { return tourDuration; }
    public void setTourDuration(String tourDuration) { this.tourDuration = tourDuration; }
    public String getTourLocation() { return tourLocation; }
    public void setTourLocation(String tourLocation) { this.tourLocation = tourLocation; }
}
