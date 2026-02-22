package model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Tour Entity - Maps to Tours table in database
 * Used for displaying tour information with orders
 */
@Entity
@Table(name = "Tours")
public class Tour implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "TourId")
    private int tourId;
    
    @Column(name = "TourName", nullable = false, length = 200)
    private String tourName;
    
    @Column(name = "Description", columnDefinition = "NVARCHAR(MAX)")
    private String description;
    
    @Column(name = "ShortDesc", length = 500)
    private String shortDesc;
    
    @Column(name = "Price", nullable = false)
    private double price;
    
    @Column(name = "ImageUrl", length = 500)
    private String imageUrl;
    
    @Column(name = "Duration", length = 50)
    private String duration;
    
    @Column(name = "StartLocation", length = 100)
    private String startLocation;
    
    @Column(name = "Itinerary", columnDefinition = "NVARCHAR(MAX)")
    private String itinerary;
    
    @Column(name = "Transport", length = 100)
    private String transport;
    
    @Column(name = "MaxPeople")
    private int maxPeople = 30;
    
    @Column(name = "IsActive")
    private boolean isActive = true;
    
    @Column(name = "CreatedAt")
    @Temporal(TemporalType.TIMESTAMP)
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
     * Format price for display
     */
    public String getFormattedPrice() {
        return String.format("%,.0f VND", price);
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

    public int getMaxPeople() {
        return maxPeople;
    }

    public void setMaxPeople(int maxPeople) {
        this.maxPeople = maxPeople;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    @Override
    public String toString() {
        return "Tour{" +
                "tourId=" + tourId +
                ", tourName='" + tourName + '\'' +
                ", price=" + price +
                '}';
    }
}
