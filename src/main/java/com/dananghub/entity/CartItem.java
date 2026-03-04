package com.dananghub.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CartItem {
    private Tour tour;
    private int quantity;
    private double totalPrice;
    private Date travelDate;

    public CartItem() {}

    public CartItem(Tour tour, int quantity, Date travelDate) {
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
    public Date getTravelDate() { return travelDate; }
    public void setTravelDate(Date travelDate) { this.travelDate = travelDate; }
}
