package controller;
import dao.BookingDAO;
import dao.IBookingDAO;
import model.Booking;
import model.BookingStatus;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
/**
 * Servlet xử lý các action trên đơn hàng
 * URL patterns: /order/confirm, /order/cancel, /order/start, /order/complete
 */
@WebServlet(name = "OrderActionServlet", urlPatterns = {
    "/order/confirm", 
    "/order/cancel", 
    "/order/start", 
    "/order/complete"
})
public class OrderActionServlet extends HttpServlet {
    private final IBookingDAO bookingDAO = new BookingDAO();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String redirectUrl = request.getParameter("redirect");
        if (redirectUrl == null) redirectUrl = "admin/orders";
        
        boolean success = false;
        String message = "";
        try {
            Booking booking = bookingDAO.getBookingById(bookingId);
            if (booking == null) {
                message = "Không tìm thấy đơn hàng #" + bookingId;
            } else {
                BookingStatus currentStatus = booking.getStatusEnum();
                
                switch (path) {
                    case "/order/confirm" -> {
                        if (currentStatus.canTransitionTo(BookingStatus.CONFIRMED)) {
                            success = bookingDAO.updateBookingStatus(bookingId, "Confirmed");
                            message = success ? "Đã xác nhận đơn hàng #" + bookingId 
                                              : "Lỗi khi xác nhận đơn hàng";
                        } else {
                            message = "Không thể xác nhận đơn ở trạng thái " + currentStatus.getDisplayName();
                        }
                    }
                    
                    case "/order/start" -> {
                        if (currentStatus.canTransitionTo(BookingStatus.INPROGRESS)) {
                            success = bookingDAO.updateBookingStatus(bookingId, "InProgress");
                            message = success ? "Đơn hàng #" + bookingId + " đang thực hiện"
                                              : "Lỗi khi cập nhật đơn hàng";
                        } else {
                            message = "Không thể bắt đầu đơn ở trạng thái " + currentStatus.getDisplayName();
                        }
                    }
                    
                    case "/order/complete" -> {
                        if (currentStatus.canTransitionTo(BookingStatus.COMPLETED)) {
                            success = bookingDAO.updateBookingStatus(bookingId, "Completed");
                            message = success ? "Đơn hàng #" + bookingId + " đã hoàn thành!"
                                              : "Lỗi khi hoàn thành đơn hàng";
                        } else {
                            message = "Không thể hoàn thành đơn ở trạng thái " + currentStatus.getDisplayName();
                        }
                    }
                    
                    case "/order/cancel" -> {
                        if (currentStatus.canTransitionTo(BookingStatus.CANCELLED)) {
                            String reason = request.getParameter("reason");
                            double refund = 0;
                            
                            // Nếu đã thanh toán, tính tiền hoàn lại
                            if ("PAID".equals(booking.getPaymentStatus())) {
                                // Chính sách: Hoàn 80% nếu hủy trước tour, 0% nếu đã bắt đầu
                                refund = booking.getTotalPrice() * 0.8;
                            }
                            
                            success = bookingDAO.cancelBooking(bookingId, reason, refund);
                            message = success ? "Đã hủy đơn hàng #" + bookingId 
                                            + (refund > 0 ? ". Hoàn lại: " + String.format("%,.0f VNĐ", refund) : "")
                                              : "Lỗi khi hủy đơn hàng";
                        } else {
                            message = "Không thể hủy đơn ở trạng thái " + currentStatus.getDisplayName();
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Lỗi hệ thống: " + e.getMessage();
        }
        // Set flash message vào session
        HttpSession session = request.getSession();
        session.setAttribute("flashMessage", message);
        session.setAttribute("flashType", success ? "success" : "danger");
        
        response.sendRedirect(request.getContextPath() + "/" + redirectUrl);
    }
}