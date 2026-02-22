package model.entity;

import java.sql.Timestamp;

public class Customer extends User {
    private int totalOrders;
    private double totalSpent;
    private Timestamp lastBookingDate;
    private String preferredCategory; // Derived from behavior

    public Customer() {
        super();
    }

    public Customer(User user) {
        setUserId(user.getUserId());
        setEmail(user.getEmail());
        setUsername(user.getUsername());
        setRoleId(user.getRoleId());
        setRoleName(user.getRoleName());
        setFullName(user.getFullName());
        setPhoneNumber(user.getPhoneNumber());
        setAvatarUrl(user.getAvatarUrl());
        setActive(user.isActive());
        setCreatedAt(user.getCreatedAt());
    }

    // Getters and Setters
    public int getTotalOrders() { return totalOrders; }
    public void setTotalOrders(int totalOrders) { this.totalOrders = totalOrders; }
    public double getTotalSpent() { return totalSpent; }
    public void setTotalSpent(double totalSpent) { this.totalSpent = totalSpent; }
    public Timestamp getLastBookingDate() { return lastBookingDate; }
    public void setLastBookingDate(Timestamp lastBookingDate) { this.lastBookingDate = lastBookingDate; }
    public String getPreferredCategory() { return preferredCategory; }
    public void setPreferredCategory(String preferredCategory) { this.preferredCategory = preferredCategory; }
}
