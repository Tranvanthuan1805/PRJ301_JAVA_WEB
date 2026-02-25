package model;

import java.math.BigDecimal;

/**
 * Model class for TravelRevenue
 */
public class TravelRevenue {
    private int id;
    private int reportMonth;
    private int reportYear;
    private String category;
    private String supplierName;
    private Double estimatedRevenueBillion;
    private BigDecimal avgHotelPriceVND;
    private Integer guestCount;
    private BigDecimal avgFlightTicketVND;

    // Constructors
    public TravelRevenue() {
    }

    public TravelRevenue(int reportMonth, int reportYear, String category, String supplierName) {
        this.reportMonth = reportMonth;
        this.reportYear = reportYear;
        this.category = category;
        this.supplierName = supplierName;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public Double getEstimatedRevenueBillion() {
        return estimatedRevenueBillion;
    }

    public void setEstimatedRevenueBillion(Double estimatedRevenueBillion) {
        this.estimatedRevenueBillion = estimatedRevenueBillion;
    }

    public BigDecimal getAvgHotelPriceVND() {
        return avgHotelPriceVND;
    }

    public void setAvgHotelPriceVND(BigDecimal avgHotelPriceVND) {
        this.avgHotelPriceVND = avgHotelPriceVND;
    }

    public Integer getGuestCount() {
        return guestCount;
    }

    public void setGuestCount(Integer guestCount) {
        this.guestCount = guestCount;
    }

    public BigDecimal getAvgFlightTicketVND() {
        return avgFlightTicketVND;
    }

    public void setAvgFlightTicketVND(BigDecimal avgFlightTicketVND) {
        this.avgFlightTicketVND = avgFlightTicketVND;
    }

    // Helper methods
    public String getMonthYearDisplay() {
        return String.format("%02d/%d", reportMonth, reportYear);
    }

    public boolean isHotelCategory() {
        return category != null && category.contains("Khách sạn");
    }

    public boolean isAirlineCategory() {
        return category != null && category.contains("Hàng không");
    }

    @Override
    public String toString() {
        return "TravelRevenue{" +
                "id=" + id +
                ", reportMonth=" + reportMonth +
                ", reportYear=" + reportYear +
                ", category='" + category + '\'' +
                ", supplierName='" + supplierName + '\'' +
                ", estimatedRevenueBillion=" + estimatedRevenueBillion +
                ", guestCount=" + guestCount +
                '}';
    }
}
