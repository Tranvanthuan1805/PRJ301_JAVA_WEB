package model;

import java.sql.Timestamp;

public class Tour {
    private int tourId;
    private String tourName;
    private String description;
    private double price;
    private String imageUrl;
    private String duration;
    private String startLocation;
    private Timestamp createdAt;
    
    // New fields from SQL
    private String itinerary;
    private String transport;
    private String shortDesc;
    private int maxPeople;

    public Tour() {}

    public Tour(int tourId, String tourName, String description, double price, String imageUrl, 
                String duration, String startLocation, Timestamp createdAt, 
                String itinerary, String transport, String shortDesc, int maxPeople) {
        this.tourId = tourId;
        this.tourName = tourName;
        this.description = description;
        this.price = price;
        this.imageUrl = imageUrl;
        this.duration = duration;
        this.startLocation = startLocation;
        this.createdAt = createdAt;
        this.itinerary = itinerary;
        this.transport = transport;
        this.shortDesc = shortDesc;
        this.maxPeople = maxPeople;
    }

    // Getters and Setters
    public int getTourId() { return tourId; }
    public void setTourId(int tourId) { this.tourId = tourId; }

    public String getTourName() { return tourName; }
    public void setTourName(String tourName) { this.tourName = tourName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getDuration() { return duration; }
    public void setDuration(String duration) { this.duration = duration; }

    public String getStartLocation() { return startLocation; }
    public void setStartLocation(String startLocation) { this.startLocation = startLocation; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getItinerary() { return itinerary; }
    public void setItinerary(String itinerary) { this.itinerary = itinerary; }

    public String getTransport() { return transport; }
    public void setTransport(String transport) { this.transport = transport; }

    public String getShortDesc() { return shortDesc; }
    public void setShortDesc(String shortDesc) { this.shortDesc = shortDesc; }

    public int getMaxPeople() { return maxPeople; }
    public void setMaxPeople(int maxPeople) { this.maxPeople = maxPeople; }
}
