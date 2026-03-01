<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${tour.tourName} - Da Nang Travel Hub</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            color: #333;
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.5rem 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .header h1 {
            font-size: 1.8rem;
            font-weight: 600;
        }
        
        .header-nav a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            padding: 8px 16px;
            border-radius: 5px;
            transition: background 0.3s;
        }
        
        .header-nav a:hover {
            background: rgba(255,255,255,0.2);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        
        .breadcrumb {
            margin-bottom: 20px;
            color: #718096;
        }
        
        .breadcrumb a {
            color: #667eea;
            text-decoration: none;
        }
        
        .breadcrumb a:hover {
            text-decoration: underline;
        }
        
        .tour-detail {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 30px;
        }
        
        .tour-main {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        
        .tour-title {
            font-size: 2rem;
            color: #2d3748;
            margin-bottom: 15px;
        }
        
        .tour-meta {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e2e8f0;
        }
        
        .meta-item {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #4a5568;
        }
        
        .tour-image-placeholder {
            width: 100%;
            height: 400px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
        }
        
        .tour-description {
            line-height: 1.8;
            color: #4a5568;
            margin-bottom: 20px;
        }
        
        .tour-info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-top: 20px;
        }
        
        .info-item {
            padding: 15px;
            background: #f7fafc;
            border-radius: 8px;
            border-left: 4px solid #667eea;
        }
        
        .info-label {
            font-size: 0.9rem;
            color: #718096;
            margin-bottom: 5px;
        }
        
        .info-value {
            font-size: 1.1rem;
            font-weight: 600;
            color: #2d3748;
        }
        
        .booking-sidebar {
            position: sticky;
            top: 20px;
            height: fit-content;
        }
        
        .booking-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        
        .price-box {
            text-align: center;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        
        .price-label {
            font-size: 0.9rem;
            opacity: 0.9;
        }
        
        .price-value {
            font-size: 2.5rem;
            font-weight: 700;
            margin: 10px 0;
        }
        
        .booking-form {
            margin-top: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            font-weight: 500;
            margin-bottom: 8px;
            color: #4a5568;
        }
        
        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #e2e8f0;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 80px;
        }
        
        .required {
            color: #dc2626;
        }
        
        .btn-submit {
            width: 100%;
            padding: 15px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-submit:hover {
            background: #5568d3;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
        
        .btn-submit:disabled {
            background: #e2e8f0;
            color: #a0aec0;
            cursor: not-allowed;
            transform: none;
        }
        
        .alert {
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        
        .alert-success {
            background: #f0fdf4;
            color: #16a34a;
            border: 1px solid #86efac;
        }
        
        .alert-error {
            background: #fef2f2;
            color: #dc2626;
            border: 1px solid #fca5a5;
        }
        
        .capacity-warning {
            background: #fef3c7;
            color: #d97706;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 15px;
            text-align: center;
        }
        
        .login-prompt {
            text-align: center;
            padding: 30px;
            background: #f7fafc;
            border-radius: 8px;
        }
        
        .login-prompt h3 {
            margin-bottom: 15px;
            color: #2d3748;
        }
        
        .btn-login {
            display: inline-block;
            padding: 12px 30px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .btn-login:hover {
            background: #5568d3;
            transform: translateY(-2px);
        }
        
        @media (max-width: 768px) {
            .tour-detail {
                grid-template-columns: 1fr;
            }
            
            .tour-info-grid {
                grid-template-columns: 1fr;
            }
            
            .header-content {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1>🌴 Da Nang Travel Hub</h1>
            <nav class="header-nav">
                <a href="${pageContext.request.contextPath}/">Trang chủ</a>
                <a href="${pageContext.request.contextPath}/explore">Khám phá</a>
                <c:choose>
                    <c:when test="${not empty sessionScope.username}">
                        <a href="${pageContext.request.contextPath}/profile">👤 ${sessionScope.username}</a>
                        <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a>
                    </c:otherwise>
                </c:choose>
            </nav>
        </div>
    </div>

    <div class="container">
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/">Trang chủ</a> / 
            <a href="${pageContext.request.contextPath}/explore">Khám phá</a> / 
            ${tour.tourName}
        </div>

        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success">
                ✓ ${sessionScope.success}
            </div>
            <c:remove var="success" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-error">
                ✗ ${sessionScope.error}
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>

        <div class="tour-detail">
            <!-- Main Content -->
            <div class="tour-main">
                <h1 class="tour-title">${tour.tourName}</h1>
                
                <div class="tour-meta">
                    <div class="meta-item">
                        📍 ${tour.startLocation}
                    </div>
                    <div class="meta-item">
                        📅 <fmt:formatDate value="${tour.startDate}" pattern="dd/MM/yyyy"/>
                    </div>
                    <c:if test="${tour.maxPeople > 0}">
                        <div class="meta-item" style="color: #16a34a;">
                            ✓ Còn ${tour.maxPeople} chỗ
                        </div>
                    </c:if>
                    <c:if test="${tour.maxPeople <= 0}">
                        <div class="meta-item" style="color: #dc2626;">
                            ✗ Hết chỗ
                        </div>
                    </c:if>
                </div>

                <div class="tour-image-placeholder">
                    🏖️
                </div>

                <div class="tour-description">
                    <h3 style="margin-bottom: 15px; color: #2d3748;">Mô tả tour</h3>
                    <p>${tour.description}</p>
                </div>

                <div class="tour-info-grid">
                    <div class="info-item">
                        <div class="info-label">Giá tour</div>
                        <div class="info-value">
                            <fmt:formatNumber value="${tour.price}" pattern="#,###"/>đ
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Sức chứa tối đa</div>
                        <div class="info-value">${tour.maxPeople + tour.currentCapacity} người</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Đã đặt</div>
                        <div class="info-value">${tour.currentCapacity} người</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Còn trống</div>
                        <div class="info-value">${tour.maxPeople} chỗ</div>
                    </div>
                </div>
            </div>

            <!-- Booking Sidebar -->
            <div class="booking-sidebar">
                <div class="booking-card">
                    <div class="price-box">
                        <div class="price-label">Giá tour</div>
                        <div class="price-value">
                            <fmt:formatNumber value="${tour.price}" pattern="#,###"/>đ
                        </div>
                        <div class="price-label">/ người</div>
                    </div>

                    <c:choose>
                        <c:when test="${not empty sessionScope.username}">
                            <!-- Booking Form for Logged-in Users -->
                            <c:choose>
                                <c:when test="${tour.maxPeople > 0}">
                                    <form action="${pageContext.request.contextPath}/booking" method="post" class="booking-form">
                                        <input type="hidden" name="action" value="book">
                                        <input type="hidden" name="tourId" value="${tour.id}">
                                        
                                        <div class="form-group">
                                            <label for="numberOfPeople">
                                                Số lượng người <span class="required">*</span>
                                            </label>
                                            <input type="number" id="numberOfPeople" name="numberOfPeople" 
                                                   min="1" max="${tour.maxPeople}" value="1" required>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="fullName">
                                                Họ và tên <span class="required">*</span>
                                            </label>
                                            <input type="text" id="fullName" name="fullName" 
                                                   placeholder="Nguyễn Văn A" required>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="email">
                                                Email <span class="required">*</span>
                                            </label>
                                            <input type="email" id="email" name="email" 
                                                   placeholder="example@email.com" required>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="phone">
                                                Số điện thoại <span class="required">*</span>
                                            </label>
                                            <input type="tel" id="phone" name="phone" 
                                                   placeholder="0123456789" required>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="address">Địa chỉ</label>
                                            <textarea id="address" name="address" 
                                                      placeholder="Địa chỉ của bạn (không bắt buộc)"></textarea>
                                        </div>
                                        
                                        <c:if test="${tour.maxPeople <= 5}">
                                            <div class="capacity-warning">
                                                ⚠️ Chỉ còn ${tour.maxPeople} chỗ trống!
                                            </div>
                                        </c:if>
                                        
                                        <button type="submit" class="btn-submit">
                                            🎫 Đặt tour ngay
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <div class="capacity-warning" style="background: #fef2f2; color: #dc2626;">
                                        ✗ Tour đã hết chỗ
                                    </div>
                                    <button type="button" class="btn-submit" disabled>
                                        Hết chỗ
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <!-- Login Prompt for Guests -->
                            <div class="login-prompt">
                                <h3>🔒 Đăng nhập để đặt tour</h3>
                                <p style="margin-bottom: 20px; color: #718096;">
                                    Bạn cần đăng nhập để có thể đặt tour
                                </p>
                                <a href="${pageContext.request.contextPath}/login.jsp?redirect=${pageContext.request.requestURI}?id=${tour.id}" 
                                   class="btn-login">
                                    Đăng nhập ngay
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
