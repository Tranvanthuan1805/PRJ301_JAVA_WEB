package model;

import java.time.LocalDateTime;

/**
 * Model đại diện cho một item trong giỏ hàng
 * Kết hợp thông tin từ Cart và Tour
 */
public class CartItem {
    private int id;
    private int userId;
    private int tourId;
    private int quantity;
    private LocalDateTime addedAt;
    
    // Thông tin tour (join từ Tours table)
    private Tour tour;
    
    public CartItem() {}
    
    public CartItem(int id, int userId, int tourId, int quantity, LocalDateTime addedAt) {
        this.id = id;
        this.userId = userId;
        this.tourId = tourId;
        this.quantity = quantity;
        this.addedAt = addedAt;
    }
    
    /**
     * Tính tổng giá cho item này
     * @return Tổng giá = giá tour * số lượng
     */
    public double getSubtotal() {
        if (tour != null) {
            return tour.getPrice() * quantity;
        }
        return 0;
    }
    
    /**
     * Kiểm tra xem số lượng có hợp lệ không
     * @return true nếu tour còn đủ chỗ cho số lượng này
     */
    public boolean isValidQuantity() {
        if (tour != null) {
            return tour.checkAvailability(quantity);
        }
        return false;
    }
    
    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getTourId() { return tourId; }
    public void setTourId(int tourId) { this.tourId = tourId; }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    public LocalDateTime getAddedAt() { return addedAt; }
    public void setAddedAt(LocalDateTime addedAt) { this.addedAt = addedAt; }
    
    public Tour getTour() { return tour; }
    public void setTour(Tour tour) { this.tour = tour; }
}
