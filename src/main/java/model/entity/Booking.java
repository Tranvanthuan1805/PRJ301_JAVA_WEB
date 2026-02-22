package model.entity;

import java.sql.Timestamp;

public class Booking {
    private int bookingId;
    private int orderId;
    private int tourId;
    private Timestamp tourDate; // Date of the actual trip
    private int quantity;
    private double subTotal;
    private String bookingStatus;

    public Booking() {}

    public Booking(int bookingId, int orderId, int tourId, Timestamp tourDate, int quantity, double subTotal, String bookingStatus) {
        this.bookingId = bookingId;
        this.orderId = orderId;
        this.tourId = tourId;
        this.tourDate = tourDate;
        this.quantity = quantity;
        this.subTotal = subTotal;
        this.bookingStatus = bookingStatus;
    }

    // Getters and Setters
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public int getTourId() { return tourId; }
    public void setTourId(int tourId) { this.tourId = tourId; }
    public Timestamp getTourDate() { return tourDate; }
    public void setTourDate(Timestamp tourDate) { this.tourDate = tourDate; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getSubTotal() { return subTotal; }
    public void setSubTotal(double subTotal) { this.subTotal = subTotal; }
    public String getBookingStatus() { return bookingStatus; }
    public void setBookingStatus(String bookingStatus) { this.bookingStatus = bookingStatus; }
}
