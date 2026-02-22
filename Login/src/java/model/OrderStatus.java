package model;

/**
 * OrderStatus Enum - Defines all possible order states
 * 
 * Status Flow:
 * PENDING -> CONFIRMED -> COMPLETED
 *    |          |
 *    +-> CANCELLED <-+
 */
public enum OrderStatus {
    
    PENDING("Pending", "Chờ xác nhận", "warning"),
    CONFIRMED("Confirmed", "Đã xác nhận", "info"),
    COMPLETED("Completed", "Hoàn thành", "success"),
    CANCELLED("Cancelled", "Đã hủy", "danger");
    
    private final String code;          // Database value
    private final String displayName;   // Vietnamese display
    private final String badgeClass;    // Bootstrap badge class
    
    OrderStatus(String code, String displayName, String badgeClass) {
        this.code = code;
        this.displayName = displayName;
        this.badgeClass = badgeClass;
    }
    
    // ==================== Getters ====================
    
    public String getCode() {
        return code;
    }
    
    public String getDisplayName() {
        return displayName;
    }
    
    public String getBadgeClass() {
        return badgeClass;
    }
    
    // ==================== Static Methods ====================
    
    /**
     * Convert database string to enum
     */
    public static OrderStatus fromCode(String code) {
        if (code == null) return PENDING;
        
        for (OrderStatus status : values()) {
            if (status.code.equalsIgnoreCase(code)) {
                return status;
            }
        }
        return PENDING;  // Default
    }
    
    /**
     * Check if transition from current status to target is allowed
     */
    public boolean canTransitionTo(OrderStatus target) {
        return switch (this) {
            case PENDING -> target == CONFIRMED || target == CANCELLED;
            case CONFIRMED -> target == COMPLETED || target == CANCELLED;
            case COMPLETED, CANCELLED -> false;  // Final states
        };
    }
    
    /**
     * Get the next logical status in the workflow
     */
    public OrderStatus getNextStatus() {
        return switch (this) {
            case PENDING -> CONFIRMED;
            case CONFIRMED -> COMPLETED;
            default -> this;  // No next status for COMPLETED/CANCELLED
        };
    }
    
    /**
     * Check if this is a final state (no more transitions)
     */
    public boolean isFinalState() {
        return this == COMPLETED || this == CANCELLED;
    }
}
