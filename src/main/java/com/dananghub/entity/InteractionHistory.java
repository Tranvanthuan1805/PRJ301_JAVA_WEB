package com.dananghub.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "InteractionHistory")
public class InteractionHistory implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private int id;

    @Column(name = "CustomerId", nullable = false)
    private int customerId;

    @Column(name = "Action", nullable = false, length = 100)
    private String action;

    @Column(name = "CreatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    public InteractionHistory() {}

    public InteractionHistory(int customerId, String action) {
        this.customerId = customerId;
        this.action = action;
        this.createdAt = new Date();
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
