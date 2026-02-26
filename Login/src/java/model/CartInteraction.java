package model;

import java.time.LocalDateTime;

/**
 * Model đại diện cho tương tác với giỏ hàng
 * Dùng để phân tích hành vi khách hàng
 */
public class CartInteraction {
    private int id;
    private Integer userId;
    private String sessionId;
    private int tourId;
    private String action; // ADD, UPDATE, REMOVE, VIEW, CHECKOUT_START, CHECKOUT_COMPLETE
    private Integer quantity;
    private LocalDateTime createdAt;
    
    public CartInteraction() {}
    
    public CartInteraction(Integer userId, String sessionId, int tourId, String action, Integer quantity) {
        this.userId = userId;
        this.sessionId = sessionId;
        this.tourId = tourId;
        this.action = action;
        this.quantity = quantity;
        this.createdAt = LocalDateTime.now();
    }
    
    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    
    public String getSessionId() { return sessionId; }
    public void setSessionId(String sessionId) { this.sessionId = sessionId; }
    
    public int getTourId() { return tourId; }
    public void setTourId(int tourId) { this.tourId = tourId; }
    
    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }
    
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
