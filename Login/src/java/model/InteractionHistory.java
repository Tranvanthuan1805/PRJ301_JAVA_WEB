package model;

import java.time.LocalDateTime;

public class InteractionHistory {
    private int id;
    private int customerId;
    private String action;
    private LocalDateTime createdAt;

    public InteractionHistory() {}

    public InteractionHistory(int id, int customerId, String action, LocalDateTime createdAt) {
        this.id = id;
        this.customerId = customerId;
        this.action = action;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
