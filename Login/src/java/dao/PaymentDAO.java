package dao;

import model.Payment;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO để quản lý thanh toán
 */
public class PaymentDAO {
    
    /**
     * Tạo payment record
     */
    public int createPayment(Payment payment) {
        String sql = "INSERT INTO Payments (orderId, paymentCode, amount, paymentMethod, paymentStatus) " +
                    "VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, payment.getOrderId());
            stmt.setString(2, payment.getPaymentCode());
            stmt.setDouble(3, payment.getAmount());
            stmt.setString(4, payment.getPaymentMethod());
            stmt.setString(5, payment.getPaymentStatus());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return -1;
    }
    
    /**
     * Cập nhật trạng thái thanh toán
     */
    public boolean updatePaymentStatus(int paymentId, String status, String transactionId) {
        String sql = "UPDATE Payments SET paymentStatus = ?, transactionId = ?, " +
                    "paymentDate = GETDATE() WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setString(2, transactionId);
            stmt.setInt(3, paymentId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Lấy payment theo ID
     */
    public Payment getPaymentById(int paymentId) {
        String sql = "SELECT * FROM Payments WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, paymentId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToPayment(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Lấy payment theo payment code
     */
    public Payment getPaymentByCode(String paymentCode) {
        String sql = "SELECT * FROM Payments WHERE paymentCode = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, paymentCode);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToPayment(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Lấy danh sách payments của order
     */
    public List<Payment> getPaymentsByOrderId(int orderId) {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM Payments WHERE orderId = ? ORDER BY createdAt DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                payments.add(mapResultSetToPayment(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return payments;
    }
    
    /**
     * Map ResultSet to Payment object
     */
    private Payment mapResultSetToPayment(ResultSet rs) throws SQLException {
        Payment payment = new Payment();
        payment.setId(rs.getInt("id"));
        payment.setOrderId(rs.getInt("orderId"));
        payment.setPaymentCode(rs.getString("paymentCode"));
        payment.setAmount(rs.getDouble("amount"));
        payment.setPaymentMethod(rs.getString("paymentMethod"));
        payment.setPaymentStatus(rs.getString("paymentStatus"));
        payment.setTransactionId(rs.getString("transactionId"));
        
        Timestamp paymentDate = rs.getTimestamp("paymentDate");
        if (paymentDate != null) {
            payment.setPaymentDate(paymentDate.toLocalDateTime());
        }
        
        Timestamp createdAt = rs.getTimestamp("createdAt");
        if (createdAt != null) {
            payment.setCreatedAt(createdAt.toLocalDateTime());
        }
        
        return payment;
    }
    
    /**
     * Generate unique payment code
     */
    public String generatePaymentCode() {
        return "PAY" + System.currentTimeMillis();
    }
}
