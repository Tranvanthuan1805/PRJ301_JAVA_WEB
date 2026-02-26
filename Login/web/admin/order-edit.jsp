<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="model.Order" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    
    if (!"ADMIN".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    Order order = (Order) request.getAttribute("order");
    if (order == null) {
        response.sendRedirect(request.getContextPath() + "/admin/orders");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa Đơn hàng - VietAir Admin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/vietair-style.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: #f5f7fa;
        }
        
        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        
        .card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            padding: 2rem;
        }
        
        .card-header {
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .card-header h1 {
            font-size: 24px;
            color: #1f2937;
            margin-bottom: 0.5rem;
        }
        
        .order-code {
            font-size: 14px;
            color: #6b7280;
        }
        
        .order-code strong {
            color: var(--primary-color);
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            color: #374151;
            margin-bottom: 0.5rem;
        }
        
        .form-label.required::after {
            content: " *";
            color: #ef4444;
        }
        
        .form-input {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.2s;
        }
        
        .form-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }
        
        .form-input:disabled {
            background: #f9fafb;
            color: #9ca3af;
            cursor: not-allowed;
        }
        
        textarea.form-input {
            min-height: 100px;
            resize: vertical;
        }
        
        .form-actions {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e5e7eb;
        }
        
        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-primary {
            background: var(--primary-color);
            color: white;
            border: none;
        }
        
        .btn-primary:hover {
            background: #2563eb;
        }
        
        .btn-secondary {
            background: white;
            color: #374151;
            border: 1px solid #d1d5db;
        }
        
        .btn-secondary:hover {
            background: #f9fafb;
        }
        
        .info-box {
            background: #eff6ff;
            border: 1px solid #bfdbfe;
            border-radius: 6px;
            padding: 1rem;
            margin-bottom: 1.5rem;
        }
        
        .info-box p {
            font-size: 14px;
            color: #1e40af;
            margin: 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                <h1>Chỉnh sửa Đơn hàng</h1>
                <p class="order-code">Mã đơn: <strong><%= order.getOrderCode() %></strong></p>
            </div>
            
            <div class="info-box">
                <p><i class="fas fa-info-circle"></i> Mã vé không thể thay đổi. Bạn chỉ có thể cập nhật thông tin khách hàng và ghi chú.</p>
            </div>
            
            <form method="POST" action="<%= request.getContextPath() %>/admin/orders">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="orderId" value="<%= order.getId() %>">
                
                <div class="form-group">
                    <label class="form-label required">Tên khách hàng</label>
                    <input type="text" name="customerName" class="form-input" 
                           value="<%= order.getCustomerName() %>" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label required">Email</label>
                    <input type="email" name="customerEmail" class="form-input" 
                           value="<%= order.getCustomerEmail() %>" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label required">Số điện thoại</label>
                    <input type="tel" name="customerPhone" class="form-input" 
                           value="<%= order.getCustomerPhone() %>" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Địa chỉ</label>
                    <input type="text" name="customerAddress" class="form-input" 
                           value="<%= order.getCustomerAddress() != null ? order.getCustomerAddress() : "" %>">
                </div>
                
                <div class="form-group">
                    <label class="form-label required">Trạng thái đơn hàng</label>
                    <select name="status" class="form-input" required>
                        <option value="PENDING" <%= "PENDING".equals(order.getStatus()) ? "selected" : "" %>>Chờ xử lý</option>
                        <option value="CONFIRMED" <%= "CONFIRMED".equals(order.getStatus()) ? "selected" : "" %>>Đã xác nhận</option>
                        <option value="COMPLETED" <%= "COMPLETED".equals(order.getStatus()) ? "selected" : "" %>>Hoàn thành</option>
                        <option value="CANCELLED" <%= "CANCELLED".equals(order.getStatus()) ? "selected" : "" %>>Đã hủy</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label class="form-label required">Trạng thái thanh toán</label>
                    <select name="paymentStatus" class="form-input" required>
                        <option value="UNPAID" <%= "UNPAID".equals(order.getPaymentStatus()) ? "selected" : "" %>>Chưa thanh toán</option>
                        <option value="PAID" <%= "PAID".equals(order.getPaymentStatus()) ? "selected" : "" %>>Đã thanh toán</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Phương thức thanh toán</label>
                    <select name="paymentMethod" class="form-input">
                        <option value="">-- Chọn phương thức --</option>
                        <option value="CASH" <%= "CASH".equals(order.getPaymentMethod()) ? "selected" : "" %>>Tiền mặt</option>
                        <option value="BANK_TRANSFER" <%= "BANK_TRANSFER".equals(order.getPaymentMethod()) ? "selected" : "" %>>Chuyển khoản</option>
                        <option value="CREDIT_CARD" <%= "CREDIT_CARD".equals(order.getPaymentMethod()) ? "selected" : "" %>>Thẻ tín dụng</option>
                        <option value="MOMO" <%= "MOMO".equals(order.getPaymentMethod()) ? "selected" : "" %>>MoMo</option>
                        <option value="VNPAY" <%= "VNPAY".equals(order.getPaymentMethod()) ? "selected" : "" %>>VNPay</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Ghi chú</label>
                    <textarea name="notes" class="form-input"><%= order.getNotes() != null ? order.getNotes() : "" %></textarea>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i>
                        Lưu thay đổi
                    </button>
                    <a href="<%= request.getContextPath() %>/admin/orders" class="btn btn-secondary">
                        <i class="fas fa-times"></i>
                        Hủy
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
