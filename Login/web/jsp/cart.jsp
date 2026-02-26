<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng - VietAir</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e8ecf1 100%);
            min-height: 100vh;
            padding: 2rem 0;
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2rem;
        }
        
        .page-header {
            margin-bottom: 2.5rem;
            animation: slideDown 0.5s ease;
        }
        
        .page-title {
            font-size: 2.5rem;
            font-weight: 800;
            background: linear-gradient(135deg, #2c5aa0 0%, #1e4070 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.5rem;
        }
        
        .page-subtitle {
            color: #64748b;
            font-size: 1.1rem;
        }
        
        .cart-layout {
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 2rem;
            align-items: start;
        }
        
        .cart-items {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }
        
        .cart-item {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06);
            transition: all 0.3s ease;
            animation: slideUp 0.5s ease;
            display: grid;
            grid-template-columns: 140px 1fr auto;
            gap: 1.5rem;
            align-items: center;
        }
        
        .cart-item:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 25px -5px rgba(0,0,0,0.1), 0 10px 10px -5px rgba(0,0,0,0.04);
        }
        
        .tour-image {
            width: 140px;
            height: 140px;
            border-radius: 12px;
            background: linear-gradient(135deg, #2c5aa0 0%, #1e4070 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
            position: relative;
            overflow: hidden;
        }
        
        .tour-image::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.1), transparent);
            transform: rotate(45deg);
            animation: shimmer 3s infinite;
        }
        
        .tour-info {
            flex: 1;
        }
        
        .tour-name {
            font-size: 1.25rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 0.5rem;
        }
        
        .tour-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            margin-bottom: 0.75rem;
        }
        
        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #64748b;
            font-size: 0.9rem;
        }
        
        .meta-item i {
            color: #2c5aa0;
        }
        
        .tour-price {
            font-size: 1.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #2c5aa0 0%, #1e4070 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .tour-actions {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            align-items: flex-end;
        }
        
        .quantity-control {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            background: #f1f5f9;
            border-radius: 12px;
            padding: 0.5rem;
        }
        
        .qty-btn {
            width: 36px;
            height: 36px;
            border: none;
            background: white;
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #2c5aa0;
            font-weight: 700;
            transition: all 0.2s;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        
        .qty-btn:hover {
            background: #2c5aa0;
            color: white;
            transform: scale(1.1);
        }
        
        .qty-input {
            width: 60px;
            text-align: center;
            border: none;
            background: transparent;
            font-size: 1.1rem;
            font-weight: 600;
            color: #1e293b;
        }
        
        .btn-remove {
            padding: 0.75rem 1.5rem;
            background: #fee2e2;
            color: #dc2626;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .btn-remove:hover {
            background: #dc2626;
            color: white;
            transform: scale(1.05);
        }
        
        .cart-summary {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05);
            position: sticky;
            top: 2rem;
            animation: slideLeft 0.5s ease;
        }
        
        .summary-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f1f5f9;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid #f1f5f9;
        }
        
        .summary-label {
            color: #64748b;
            font-size: 1rem;
        }
        
        .summary-value {
            font-weight: 600;
            color: #1e293b;
            font-size: 1.1rem;
        }
        
        .summary-total {
            padding: 1.5rem 0;
            margin-top: 1rem;
        }
        
        .summary-total .summary-label {
            font-size: 1.2rem;
            font-weight: 600;
            color: #1e293b;
        }
        
        .summary-total .summary-value {
            font-size: 2rem;
            font-weight: 800;
            background: linear-gradient(135deg, #2c5aa0 0%, #1e4070 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .btn-checkout {
            width: 100%;
            padding: 1.25rem;
            background: linear-gradient(135deg, #2c5aa0 0%, #1e4070 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 10px 15px -3px rgba(44, 90, 160, 0.4);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            text-decoration: none;
        }
        
        .btn-checkout:hover {
            transform: translateY(-2px);
            box-shadow: 0 20px 25px -5px rgba(44, 90, 160, 0.5);
        }
        
        .btn-continue {
            width: 100%;
            padding: 1rem;
            background: #f1f5f9;
            color: #64748b;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            margin-top: 1rem;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }
        
        .btn-continue:hover {
            background: #e2e8f0;
            color: #475569;
        }
        
        .empty-cart {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
            animation: fadeIn 0.5s ease;
        }
        
        .empty-icon {
            font-size: 5rem;
            color: #e2e8f0;
            margin-bottom: 1.5rem;
        }
        
        .empty-title {
            font-size: 1.75rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 0.75rem;
        }
        
        .empty-text {
            color: #64748b;
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }
        
        .alert {
            padding: 1.25rem 1.5rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            animation: slideDown 0.5s ease;
        }
        
        .alert-success {
            background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            color: #065f46;
            border-left: 4px solid #10b981;
        }
        
        .alert-warning {
            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
            color: #92400e;
            border-left: 4px solid #f59e0b;
        }
        
        .alert-error {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            color: #991b1b;
            border-left: 4px solid #ef4444;
        }
        
        .alert i {
            font-size: 1.5rem;
        }
        
        .warning-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            background: #fef3c7;
            color: #92400e;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 600;
            margin-top: 0.5rem;
        }
        
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes slideLeft {
            from {
                opacity: 0;
                transform: translateX(20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        @keyframes shimmer {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }
        
        @media (max-width: 1024px) {
            .cart-layout {
                grid-template-columns: 1fr;
            }
            
            .cart-summary {
                position: static;
            }
        }
        
        @media (max-width: 768px) {
            .cart-item {
                grid-template-columns: 1fr;
                text-align: center;
            }
            
            .tour-image {
                margin: 0 auto;
            }
            
            .tour-actions {
                align-items: center;
            }
            
            .page-title {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">
                <i class="fas fa-shopping-cart"></i> Giỏ hàng của bạn
            </h1>
            <p class="page-subtitle">Xem lại và hoàn tất đặt tour của bạn</p>
        </div>

        <!-- Alerts -->
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <span>${sessionScope.success}</span>
            </div>
            <c:remove var="success" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                <span>${sessionScope.error}</span>
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>

        <c:if test="${not empty cartWarnings}">
            <div class="alert alert-warning">
                <i class="fas fa-exclamation-triangle"></i>
                <span>${cartWarnings}</span>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${empty cartItems}">
                <!-- Empty Cart -->
                <div class="empty-cart">
                    <div class="empty-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <h2 class="empty-title">Giỏ hàng của bạn đang trống</h2>
                    <p class="empty-text">Hãy khám phá các tour du lịch tuyệt vời của chúng tôi!</p>
                    <a href="${pageContext.request.contextPath}/tour?action=list" class="btn-checkout">
                        <i class="fas fa-compass"></i>
                        Xem các tour
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Cart Layout -->
                <div class="cart-layout">
                    <!-- Cart Items -->
                    <div class="cart-items">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="cart-item">
                                <!-- Tour Image -->
                                <div class="tour-image">
                                    <i class="fas fa-mountain"></i>
                                </div>

                                <!-- Tour Info -->
                                <div class="tour-info">
                                    <h3 class="tour-name">${item.tour.name}</h3>
                                    <div class="tour-meta">
                                        <div class="meta-item">
                                            <i class="fas fa-map-marker-alt"></i>
                                            <span>${item.tour.destination}</span>
                                        </div>
                                        <div class="meta-item">
                                            <i class="fas fa-calendar-alt"></i>
                                            <span>${item.tour.startDate} - ${item.tour.endDate}</span>
                                        </div>
                                    </div>
                                    <div class="tour-price">
                                        <fmt:formatNumber value="${item.tour.price}" pattern="#,###"/>₫
                                        <span style="font-size: 0.9rem; color: #64748b; font-weight: 400;">/ người</span>
                                    </div>
                                    <c:if test="${item.tour.availableSlots <= 5 && item.tour.availableSlots > 0}">
                                        <div class="warning-badge">
                                            <i class="fas fa-exclamation-triangle"></i>
                                            Chỉ còn ${item.tour.availableSlots} chỗ trống!
                                        </div>
                                    </c:if>
                                </div>

                                <!-- Actions -->
                                <div class="tour-actions">
                                    <form action="${pageContext.request.contextPath}/cart/update" method="post" style="margin: 0;">
                                        <input type="hidden" name="tourId" value="${item.tourId}">
                                        <div class="quantity-control">
                                            <button type="submit" name="quantity" value="${item.quantity - 1}" class="qty-btn">
                                                <i class="fas fa-minus"></i>
                                            </button>
                                            <input type="text" value="${item.quantity}" class="qty-input" readonly>
                                            <button type="submit" name="quantity" value="${item.quantity + 1}" class="qty-btn">
                                                <i class="fas fa-plus"></i>
                                            </button>
                                        </div>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/cart/remove" method="post" style="margin: 0;">
                                        <input type="hidden" name="tourId" value="${item.tourId}">
                                        <button type="submit" class="btn-remove">
                                            <i class="fas fa-trash-alt"></i>
                                            Xóa
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Cart Summary -->
                    <div class="cart-summary">
                        <h2 class="summary-title">Tổng đơn hàng</h2>
                        
                        <div class="summary-row">
                            <span class="summary-label">Số lượng tour:</span>
                            <span class="summary-value">${cartItemCount}</span>
                        </div>
                        
                        <div class="summary-row">
                            <span class="summary-label">Tổng số người:</span>
                            <span class="summary-value">
                                <c:set var="totalPeople" value="0"/>
                                <c:forEach var="item" items="${cartItems}">
                                    <c:set var="totalPeople" value="${totalPeople + item.quantity}"/>
                                </c:forEach>
                                ${totalPeople}
                            </span>
                        </div>
                        
                        <div class="summary-row summary-total">
                            <span class="summary-label">Tổng cộng:</span>
                            <span class="summary-value">
                                <fmt:formatNumber value="${cartTotal}" pattern="#,###"/>₫
                            </span>
                        </div>
                        
                        <a href="${pageContext.request.contextPath}/checkout" class="btn-checkout">
                            <i class="fas fa-credit-card"></i>
                            Tiến hành đặt tour
                        </a>
                        
                        <a href="${pageContext.request.contextPath}/tour?action=list" class="btn-continue">
                            <i class="fas fa-arrow-left"></i>
                            Tiếp tục mua sắm
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
