package model.entity;

import java.sql.Timestamp;

public class CartItem {
    private Tour tour;
    private int quantity;
    private double totalPrice;
    private Timestamp travelDate;

    public CartItem() {}

    public CartItem(Tour tour, int quantity, Timestamp travelDate) {
        this.tour = tour;
        this.quantity = quantity;
        this.travelDate = travelDate;
        this.totalPrice = tour.getPrice() * quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
        this.totalPrice = this.tour.getPrice() * quantity;
    }
    
    public Tour getTour() { return tour; }
    public void setTour(Tour tour) { this.tour = tour; }
    
    public int getQuantity() { return quantity; }
    
    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
    
    public Timestamp getTravelDate() { return travelDate; }
    public void setTravelDate(Timestamp travelDate) { this.travelDate = travelDate; }
}
