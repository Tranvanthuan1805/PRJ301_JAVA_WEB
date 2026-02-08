package model;
import jakarta.persistence.*;
import java.util.Date; 

@Entity
@Table(name = "Bookings")
public class Booking {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "BookingId")
    private int bookingId;
    
    @Column(name = "UserId")
    private int userId;
    
    @Column(name = "TourId")
    private int tourId;
    
    @Column(name = "BookingDate")
    @Temporal(TemporalType.DATE) // Chỉ lưu ngày, không cần giờ
    private Date bookingDate;
    
    @Column(name = "NumberOfPeople")
    private int numberOfPeople;
    
    @Column(name = "TotalPrice")
    private double totalPrice;
    
    @Column(name = "Status")
    private String status;
    
    @Column(name = "UpdatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedAt;
    
    @Column(name = "CancelReason")
    private String cancelReason;
    
    @Column(name = "RefundAmount")
    private double refundAmount;
    
    @Column(name = "PaymentStatus")
    private String paymentStatus = "UNPAID"; // UNPAID, PAID, REFUNDED
    
    public Booking() {
    }

    public Booking(int bookingId, int userId, int tourId, Date bookingDate, int numberOfPeople, double totalPrice, String status) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.tourId = tourId;
        this.bookingDate = bookingDate;
        this.numberOfPeople = numberOfPeople;
        this.totalPrice = totalPrice;
        this.status = status;
    }
    
    // Helper method
    public BookingStatus getStatusEnum() {
        return BookingStatus.fromCode(this.status);
    }
    public boolean canCancel() {
        BookingStatus current = getStatusEnum();
        return current == BookingStatus.PENDING || current == BookingStatus.CONFIRMED;
    }
    public boolean isCompleted() {
        return "Completed".equalsIgnoreCase(this.status);
    }
    
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
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

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
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

    public double getRefundAmount() {
        return refundAmount;
    }

    public void setRefundAmount(double refundAmount) {
        this.refundAmount = refundAmount;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
    
    
}