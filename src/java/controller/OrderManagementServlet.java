package controller;
import dao.BookingDAO;
import dao.IBookingDAO;
import model.Booking;
import model.BookingDetailDTO;
import model.BookingStatus;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
/**
 * Servlet quản lý đơn hàng cho Admin
 * URL: /admin/orders
 */
@WebServlet(name = "OrderManagementServlet", urlPatterns = {"/admin/orders"})
public class OrderManagementServlet extends HttpServlet {
    private final IBookingDAO bookingDAO = new BookingDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "list";
        
        try {
            switch (action) {
                case "view" -> viewOrderDetail(request, response);
                case "filter" -> filterOrders(request, response);
                default -> listAllOrders(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/admin/order-list.jsp").forward(request, response);
        }
    }
    // Hiển thị danh sách tất cả đơn hàng
    private void listAllOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<BookingDetailDTO> orders = bookingDAO.getAllBookingDetails();
        
        // Thống kê nhanh
        long pending = bookingDAO.countByStatus("Pending");
        long confirmed = bookingDAO.countByStatus("Confirmed");
        long inProgress = bookingDAO.countByStatus("InProgress");
        long completed = bookingDAO.countByStatus("Completed");
        long cancelled = bookingDAO.countByStatus("Cancelled");
        double totalRevenue = bookingDAO.getTotalRevenue();
        
        request.setAttribute("orders", orders);
        request.setAttribute("pendingCount", pending);
        request.setAttribute("confirmedCount", confirmed);
        request.setAttribute("inProgressCount", inProgress);
        request.setAttribute("completedCount", completed);
        request.setAttribute("cancelledCount", cancelled);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("statuses", BookingStatus.values());
        
        request.getRequestDispatcher("/admin/order-list.jsp").forward(request, response);
    }
    // Xem chi tiết 1 đơn
    private void viewOrderDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int bookingId = Integer.parseInt(request.getParameter("id"));
        BookingDetailDTO order = bookingDAO.getBookingDetailById(bookingId);
        
        if (order == null) {
            response.sendRedirect("orders");
            return;
        }
        
        request.setAttribute("order", order);
        request.setAttribute("statuses", BookingStatus.values());
        request.getRequestDispatcher("/admin/order-detail.jsp").forward(request, response);
    }
    // Lọc đơn theo trạng thái
    private void filterOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String status = request.getParameter("status");

        List<BookingDetailDTO> filteredOrders; 
        if (status == null || status.isEmpty() || "all".equalsIgnoreCase(status)) {
            filteredOrders = bookingDAO.getAllBookingDetails(); 
        } else {
            // Cần thêm method mới trong DAO hoặc convert thủ công
            List<Booking> bookings = bookingDAO.getBookingsByStatus(status);
            filteredOrders = new ArrayList<>();
            for (Booking b : bookings) {
                filteredOrders.add(bookingDAO.getBookingDetailById(b.getBookingId()));
            }
        }

        // Thêm lại statistics
        long pending = bookingDAO.countByStatus("Pending");
        long confirmed = bookingDAO.countByStatus("Confirmed");
        long inProgress = bookingDAO.countByStatus("InProgress");
        long completed = bookingDAO.countByStatus("Completed");
        long cancelled = bookingDAO.countByStatus("Cancelled");
        double totalRevenue = bookingDAO.getTotalRevenue();

        request.setAttribute("orders", filteredOrders);
        request.setAttribute("pendingCount", pending);
        request.setAttribute("confirmedCount", confirmed);
        request.setAttribute("inProgressCount", inProgress);
        request.setAttribute("completedCount", completed);
        request.setAttribute("cancelledCount", cancelled);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("selectedStatus", status);
        request.setAttribute("statuses", BookingStatus.values());

        request.getRequestDispatcher("/admin/order-list.jsp").forward(request, response);
    }
}