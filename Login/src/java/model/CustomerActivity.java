package model;

import java.sql.Timestamp;

/**
 * Model class for customer activity tracking
 */
public class CustomerActivity {
    private int id;
    private int customerId;
    private String actionType;  // SEARCH, BOOKING, CANCEL, LOGIN, etc.
    private String description;
    private String metadata;    // JSON string for additional data
    private Timestamp createdAt;
    
    // Constructors
    public CustomerActivity() {}
    
    public CustomerActivity(int customerId, String actionType, String description) {
        this.customerId = customerId;
        this.actionType = actionType;
        this.description = description;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getCustomerId() {
        return customerId;
    }
    
    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }
    
    public String getActionType() {
        return actionType;
    }
    
    public void setActionType(String actionType) {
        this.actionType = actionType;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getMetadata() {
        return metadata;
    }
    
    public void setMetadata(String metadata) {
        this.metadata = metadata;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
