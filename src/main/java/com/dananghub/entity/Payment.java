package com.dananghub.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "Payments")
public class Payment implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "PaymentId")
    private int paymentId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "OrderId", nullable = false)
    private Order order;

    @Column(name = "PaymentMethod", length = 50)
    private String paymentMethod;

    @Column(name = "TransactionId", length = 100)
    private String transactionId;

    @Column(name = "Amount")
    private double amount;

    @Column(name = "PaymentStatus", length = 50)
    private String paymentStatus;

    @Column(name = "PaidAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date paidAt;

    public Payment() {}

    public int getPaymentId() { return paymentId; }
    public void setPaymentId(int paymentId) { this.paymentId = paymentId; }

    public Order getOrder() { return order; }
    public void setOrder(Order order) { this.order = order; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getTransactionId() { return transactionId; }
    public void setTransactionId(String transactionId) { this.transactionId = transactionId; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public Date getPaidAt() { return paidAt; }
    public void setPaidAt(Date paidAt) { this.paidAt = paidAt; }
}
