package model;

import java.math.BigDecimal;

/**
 * HotelComparison Model Class
 * Represents hotel comparison data from vw_DanangHotelPriceComparison view
 */
public class HotelComparison {
    
    private int supplierID;
    private String supplierCode;
    private String supplierName;
    private String address;
    private BigDecimal currentPrice;
    private BigDecimal avgPrice6Months;
    private BigDecimal lowestPrice;
    private BigDecimal highestPrice;
    private BigDecimal rating;
    private int totalReviews;
    private int qualityScore;
    private String hotelCategory;  // "5 Sao Cao Cấp", "5 Sao", "4 Sao", "3 Sao / Boutique"
    private int priceChangeCount;
    private BigDecimal priceVsAvgPercent;
    private String valueRating;  // "Giá trị tốt", "Đáng cân nhắc", "Giá cao", "Bình thường"
    private String tags;
    
    // Constructors
    public HotelComparison() {
    }
    
    public HotelComparison(int supplierID, String supplierName, String hotelCategory, 
                          BigDecimal currentPrice, BigDecimal rating) {
        this.supplierID = supplierID;
        this.supplierName = supplierName;
        this.hotelCategory = hotelCategory;
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
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public BigDecimal getCurrentPrice() {
        return currentPrice;
    }
    
    public void setCurrentPrice(BigDecimal currentPrice) {
        this.currentPrice = currentPrice;
    }
    
    public BigDecimal getAvgPrice6Months() {
        return avgPrice6Months;
    }
    
    public void setAvgPrice6Months(BigDecimal avgPrice6Months) {
        this.avgPrice6Months = avgPrice6Months;
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
    
    public int getQualityScore() {
        return qualityScore;
    }
    
    public void setQualityScore(int qualityScore) {
        this.qualityScore = qualityScore;
    }
    
    public String getHotelCategory() {
        return hotelCategory;
    }
    
    public void setHotelCategory(String hotelCategory) {
        this.hotelCategory = hotelCategory;
    }
    
    public int getPriceChangeCount() {
        return priceChangeCount;
    }
    
    public void setPriceChangeCount(int priceChangeCount) {
        this.priceChangeCount = priceChangeCount;
    }
    
    public BigDecimal getPriceVsAvgPercent() {
        return priceVsAvgPercent;
    }
    
    public void setPriceVsAvgPercent(BigDecimal priceVsAvgPercent) {
        this.priceVsAvgPercent = priceVsAvgPercent;
    }
    
    public String getValueRating() {
        return valueRating;
    }
    
    public void setValueRating(String valueRating) {
        this.valueRating = valueRating;
    }
    
    public String getTags() {
        return tags;
    }
    
    public void setTags(String tags) {
        this.tags = tags;
    }
    
    @Override
    public String toString() {
        return "HotelComparison{" +
                "supplierID=" + supplierID +
                ", supplierName='" + supplierName + '\'' +
                ", hotelCategory='" + hotelCategory + '\'' +
                ", currentPrice=" + currentPrice +
                ", avgPrice6Months=" + avgPrice6Months +
                ", rating=" + rating +
                ", totalReviews=" + totalReviews +
                ", valueRating='" + valueRating + '\'' +
                '}';
    }
}
