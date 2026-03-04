<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán | eztravel</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box}
        body{font-family:'Inter',sans-serif;background:#0F172A;color:#E2E8F0;min-height:100vh;padding-top:100px}
        .container{max-width:1200px;margin:0 auto;padding:40px 24px}
        
        /* Steps */
        .checkout-steps{display:flex;justify-content:center;gap:40px;margin-bottom:40px;position:relative}
        .checkout-steps::before{content:'';position:absolute;top:20px;left:25%;right:25%;height:2px;background:rgba(255,255,255,.1);z-index:0}
        .step{display:flex;flex-direction:column;align-items:center;gap:12px;position:relative;z-index:1}
        .step-circle{width:44px;height:44px;border-radius:50%;background:rgba(255,255,255,.06);border:2px solid rgba(255,255,255,.2);display:flex;align-items:center;justify-content:center;font-weight:700;transition:.3s}
        .step.active .step-circle{background:linear-gradient(135deg,#3B82F6,#2563EB);border-color:#3B82F6;box-shadow:0 4px 12px rgba(59,130,246,.4)}
        .step.completed .step-circle{background:linear-gradient(135deg,#10B981,#059669);border-color:#10B981}
        .step-label{font-size:.85rem;color:rgba(255,255,255,.5);font-weight:600}
        .step.active .step-label{color:#fff}
        
        /* Layout */
        .checkout-layout{display:grid;grid-template-columns:1.5fr 1fr;gap:32px}
        
        /* Card */
        .card{background:linear-gradient(135deg,rgba(255,255,255,.05),rgba(255,255,255,.02));border:1px solid rgba(255,255,255,.1);border-radius:20px;padding:32px;backdrop-filter:blur(10px)}
        .card-title{font-size:1.4rem;font-weight:800;color:#fff;margin-bottom:24px;display:flex;align-items:center;gap:12px}
        .card-title i{color:#60A5FA}
        
        /* Form */
        .form-group{margin-bottom:24px}
        .form-label{display:block;font-size:.9rem;color:rgba(255,255,255,.7);margin-bottom:10px;font-weight:700}
        .form-label i{color:#60A5FA;margin-right:6px}
        .form-input{width:100%;padding:14px 16px;background:rgba(255,255,255,.06);border:2px solid rgba(255,255,255,.15);border-radius:12px;color:#fff;font-size:1rem;transition:all .3s}
        .form-input:focus{outline:none;border-color:#3B82F6;background:rgba(59,130,246,.1)}
        .form-textarea{min-height:100px;resize:vertical;font-family:inherit}
        
        /* Payment Methods */
        .payment-methods{display:grid;grid-template-columns:1fr 1fr;gap:16px;margin-bottom:24px}
        .payment-method{position:relative}
        .payment-method input[type="radio"]{position:absolute;opacity:0}
        .payment-method label{display:flex;flex-direction:column;align-items:center;gap:12px;padding:20px;background:rgba(255,255,255,.04);border:2px solid rgba(255,255,255,.1);border-radius:16px;cursor:pointer;transition:all .3s}
        .payment-method input:checked + label{background:linear-gradient(135deg,rgba(59,130,246,.15),rgba(59,130,246,.08));border-color:#3B82F6;box-shadow:0 4px 16px rgba(59,130,246,.3)}
        .payment-icon{font-size:2rem;color:#60A5FA}
        .payment-name{font-weight:700;color:#fff;font-size:.95rem}
        
        /* Payment Instructions */
        .payment-instructions{display:none;padding:20px;background:rgba(59,130,246,.1);border:1px solid rgba(59,130,246,.3);border-radius:12px;margin-top:20px}
        .payment-instructions.active{display:block;animation:slideDown .3s ease}
        .payment-instructions h4{color:#60A5FA;margin-bottom:12px;font-size:1.1rem}
        .payment-instructions ol{margin-left:20px;color:rgba(255,255,255,.8);line-height:1.8}
        
        /* Order Summary */
        .order-item{display:flex;gap:16px;padding:16px;background:rgba(255,255,255,.02);border:1px solid rgba(255,255,255,.06);border-radius:12px;margin-bottom:12px}
        .order-item-image{width:80px;height:60px;border-radius:8px;background:linear-gradient(135deg,#667eea,#764ba2)}
        .order-item-info{flex:1}
        .order-item-name{font-weight:700;color:#fff;margin-bottom:6px}
        .order-item-meta{font-size:.85rem;color:rgba(255,255,255,.6)}
        .order-item-price{text-align:right}
        .order-item-quantity{font-size:.85rem;color:rgba(255,255,255,.6);margin-bottom:6px}
        .order-item-total{font-weight:700;color:#34D399;font-size:1.1rem}
        
        .order-total{display:flex;justify-content:space-between;align-items:center;padding-top:20px;margin-top:20px;border-top:2px solid rgba(255,255,255,.1)}
        .order-total-label{font-size:1.2rem;font-weight:700;color:#fff}
        .order-total-value{font-size:2rem;font-weight:900;background:linear-gradient(135deg,#34D399,#10B981);-webkit-background-clip:text;-webkit-text-fill-color:transparent}
        
        /* Button */
        .btn{padding:16px 32px;border:none;border-radius:12px;font-weight:800;font-size:1.05rem;cursor:pointer;transition:all .3s;display:inline-flex;align-items:center;justify-content:center;gap:10px;width:100%}
        .btn-primary{background:linear-gradient(135deg,#2563EB,#3B82F6);color:#fff;box-shadow:0 4px 15px rgba(37,99,235,.4)}
        .btn-primary:hover{transform:translateY(-3px);box-shadow:0 8px 25px rgba(37,99,235,.5)}
        .btn-secondary{background:rgba(255,255,255,.08);color:#fff;border:1px solid rgba(255,255,255,.2);margin-top:12px}
        .btn-secondary:hover{background:rgba(255,255,255,.12)}
        
        @keyframes slideDown{from{opacity:0;transform:translateY(-10px)}to{opacity:1;transform:translateY(0)}}
        
        @media (max-width: 768px) {
            .checkout-layout{grid-template-columns:1fr}
            .payment-methods{grid-template-columns:1fr}
        }
    </style>
</head>
<body>
    <jsp:include page="/common/_header.jsp" />
    
    <div class="container">
        <!-- Steps -->
        <div class="checkout-steps">
            <div class="step completed">
                <div class="step-circle"><i class="fas fa-shopping-cart"></i></div>
                <div class="step-label">Giỏ hàng</div>
            </div>
            <div class="step active">
                <div class="step-circle">2</div>
                <div class="step-label">Thanh toán</div>
            </div>
            <div class="step">
                <div class="step-circle">3</div>
                <div class="step-label">Hoàn tất</div>
            </div>
        </div>
        
        <div class="checkout-layout">
            <!-- Left: Customer Info & Payment -->
            <div>
                <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm">
                    <!-- Customer Info -->
                    <div class="card">
                        <h2 class="card-title">
                            <i class="fas fa-user"></i>
                            Thông tin khách hàng
                        </h2>
                        
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-user"></i>
                                Họ và tên *
                            </label>
                            <input type="text" name="fullName" class="form-input" value="${user.username}" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-envelope"></i>
                                Email
                            </label>
                            <input type="email" name="email" class="form-input" value="${not empty user.email ? user.email : ''}" placeholder="email@example.com">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-phone"></i>
                                Số điện thoại *
                            </label>
                            <input type="tel" name="phone" class="form-input" placeholder="0335111783" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-map-marker-alt"></i>
                                Địa chỉ
                            </label>
                            <input type="text" name="address" class="form-input" placeholder="123 Đường ABC, Quận XYZ, Đà Nẵng">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-comment"></i>
                                Ghi chú
                            </label>
                            <textarea name="note" class="form-input form-textarea" placeholder="Yêu cầu đặc biệt, ghi chú thêm..."></textarea>
                        </div>
                    </div>
                    
                    <!-- Payment Method -->
                    <div class="card" style="margin-top:24px">
                        <h2 class="card-title">
                            <i class="fas fa-credit-card"></i>
                            Phương thức thanh toán
                        </h2>
                        
                        <div class="payment-methods">
                            <div class="payment-method">
                                <input type="radio" name="paymentMethod" id="cash" value="CASH" checked>
                                <label for="cash">
                                    <i class="fas fa-money-bill-wave payment-icon"></i>
                                    <span class="payment-name">Thanh toán khi nhận tour</span>
                                </label>
                            </div>
                            
                            <div class="payment-method">
                                <input type="radio" name="paymentMethod" id="bank" value="BANK">
                                <label for="bank">
                                    <i class="fas fa-university payment-icon"></i>
                                    <span class="payment-name">Chuyển khoản ngân hàng</span>
                                </label>
                            </div>
                            
                            <div class="payment-method">
                                <input type="radio" name="paymentMethod" id="momo" value="MOMO">
                                <label for="momo">
                                    <i class="fas fa-wallet payment-icon"></i>
                                    <span class="payment-name">Ví điện tử MoMo</span>
                                </label>
                            </div>
                            
                            <div class="payment-method">
                                <input type="radio" name="paymentMethod" id="card" value="CARD">
                                <label for="card">
                                    <i class="fas fa-credit-card payment-icon"></i>
                                    <span class="payment-name">Thẻ tín dụng</span>
                                </label>
                            </div>
                        </div>
                        
                        <!-- Payment Instructions -->
                        <div id="cashInstructions" class="payment-instructions active">
                            <h4><i class="fas fa-info-circle"></i> Hướng dẫn thanh toán tiền mặt</h4>
                            <ol>
                                <li>Nhấn nút "Đặt hàng" để xác nhận đơn hàng</li>
                                <li>Nhân viên sẽ liên hệ xác nhận trong 24h</li>
                                <li>Thanh toán tiền mặt khi nhận tour</li>
                            </ol>
                        </div>
                        
                        <div id="bankInstructions" class="payment-instructions">
                            <h4><i class="fas fa-info-circle"></i> Hướng dẫn chuyển khoản</h4>
                            <ol>
                                <li>Ngân hàng: <strong>Vietcombank</strong></li>
                                <li>Số tài khoản: <strong>1234567890</strong></li>
                                <li>Chủ tài khoản: <strong>CONG TY EZTRAVEL</strong></li>
                                <li>Nội dung: <strong>THANHTOAN [Mã đơn hàng]</strong></li>
                                <li>Sau khi chuyển khoản, vui lòng gửi ảnh chụp màn hình</li>
                            </ol>
                        </div>
                        
                        <div id="momoInstructions" class="payment-instructions">
                            <h4><i class="fas fa-info-circle"></i> Hướng dẫn thanh toán MoMo</h4>
                            <ol>
                                <li>Mở ứng dụng MoMo</li>
                                <li>Quét mã QR hoặc nhập số điện thoại: <strong>0335111783</strong></li>
                                <li>Nhập số tiền và nội dung: <strong>THANHTOAN [Mã đơn hàng]</strong></li>
                                <li>Xác nhận thanh toán</li>
                            </ol>
                        </div>
                        
                        <div id="cardInstructions" class="payment-instructions">
                            <h4><i class="fas fa-info-circle"></i> Hướng dẫn thanh toán thẻ</h4>
                            <ol>
                                <li>Nhập thông tin thẻ tín dụng/ghi nợ</li>
                                <li>Xác thực OTP từ ngân hàng</li>
                                <li>Hoàn tất thanh toán</li>
                            </ol>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-primary" style="margin-top:24px">
                        <i class="fas fa-check-circle"></i>
                        <span>Đặt hàng ngay</span>
                    </button>
                    
                    <a href="${pageContext.request.contextPath}/cart" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        <span>Quay lại giỏ hàng</span>
                    </a>
                </form>
            </div>
            
            <!-- Right: Order Summary -->
            <div>
                <div class="card">
                    <h2 class="card-title">
                        <i class="fas fa-receipt"></i>
                        Đơn hàng của bạn
                    </h2>
                    
                    <c:forEach var="entry" items="${cartItems}">
                        <c:set var="tour" value="${entry.key}"/>
                        <c:set var="quantity" value="${entry.value}"/>
                        
                        <div class="order-item">
                            <div class="order-item-image"></div>
                            <div class="order-item-info">
                                <div class="order-item-name">${tour.name}</div>
                                <div class="order-item-meta">
                                    <i class="fas fa-map-marker-alt"></i> ${tour.destination}
                                </div>
                            </div>
                            <div class="order-item-price">
                                <div class="order-item-quantity">${quantity} người</div>
                                <div class="order-item-total">
                                    <fmt:formatNumber value="${tour.price * quantity}" pattern="#,###"/> đ
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <div class="order-total">
                        <span class="order-total-label">Tổng cộng:</span>
                        <span class="order-total-value">
                            <fmt:formatNumber value="${grandTotal}" pattern="#,###"/> đ
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // Toggle payment instructions
        const paymentMethods = document.querySelectorAll('input[name="paymentMethod"]');
        const instructions = {
            'CASH': document.getElementById('cashInstructions'),
            'BANK': document.getElementById('bankInstructions'),
            'MOMO': document.getElementById('momoInstructions'),
            'CARD': document.getElementById('cardInstructions')
        };
        
        paymentMethods.forEach(method => {
            method.addEventListener('change', function() {
                // Hide all instructions
                Object.values(instructions).forEach(inst => inst.classList.remove('active'));
                // Show selected instruction
                instructions[this.value].classList.add('active');
            });
        });
    </script>
</body>
</html>
