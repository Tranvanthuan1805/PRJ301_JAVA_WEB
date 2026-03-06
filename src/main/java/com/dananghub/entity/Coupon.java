package com.dananghub.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "Coupons")
public class Coupon implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CouponId")
    private int couponId;

    @Column(name = "Code", nullable = false, unique = true, length = 50)
    private String code;

    @Column(name = "DiscountType", nullable = false, length = 20)
    private String discountType = "PERCENTAGE"; // PERCENTAGE or FIXED

    @Column(name = "DiscountValue", nullable = false)
    private double discountValue;

    @Column(name = "MinOrderAmount")
    private double minOrderAmount = 0;

    @Column(name = "MaxDiscount")
    private Double maxDiscount;

    @Column(name = "UsageLimit")
    private int usageLimit = 0; // 0 = unlimited

    @Column(name = "UsedCount")
    private int usedCount = 0;

    @Column(name = "StartDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date startDate;

    @Column(name = "EndDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date endDate;

    @Column(name = "IsActive")
    private boolean isActive = true;

    @Column(name = "CreatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt = new Date();

    public Coupon() {}

    // ==================== Helper Methods ====================

    /**
     * Check if this coupon is currently valid (active, within dates, usage not exceeded)
     */
    public boolean isValid() {
        if (!isActive) return false;
        Date now = new Date();
        if (startDate != null && now.before(startDate)) return false;
        if (endDate != null && now.after(endDate)) return false;
        if (usageLimit > 0 && usedCount >= usageLimit) return false;
        return true;
    }

    /**
     * Calculate discount amount for a given order total.
     * Returns 0 if order total is below minimum.
     */
    public double calculateDiscount(double orderTotal) {
        if (orderTotal < minOrderAmount) return 0;

        double discount;
        if ("PERCENTAGE".equalsIgnoreCase(discountType)) {
            discount = orderTotal * (discountValue / 100.0);
            if (maxDiscount != null && discount > maxDiscount) {
                discount = maxDiscount;
            }
        } else {
            // FIXED
            discount = discountValue;
        }

        // Discount cannot exceed order total
        if (discount > orderTotal) discount = orderTotal;
        return Math.round(discount);
    }

    public String getDiscountDisplay() {
        if ("PERCENTAGE".equalsIgnoreCase(discountType)) {
            return String.format("%.0f%%", discountValue);
        } else {
            return String.format("%,.0fđ", discountValue);
        }
    }

    // ==================== Getters and Setters ====================

    public int getCouponId() { return couponId; }
    public void setCouponId(int couponId) { this.couponId = couponId; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public String getDiscountType() { return discountType; }
    public void setDiscountType(String discountType) { this.discountType = discountType; }

    public double getDiscountValue() { return discountValue; }
    public void setDiscountValue(double discountValue) { this.discountValue = discountValue; }

    public double getMinOrderAmount() { return minOrderAmount; }
    public void setMinOrderAmount(double minOrderAmount) { this.minOrderAmount = minOrderAmount; }

    public Double getMaxDiscount() { return maxDiscount; }
    public void setMaxDiscount(Double maxDiscount) { this.maxDiscount = maxDiscount; }

    public int getUsageLimit() { return usageLimit; }
    public void setUsageLimit(int usageLimit) { this.usageLimit = usageLimit; }

    public int getUsedCount() { return usedCount; }
    public void setUsedCount(int usedCount) { this.usedCount = usedCount; }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }

    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }

    public boolean getIsActive() { return isActive; }
    public void setIsActive(boolean isActive) { this.isActive = isActive; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
