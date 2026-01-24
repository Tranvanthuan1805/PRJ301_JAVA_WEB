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
}