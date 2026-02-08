package model;
/**
 * Enum định nghĩa các trạng thái của đơn đặt tour
 * Luồng: PENDING → CONFIRMED → INPROGRESS → COMPLETED
 *        Có thể CANCELLED từ PENDING hoặc CONFIRMED
 */
public enum BookingStatus {
    PENDING("Pending", "Chờ xác nhận", "warning"),
    CONFIRMED("Confirmed", "Đã xác nhận", "info"),
    INPROGRESS("InProgress", "Đang thực hiện", "primary"),
    COMPLETED("Completed", "Hoàn thành", "success"),
    CANCELLED("Cancelled", "Đã hủy", "danger");
    private final String code;
    private final String displayName;
    private final String badgeClass;
    BookingStatus(String code, String displayName, String badgeClass) {
        this.code = code;
        this.displayName = displayName;
        this.badgeClass = badgeClass;
    }
    public String getCode() { return code; }
    public String getDisplayName() { return displayName; }
    public String getBadgeClass() { return badgeClass; }
    public static BookingStatus fromCode(String code) {
        if (code == null) return PENDING;
        for (BookingStatus status : values()) {
            if (status.code.equalsIgnoreCase(code)) {
                return status;
            }
        }
        return PENDING;
    }
    public boolean canTransitionTo(BookingStatus target) {
        return switch (this) {
            case PENDING -> target == CONFIRMED || target == CANCELLED;
            case CONFIRMED -> target == INPROGRESS || target == CANCELLED;
            case INPROGRESS -> target == COMPLETED;
            case COMPLETED, CANCELLED -> false;
        };
    }
    public BookingStatus getNextStatus() {
        return switch (this) {
            case PENDING -> CONFIRMED;
            case CONFIRMED -> INPROGRESS;
            case INPROGRESS -> COMPLETED;
            default -> this;
        };
    }
}