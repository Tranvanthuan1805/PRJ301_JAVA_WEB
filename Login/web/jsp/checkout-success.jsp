<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt tour thành công - VietAir Travel</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vietair-style.css">
    <style>
        .success-container {
            max-width: 800px;
            margin: 60px auto;
            padding: 20px;
            text-align: center;
        }
        
        .success-icon {
            font-size: 80px;
            color: #27ae60;
            margin-bottom: 20px;
        }
        
        .success-title {
            font-size: 32px;
            color: #333;
            margin-bottom: 15px;
        }
        
        .success-message {
            font-size: 18px;
            color: #666;
            margin-bottom: 40px;
        }
        
        .order-info {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            text-align: left;
            margin-bottom: 30px;
        }
        
        .order-info h3 {
            margin: 0 0 20px 0;
            color: #333;
            font-size: 20px;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 10px;
        }
        
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .info-row:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: 600;
            color: #666;
        }
        
        .info-value {
            color: #333;
        }
        
        .order-code {
            font-size: 24px;
            font-weight: 700;
            color: #3498db;
        }
        
        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 600;
        }
        
        .status-success {
            background: #d1fae5;
            color: #065f46;
        }
        
        .status-warning {
            background: #fef3c7;
            color: #92400e;
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
        }
        
        .btn {
            padding: 12px 30px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 600;
            font-size: 16px;
            display: inline-block;
        }
        
        .btn-primary {
            background: #3498db;
            color: white;
        }
        
        .btn-secondary {
            background: #95a5a6;
            color: white;
        }
        
        .btn:hover {
            opacity: 0.9;
        }
        
        .tour-list {
            margin-top: 20px;
        }
        
        .tour-item {
            padding: 15px;
            background: #f8f9fa;
            border-radius: 4px;
            margin-bottom: 10px;
        }
        
        .tour-item-name {
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }
        
        .tour-item-details {
            font-size: 14px;
            color: #666;
        }
        
        .cash-payment-instructions {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 35px;
            border-radius: 12px;
            margin-bottom: 30px;
            border: 2px solid #2c5aa0;
            box-shadow: 0 4px 15px rgba(44, 90, 160, 0.15);
        }
        
        .cash-payment-instructions h3 {
            color: #2c5aa0;
            font-size: 24px;
            margin: 0 0 30px 0;
            text-align: center;
            font-weight: 700;
        }
        
        .cash-payment-instructions h3 i {
            margin-right: 10px;
        }
        
        .instruction-steps {
            margin-bottom: 25px;
        }
        
        .step-item {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
            align-items: flex-start;
        }
        
        .step-item:last-child {
            margin-bottom: 0;
        }
        
        .step-number {
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, #2c5aa0 0%, #1e4070 100%);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            font-weight: 700;
            flex-shrink: 0;
            box-shadow: 0 3px 10px rgba(44, 90, 160, 0.3);
        }
        
        .step-content {
            flex: 1;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        
        .step-content h4 {
            margin: 0 0 10px 0;
            color: #2c3e50;
            font-size: 18px;
            font-weight: 700;
        }
        
        .step-content p {
            margin: 0;
            color: #555;
            line-height: 1.6;
            font-size: 15px;
        }
        
        .order-code-highlight {
            color: #2c5aa0;
            font-size: 18px;
            font-weight: 700;
            background: #e3f2fd;
            padding: 2px 8px;
            border-radius: 4px;
        }
        
        .amount-highlight {
            color: #e74c3c;
            font-size: 18px;
            font-weight: 700;
        }
        
        .important-note {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 15px 20px;
            border-radius: 8px;
            color: #856404;
            font-size: 15px;
            line-height: 1.6;
        }
        
        .important-note i {
            margin-right: 8px;
            color: #ffc107;
        }
        
        .important-note strong {
            color: #856404;
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div class="success-icon">✅</div>
        <h1 class="success-title">Đặt tour thành công!</h1>
        <p class="success-message">
            Cảm ơn bạn đã đặt tour tại VietAir Travel. Chúng tôi đã nhận được đơn hàng của bạn.
        </p>
        
        <div class="order-info">
            <h3>Thông tin đơn hàng</h3>
            
            <div class="info-row">
                <span class="info-label">Mã đơn hàng:</span>
                <span class="order-code">${order.orderCode}</span>
            </div>
            
            <div class="info-row">
                <span class="info-label">Khách hàng:</span>
                <span class="info-value">${order.customerName}</span>
            </div>
            
            <div class="info-row">
                <span class="info-label">Email:</span>
                <span class="info-value">${order.customerEmail}</span>
            </div>
            
            <div class="info-row">
                <span class="info-label">Số điện thoại:</span>
                <span class="info-value">${order.customerPhone}</span>
            </div>
            
            <div class="info-row">
                <span class="info-label">Tổng tiền:</span>
                <span class="info-value" style="font-size: 20px; font-weight: 700; color: #e74c3c;">
                    <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/> ₫
                </span>
            </div>
            
            <div class="info-row">
                <span class="info-label">Trạng thái:</span>
                <span class="status-badge status-success">${order.statusBadge}</span>
            </div>
            
            <div class="info-row">
                <span class="info-label">Thanh toán:</span>
                <span class="status-badge status-success">${order.paymentStatusBadge}</span>
            </div>
            
            <c:if test="${not empty order.paymentMethod}">
                <div class="info-row">
                    <span class="info-label">Phương thức:</span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${order.paymentMethod == 'CASH'}">💵 Tiền mặt</c:when>
                            <c:when test="${order.paymentMethod == 'BANK_TRANSFER'}">🏦 Chuyển khoản</c:when>
                            <c:when test="${order.paymentMethod == 'CREDIT_CARD'}">💳 Thẻ tín dụng</c:when>
                            <c:when test="${order.paymentMethod == 'MOMO'}">📱 Ví MoMo</c:when>
                            <c:otherwise>${order.paymentMethod}</c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </c:if>
        </div>
        
        <div class="order-info">
            <h3>Danh sách tour đã đặt</h3>
            <div class="tour-list">
                <c:forEach var="item" items="${order.items}">
                    <div class="tour-item">
                        <div class="tour-item-name">${item.tourName}</div>
                        <div class="tour-item-details">
                            Số lượng: ${item.quantity} × 
                            <fmt:formatNumber value="${item.tourPrice}" type="number" groupingUsed="true"/> ₫
                            = <fmt:formatNumber value="${item.subtotal}" type="number" groupingUsed="true"/> ₫
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        
        <c:if test="${order.paymentMethod == 'CASH'}">
            <div class="cash-payment-instructions">
                <h3><i class="fas fa-hand-holding-usd"></i> Hướng dẫn thanh toán khi nhận tour</h3>
                <div class="instruction-steps">
                    <div class="step-item">
                        <div class="step-number">1</div>
                        <div class="step-content">
                            <h4>Xác nhận đơn hàng</h4>
                            <p>Nhân viên VietAir sẽ liên hệ với bạn qua số điện thoại <strong>${order.customerPhone}</strong> trong vòng 24 giờ để xác nhận thông tin tour.</p>
                        </div>
                    </div>
                    <div class="step-item">
                        <div class="step-number">2</div>
                        <div class="step-content">
                            <h4>Chuẩn bị giấy tờ</h4>
                            <p>Vui lòng mang theo CMND/CCCD và mã đơn hàng <strong class="order-code-highlight">${order.orderCode}</strong> khi đến nhận tour.</p>
                        </div>
                    </div>
                    <div class="step-item">
                        <div class="step-number">3</div>
                        <div class="step-content">
                            <h4>Thanh toán</h4>
                            <p>Thanh toán trực tiếp tại quầy VietAir hoặc cho hướng dẫn viên khi bắt đầu tour. Số tiền cần thanh toán: <strong class="amount-highlight"><fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/> ₫</strong></p>
                        </div>
                    </div>
                </div>
                <div class="important-note">
                    <i class="fas fa-exclamation-circle"></i>
                    <strong>Lưu ý quan trọng:</strong> Nếu không thể tham gia tour, vui lòng thông báo trước ít nhất 48 giờ để được hỗ trợ hoàn/đổi tour.
                </div>
            </div>
        </c:if>
        
        <div style="background: #e3f2fd; padding: 20px; border-radius: 8px; margin-bottom: 30px;">
            <p style="margin: 0; color: #1565c0; font-size: 16px;">
                📧 Chúng tôi đã gửi email xác nhận đến <strong>${order.customerEmail}</strong>
            </p>
            <p style="margin: 10px 0 0 0; color: #666; font-size: 14px;">
                Vui lòng kiểm tra hộp thư để xem chi tiết đơn hàng.
            </p>
        </div>
        
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/orders" class="btn btn-primary">
                Xem đơn hàng của tôi
            </a>
            <a href="${pageContext.request.contextPath}/tours" class="btn btn-secondary">
                Tiếp tục mua sắm
            </a>
        </div>
    </div>
</body>
</html>
