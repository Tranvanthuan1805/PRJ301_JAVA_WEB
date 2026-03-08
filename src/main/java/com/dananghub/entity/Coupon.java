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
    private String discountType = "percent"; // "percent" or "fixed"

    @Column(name = "DiscountValue", nullable = false)
    private double discountValue;

    @Column(name = "MinOrderAmount")
    private double minOrderAmount = 0;

    @Column(name = "MaxDiscount")
    private Double maxDiscount;

    @Column(name = "UsageLimit")
    private Integer usageLimit;

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

    @Column(name = "Description", length = 255)
    private String description;

    @Column(name = "CreatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    public Coupon() {}

    /**
     * Tính số tiền giảm dựa trên subtotal
     */
    public double calculateDiscount(double subtotal) {
        if ("percent".equalsIgnoreCase(discountType)) {
            double discount = subtotal * discountValue / 100.0;
            if (maxDiscount != null && discount > maxDiscount) {
                discount = maxDiscount;
            }
            return discount;
        } else {
            // fixed
            return Math.min(discountValue, subtotal);
        }
    }

    /**
     * Kiểm tra mã có hợp lệ không
     */
    public boolean isValid(double subtotal) {
        if (!isActive) return false;
        if (subtotal < minOrderAmount) return false;
        if (usageLimit != null && usedCount >= usageLimit) return false;
        Date now = new Date();
        if (startDate != null && now.before(startDate)) return false;
        if (endDate != null && now.after(endDate)) return false;
        return true;
    }

    public String getDiscountLabel() {
        if ("percent".equalsIgnoreCase(discountType)) {
            String label = String.format("Giảm %.0f%%", discountValue);
            if (maxDiscount != null) {
                label += String.format(" (tối đa %,.0fđ)", maxDiscount);
            }
            return label;
        } else {
            return String.format("Giảm %,.0fđ", discountValue);
        }
    }

    // Getters and Setters
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

    public Integer getUsageLimit() { return usageLimit; }
    public void setUsageLimit(Integer usageLimit) { this.usageLimit = usageLimit; }

    public int getUsedCount() { return usedCount; }
    public void setUsedCount(int usedCount) { this.usedCount = usedCount; }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }

    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
