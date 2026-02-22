package model.entity;

import java.sql.Timestamp;

public class Tour {
    private int tourId;
    private int providerId;
    private int categoryId;
    private String tourName;
    private String shortDesc;
    private String description;
    private double price;
    private int maxPeople;
    private String duration;
    private String transport;
    private String startLocation;
    private String imageUrl;
    private String itinerary;
    private boolean isActive;
    private Timestamp createdAt;

    public Tour() {}

    public Tour(int tourId, int providerId, int categoryId, String tourName, double price, String imageUrl) {
        this.tourId = tourId;
        this.providerId = providerId;
        this.categoryId = categoryId;
        this.tourName = tourName;
        this.price = price;
        this.imageUrl = imageUrl;
    }

    // Getters and Setters
    public int getTourId() { return tourId; }
    public void setTourId(int tourId) { this.tourId = tourId; }
    public int getProviderId() { return providerId; }
    public void setProviderId(int providerId) { this.providerId = providerId; }
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    public String getTourName() { return tourName; }
    public void setTourName(String tourName) { this.tourName = tourName; }
    public String getShortDesc() { return shortDesc; }
    public void setShortDesc(String shortDesc) { this.shortDesc = shortDesc; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public int getMaxPeople() { return maxPeople; }
    public void setMaxPeople(int maxPeople) { this.maxPeople = maxPeople; }
    public String getDuration() { return duration; }
    public void setDuration(String duration) { this.duration = duration; }
    public String getTransport() { return transport; }
    public void setTransport(String transport) { this.transport = transport; }
    public String getStartLocation() { return startLocation; }
    public void setStartLocation(String startLocation) { this.startLocation = startLocation; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public String getItinerary() { return itinerary; }
    public void setItinerary(String itinerary) { this.itinerary = itinerary; }
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
