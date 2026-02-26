package model;

/**
 * Model đại diện cho một item trong đơn hàng
 */
public class OrderItem {
    private int id;
    private int orderId;
    private int tourId;
    private String tourName;
    private double tourPrice;
    private int quantity;
    private double subtotal;
    
    public OrderItem() {}
    
    public OrderItem(int tourId, String tourName, double tourPrice, int quantity) {
        this.tourId = tourId;
        this.tourName = tourName;
        this.tourPrice = tourPrice;
        this.quantity = quantity;
        this.subtotal = tourPrice * quantity;
    }
    
    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    
    public int getTourId() { return tourId; }
    public void setTourId(int tourId) { this.tourId = tourId; }
    
    public String getTourName() { return tourName; }
    public void setTourName(String tourName) { this.tourName = tourName; }
    
    public double getTourPrice() { return tourPrice; }
    public void setTourPrice(double tourPrice) { this.tourPrice = tourPrice; }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    public double getSubtotal() { return subtotal; }
    public void setSubtotal(double subtotal) { this.subtotal = subtotal; }
}
