package model;

import java.math.BigDecimal;

/**
 * TourComparison Model Class
 * Represents tour comparison data from vw_DanangTourPriceComparison view
 */
public class TourComparison {
    
    private int supplierID;
    private String supplierCode;
    private String supplierName;
    private String shortDescription;
    private BigDecimal currentPrice;
    private BigDecimal avgPriceAllTime;
    private BigDecimal lowestPrice;
    private BigDecimal highestPrice;
    private BigDecimal priceChangePercent;
    private BigDecimal rating;
    private int totalReviews;
    private String tourType;  // "Tour Dài Ngày (2N+)", "Tour Full Day", "Tour Half Day"
    private String priceTrend;  // "Tăng mạnh", "Tăng nhẹ", "Giảm mạnh", "Giảm nhẹ", "Ổn định"
    private String recommendation;  // "Khuyến nghị mạnh", "Đáng thử", "Chờ giảm giá", "Bình thường"
    private String tags;
    
    // Constructors
    public TourComparison() {
    }
    
    public TourComparison(int supplierID, String supplierName, String tourType, 
                         BigDecimal currentPrice, BigDecimal rating) {
        this.supplierID = supplierID;
        this.supplierName = supplierName;
        this.tourType = tourType;
        this.currentPrice = currentPrice;
        this.rating = rating;
    }
    
    // Getters and Setters
    public int getSupplierID() {
        return supplierID;
    }
    
    public void setSupplierID(int supplierID) {
        this.supplierID = supplierID;
    }
    
    public String getSupplierCode() {
        return supplierCode;
    }
    
    public void setSupplierCode(String supplierCode) {
        this.supplierCode = supplierCode;
    }
    
    public String getSupplierName() {
        return supplierName;
    }
    
    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }
    
    public String getShortDescription() {
        return shortDescription;
    }
    
    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }
    
    public BigDecimal getCurrentPrice() {
        return currentPrice;
    }
    
    public void setCurrentPrice(BigDecimal currentPrice) {
        this.currentPrice = currentPrice;
    }
    
    public BigDecimal getAvgPriceAllTime() {
        return avgPriceAllTime;
    }
    
    public void setAvgPriceAllTime(BigDecimal avgPriceAllTime) {
        this.avgPriceAllTime = avgPriceAllTime;
    }
    
    public BigDecimal getLowestPrice() {
        return lowestPrice;
    }
    
    public void setLowestPrice(BigDecimal lowestPrice) {
        this.lowestPrice = lowestPrice;
    }
    
    public BigDecimal getHighestPrice() {
        return highestPrice;
    }
    
    public void setHighestPrice(BigDecimal highestPrice) {
        this.highestPrice = highestPrice;
    }
    
    public BigDecimal getPriceChangePercent() {
        return priceChangePercent;
    }
    
    public void setPriceChangePercent(BigDecimal priceChangePercent) {
        this.priceChangePercent = priceChangePercent;
    }
    
    public BigDecimal getRating() {
        return rating;
    }
    
    public void setRating(BigDecimal rating) {
        this.rating = rating;
    }
    
    public int getTotalReviews() {
        return totalReviews;
    }
    
    public void setTotalReviews(int totalReviews) {
        this.totalReviews = totalReviews;
    }
    
    public String getTourType() {
        return tourType;
    }
    
    public void setTourType(String tourType) {
        this.tourType = tourType;
    }
    
    public String getPriceTrend() {
        return priceTrend;
    }
    
    public void setPriceTrend(String priceTrend) {
        this.priceTrend = priceTrend;
    }
    
    public String getRecommendation() {
        return recommendation;
    }
    
    public void setRecommendation(String recommendation) {
        this.recommendation = recommendation;
    }
    
    public String getTags() {
        return tags;
    }
    
    public void setTags(String tags) {
        this.tags = tags;
    }
    
    @Override
    public String toString() {
        return "TourComparison{" +
                "supplierID=" + supplierID +
                ", supplierName='" + supplierName + '\'' +
                ", tourType='" + tourType + '\'' +
                ", currentPrice=" + currentPrice +
                ", avgPriceAllTime=" + avgPriceAllTime +
                ", rating=" + rating +
                ", totalReviews=" + totalReviews +
                ", recommendation='" + recommendation + '\'' +
                '}';
    }
}
