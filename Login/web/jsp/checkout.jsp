<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán - VietAir Travel</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vietair-style.css">
    <style>
        body {
            background: linear-gradient(135deg, #2c5aa0 0%, #1e4070 100%);
            min-height: 100vh;
            padding: 40px 0;
        }
        
        .checkout-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .checkout-header {
            text-align: center;
            margin-bottom: 40px;
            color: white;
        }
        
        .checkout-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .progress-steps {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }
        
        .step {
            display: flex;
            align-items: center;
            gap: 10px;
            color: rgba(255,255,255,0.6);
            font-weight: 600;
        }
        
        .step.active {
            color: white;
        }
        
        .step-number {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: rgba(255,255,255,0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
        }
        
        .step.active .step-number {
            background: white;
            color: #2c5aa0;
        }
        
        .checkout-grid {
            display: grid;
            grid-template-columns: 1.5fr 1fr;
            gap: 30px;
        }
        
        .checkout-card {
            background: white;
            border-radius: 16px;
            padding: 35px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
        }
        
        .card-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .card-title i {
            color: #2c5aa0;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #2c3e50;
            font-size: 0.95rem;
        }
        
        .form-group label .required {
            color: #e74c3c;
        }
        
        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s;
            font-family: inherit;
        }
        
        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #2c5aa0;
            box-shadow: 0 0 0 3px rgba(44, 90, 160, 0.1);
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }
        
        .payment-section {
            margin-top: 35px;
        }
        
        .payment-methods {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-top: 15px;
        }
        
        .payment-method {
            position: relative;
        }
        
        .payment-method input[type="radio"] {
            position: absolute;
            opacity: 0;
        }
        
        .payment-method label {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 16px;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: 600;
            color: #2c3e50;
        }
        
        .payment-method label i {
            font-size: 1.5rem;
        }
        
        .payment-method input[type="radio"]:checked + label {
            border-color: #2c5aa0;
            background: linear-gradient(135deg, rgba(44, 90, 160, 0.1), rgba(30, 64, 112, 0.1));
            color: #2c5aa0;
        }
        
        .payment-method:hover label {
            border-color: #2c5aa0;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(44, 90, 160, 0.2);
        }
        
        .payment-info {
            display: none;
            margin-top: 20px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 12px;
            border-left: 4px solid #2c5aa0;
        }
        
        .payment-info.active {
            display: block;
            animation: slideDown 0.3s ease;
        }
        
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .payment-info h4 {
            color: #2c5aa0;
            margin-bottom: 15px;
            font-size: 1.1rem;
        }
        
        .payment-info p {
            color: #555;
            line-height: 1.6;
            margin-bottom: 10px;
        }
        
        .payment-info strong {
            color: #2c3e50;
        }
        
        .order-summary {
            position: sticky;
            top: 20px;
        }
        
        .tour-item {
            padding: 20px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .tour-item:last-child {
            border-bottom: none;
        }
        
        .tour-name {
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 8px;
            font-size: 1.05rem;
        }
        
        .tour-details {
            font-size: 0.9rem;
            color: #7f8c8d;
            margin-bottom: 4px;
        }
        
        .tour-subtotal {
            font-weight: 600;
            color: #2c5aa0;
            margin-top: 8px;
            font-size: 1.05rem;
        }
        
        .summary-divider {
            height: 2px;
            background: linear-gradient(90deg, #2c5aa0, #1e4070);
            margin: 25px 0;
        }
        
        .summary-total {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 1.5rem;
            font-weight: 700;
            color: #2c3e50;
            padding: 20px;
            background: linear-gradient(135deg, rgba(44, 90, 160, 0.1), rgba(30, 64, 112, 0.1));
            border-radius: 12px;
        }
        
        .summary-total .amount {
            color: #e74c3c;
        }
        
        .btn-checkout {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, #2c5aa0 0%, #1e4070 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            margin-top: 25px;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .btn-checkout:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(44, 90, 160, 0.4);
        }
        
        .btn-back {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #2c5aa0;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-back:hover {
            color: #1e4070;
        }
        
        .alert {
            padding: 16px 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 500;
        }
        
        .alert-error {
            background: #fee2e2;
            color: #991b1b;
            border-left: 4px solid #ef4444;
        }
        
        @media (max-width: 968px) {
            .checkout-grid {
                grid-template-columns: 1fr;
            }
            
            .order-summary {
                position: static;
            }
            
            .payment-methods {
                grid-template-columns: 1fr;
            }
            
            .checkout-header h1 {
                font-size: 2rem;
            }
            
            .progress-steps {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>
    <div class="checkout-container">
        <div class="checkout-header">
            <h1><i class="fas fa-shopping-cart"></i> Thanh toán</h1>
            <div class="progress-steps">
                <div class="step">
                    <div class="step-number">1</div>
                    <span>Giỏ hàng</span>
                </div>
                <div class="step active">
                    <div class="step-number">2</div>
                    <span>Thanh toán</span>
                </div>
                <div class="step">
                    <div class="step-number">3</div>
                    <span>Hoàn tất</span>
                </div>
            </div>
        </div>
        
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                ${sessionScope.error}
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>
        
        <div class="checkout-grid">
            <div class="checkout-card">
                <h2 class="card-title">
                    <i class="fas fa-user-circle"></i>
                    Thông tin khách hàng
                </h2>
                
                <form action="${pageContext.request.contextPath}/checkout" method="post">
                    <c:if test="${isBuyNow}">
                        <input type="hidden" name="buyNowTourId" value="${buyNowTourId}">
                        <input type="hidden" name="buyNowQuantity" value="${buyNowQuantity}">
                    </c:if>
                    
                    <div class="form-group">
                        <label>Họ và tên <span class="required">*</span></label>
                        <input type="text" name="customerName" required 
                               value="${user.username}" placeholder="Nguyễn Văn A">
                    </div>
                    
                    <div class="form-group">
                        <label>Email <span class="required">*</span></label>
                        <input type="email" name="customerEmail" required 
                               placeholder="example@email.com">
                    </div>
                    
                    <div class="form-group">
                        <label>Số điện thoại <span class="required">*</span></label>
                        <input type="tel" name="customerPhone" required 
                               pattern="[0-9]{10,11}" placeholder="0901234567">
                    </div>
                    
                    <div class="form-group">
                        <label>Địa chỉ</label>
                        <input type="text" name="customerAddress" 
                               placeholder="123 Đường ABC, Quận XYZ, Đà Nẵng">
                    </div>
                    
                    <div class="form-group">
                        <label>Ghi chú</label>
                        <textarea name="notes" placeholder="Yêu cầu đặc biệt, ghi chú thêm..."></textarea>
                    </div>
                    
                    <div class="payment-section">
                        <h2 class="card-title">
                            <i class="fas fa-credit-card"></i>
                            Phương thức thanh toán
                        </h2>
                        
                        <div class="payment-methods">
                            <div class="payment-method">
                                <input type="radio" name="paymentMethod" value="CASH" id="cash" checked>
                                <label for="cash">
                                    <i class="fas fa-hand-holding-usd"></i>
                                    Thanh toán khi nhận tour
                                </label>
                            </div>
                            
                            <div class="payment-method">
                                <input type="radio" name="paymentMethod" value="BANK_TRANSFER" id="bank">
                                <label for="bank">
                                    <i class="fas fa-university"></i>
                                    Chuyển khoản ngân hàng
                                </label>
                            </div>
                            
                            <div class="payment-method">
                                <input type="radio" name="paymentMethod" value="CREDIT_CARD" id="card">
                                <label for="card">
                                    <i class="fas fa-credit-card"></i>
                                    Thẻ tín dụng/ghi nợ
                                </label>
                            </div>
                            
                            <div class="payment-method">
                                <input type="radio" name="paymentMethod" value="MOMO" id="momo">
                                <label for="momo">
                                    <i class="fas fa-wallet"></i>
                                    Ví điện tử MoMo
                                </label>
                            </div>
                        </div>
                        
                        <!-- Payment Instructions -->
                        <div id="cashInfo" class="payment-info active">
                            <h4><i class="fas fa-info-circle"></i> Hướng dẫn thanh toán khi nhận tour</h4>
                            <p><strong>Bước 1:</strong> Hoàn tất đặt tour trên hệ thống</p>
                            <p><strong>Bước 2:</strong> Nhân viên VietAir sẽ liên hệ xác nhận thông tin trong vòng 24h</p>
                            <p><strong>Bước 3:</strong> Thanh toán trực tiếp tại quầy hoặc cho hướng dẫn viên khi bắt đầu tour</p>
                            <p style="color: #e74c3c; font-weight: 600; margin-top: 15px;">
                                <i class="fas fa-exclamation-triangle"></i> Lưu ý: Vui lòng mang theo CMND/CCCD khi nhận tour
                            </p>
                        </div>
                        
                        <div id="bankInfo" class="payment-info">
                            <h4><i class="fas fa-info-circle"></i> Thông tin chuyển khoản</h4>
                            <p><strong>Ngân hàng:</strong> Vietcombank - Chi nhánh Đà Nẵng</p>
                            <p><strong>Số tài khoản:</strong> 0123456789</p>
                            <p><strong>Chủ tài khoản:</strong> CÔNG TY TNHH VIETAIR TRAVEL</p>
                            <p><strong>Nội dung:</strong> [Họ tên] - [Số điện thoại] - Dat tour</p>
                            <p style="color: #e74c3c; font-weight: 600; margin-top: 15px;">
                                <i class="fas fa-exclamation-triangle"></i> Vui lòng chuyển khoản trong vòng 24h để giữ chỗ
                            </p>
                        </div>
                        
                        <div id="cardInfo" class="payment-info">
                            <h4><i class="fas fa-info-circle"></i> Thanh toán bằng thẻ</h4>
                            <p><strong>Bước 1:</strong> Nhấn "Xác nhận đặt tour" để chuyển đến cổng thanh toán</p>
                            <p><strong>Bước 2:</strong> Nhập thông tin thẻ tín dụng/ghi nợ</p>
                            <p><strong>Bước 3:</strong> Xác thực OTP từ ngân hàng</p>
                            <p style="margin-top: 15px;">
                                <i class="fas fa-shield-alt"></i> Giao dịch được bảo mật bởi chuẩn PCI DSS
                            </p>
                        </div>
                        
                        <div id="momoInfo" class="payment-info">
                            <h4><i class="fas fa-info-circle"></i> Thanh toán qua MoMo</h4>
                            <p><strong>Bước 1:</strong> Nhấn "Xác nhận đặt tour" để tạo mã QR</p>
                            <p><strong>Bước 2:</strong> Mở ứng dụng MoMo và quét mã QR</p>
                            <p><strong>Bước 3:</strong> Xác nhận thanh toán trên ứng dụng</p>
                            <p style="margin-top: 15px;">
                                <i class="fas fa-mobile-alt"></i> Hỗ trợ thanh toán nhanh chóng và an toàn
                            </p>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn-checkout">
                        <i class="fas fa-check-circle"></i>
                        Xác nhận đặt tour
                    </button>
                </form>
            </div>
            
            <div class="order-summary">
                <div class="checkout-card">
                    <h2 class="card-title">
                        <i class="fas fa-receipt"></i>
                        Đơn hàng của bạn
                    </h2>
                    
                    <c:forEach var="item" items="${cartItems}">
                        <div class="tour-item">
                            <div class="tour-name">${item.tour.name}</div>
                            <div class="tour-details">
                                <i class="fas fa-map-marker-alt"></i> ${item.tour.destination}
                            </div>
                            <div class="tour-details">
                                <i class="fas fa-users"></i> Số lượng: ${item.quantity} người
                            </div>
                            <div class="tour-details">
                                <i class="fas fa-tag"></i> 
                                <fmt:formatNumber value="${item.tour.price}" type="number" groupingUsed="true"/> ₫ / người
                            </div>
                            <div class="tour-subtotal">
                                <fmt:formatNumber value="${item.subtotal}" type="number" groupingUsed="true"/> ₫
                            </div>
                        </div>
                    </c:forEach>
                    
                    <div class="summary-divider"></div>
                    
                    <div class="summary-total">
                        <span>Tổng cộng:</span>
                        <span class="amount">
                            <fmt:formatNumber value="${cartTotal}" type="number" groupingUsed="true"/> ₫
                        </span>
                    </div>
                    
                    <a href="${pageContext.request.contextPath}/cart" class="btn-back">
                        <i class="fas fa-arrow-left"></i> Quay lại giỏ hàng
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // Toggle payment info sections based on selected payment method
        document.addEventListener('DOMContentLoaded', function() {
            const paymentRadios = document.querySelectorAll('input[name="paymentMethod"]');
            const paymentInfos = {
                'CASH': document.getElementById('cashInfo'),
                'BANK_TRANSFER': document.getElementById('bankInfo'),
                'CREDIT_CARD': document.getElementById('cardInfo'),
                'MOMO': document.getElementById('momoInfo')
            };
            
            paymentRadios.forEach(radio => {
                radio.addEventListener('change', function() {
                    // Hide all payment info sections
                    Object.values(paymentInfos).forEach(info => {
                        info.classList.remove('active');
                    });
                    
                    // Show the selected payment info
                    if (paymentInfos[this.value]) {
                        paymentInfos[this.value].classList.add('active');
                    }
                });
            });
        });
    </script>
</body>
</html>
