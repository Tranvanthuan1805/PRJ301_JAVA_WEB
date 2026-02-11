package servlet;

import dao.TourDAO;
import dao.InteractionHistoryDAO;
import model.Tour;
import model.InteractionHistory;
import model.User;
import util.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.util.UUID;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        
        // Check if user is logged in
        if (username == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("book".equals(action)) {
            handleBooking(request, response, username);
        }
    }
    
    private void handleBooking(HttpServletRequest request, HttpServletResponse response, String username) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String tourIdParam = request.getParameter("tourId");
        String numberOfPeopleParam = request.getParameter("numberOfPeople");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        if (tourIdParam == null || numberOfPeopleParam == null || 
            fullName == null || email == null || phone == null) {
            session.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
            response.sendRedirect(request.getContextPath() + "/tour");
            return;
        }
        
        // Trim inputs
        fullName = fullName.trim();
        email = email.trim();
        phone = phone.trim();
        address = (address != null) ? address.trim() : "";
        
        if (fullName.isEmpty() || email.isEmpty() || phone.isEmpty()) {
            session.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
            response.sendRedirect(request.getContextPath() + "/tour");
            return;
        }
        
        try {
            int tourId = Integer.parseInt(tourIdParam);
            int numberOfPeople = Integer.parseInt(numberOfPeopleParam);
            
            if (numberOfPeople <= 0) {
                session.setAttribute("error", "Số lượng người phải lớn hơn 0");
                response.sendRedirect(request.getContextPath() + "/jsp/tour-view.jsp?id=" + tourId);
                return;
            }
            
            Connection conn = DatabaseConnection.getNewConnection();
            
            try {
                // Start transaction
                conn.setAutoCommit(false);
                
                // Get tour info
                TourDAO tourDAO = new TourDAO(conn);
                Tour tour = tourDAO.getTourById(tourId);
                
                if (tour == null) {
                    session.setAttribute("error", "Tour không tồn tại");
                    response.sendRedirect(request.getContextPath() + "/tour");
                    return;
                }
                
                // Check capacity
                int availableSeats = tour.getMaxCapacity() - tour.getCurrentCapacity();
                if (numberOfPeople > availableSeats) {
                    session.setAttribute("error", 
                        "Không đủ chỗ trống. Chỉ còn " + availableSeats + " chỗ");
                    response.sendRedirect(request.getContextPath() + "/jsp/tour-view.jsp?id=" + tourId);
                    conn.rollback();
                    return;
                }
                
                // Get or create customer with provided info
                int customerId = getOrCreateCustomer(conn, fullName, email, phone, address);
                
                // Generate booking code
                String bookingCode = "BK" + System.currentTimeMillis();
                
                // Insert booking
                String insertBookingSql = "INSERT INTO Bookings (customerId, tourId, bookingDate, status, bookingCode) " +
                                         "VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(insertBookingSql)) {
                    stmt.setInt(1, customerId);
                    stmt.setInt(2, tourId);
                    stmt.setTimestamp(3, java.sql.Timestamp.valueOf(LocalDateTime.now()));
                    stmt.setString(4, "CONFIRMED");
                    stmt.setString(5, bookingCode);
                    stmt.executeUpdate();
                }
                
                // Update tour capacity
                String updateCapacitySql = "UPDATE Tours SET currentCapacity = currentCapacity + ? WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(updateCapacitySql)) {
                    stmt.setInt(1, numberOfPeople);
                    stmt.setInt(2, tourId);
                    stmt.executeUpdate();
                }
                
                // Log interaction history
                InteractionHistoryDAO historyDAO = new InteractionHistoryDAO(conn);
                InteractionHistory history = new InteractionHistory();
                history.setCustomerId(customerId);
                history.setAction("Đặt tour: " + tour.getName() + " - " + numberOfPeople + " người - Mã: " + bookingCode);
                history.setCreatedAt(LocalDateTime.now());
                historyDAO.addInteraction(history);
                
                // Commit transaction
                conn.commit();
                
                session.setAttribute("success", 
                    "Đặt tour thành công! Mã đặt tour: " + bookingCode);
                response.sendRedirect(request.getContextPath() + "/jsp/tour-view.jsp?id=" + tourId);
                
            } catch (Exception e) {
                conn.rollback();
                e.printStackTrace();
                session.setAttribute("error", "Lỗi khi đặt tour: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/jsp/tour-view.jsp?id=" + tourId);
            } finally {
                conn.setAutoCommit(true);
                conn.close();
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Thông tin không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/tour");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/tour");
        }
    }
    
    private int getOrCreateCustomer(Connection conn, String fullName, String email, String phone, String address) throws Exception {
        // Check if customer exists with this email
        String checkSql = "SELECT id FROM Customers WHERE email = ?";
        try (PreparedStatement stmt = conn.prepareStatement(checkSql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int customerId = rs.getInt("id");
                
                // Update customer info
                String updateSql = "UPDATE Customers SET fullName = ?, phone = ?, address = ?, updatedAt = GETDATE() WHERE id = ?";
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setString(1, fullName);
                    updateStmt.setString(2, phone);
                    updateStmt.setString(3, address);
                    updateStmt.setInt(4, customerId);
                    updateStmt.executeUpdate();
                }
                
                return customerId;
            }
        }
        
        // Create new customer
        String insertSql = "INSERT INTO Customers (fullName, email, phone, address) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(insertSql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, fullName);
            stmt.setString(2, email);
            stmt.setString(3, phone);
            stmt.setString(4, address);
            stmt.executeUpdate();
            
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        
        throw new Exception("Không thể tạo customer");
    }
}
