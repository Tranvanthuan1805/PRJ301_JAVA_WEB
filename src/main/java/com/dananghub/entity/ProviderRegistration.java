package com.dananghub.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * Entity cho đơn đăng ký làm Nhà cung cấp
 * Lưu trữ thông tin đăng ký chờ admin duyệt
 */
@Entity
@Table(name = "ProviderRegistrations")
public class ProviderRegistration implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "RegistrationId")
    private Integer registrationId;

    @Column(name = "BusinessName", nullable = false, length = 200)
    private String businessName;

    @Column(name = "BusinessLicense", nullable = false, length = 100)
    private String businessLicense;

    @Column(name = "Email", nullable = false, length = 100)
    private String email;

    @Column(name = "PhoneNumber", nullable = false, length = 20)
    private String phoneNumber;

    @Column(name = "Address", length = 255)
    private String address;

    @Column(name = "ProviderType", nullable = false, length = 50)
    private String providerType; // Hotel, Tour, Transport, Flight

    @Column(name = "Description", columnDefinition = "NVARCHAR(MAX)")
    private String description;

    @Column(name = "Status", length = 20)
    private String status = "Pending"; // Pending, Approved, Rejected

    @Column(name = "SubmittedDate")
    private LocalDateTime submittedDate;

    @Column(name = "ReviewedDate")
    private LocalDateTime reviewedDate;

    @Column(name = "ReviewedBy")
    private Integer reviewedBy; // Admin UserId

    @Column(name = "RejectionReason", length = 500)
    private String rejectionReason;

    @PrePersist
    protected void onCreate() {
        if (submittedDate == null) {
            submittedDate = LocalDateTime.now();
        }
        if (status == null) {
            status = "Pending";
        }
    }

    // Constructors
    public ProviderRegistration() {
    }

    public ProviderRegistration(String businessName, String businessLicense, String email,
            String phoneNumber, String providerType) {
        this.businessName = businessName;
        this.businessLicense = businessLicense;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.providerType = providerType;
    }

    // Getters and Setters
    public Integer getRegistrationId() {
        return registrationId;
    }

    public void setRegistrationId(Integer registrationId) {
        this.registrationId = registrationId;
    }

    public String getBusinessName() {
        return businessName;
    }

    public void setBusinessName(String businessName) {
        this.businessName = businessName;
    }

    public String getBusinessLicense() {
        return businessLicense;
    }

    public void setBusinessLicense(String businessLicense) {
        this.businessLicense = businessLicense;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getProviderType() {
        return providerType;
    }

    public void setProviderType(String providerType) {
        this.providerType = providerType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getSubmittedDate() {
        return submittedDate;
    }

    public void setSubmittedDate(LocalDateTime submittedDate) {
        this.submittedDate = submittedDate;
    }

    public LocalDateTime getReviewedDate() {
        return reviewedDate;
    }

    public void setReviewedDate(LocalDateTime reviewedDate) {
        this.reviewedDate = reviewedDate;
    }

    public Integer getReviewedBy() {
        return reviewedBy;
    }

    public void setReviewedBy(Integer reviewedBy) {
        this.reviewedBy = reviewedBy;
    }

    public String getRejectionReason() {
        return rejectionReason;
    }

    public void setRejectionReason(String rejectionReason) {
        this.rejectionReason = rejectionReason;
    }
}
