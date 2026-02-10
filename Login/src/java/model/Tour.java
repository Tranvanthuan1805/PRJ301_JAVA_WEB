package model;

import java.time.LocalDate;

public class Tour {
    private int id;
    private String name;
    private String destination;
    private LocalDate startDate;
    private LocalDate endDate;
    private double price;
    private int maxCapacity;
    private int currentCapacity;
    private String description;

    public Tour() {}

    public Tour(int id, String name, String destination,
                LocalDate startDate, LocalDate endDate,
                double price, int maxCapacity, int currentCapacity,
                String description) {
        this.id = id;
        this.name = name;
        this.destination = destination;
        this.startDate = startDate;
        this.endDate = endDate;
        this.price = price;
        this.maxCapacity = maxCapacity;
        this.currentCapacity = currentCapacity;
        this.description = description;
    }

    /**
     * Kiểm tra tour còn chỗ trống không
     * @return true nếu còn chỗ, false nếu đã hết
     */
    public boolean isAvailable() {
        return currentCapacity < maxCapacity;
    }
    
    /**
     * Alias cho isAvailable() để tương thích với JSP
     */
    public boolean getAvailable() {
        return isAvailable();
    }
    
    /**
     * Kiểm tra còn đủ số lượng chỗ yêu cầu không
     * @param quantity Số lượng chỗ cần kiểm tra
     * @return true nếu còn đủ chỗ
     */
    public boolean checkAvailability(int quantity) {
        return (maxCapacity - currentCapacity) >= quantity;
    }
    
    /**
     * Tính occupancy rate (tỷ lệ lấp đầy)
     * @return Tỷ lệ % (0-100)
     */
    public double getOccupancyRate() {
        if (maxCapacity == 0) return 0;
        return (double) currentCapacity / maxCapacity * 100;
    }
    
    /**
     * Lấy số chỗ còn trống
     * @return Số chỗ trống
     */
    public int getAvailableSlots() {
        return maxCapacity - currentCapacity;
    }
    
    /**
     * Kiểm tra trạng thái Active/Paused
     * Logic: Active nếu còn chỗ VÀ chưa quá hạn
     * @return true nếu Active, false nếu Paused
     */
    public boolean isActive() {
        LocalDate today = LocalDate.now();
        boolean hasSlots = currentCapacity < maxCapacity;
        boolean notExpired = startDate.isAfter(today) || startDate.isEqual(today);
        return hasSlots && notExpired;
    }
    
    /**
     * Lấy status badge text
     * @return "Active" hoặc "Paused"
     */
    public String getStatusBadge() {
        return isActive() ? "Active" : "Paused";
    }
    
    /**
     * Lấy màu badge
     * @return CSS class cho badge color
     */
    public String getStatusColor() {
        return isActive() ? "success" : "danger";
    }
    
    /**
     * Lấy status text chi tiết
     * @return Mô tả trạng thái
     */
    public String getStatusText() {
        if (!isAvailable()) {
            return "Hết chỗ";
        }
        LocalDate today = LocalDate.now();
        if (startDate.isBefore(today)) {
            return "Đã qua";
        }
        double occupancy = getOccupancyRate();
        if (occupancy >= 80) {
            return "Sắp hết chỗ";
        }
        return "Còn chỗ";
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }

    public LocalDate getEndDate() { return endDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getMaxCapacity() { return maxCapacity; }
    public void setMaxCapacity(int maxCapacity) { this.maxCapacity = maxCapacity; }

    public int getCurrentCapacity() { return currentCapacity; }
    public void setCurrentCapacity(int currentCapacity) { this.currentCapacity = currentCapacity; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
