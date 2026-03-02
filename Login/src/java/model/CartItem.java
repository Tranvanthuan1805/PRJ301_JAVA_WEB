package model;

import java.io.Serializable;

public class CartItem implements Serializable {
    private Tour tour;
    private int quantity;
    private double subTotal;

    public CartItem() {
    }

    public CartItem(Tour tour, int quantity) {
        this.tour = tour;
        this.quantity = quantity;
        this.subTotal = tour.getPrice() * quantity;
    }

    public Tour getTour() {
        return tour;
    }

    public void setTour(Tour tour) {
        this.tour = tour;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
        this.subTotal = tour.getPrice() * quantity;
    }

    public double getSubTotal() {
        return subTotal;
    }
}
