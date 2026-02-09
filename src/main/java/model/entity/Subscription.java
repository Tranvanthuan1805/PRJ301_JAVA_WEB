package model.entity;

import java.sql.Timestamp;

public class Subscription {
    private int subId;
    private int providerId;
    private String planName; // Basic, Pro, Enterprise
    private Timestamp startDate;
    private Timestamp endDate;
    private double price;
    private boolean isActive;

    public Subscription() {}

    public Subscription(int subId, int providerId, String planName, Timestamp startDate, Timestamp endDate, double price, boolean isActive) {
        this.subId = subId;
        this.providerId = providerId;
        this.planName = planName;
        this.startDate = startDate;
        this.endDate = endDate;
        this.price = price;
        this.isActive = isActive;
    }

    // Getters and Setters
    public int getSubId() { return subId; }
    public void setSubId(int subId) { this.subId = subId; }
    public int getProviderId() { return providerId; }
    public void setProviderId(int providerId) { this.providerId = providerId; }
    public String getPlanName() { return planName; }
    public void setPlanName(String planName) { this.planName = planName; }
    public Timestamp getStartDate() { return startDate; }
    public void setStartDate(Timestamp startDate) { this.startDate = startDate; }
    public Timestamp getEndDate() { return endDate; }
    public void setEndDate(Timestamp endDate) { this.endDate = endDate; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
}
