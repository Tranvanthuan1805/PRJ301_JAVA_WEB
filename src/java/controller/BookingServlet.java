package controller;

import dao.BookingDAO;
import dao.IBookingDAO;
import dao.ITourDAO;
import dao.TourDAO;
import java.io.IOException;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Booking;
import model.Tour;

@WebServlet(name = "BookingServlet", urlPatterns = {"/booking"})
public class BookingServlet extends HttpServlet {

    private final IBookingDAO bookingDAO = new BookingDAO();
    private final ITourDAO tourDAO = new TourDAO(); // Để lấy giá tiền

    // --- NHIỆM VỤ 1: HIỆN FORM (Khi bấm nút "Đặt ngay" từ trang chủ) ---
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id = request.getParameter("id"); // Lấy id từ URL (ví dụ: booking?id=1)
        
        // 1. Kiểm tra ID có hợp lệ không
        if (id == null || id.isEmpty()) {
            response.sendRedirect("home"); // Nếu không có ID thì đá về trang chủ
            return;
        }

        try {
            // 2. Tìm thông tin Tour để hiện lên Form
            Tour t = tourDAO.getTourById(Integer.parseInt(id));
            
            if (t == null) {
                response.sendRedirect("home"); // ID có số nhưng không tìm thấy tour
                return;
            }
            
            // 3. Gửi thông tin sang trang booking.jsp
            request.setAttribute("tour", t);
            request.getRequestDispatcher("booking.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }
    
    // --- NHIỆM VỤ 2: LƯU ĐƠN HÀNG (Khi bấm nút "Xác nhận" ở form booking.jsp) ---
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // 1. Lấy dữ liệu người dùng nhập từ Form
            int tourId = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("quantity")); // Số lượng người
            
            // 2. Tính toán tổng tiền
            Tour t = tourDAO.getTourById(tourId);
            double totalPrice = t.getPrice() * quantity;
            
            // 3. Giả định User (hieu - ID 3)
            int fakeUserId = 3; 

            // 4. Tạo đối tượng Booking
            Booking b = new Booking();
            b.setUserId(fakeUserId);
            b.setTourId(tourId);
            b.setBookingDate(new Date()); // Ngày hiện tại
            b.setNumberOfPeople(quantity);
            b.setTotalPrice(totalPrice);
            b.setStatus("Pending");
            
            // 5. Lưu vào Database
            bookingDAO.insertBooking(b);
            
            // 6. Thông báo thành công
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' rel='stylesheet'>");
            response.getWriter().println("<div class='container text-center mt-5'>");
            response.getWriter().println("<h1 class='text-success fw-bold'>🎉 ĐẶT TOUR THÀNH CÔNG!</h1>");
            response.getWriter().println("<h3>Cảm ơn bạn đã đặt tour: " + t.getTourName() + "</h3>");
            response.getWriter().println("<p class='fs-4'>Tổng tiền: <span class='text-danger fw-bold'>" + String.format("%,.0f", totalPrice) + " VNĐ</span> (" + quantity + " người)</p>");
            response.getWriter().println("<a href='home' class='btn btn-primary mt-3'>Quay lại trang chủ</a>");
            response.getWriter().println("</div>");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi xử lý: " + e.getMessage());
        }
    }
}