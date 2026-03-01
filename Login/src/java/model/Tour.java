package model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Tour Entity - Maps to Tours table in TourManagement database
 */
@Entity
@Table(name = "Tours")
public class Tour implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int tourId;
    
    @Column(name = "name", nullable = false, length = 255)
    private String tourName;
    
    @Column(name = "destination", length = 255)
    private String startLocation;
    
    @Column(name = "startDate")
    @Temporal(TemporalType.DATE)
    private Date startDate;
    
    @Column(name = "endDate")
    @Temporal(TemporalType.DATE)
    private Date endDate;
    
    @Column(name = "price", nullable = false)
    private double price;
    
    @Column(name = "maxCapacity")
    private int maxCapacity = 30;
    
    @Column(name = "currentCapacity")
    private int currentCapacity = 0;
    
    @Column(name = "description", columnDefinition = "NVARCHAR(MAX)")
    private String description;
    
    @Transient
    private String shortDesc;
    
    @Transient
    private String imageUrl;
    
    @Transient
    private String duration;
    
    @Transient
    private String itinerary;
    
    @Transient
    private String transport;
    
    @Transient
    private boolean isActive = true;
    
    @Transient
    private Date createdAt;

    // ==================== Constructors ====================
    
    public Tour() {
    }

    public Tour(int tourId, String tourName, double price) {
        this.tourId = tourId;
        this.tourName = tourName;
        this.price = price;
    }

    // ==================== Helper Methods ====================
    
    /**
     * Get available slots
     */
    public int getMaxPeople() {
        return maxCapacity - currentCapacity;
    }
    
    public void setMaxPeople(int maxPeople) {
        this.maxCapacity = maxPeople;
    }
    
    /**
     * Format price for display
     */
    public String getFormattedPrice() {
        return String.format("%,.0f VND", price);
    }
    
    /**
     * Check if tour has available slots
     */
    public boolean hasAvailableSlots() {
        return (maxCapacity - currentCapacity) > 0;
    }
    
    /**
     * Get year of tour
     */
    public int getYear() {
        if (startDate == null) return 0;
        return startDate.toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDate().getYear();
    }

    // ==================== Getters and Setters ====================
    
    public int getTourId() {
        return tourId;
    }

    public void setTourId(int tourId) {
        this.tourId = tourId;
    }

    public String getTourName() {
        return tourName;
    }

    public void setTourName(String tourName) {
        this.tourName = tourName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getShortDesc() {
        return shortDesc;
    }

    public void setShortDesc(String shortDesc) {
        this.shortDesc = shortDesc;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getStartLocation() {
        return startLocation;
    }

    public void setStartLocation(String startLocation) {
        this.startLocation = startLocation;
    }

    public String getItinerary() {
        return itinerary;
    }

    public void setItinerary(String itinerary) {
        this.itinerary = itinerary;
    }

    public String getTransport() {
        return transport;
    }

    public void setTransport(String transport) {
        this.transport = transport;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public Date getCreatedAt() {
        return createdAt != null ? createdAt : startDate;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public int getMaxCapacity() {
        return maxCapacity;
    }

    public void setMaxCapacity(int maxCapacity) {
        this.maxCapacity = maxCapacity;
    }

    public int getCurrentCapacity() {
        return currentCapacity;
    }

    public void setCurrentCapacity(int currentCapacity) {
        this.currentCapacity = currentCapacity;
    }
    
    @Override
    public String toString() {
        return "Tour{" +
                "tourId=" + tourId +
                ", tourName='" + tourName + '\'' +
                ", price=" + price +
                ", available=" + (maxCapacity - currentCapacity) +
                '}';
    }
}
