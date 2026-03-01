package com.dananghub.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "MonthlyRevenue")
public class MonthlyRevenue implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "RevenueId")
    private int revenueId;

    @Column(name = "ReportMonth")
    private int reportMonth;

    @Column(name = "ReportYear")
    private int reportYear;

    @Column(name = "TotalBookings")
    private int totalBookings;

    @Column(name = "GrossVolume")
    private Double grossVolume;

    @Column(name = "PlatformFee")
    private Double platformFee;

    @Column(name = "CreatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    public MonthlyRevenue() {
    }

    public int getRevenueId() {
        return revenueId;
    }

    public void setRevenueId(int revenueId) {
        this.revenueId = revenueId;
    }

    public int getReportMonth() {
        return reportMonth;
    }

    public void setReportMonth(int reportMonth) {
        this.reportMonth = reportMonth;
    }

    public int getReportYear() {
        return reportYear;
    }

    public void setReportYear(int reportYear) {
        this.reportYear = reportYear;
    }

    public int getTotalBookings() {
        return totalBookings;
    }

    public void setTotalBookings(int totalBookings) {
        this.totalBookings = totalBookings;
    }

    public Double getGrossVolume() {
        return grossVolume;
    }

    public void setGrossVolume(Double grossVolume) {
        this.grossVolume = grossVolume;
    }

    public Double getPlatformFee() {
        return platformFee;
    }

    public void setPlatformFee(Double platformFee) {
        this.platformFee = platformFee;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
