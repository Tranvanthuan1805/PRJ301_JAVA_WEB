package model;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "SubscriptionPlans")
public class SubscriptionPlan implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "PlanId")
    private int planId;

    @Column(name = "PlanName", nullable = false)
    private String planName;

    @Column(name = "PlanCode", nullable = false, unique = true)
    private String planCode;

    @Column(name = "Price", nullable = false)
    private double price;

    @Column(name = "DurationDays")
    private int durationDays;

    @Column(name = "Description")
    private String description;

    @Column(name = "Features")
    private String features;

    @Column(name = "IsActive")
    private boolean isActive;

    public SubscriptionPlan() {
    }

    public int getPlanId() { return planId; }
    public void setPlanId(int planId) { this.planId = planId; }

    public String getPlanName() { return planName; }
    public void setPlanName(String planName) { this.planName = planName; }

    public String getPlanCode() { return planCode; }
    public void setPlanCode(String planCode) { this.planCode = planCode; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getDurationDays() { return durationDays; }
    public void setDurationDays(int durationDays) { this.durationDays = durationDays; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getFeatures() { return features; }
    public void setFeatures(String features) { this.features = features; }

    public boolean isIsActive() { return isActive; }
    public void setIsActive(boolean isActive) { this.isActive = isActive; }
}
