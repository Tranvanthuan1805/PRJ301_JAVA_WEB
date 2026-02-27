package com.dananghub.entity;

public enum OrderStatus {

    PENDING("Pending", "Chờ xác nhận", "warning"),
    CONFIRMED("Confirmed", "Đã xác nhận", "info"),
    COMPLETED("Completed", "Hoàn thành", "success"),
    CANCELLED("Cancelled", "Đã hủy", "danger");

    private final String code;
    private final String displayName;
    private final String badgeClass;

    OrderStatus(String code, String displayName, String badgeClass) {
        this.code = code;
        this.displayName = displayName;
        this.badgeClass = badgeClass;
    }

    public String getCode() { return code; }
    public String getDisplayName() { return displayName; }
    public String getBadgeClass() { return badgeClass; }

    public static OrderStatus fromCode(String code) {
        if (code == null) return PENDING;
        for (OrderStatus s : values()) {
            if (s.code.equalsIgnoreCase(code)) return s;
        }
        return PENDING;
    }

    public boolean canTransitionTo(OrderStatus target) {
        return switch (this) {
            case PENDING -> target == CONFIRMED || target == CANCELLED;
            case CONFIRMED -> target == COMPLETED || target == CANCELLED;
            case COMPLETED, CANCELLED -> false;
        };
    }

    public OrderStatus getNextStatus() {
        return switch (this) {
            case PENDING -> CONFIRMED;
            case CONFIRMED -> COMPLETED;
            default -> this;
        };
    }

    public boolean isFinalState() {
        return this == COMPLETED || this == CANCELLED;
    }
}
