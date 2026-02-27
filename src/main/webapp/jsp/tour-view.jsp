<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${tour.tourName} | Da Nang Travel Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .tour-hero {
            height: 450px; position: relative; overflow: hidden;
        }
        .tour-hero img {
            width: 100%; height: 100%; object-fit: cover;
        }
        .tour-hero .overlay {
            position: absolute; inset: 0;
            background: linear-gradient(transparent 40%, rgba(10,35,81,0.9));
        }
        .tour-hero .hero-content {
            position: absolute; bottom: 40px; left: 0; right: 0;
            color: white; padding: 0 40px;
        }
        .tour-hero .hero-content h1 { font-size: 2.5rem; margin-bottom: 10px; }
        .tour-hero .hero-content .meta { display: flex; gap: 25px; font-size: 0.95rem; opacity: 0.9; }
        .tour-hero .hero-content .meta i { margin-right: 6px; }

        .tour-detail { display: grid; grid-template-columns: 2fr 1fr; gap: 40px; margin: 40px auto; max-width: 1200px; padding: 0 20px; }

        .tour-info h2 { font-size: 1.6rem; color: #0a2351; margin-bottom: 15px; border-bottom: 3px solid #ff6b6b; padding-bottom: 10px; display: inline-block; }
        .tour-info .desc { color: #636e72; line-height: 1.8; font-size: 0.95rem; margin-bottom: 30px; }
        .tour-info .highlights { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 30px; }
        .tour-info .highlight-item {
            display: flex; align-items: center; gap: 12px;
            padding: 15px 18px; background: #f8f9fa; border-radius: 12px;
        }
        .tour-info .highlight-item i { color: #ff6b6b; font-size: 1.1rem; width: 20px; }

        .booking-card {
            background: white; border-radius: 20px; padding: 30px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.08); border: 1px solid #f0f0f0;
            position: sticky; top: 100px; height: fit-content;
        }
        .booking-card .price-section { text-align: center; margin-bottom: 25px; padding-bottom: 25px; border-bottom: 1px solid #f0f0f0; }
        .booking-card .price-label { font-size: 0.85rem; color: #b2bec3; }
        .booking-card .price { font-size: 2.5rem; font-weight: 800; color: #2e7d32; }
        .booking-card .seasonal { font-size: 0.85rem; color: #ff6b6b; margin-top: 5px; }

        .booking-card .form-group { margin-bottom: 18px; }
        .booking-card .form-group label { display: block; font-size: 0.85rem; font-weight: 600; margin-bottom: 6px; color: #2d3436; }
        .booking-card .form-group input, .booking-card .form-group select {
            width: 100%; padding: 12px 14px; border: 2px solid #e9ecef; border-radius: 10px;
            font-family: 'Inter', sans-serif; font-size: 0.9rem; transition: 0.3s;
        }
        .booking-card .form-group input:focus, .booking-card .form-group select:focus {
            outline: none; border-color: #4facfe; box-shadow: 0 0 0 3px rgba(79,172,254,0.12);
        }
        .btn-book-now {
            width: 100%; padding: 16px; background: linear-gradient(135deg, #ff6b6b, #ee5a24);
            color: white; border: none; border-radius: 12px; font-size: 1.05rem; font-weight: 800;
            cursor: pointer; transition: 0.3s; font-family: 'Inter', sans-serif;
        }
        .btn-book-now:hover { transform: translateY(-2px); box-shadow: 0 10px 30px rgba(255,107,107,0.35); }

        .alert-success {
            background: #e8f5e9; color: #2e7d32; padding: 14px 18px;
            border-radius: 12px; margin-bottom: 20px; border-left: 4px solid #2e7d32;
        }
        .alert-error {
            background: #fdecea; color: #c0392b; padding: 14px 18px;
            border-radius: 12px; margin-bottom: 20px; border-left: 4px solid #e74c3c;
        }

        @media (max-width: 768px) {
            .tour-detail { grid-template-columns: 1fr; }
            .booking-card { position: static; }
        }
    </style>
</head>
<body>
    <jsp:include page="/common/_header.jsp" />

    <!-- Tour Hero -->
    <section class="tour-hero">
        <img src="${not empty tour.imageUrl ? tour.imageUrl : 'https://images.unsplash.com/photo-1559592442-7e182c3c03fb?auto=format&fit=crop&w=1600&q=80'}" alt="${tour.tourName}">
        <div class="overlay"></div>
        <div class="hero-content container">
            <h1>${tour.tourName}</h1>
            <div class="meta">
                <c:if test="${not empty tour.duration}"><span><i class="fas fa-clock"></i> ${tour.duration}</span></c:if>
                <c:if test="${not empty tour.startLocation}"><span><i class="fas fa-map-marker-alt"></i> ${tour.startLocation}</span></c:if>
                <c:if test="${not empty tour.category}"><span><i class="fas fa-tag"></i> ${tour.category.categoryName}</span></c:if>
            </div>
        </div>
    </section>

    <div class="tour-detail">
        <!-- Left: Tour Info -->
        <div class="tour-info">
            <c:if test="${not empty sessionScope.success}">
                <div class="alert-success"><i class="fas fa-check-circle"></i> ${sessionScope.success}</div>
                <% session.removeAttribute("success"); %>
            </c:if>
            <c:if test="${not empty sessionScope.error}">
                <div class="alert-error"><i class="fas fa-exclamation-circle"></i> ${sessionScope.error}</div>
                <% session.removeAttribute("error"); %>
            </c:if>

            <h2>Mô tả tour</h2>
            <p class="desc">${not empty tour.description ? tour.description : 'Trải nghiệm du lịch đẳng cấp tại Đà Nẵng với hướng dẫn viên chuyên nghiệp. Khám phá vẻ đẹp tự nhiên và văn hóa độc đáo của thành phố biển.'}</p>

            <h2>Điểm nổi bật</h2>
            <div class="highlights">
                <div class="highlight-item"><i class="fas fa-check-circle"></i> Hướng dẫn viên chuyên nghiệp</div>
                <div class="highlight-item"><i class="fas fa-check-circle"></i> Đón tận nơi</div>
                <div class="highlight-item"><i class="fas fa-check-circle"></i> Bảo hiểm du lịch</div>
                <div class="highlight-item"><i class="fas fa-check-circle"></i> Ảnh chụp miễn phí</div>
                <div class="highlight-item"><i class="fas fa-check-circle"></i> Bữa trưa đặc sản</div>
                <div class="highlight-item"><i class="fas fa-check-circle"></i> Xe đưa đón VIP</div>
            </div>
        </div>

        <!-- Right: Booking Card -->
        <div class="booking-card">
            <div class="price-section">
                <div class="price-label">Giá từ</div>
                <div class="price"><fmt:formatNumber value="${tour.price}" type="number" groupingUsed="true"/>đ</div>
                <c:if test="${seasonalPrice != tour.price}">
                    <div class="seasonal">Giá mùa: <fmt:formatNumber value="${seasonalPrice}" type="number" groupingUsed="true"/>đ</div>
                </c:if>
                <div style="font-size: 0.8rem; color: #b2bec3; margin-top: 5px;">/ người</div>
            </div>

            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <form action="${pageContext.request.contextPath}/booking" method="post">
                        <input type="hidden" name="action" value="book">
                        <input type="hidden" name="tourId" value="${tour.tourId}">
                        <div class="form-group">
                            <label>Số người</label>
                            <input type="number" name="numberOfPeople" value="1" min="1" max="50" required>
                        </div>
                        <button type="submit" class="btn-book-now">
                            <i class="fas fa-shopping-cart"></i> ĐẶT TOUR NGAY
                        </button>
                    </form>
                </c:when>
                <c:otherwise>
                    <p style="text-align: center; color: #636e72; margin-bottom: 15px;">Đăng nhập để đặt tour</p>
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn-book-now" style="display: block; text-align: center; text-decoration: none;">
                        <i class="fas fa-sign-in-alt"></i> ĐĂNG NHẬP
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <jsp:include page="/common/_footer.jsp" />
</body>
</html>
