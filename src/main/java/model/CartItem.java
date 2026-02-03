package model;

public class CartItem {
    private Tour tour;
    private int quantity;
    private double totalPrice;

    public CartItem(Tour tour, int quantity) {
        this.tour = tour;
        this.quantity = quantity;
        this.totalPrice = tour.getPrice() * quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
        this.totalPrice = this.tour.getPrice() * quantity;
    }
    
    public Tour getTour() { return tour; }
    public int getQuantity() { return quantity; }
    public double getTotalPrice() { return totalPrice; }
}
