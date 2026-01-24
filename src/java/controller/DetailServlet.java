package controller;

import dao.BookingDAO;
import dao.IBookingDAO;
import dao.ITourDAO;
import dao.TourDAO;
import model.Tour;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DetailServlet", urlPatterns = {"/detail"})
public class DetailServlet extends HttpServlet {

    private final ITourDAO tourDAO = new TourDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            
            if (id == null || id.isEmpty()) {
                response.sendRedirect("home");
                return;
            }

            // Lấy thông tin chi tiết tour
            Tour t = tourDAO.getTourById(Integer.parseInt(id));
            
            if (t != null) {
                // Lấy tổng vé tối đa
                int maxSeats = t.getMaxPeople();
                
                // Lấy số vé đã đặt
                IBookingDAO bookingDAO = new BookingDAO();
                int bookedSeat = bookingDAO.getBookedCount(t.getTourId());
                
                // Tính số còn lại
                int remaining = maxSeats - bookedSeat;
                
                request.setAttribute("remaining", remaining);
                request.setAttribute("tour", t);
                request.getRequestDispatcher("detail.jsp").forward(request, response);
            }
            // Nếu không có tourId tương ứng, về trang chủ
            else { 
                response.sendRedirect("home");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }
}