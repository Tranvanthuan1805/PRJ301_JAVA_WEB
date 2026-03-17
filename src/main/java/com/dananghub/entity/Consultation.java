package com.dananghub.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "Consultations")
public class Consultation implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ConsultationId")
    private int consultationId;

    @Column(name = "FullName", nullable = false, length = 100)
    private String fullName;

    @Column(name = "Email", nullable = false, length = 150)
    private String email;

    @Column(name = "Phone", length = 20)
    private String phone;

    @Column(name = "TourType", length = 50)
    private String tourType;

    @Column(name = "Message", columnDefinition = "TEXT")
    private String message;

    @Column(name = "Status", length = 20)
    private String status = "new";

    @Column(name = "CreatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "AdminNote", columnDefinition = "TEXT")
    private String adminNote;

    @PrePersist
    protected void onCreate() {
        createdAt = new Date();
    }

    public Consultation() {}

    // Getters and Setters
    public int getConsultationId() { return consultationId; }
    public void setConsultationId(int consultationId) { this.consultationId = consultationId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getTourType() { return tourType; }
    public void setTourType(String tourType) { this.tourType = tourType; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public String getAdminNote() { return adminNote; }
    public void setAdminNote(String adminNote) { this.adminNote = adminNote; }

    public String getStatusBadge() {
        if (status == null) return "badge-secondary";
        return switch (status.toLowerCase()) {
            case "new" -> "badge-info";
            case "contacted" -> "badge-warning";
            case "done" -> "badge-success";
            default -> "badge-secondary";
        };
    }

    public String getTourTypeLabel() {
        if (tourType == null) return tourType;
        return switch (tourType) {
            case "beach" -> "Tour Biển & Đảo";
            case "mountain" -> "Tour Núi & Trekking";
            case "culture" -> "Tour Văn Hóa & Lịch Sử";
            case "food" -> "Tour Ẩm Thực";
            case "combo" -> "Combo Trọn Gói";
            case "custom" -> "Yêu cầu riêng";
            default -> tourType;
        };
    }
}
