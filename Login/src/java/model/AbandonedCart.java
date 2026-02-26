package model;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

/**
 * Model đại diện cho giỏ hàng bị bỏ quên
 */
public class AbandonedCart {
    private int id;
    private Integer userId;
    private String sessionId;
    private int tourId;
    private int quantity;
    private LocalDateTime addedAt;
    private LocalDateTime lastViewedAt;
    private LocalDateTime abandonedAt;
    private boolean reminderSent;
    private LocalDateTime reminderSentAt;
    private boolean converted;
    private LocalDateTime convertedAt;
    private Integer orderId;
    
    // Tour information (joined)
    private Tour tour;
    
    public AbandonedCart() {}
    
    /**
     * Tính số giờ từ khi bỏ quên
     */
    public long getHoursSinceAbandoned() {
        if (abandonedAt == null) {
            return 0;
        }
        return ChronoUnit.HOURS.between(abandonedAt, LocalDateTime.now());
    }
    
    /**
     * Tính số ngày từ khi bỏ quên
     */
    public long getDaysSinceAbandoned() {
        if (abandonedAt == null) {
            return 0;
        }
        return ChronoUnit.DAYS.between(abandonedAt, LocalDateTime.now());
    }
    
    /**
     * Kiểm tra có nên gửi reminder không
     * Logic: Sau 24h, chưa gửi reminder, chưa convert
     */
    public boolean shouldSendReminder() {
        return !reminderSent && !converted && getHoursSinceAbandoned() >= 24;
    }
    
    /**
     * Tính giá trị tiềm năng (potential value)
     */
    public double getPotentialValue() {
        if (tour != null) {
            return tour.getPrice() * quantity;
        }
        return 0;
    }
    
    /**
     * Lấy priority level cho AI
     * HIGH: Giá trị cao, mới bỏ quên
     * MEDIUM: Giá trị trung bình hoặc đã lâu
     * LOW: Giá trị thấp hoặc quá lâu
     */
    public String getPriorityLevel() {
        double value = getPotentialValue();
        long hours = getHoursSinceAbandoned();
        
        if (value >= 5000000 && hours <= 48) {
            return "HIGH";
        } else if (value >= 2000000 && hours <= 72) {
            return "MEDIUM";
        } else {
            return "LOW";
        }
    }
    
    /**
     * Lấy recommended action cho AI
     */
    public String getRecommendedAction() {
        long hours = getHoursSinceAbandoned();
        
        if (hours <= 24) {
            return "WAIT"; // Chờ thêm
        } else if (hours <= 48) {
            return "SEND_REMINDER"; // Gửi nhắc nhở
        } else if (hours <= 72) {
            return "SEND_DISCOUNT"; // Gửi ưu đãi
        } else {
            return "SEND_SPECIAL_OFFER"; // Gửi ưu đãi đặc biệt
        }
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
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    public LocalDateTime getAddedAt() { return addedAt; }
    public void setAddedAt(LocalDateTime addedAt) { this.addedAt = addedAt; }
    
    public LocalDateTime getLastViewedAt() { return lastViewedAt; }
    public void setLastViewedAt(LocalDateTime lastViewedAt) { this.lastViewedAt = lastViewedAt; }
    
    public LocalDateTime getAbandonedAt() { return abandonedAt; }
    public void setAbandonedAt(LocalDateTime abandonedAt) { this.abandonedAt = abandonedAt; }
    
    public boolean isReminderSent() { return reminderSent; }
    public void setReminderSent(boolean reminderSent) { this.reminderSent = reminderSent; }
    
    public LocalDateTime getReminderSentAt() { return reminderSentAt; }
    public void setReminderSentAt(LocalDateTime reminderSentAt) { this.reminderSentAt = reminderSentAt; }
    
    public boolean isConverted() { return converted; }
    public void setConverted(boolean converted) { this.converted = converted; }
    
    public LocalDateTime getConvertedAt() { return convertedAt; }
    public void setConvertedAt(LocalDateTime convertedAt) { this.convertedAt = convertedAt; }
    
    public Integer getOrderId() { return orderId; }
    public void setOrderId(Integer orderId) { this.orderId = orderId; }
    
    public Tour getTour() { return tour; }
    public void setTour(Tour tour) { this.tour = tour; }
}
