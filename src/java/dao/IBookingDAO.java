package dao;

import java.util.List;
import model.Booking;

public interface IBookingDAO {
    // Chỉ khai báo hàm, không viết thân hàm
    void insertBooking(Booking b);
    List<Booking> getBookingsByUserId(int userId);
}