package com.dananghub.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "Customers")
public class Customer implements Serializable {

    @Id
    @Column(name = "CustomerId")
    private int customerId;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "CustomerId", referencedColumnName = "UserId", insertable = false, updatable = false)
    private User user;

    @Column(name = "Address", length = 255)
    private String address;

    @Column(name = "DateOfBirth")
    @Temporal(TemporalType.DATE)
    private Date dateOfBirth;

    @Column(name = "Status", length = 20)
    private String status = "active";

    public Customer() {}

    // Helper methods
    public boolean isActive() {
        return "active".equalsIgnoreCase(status);
    }

    public String getStatusBadgeClass() {
        if (status == null) return "badge-secondary";
        return switch (status.toLowerCase()) {
            case "active" -> "badge-success";
            case "inactive" -> "badge-warning";
            case "banned" -> "badge-danger";
            default -> "badge-secondary";
        };
    }

    public String getStatusText() {
        if (status == null) return "Unknown";
        return switch (status.toLowerCase()) {
            case "active" -> "Hoạt động";
            case "inactive" -> "Tạm ngưng";
            case "banned" -> "Bị khóa";
            default -> status;
        };
    }

    // Getters and Setters
    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public Date getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(Date dateOfBirth) { this.dateOfBirth = dateOfBirth; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    // Convenience getters from User
    public String getFullName() { return user != null ? user.getFullName() : null; }
    public String getEmail() { return user != null ? user.getEmail() : null; }
    public String getPhone() { return user != null ? user.getPhoneNumber() : null; }
}
