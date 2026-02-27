package com.dananghub.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "CustomerActivities")
public class CustomerActivity implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private int id;

    @Column(name = "CustomerId", nullable = false)
    private int customerId;

    @Column(name = "ActionType", nullable = false, length = 50)
    private String actionType;

    @Column(name = "Description", length = 500)
    private String description;

    @Column(name = "Metadata", columnDefinition = "NVARCHAR(MAX)")
    private String metadata;

    @Column(name = "CreatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    public CustomerActivity() {}

    public CustomerActivity(int customerId, String actionType, String description) {
        this.customerId = customerId;
        this.actionType = actionType;
        this.description = description;
        this.createdAt = new Date();
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public String getActionType() { return actionType; }
    public void setActionType(String actionType) { this.actionType = actionType; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getMetadata() { return metadata; }
    public void setMetadata(String metadata) { this.metadata = metadata; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
