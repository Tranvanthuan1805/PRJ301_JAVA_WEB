package model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * Model class for Customer
 */
public class Customer {
    private int id;
    private String fullName;
    private String email;
    private String phone;
    private String address;
    private Date dateOfBirth;
    private String status;  // active, inactive, banned
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Constructors
    public Customer() {}
    
    public Customer(int id, String fullName, String email, String phone, 
                   String address, Date dateOfBirth, String status) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.dateOfBirth = dateOfBirth;
        this.status = status;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public Date getDateOfBirth() {
        return dateOfBirth;
    }
    
    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    // Helper methods
    public boolean isActive() {
        return "active".equalsIgnoreCase(status);
    }
    
    public String getStatusBadgeClass() {
        if (status == null) return "badge-secondary";
        switch (status.toLowerCase()) {
            case "active": return "badge-success";
            case "inactive": return "badge-warning";
            case "banned": return "badge-danger";
            default: return "badge-secondary";
        }
    }
    
    public String getStatusText() {
        if (status == null) return "Unknown";
        switch (status.toLowerCase()) {
            case "active": return "Hoạt động";
            case "inactive": return "Tạm ngưng";
            case "banned": return "Bị khóa";
            default: return status;
        }
    }
}
