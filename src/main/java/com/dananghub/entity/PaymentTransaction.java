package com.dananghub.entity;

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

    @Column(name = "PlanId")
    private Integer planId;

    @Column(name = "OrderId")
    private Integer orderId;

    @Column(name = "Amount", nullable = false)
    private Double amount;

    @Column(name = "TransactionCode", unique = true, nullable = false, length = 100)
    private String transactionCode;

    @Column(name = "Status", length = 20)
    private String status = "Pending";

    @Column(name = "PaymentGateway", length = 50)
    private String paymentGateway;

    @Column(name = "SePayReference", length = 100)
    private String sePayReference;

    @Column(name = "CreatedDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;

    @Column(name = "PaidDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date paidDate;

    public PaymentTransaction() {
    }

    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Integer getPlanId() {
        return planId;
    }

    public void setPlanId(Integer planId) {
        this.planId = planId;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public String getTransactionCode() {
        return transactionCode;
    }

    public void setTransactionCode(String transactionCode) {
        this.transactionCode = transactionCode;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentGateway() {
        return paymentGateway;
    }

    public void setPaymentGateway(String paymentGateway) {
        this.paymentGateway = paymentGateway;
    }

    public String getSePayReference() {
        return sePayReference;
    }

    public void setSePayReference(String sePayReference) {
        this.sePayReference = sePayReference;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getPaidDate() {
        return paidDate;
    }

    public void setPaidDate(Date paidDate) {
        this.paidDate = paidDate;
    }
}
