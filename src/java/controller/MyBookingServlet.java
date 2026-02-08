package controller;
import dao.BookingDAO;
import dao.IBookingDAO;
import dao.ITourDAO;
import dao.TourDAO;
import model.Booking;
import model.BookingDetailDTO;
import model.Tour;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
/**
 * Servlet cho User xem lịch sử đặt tour của mình
 * URL: /my-bookings
 */
@WebServlet(name = "MyBookingServlet", urlPatterns = {"/my-bookings"})
public class MyBookingServlet extends HttpServlet {
    private final IBookingDAO bookingDAO = new BookingDAO();
    private final ITourDAO tourDAO = new TourDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // TODO: Lấy userId từ session khi tích hợp Login
        // User user = (User) session.getAttribute("user");
        // int userId = user.getUserId();
        
        // Tạm thời hardcode userId = 3 (hieu)
        int userId = 3;
        
        try {
            List<Booking> bookings = bookingDAO.getBookingsByUserId(userId);
            
            // Chuyển đổi thành DTO với thông tin Tour
            List<BookingDetailDTO> bookingDetails = new ArrayList<>();
            for (Booking b : bookings) {
                Tour t = tourDAO.getTourById(b.getTourId());
                bookingDetails.add(new BookingDetailDTO(b, t, "hieu")); // Username tạm
            }
            
            request.setAttribute("bookings", bookingDetails);
            request.getRequestDispatcher("/my-bookings.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi tải lịch sử đặt tour");
            request.getRequestDispatcher("/my-bookings.jsp").forward(request, response);
        }
    }
}