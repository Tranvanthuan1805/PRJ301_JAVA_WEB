package model;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Revenue")
public class Revenue {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "RevenueId")
    private int revenueId;
    
    @Column(name = "RevenueDate")
    @Temporal(TemporalType.DATE)
    private Date revenueDate;
    
    @Column(name = "TotalAmount")
    private double totalAmount;
    
    @Column(name = "CompletedBookings")
    private int completedBookings;
    
    @Column(name = "CancelledBookings")
    private int cancelledBookings;
    
    @Column(name = "CreatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;
    
    @Column(name = "UpdatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedAt;
    
    public Revenue() {}
    
    public Revenue(Date revenueDate, double totalAmount, int completedBookings) {
        this.revenueDate = revenueDate;
        this.totalAmount = totalAmount;
        this.completedBookings = completedBookings;
        this.createdAt = new Date();
    }
    
    // Getters
    public int getRevenueId() { return revenueId; }
    public Date getRevenueDate() { return revenueDate; }
    public double getTotalAmount() { return totalAmount; }
    public int getCompletedBookings() { return completedBookings; }
    public int getCancelledBookings() { return cancelledBookings; }
    public Date getCreatedAt() { return createdAt; }
    public Date getUpdatedAt() { return updatedAt; }
    // Setters
    public void setRevenueId(int revenueId) { this.revenueId = revenueId; }
    public void setRevenueDate(Date revenueDate) { this.revenueDate = revenueDate; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public void setCompletedBookings(int completedBookings) { this.completedBookings = completedBookings; }
    public void setCancelledBookings(int cancelledBookings) { this.cancelledBookings = cancelledBookings; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
}