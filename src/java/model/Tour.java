package model;

import jakarta.persistence.*;
import java.io.Serializable;


@Entity
@Table(name = "Tours")
public class Tour implements Serializable{
    @Id 
    @GeneratedValue(strategy = GenerationType.IDENTITY) 
    @Column(name = "TourId") 
    private int tourId;
    
    @Column(name = "TourName")
    private String tourName;
    
    @Column(name = "Description")
    private String description;
    
    @Column(name = "Price")
    private double price;
    
    @Column(name = "ImageUrl") 
    private String imageUrl;    
    
    @Column(name = "Duration")
    private String duration;
    
    @Column(name = "StartLocation")
    private String startLocation;
    
    @Column(name = "Itinerary")
    private String itinerary;
    
    @Column(name = "Transport")
    private String transport;
    
    @Column(name = "ShortDesc")
    private String shortDesc;
    
    @Column(name = "MaxPeople")
    private int maxPeople;

    public Tour() {
    }

    public Tour(int tourId, String tourName, String description, double price, String imageUrl, String duration, String startLocation) {
        this.tourId = tourId;
        this.tourName = tourName;
        this.description = description;
        this.price = price;
        this.imageUrl = imageUrl;
        this.duration = duration;
        this.startLocation = startLocation;
    }

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

    public String getShortDesc() {
        return shortDesc;
    }

    public void setShortDesc(String shortDesc) {
        this.shortDesc = shortDesc;
    }

    public int getMaxPeople() {
        return maxPeople;
    }

    public void setMaxPeople(int maxPeople) {
        this.maxPeople = maxPeople;
    }
}