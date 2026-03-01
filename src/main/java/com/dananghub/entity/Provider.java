package com.dananghub.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "Providers")
public class Provider implements Serializable {

    @Id
    @Column(name = "ProviderId")
    private int providerId;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "ProviderId", referencedColumnName = "UserId", insertable = false, updatable = false)
    private User user;

    @Column(name = "BusinessName", nullable = false, length = 200)
    private String businessName;

    @Column(name = "BusinessLicense", length = 100)
    private String businessLicense;

    @Column(name = "ProviderType", length = 50)
    private String providerType;

    @Column(name = "Rating")
    private Double rating;

    @Column(name = "IsVerified")
    private boolean isVerified;

    @Column(name = "TotalTours")
    private int totalTours;

    @Column(name = "IsActive")
    private boolean isActive = true;

    @Column(name = "JoinDate", nullable = false)
    private LocalDate joinDate;

    @Column(name = "Status", nullable = false, length = 20)
    private String status = "Pending";

    @Column(name = "Description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "CreatedAt")
    private LocalDateTime createdAt;

    @Column(name = "UpdatedAt")
    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "provider", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<ProviderPriceHistory> priceHistory;

    // Transient fields for display purposes
    @Transient
    private String email;

    @Transient
    private String phone;

    @Transient
    private Double averagePrice;

    public Provider() {
    }

    public Provider(int providerId, String businessName, String providerType) {
        this.providerId = providerId;
        this.businessName = businessName;
        this.providerType = providerType;
    }

    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
        if (updatedAt == null) {
            updatedAt = LocalDateTime.now();
        }
        if (joinDate == null) {
            joinDate = LocalDate.now();
        }
        if (status == null) {
            status = "Pending";
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    public int getProviderId() {
        return providerId;
    }

    public void setProviderId(int providerId) {
        this.providerId = providerId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getBusinessName() {
        return businessName;
    }

    public void setBusinessName(String businessName) {
        this.businessName = businessName;
    }

    public String getBusinessLicense() {
        return businessLicense;
    }

    public void setBusinessLicense(String businessLicense) {
        this.businessLicense = businessLicense;
    }

    public String getProviderType() {
        return providerType;
    }

    public void setProviderType(String providerType) {
        this.providerType = providerType;
    }

    public Double getRating() {
        return rating;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    public boolean isVerified() {
        return isVerified;
    }

    public void setVerified(boolean verified) {
        isVerified = verified;
    }

    public int getTotalTours() {
        return totalTours;
    }

    public void setTotalTours(int totalTours) {
        this.totalTours = totalTours;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public LocalDate getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(LocalDate joinDate) {
        this.joinDate = joinDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public List<ProviderPriceHistory> getPriceHistory() {
        return priceHistory;
    }

    public void setPriceHistory(List<ProviderPriceHistory> priceHistory) {
        this.priceHistory = priceHistory;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Double getAveragePrice() {
        return averagePrice;
    }

    public void setAveragePrice(Double averagePrice) {
        this.averagePrice = averagePrice;
    }
}
