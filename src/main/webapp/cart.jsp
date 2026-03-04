<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng | eztravel</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box}
        body{font-family:'Inter',sans-serif;background:#0F172A;color:#E2E8F0;min-height:100vh}
        .container{max-width:1200px;margin:0 auto;padding:40px 24px}
        
        .page-header{text-align:center;margin-bottom:40px;animation:fadeInDown 0.6s ease}
        .page-header h1{font-size:2.5rem;font-weight:800;color:#fff;margin-bottom:12px}
        .page-header h1 i{color:#60A5FA;margin-right:12px}
        .page-header p{color:rgba(255,255,255,.6);font-size:1.1rem}
        
        .cart-empty{text-align:center;padding:80px 20px;background:rgba(255,255,255,.02);border:1px solid rgba(255,255,255,.06);border-radius:16px;animation:fadeIn 0.6s ease}
        .cart-empty i{font-size:5rem;color:rgba(255,255,255,.2);margin-bottom:24px;animation:bounce 2s infinite}
        .cart-empty h2{font-size:1.8rem;color:#fff;margin-bottom:12px}
        .cart-empty p{color:rgba(255,255,255,.5);margin-bottom:32px}
        
        .btn{padding:12px 28px;border:none;border-radius:10px;font-size:1rem;font-weight:700;cursor:pointer;transition:all 0.3s;text-decoration:none;display:inline-block}
        .btn-primary{background:linear-gradient(135deg,#2563EB,#3B82F6);color:#fff;box-shadow:0 4px 14px rgba(37,99,235,.3)}
        .btn-primary:hover{transform:translateY(-2px);box-shadow:0 6px 20px rgba(37,99,235,.4)}
        
        .message{padding:16px 24px;border-radius:10px;margin-bottom:24px;display:flex;align-items:center;gap:12px;animation:slideInRight 0.5s ease}
        .message.success{background:rgba(16,185,129,.1);border:1px solid rgba(16,185,129,.2);color:#34D399}
        .message.error{background:rgba(239,68,68,.1);border:1px solid rgba(239,68,68,.2);color:#F87171}
        
        /* Cart Items */
        .cart-container{background:rgba(255,255,255,.02);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:32px;animation:fadeIn 0.6s ease}
        .cart-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:32px;padding-bottom:24px;border-bottom:1px solid rgba(255,255,255,.1)}
        .cart-header h2{font-size:1.8rem;color:#fff;display:flex;align-items:center;gap:12px}
        .cart-count{background:rgba(96,165,250,.2);color:#60A5FA;padding:4px 12px;border-radius:20px;font-size:0.9rem;font-weight:600}
        
        .cart-item{background:linear-gradient(135deg,rgba(255,255,255,.05),rgba(255,255,255,.02));border:1px solid rgba(255,255,255,.1);border-radius:16px;padding:28px;margin-bottom:20px;display:grid;grid-template-columns:140px 1fr auto;gap:28px;align-items:center;transition:all 0.4s ease;animation:slideInUp 0.5s ease;position:relative;overflow:hidden}
        .cart-item::before{content:'';position:absolute;top:0;left:0;width:4px;height:100%;background:linear-gradient(135deg,#3B82F6,#10B981);opacity:0;transition:opacity .3s}
        .cart-item:hover{background:linear-gradient(135deg,rgba(255,255,255,.08),rgba(255,255,255,.04));border-color:rgba(96,165,250,.4);transform:translateY(-4px);box-shadow:0 12px 40px rgba(0,0,0,.3)}
        .cart-item:hover::before{opacity:1}
        
        .tour-image{width:140px;height:95px;border-radius:12px;object-fit:cover;background:linear-gradient(135deg,#667eea 0%,#764ba2 100%);box-shadow:0 4px 12px rgba(0,0,0,.3)}
        
        .tour-info{flex:1}
        .tour-name{font-size:1.3rem;color:#fff;margin-bottom:12px;font-weight:700;line-height:1.4}
        .tour-meta{display:flex;gap:20px;color:rgba(255,255,255,.6);font-size:0.92rem;flex-wrap:wrap}
        .tour-meta-item{display:flex;align-items:center;gap:6px}
        .tour-meta i{color:#60A5FA;font-size:.95rem}
        
        .tour-actions{text-align:right;display:flex;flex-direction:column;gap:16px;align-items:flex-end}
        .tour-price-section{text-align:right}
        .tour-price-label{font-size:.8rem;color:rgba(255,255,255,.5);text-transform:uppercase;letter-spacing:1px;margin-bottom:6px;font-weight:600}
        .tour-price{font-size:1.8rem;font-weight:900;background:linear-gradient(135deg,#34D399,#10B981);-webkit-background-clip:text;-webkit-text-fill-color:transparent;line-height:1.2}
        
        .quantity-controls{display:flex;gap:10px;align-items:center}
        .qty-btn{width:40px;height:40px;border:none;background:rgba(255,255,255,.08);color:#fff;border-radius:10px;cursor:pointer;transition:all 0.3s;display:flex;align-items:center;justify-content:center;font-size:1rem;font-weight:700}
        .qty-btn:hover{background:linear-gradient(135deg,#3B82F6,#2563EB);color:#fff;transform:scale(1.15);box-shadow:0 4px 12px rgba(59,130,246,.4)}
        .qty-btn:active{transform:scale(1.05)}
        .qty-display{min-width:60px;height:40px;background:rgba(255,255,255,.06);border:2px solid rgba(255,255,255,.15);border-radius:10px;display:flex;align-items:center;justify-content:center;color:#fff;font-weight:800;font-size:1.1rem}
        
        .btn-remove{padding:10px 20px;background:linear-gradient(135deg,rgba(239,68,68,.15),rgba(239,68,68,.1));color:#F87171;border:1px solid rgba(239,68,68,.3);border-radius:10px;cursor:pointer;transition:all 0.3s;font-size:0.9rem;font-weight:700;display:inline-flex;align-items:center;gap:8px}
        .btn-remove:hover{background:linear-gradient(135deg,rgba(239,68,68,.25),rgba(239,68,68,.15));border-color:rgba(239,68,68,.5);transform:scale(1.05);box-shadow:0 4px 12px rgba(239,68,68,.3)}
        .btn-remove i{font-size:.95rem}
        
        /* Summary */
        .cart-summary{margin-top:40px;padding:32px;background:linear-gradient(135deg,rgba(255,255,255,.06),rgba(255,255,255,.03));border:1px solid rgba(255,255,255,.15);border-radius:20px;backdrop-filter:blur(10px)}
        .summary-row{display:flex;justify-content:space-between;align-items:center;margin-bottom:32px;padding-bottom:24px;border-bottom:2px solid rgba(255,255,255,.1)}
        .summary-label{font-size:1.4rem;font-weight:700;color:#fff;display:flex;align-items:center;gap:12px}
        .summary-label i{color:#60A5FA;font-size:1.3rem}
        .summary-value{font-size:3rem;font-weight:900;background:linear-gradient(135deg,#34D399,#10B981);-webkit-background-clip:text;-webkit-text-fill-color:transparent;text-shadow:0 0 30px rgba(52,211,153,.3);line-height:1}
        
        .cart-buttons{display:grid;grid-template-columns:1fr 1fr 2fr;gap:16px}
        .cart-buttons .btn{width:100%;text-align:center;padding:18px;font-size:1rem;font-weight:800;border-radius:12px;transition:all .3s;display:inline-flex;align-items:center;justify-content:center;gap:10px;position:relative;overflow:hidden}
        .cart-buttons .btn::before{content:'';position:absolute;top:50%;left:50%;width:0;height:0;border-radius:50%;background:rgba(255,255,255,.2);transform:translate(-50%,-50%);transition:width .6s,height .6s}
        .cart-buttons .btn:hover::before{width:300px;height:300px}
        .cart-buttons .btn i{font-size:1.1rem;transition:transform .3s}
        .cart-buttons .btn:hover i{transform:scale(1.15)}
        
        .btn-secondary{background:rgba(255,255,255,.08);color:#fff;border:1px solid rgba(255,255,255,.2)}
        .btn-secondary:hover{background:rgba(255,255,255,.12);transform:translateY(-2px);box-shadow:0 6px 20px rgba(0,0,0,.3)}
        .btn-danger{background:linear-gradient(135deg,rgba(239,68,68,.2),rgba(239,68,68,.1));color:#F87171;border:1px solid rgba(239,68,68,.3)}
        .btn-danger:hover{background:linear-gradient(135deg,rgba(239,68,68,.3),rgba(239,68,68,.15));transform:translateY(-2px);box-shadow:0 6px 20px rgba(239,68,68,.3)}
        .btn-primary{background:linear-gradient(135deg,#2563EB,#3B82F6);color:#fff;box-shadow:0 4px 15px rgba(37,99,235,.4)}
        .btn-primary:hover{transform:translateY(-3px);box-shadow:0 8px 25px rgba(37,99,235,.5)}
        
        /* Animations */
        @keyframes fadeIn{from{opacity:0}to{opacity:1}}
        @keyframes fadeInDown{from{opacity:0;transform:translateY(-20px)}to{opacity:1;transform:translateY(0)}}
        @keyframes slideInUp{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}
        @keyframes slideInRight{from{opacity:0;transform:translateX(20px)}to{opacity:1;transform:translateX(0)}}
        @keyframes bounce{0%,100%{transform:translateY(0)}50%{transform:translateY(-10px)}}
        
        /* Responsive */
        @media (max-width: 768px) {
            .cart-item{grid-template-columns:1fr;text-align:center;gap:20px}
            .tour-image{margin:0 auto}
            .tour-info{text-align:center}
            .tour-meta{justify-content:center}
            .tour-actions{align-items:center}
            .tour-price-section{text-align:center}
            .quantity-controls{justify-content:center}
            .cart-buttons{grid-template-columns:1fr}
        }
    </style>
</head>
<body>
    <jsp:include page="/common/_header.jsp" />
    
    <div class="container">
        <div class="page-header">
            <h1><i class="fas fa-shopping-cart"></i> Giỏ Hàng</h1>
            <p>Quản lý các tour bạn muốn đặt</p>
        </div>

        <!-- Messages -->
        <c:if test="${not empty sessionScope.message}">
            <div class="message ${sessionScope.messageType}">
                <i class="fas fa-${sessionScope.messageType == 'success' ? 'check-circle' : 'exclamation-circle'}"></i>
                ${sessionScope.message}
            </div>
            <c:remove var="message" scope="session"/>
            <c:remove var="messageType" scope="session"/>
        </c:if>

        <!-- Cart Content -->
        <c:choose>
            <c:when test="${empty cartItems}">
                <div class="cart-empty">
                    <i class="fas fa-shopping-cart"></i>
                    <h2>Giỏ hàng trống</h2>
                    <p>Bạn chưa thêm tour nào vào giỏ hàng</p>
                    <a href="${pageContext.request.contextPath}/explore" class="btn btn-primary">
                        <i class="fas fa-compass"></i> Khám phá tours
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="cart-container">
                    <div class="cart-header">
                        <h2>
                            <i class="fas fa-shopping-bag"></i> 
                            Giỏ hàng của bạn
                            <span class="cart-count">${cartCount} tours</span>
                        </h2>
                    </div>
                    
                    <c:forEach var="entry" items="${cartItems}" varStatus="status">
                        <c:set var="tour" value="${entry.key}"/>
                        <c:set var="quantity" value="${entry.value}"/>
                        
                        <div class="cart-item" style="animation-delay:${status.index * 0.1}s">
                            <div class="tour-image"></div>
                            
                            <div class="tour-info">
                                <div class="tour-name">${tour.name}</div>
                                <div class="tour-meta">
                                    <div class="tour-meta-item">
                                        <i class="fas fa-map-marker-alt"></i>
                                        <span>${tour.destination}</span>
                                    </div>
                                    <div class="tour-meta-item">
                                        <i class="fas fa-calendar"></i>
                                        <span><fmt:formatDate value="${tour.startDate}" pattern="dd/MM/yyyy"/></span>
                                    </div>
                                    <div class="tour-meta-item">
                                        <i class="fas fa-users"></i>
                                        <span>${quantity} người</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="tour-actions">
                                <div class="tour-price-section">
                                    <div class="tour-price-label">Thành tiền</div>
                                    <div class="tour-price">
                                        <fmt:formatNumber value="${tour.price * quantity}" pattern="#,###"/> đ
                                    </div>
                                </div>
                                
                                <div class="quantity-controls">
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="tourId" value="${tour.id}">
                                        <button type="submit" name="quantity" value="${quantity - 1}" class="qty-btn">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                    </form>
                                    
                                    <div class="qty-display">${quantity}</div>
                                    
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="tourId" value="${tour.id}">
                                        <button type="submit" name="quantity" value="${quantity + 1}" class="qty-btn">
                                            <i class="fas fa-plus"></i>
                                        </button>
                                    </form>
                                </div>
                                
                                <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="tourId" value="${tour.id}">
                                    <button type="submit" class="btn-remove" onclick="return confirm('Xóa tour này khỏi giỏ hàng?')">
                                        <i class="fas fa-trash-alt"></i> Xóa
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <!-- Summary -->
                    <div class="cart-summary">
                        <div class="summary-row">
                            <span class="summary-label">
                                <i class="fas fa-receipt"></i>
                                Tổng thanh toán
                            </span>
                            <span class="summary-value">
                                <fmt:formatNumber value="${grandTotal}" pattern="#,###"/> đ
                            </span>
                        </div>
                        
                        <div class="cart-buttons">
                            <a href="${pageContext.request.contextPath}/explore" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> <span>Tiếp tục mua</span>
                            </a>
                            
                            <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline">
                                <input type="hidden" name="action" value="clear">
                                <button type="submit" class="btn btn-danger" onclick="return confirm('Xóa tất cả tours khỏi giỏ hàng?')">
                                    <i class="fas fa-trash-alt"></i> <span>Xóa tất cả</span>
                                </button>
                            </form>
                            
                            <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary">
                                <i class="fas fa-bolt"></i> <span>Thanh toán ngay</span>
                            </a>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
