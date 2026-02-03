package dao;

import java.util.List;
import model.Booking;

public interface IBookingDAO {
    void insertBooking(Booking b);
    List<Booking> getBookingsByUserId(int userId);
    public int getBookedCount(int tourId);
}