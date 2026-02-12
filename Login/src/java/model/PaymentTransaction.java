package model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "PaymentTransactions")
public class PaymentTransaction implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "TransactionId")
    private int transactionId;

    @Column(name = "UserId", nullable = false)
    private int userId;

    @Column(name = "PlanId", nullable = false)
    private int planId;

    @Column(name = "Amount", nullable = false)
    private double amount;

    @Column(name = "TransactionCode", unique = true, nullable = false)
    private String transactionCode;

    @Column(name = "Status")
    private String status;

    @Column(name = "CreatedDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;

    @Column(name = "PaidDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date paidDate;

    @Column(name = "PaymentGateway")
    private String paymentGateway;

    @Column(name = "SePayReference")
    private String sePayReference;

    public PaymentTransaction() {
    }

    public int getTransactionId() { return transactionId; }
    public void setTransactionId(int transactionId) { this.transactionId = transactionId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getPlanId() { return planId; }
    public void setPlanId(int planId) { this.planId = planId; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getTransactionCode() { return transactionCode; }
    public void setTransactionCode(String transactionCode) { this.transactionCode = transactionCode; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }

    public Date getPaidDate() { return paidDate; }
    public void setPaidDate(Date paidDate) { this.paidDate = paidDate; }

    public String getPaymentGateway() { return paymentGateway; }
    public void setPaymentGateway(String paymentGateway) { this.paymentGateway = paymentGateway; }

    public String getSePayReference() { return sePayReference; }
    public void setSePayReference(String sePayReference) { this.sePayReference = sePayReference; }
}
