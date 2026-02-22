package model.entity;

public class Provider {
    private int providerId;
    private String businessName;
    private String businessLicense;
    private double rating;
    private boolean isVerified;
    private int totalTours;
    private String providerType; // Hotel, Airline, Transport
    private boolean isActive;

    public Provider() {}

    public Provider(int providerId, String businessName, String providerType, boolean isActive) {
        this.providerId = providerId;
        this.businessName = businessName;
        this.providerType = providerType;
        this.isActive = isActive;
    }

    // Getters and Setters
    public int getProviderId() { return providerId; }
    public void setProviderId(int providerId) { this.providerId = providerId; }
    public String getBusinessName() { return businessName; }
    public void setBusinessName(String businessName) { this.businessName = businessName; }
    public String getBusinessLicense() { return businessLicense; }
    public void setBusinessLicense(String businessLicense) { this.businessLicense = businessLicense; }
    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }
    public boolean isVerified() { return isVerified; }
    public void setVerified(boolean verified) { isVerified = verified; }
    public int getTotalTours() { return totalTours; }
    public void setTotalTours(int totalTours) { this.totalTours = totalTours; }
    public String getProviderType() { return providerType; }
    public void setProviderType(String providerType) { this.providerType = providerType; }
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
}
