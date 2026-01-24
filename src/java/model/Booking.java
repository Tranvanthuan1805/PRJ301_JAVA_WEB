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
}