package com.dananghub.entity;

import jakarta.persistence.*;
import java.io.Serializable;

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

    @Column(name = "Rating", precision = 3, scale = 2)
    private double rating;

    @Column(name = "IsVerified")
    private boolean isVerified;

    @Column(name = "TotalTours")
    private int totalTours;

    @Column(name = "IsActive")
    private boolean isActive = true;

    public Provider() {}

    public Provider(int providerId, String businessName, String providerType) {
        this.providerId = providerId;
        this.businessName = businessName;
        this.providerType = providerType;
    }

    public int getProviderId() { return providerId; }
    public void setProviderId(int providerId) { this.providerId = providerId; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public String getBusinessName() { return businessName; }
    public void setBusinessName(String businessName) { this.businessName = businessName; }

    public String getBusinessLicense() { return businessLicense; }
    public void setBusinessLicense(String businessLicense) { this.businessLicense = businessLicense; }

    public String getProviderType() { return providerType; }
    public void setProviderType(String providerType) { this.providerType = providerType; }

    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }

    public boolean isVerified() { return isVerified; }
    public void setVerified(boolean verified) { isVerified = verified; }

    public int getTotalTours() { return totalTours; }
    public void setTotalTours(int totalTours) { this.totalTours = totalTours; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
}
