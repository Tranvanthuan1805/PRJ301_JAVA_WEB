package model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "ProviderSubscriptions")
public class ProviderSubscription implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "SubscriptionId")
    private int subscriptionId;

    @Column(name = "UserId", nullable = false)
    private int userId;

    @ManyToOne
    @JoinColumn(name = "PlanId", nullable = false)
    private SubscriptionPlan plan;

    @Column(name = "StartDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date startDate;

    @Column(name = "EndDate", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date endDate;

    @Column(name = "Status")
    private String status;

    @Column(name = "PaymentStatus")
    private String paymentStatus;

    @Column(name = "Amount")
    private double amount;

    public ProviderSubscription() {
    }

    public int getSubscriptionId() { return subscriptionId; }
    public void setSubscriptionId(int subscriptionId) { this.subscriptionId = subscriptionId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public SubscriptionPlan getPlan() { return plan; }
    public void setPlan(SubscriptionPlan plan) { this.plan = plan; }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }

    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
}
