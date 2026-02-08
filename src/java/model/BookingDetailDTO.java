package model;
import java.util.Date;
/**
 * DTO để hiển thị chi tiết đơn hàng với thông tin Tour và User
 */
public class BookingDetailDTO {
    // Booking info
    private int bookingId;
    private Date bookingDate;
    private int numberOfPeople;
    private double totalPrice;
    private String status;
    private String paymentStatus;
    private String cancelReason;
    private double refundAmount;
    private Date updatedAt;
    
    // Tour info
    private int tourId;
    private String tourName;
    private String duration;
    private String startLocation;
    private double tourPrice;
    private String imageUrl;
    
    // User info
    private int userId;
    private String username;
    // Constructor từ Booking + Tour + User
    public BookingDetailDTO(Booking b, Tour t, String username) {
        this.bookingId = b.getBookingId();
        this.bookingDate = b.getBookingDate();
        this.numberOfPeople = b.getNumberOfPeople();
        this.totalPrice = b.getTotalPrice();
        this.status = b.getStatus();
        this.paymentStatus = b.getPaymentStatus();
        this.cancelReason = b.getCancelReason();
        this.refundAmount = b.getRefundAmount();
        this.updatedAt = b.getUpdatedAt();
        
        this.tourId = t.getTourId();
        this.tourName = t.getTourName();
        this.duration = t.getDuration();
        this.startLocation = t.getStartLocation();
        this.tourPrice = t.getPrice();
        this.imageUrl = t.getImageUrl();
        
        this.userId = b.getUserId();
        this.username = username;
    }
    
    // Getters
    public int getBookingId() { return bookingId; }
    public Date getBookingDate() { return bookingDate; }
    public int getNumberOfPeople() { return numberOfPeople; }
    public double getTotalPrice() { return totalPrice; }
    public String getStatus() { return status; }
    public String getPaymentStatus() { return paymentStatus; }
    public String getCancelReason() { return cancelReason; }
    public double getRefundAmount() { return refundAmount; }
    public Date getUpdatedAt() { return updatedAt; }
    public int getTourId() { return tourId; }
    public String getTourName() { return tourName; }
    public String getDuration() { return duration; }
    public String getStartLocation() { return startLocation; }
    public double getTourPrice() { return tourPrice; }
    public String getImageUrl() { return imageUrl; }
    public int getUserId() { return userId; }
    public String getUsername() { return username; }
    // Setters
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
    public void setBookingDate(Date bookingDate) { this.bookingDate = bookingDate; }
    public void setNumberOfPeople(int numberOfPeople) { this.numberOfPeople = numberOfPeople; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
    public void setStatus(String status) { this.status = status; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
    public void setCancelReason(String cancelReason) { this.cancelReason = cancelReason; }
    public void setRefundAmount(double refundAmount) { this.refundAmount = refundAmount; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
    public void setTourId(int tourId) { this.tourId = tourId; }
    public void setTourName(String tourName) { this.tourName = tourName; }
    public void setDuration(String duration) { this.duration = duration; }
    public void setStartLocation(String startLocation) { this.startLocation = startLocation; }
    public void setTourPrice(double tourPrice) { this.tourPrice = tourPrice; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public void setUserId(int userId) { this.userId = userId; }
    public void setUsername(String username) { this.username = username; }
    
    // Helper
    public BookingStatus getStatusEnum() {
        return BookingStatus.fromCode(this.status);
    }
    public boolean canCancel() {
        BookingStatus current = getStatusEnum();
        return current == BookingStatus.PENDING || current == BookingStatus.CONFIRMED;
    }
}