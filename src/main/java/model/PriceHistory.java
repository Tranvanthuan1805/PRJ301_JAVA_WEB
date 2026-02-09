package model;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * PriceHistory Model Class
 * Represents price history data from vw_PriceHistoryDetails view
 */
public class PriceHistory {
    
    private int priceHistoryID;
    private int supplierID;
    private String supplierName;
    private String supplierCode;
    private String serviceTypeName;
    private BigDecimal oldPrice;
    private BigDecimal newPrice;
    private BigDecimal priceChange;
    private BigDecimal changePercent;
    private String changeType;  // "Tăng", "Giảm", "Không đổi"
    private String changeReason;
    private LocalDate effectiveDate;
    private LocalDate createdDate;
    private String createdBy;
    
    // Constructors
    public PriceHistory() {
    }
    
    public PriceHistory(int priceHistoryID, int supplierID, String supplierName, 
                       BigDecimal oldPrice, BigDecimal newPrice, String changeReason, 
                       LocalDate effectiveDate) {
        this.priceHistoryID = priceHistoryID;
        this.supplierID = supplierID;
        this.supplierName = supplierName;
        this.oldPrice = oldPrice;
        this.newPrice = newPrice;
        this.changeReason = changeReason;
        this.effectiveDate = effectiveDate;
        this.priceChange = newPrice.subtract(oldPrice);
    }
    
    // Getters and Setters
    public int getPriceHistoryID() {
        return priceHistoryID;
    }
    
    public void setPriceHistoryID(int priceHistoryID) {
        this.priceHistoryID = priceHistoryID;
    }
    
    public int getSupplierID() {
        return supplierID;
    }
    
    public void setSupplierID(int supplierID) {
        this.supplierID = supplierID;
    }
    
    public String getSupplierName() {
        return supplierName;
    }
    
    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }
    
    public String getSupplierCode() {
        return supplierCode;
    }
    
    public void setSupplierCode(String supplierCode) {
        this.supplierCode = supplierCode;
    }
    
    public String getServiceTypeName() {
        return serviceTypeName;
    }
    
    public void setServiceTypeName(String serviceTypeName) {
        this.serviceTypeName = serviceTypeName;
    }
    
    public BigDecimal getOldPrice() {
        return oldPrice;
    }
    
    public void setOldPrice(BigDecimal oldPrice) {
        this.oldPrice = oldPrice;
    }
    
    public BigDecimal getNewPrice() {
        return newPrice;
    }
    
    public void setNewPrice(BigDecimal newPrice) {
        this.newPrice = newPrice;
    }
    
    public BigDecimal getPriceChange() {
        return priceChange;
    }
    
    public void setPriceChange(BigDecimal priceChange) {
        this.priceChange = priceChange;
    }
    
    public BigDecimal getChangePercent() {
        return changePercent;
    }
    
    public void setChangePercent(BigDecimal changePercent) {
        this.changePercent = changePercent;
    }
    
    public String getChangeType() {
        return changeType;
    }
    
    public void setChangeType(String changeType) {
        this.changeType = changeType;
    }
    
    public String getChangeReason() {
        return changeReason;
    }
    
    public void setChangeReason(String changeReason) {
        this.changeReason = changeReason;
    }
    
    public LocalDate getEffectiveDate() {
        return effectiveDate;
    }
    
    public void setEffectiveDate(LocalDate effectiveDate) {
        this.effectiveDate = effectiveDate;
    }
    
    public LocalDate getCreatedDate() {
        return createdDate;
    }
    
    public void setCreatedDate(LocalDate createdDate) {
        this.createdDate = createdDate;
    }
    
    public String getCreatedBy() {
        return createdBy;
    }
    
    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }
    
    @Override
    public String toString() {
        return "PriceHistory{" +
                "priceHistoryID=" + priceHistoryID +
                ", supplierName='" + supplierName + '\'' +
                ", oldPrice=" + oldPrice +
                ", newPrice=" + newPrice +
                ", priceChange=" + priceChange +
                ", changePercent=" + changePercent +
                ", changeType='" + changeType + '\'' +
                ", effectiveDate=" + effectiveDate +
                '}';
    }
}
