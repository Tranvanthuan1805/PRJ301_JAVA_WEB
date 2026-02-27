package com.dananghub.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "Tours")
public class Tour implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "TourId")
    private int tourId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "ProviderId", nullable = false)
    private Provider provider;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "CategoryId", nullable = false)
    private Category category;

    @Column(name = "TourName", nullable = false, length = 255)
    private String tourName;

    @Column(name = "ShortDesc", length = 500)
    private String shortDesc;

    @Column(name = "Description", columnDefinition = "NVARCHAR(MAX)")
    private String description;

    @Column(name = "Price", nullable = false)
    private double price;

    @Column(name = "MaxPeople")
    private int maxPeople = 20;

    @Column(name = "Duration", length = 50)
    private String duration;

    @Column(name = "Transport", length = 100)
    private String transport;

    @Column(name = "StartLocation", length = 200)
    private String startLocation;

    @Column(name = "Destination", length = 200)
    private String destination;

    @Column(name = "ImageUrl", length = 500)
    private String imageUrl;

    @Column(name = "Itinerary", columnDefinition = "NVARCHAR(MAX)")
    private String itinerary;

    @Column(name = "IsActive")
    private boolean isActive = true;

    @Column(name = "CreatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "UpdatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedAt;

    @OneToMany(mappedBy = "tour", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<TourImage> images;

    public Tour() {}

    public Tour(int tourId, String tourName, double price) {
        this.tourId = tourId;
        this.tourName = tourName;
        this.price = price;
    }

    // Helper
    public String getFormattedPrice() {
        return String.format("%,.0f VND", price);
    }

    public int getProviderId() {
        return provider != null ? provider.getProviderId() : 0;
    }

    public int getCategoryId() {
        return category != null ? category.getCategoryId() : 0;
    }

    // Getters and Setters
    public int getTourId() { return tourId; }
    public void setTourId(int tourId) { this.tourId = tourId; }

    public Provider getProvider() { return provider; }
    public void setProvider(Provider provider) { this.provider = provider; }

    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }

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

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getItinerary() { return itinerary; }
    public void setItinerary(String itinerary) { this.itinerary = itinerary; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }

    public List<TourImage> getImages() { return images; }
    public void setImages(List<TourImage> images) { this.images = images; }

    @Override
    public String toString() {
        return "Tour{tourId=" + tourId + ", tourName='" + tourName + "', price=" + price + "}";
    }
}
