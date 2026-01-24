package controller;

import dao.BookingDAO;
import dao.IBookingDAO;
import dao.ITourDAO;
import dao.TourDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Booking;

@WebServlet(name = "HistoryServlet", urlPatterns = {"/history"})
public class HistoryServlet extends HttpServlet {

    private final IBookingDAO bookingDAO = new BookingDAO();
    private final ITourDAO tourDAO = new TourDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Giả định User hiện tại là Hiếu (ID = 3)
        // (Sau này ghép Login của Minh vào thì thay bằng session)
        int userId = 3; 
        
        // 1. Lấy danh sách booking
        List<Booking> list = bookingDAO.getBookingsByUserId(userId);
        
        // 2. Gửi sang JSP
        request.setAttribute("bookingList", list);
        request.setAttribute("tourDAO", tourDAO); // Để JSP lấy được tên Tour từ ID
        
        request.getRequestDispatcher("history.jsp").forward(request, response);
    }
}