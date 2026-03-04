<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${tour.name} | eztravel</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
    *{margin:0;padding:0;box-sizing:border-box}
    body{font-family:'Inter',system-ui,sans-serif;background:#0F172A;color:#E2E8F0;-webkit-font-smoothing:antialiased;min-height:100vh;padding-top:100px}
    
    /* Header - Remove old styles, use common header */
    
    /* Main */
    .btn{padding:14px 24px;border:none;border-radius:12px;font-weight:700;font-size:.95rem;cursor:pointer;transition:all .3s ease;text-decoration:none;display:inline-flex;align-items:center;justify-content:center;gap:10px;position:relative;overflow:hidden}
    .btn::before{content:'';position:absolute;top:50%;left:50%;width:0;height:0;border-radius:50%;background:rgba(255,255,255,.2);transform:translate(-50%,-50%);transition:width .6s,height .6s}
    .btn:hover::before{width:300px;height:300px}
    .btn i{font-size:1.1rem;transition:transform .3s}
    .btn:hover i{transform:scale(1.15)}
    
    .btn-primary{background:linear-gradient(135deg,#3B82F6,#2563EB);color:#fff;box-shadow:0 4px 15px rgba(37,99,235,.4)}
    .btn-primary:hover{transform:translateY(-3px);box-shadow:0 8px 25px rgba(37,99,235,.5)}
    .btn-primary:active{transform:translateY(-1px)}
    
    .btn-cart{background:linear-gradient(135deg,#10B981,#059669);color:#fff;box-shadow:0 4px 15px rgba(16,185,129,.4)}
    .btn-cart:hover{transform:translateY(-3px);box-shadow:0 8px 25px rgba(16,185,129,.5)}
    
    .btn-secondary{background:rgba(255,255,255,.06);color:rgba(255,255,255,.8);border:1px solid rgba(255,255,255,.15);backdrop-filter:blur(10px)}
    .btn-secondary:hover{background:rgba(255,255,255,.1);color:#fff;border-color:rgba(255,255,255,.3);transform:translateY(-2px);box-shadow:0 6px 20px rgba(0,0,0,.2)}
    
    .container{max-width:1200px;margin:0 auto;padding:40px 24px}
    .back-link{display:inline-flex;align-items:center;gap:8px;color:rgba(255,255,255,.5);text-decoration:none;font-size:.88rem;margin-bottom:24px;transition:.3s}
    .back-link:hover{color:#60A5FA}
    
    /* Tour Detail */
    .tour-detail{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:16px;overflow:hidden}
    .tour-header{padding:32px;border-bottom:1px solid rgba(255,255,255,.06)}
    .tour-header h1{font-size:2rem;font-weight:800;color:#fff;margin-bottom:12px}
    .tour-meta{display:flex;gap:24px;flex-wrap:wrap}
    .tour-meta-item{display:flex;align-items:center;gap:8px;color:rgba(255,255,255,.6);font-size:.88rem}
    .tour-meta-item i{color:#60A5FA}
    
    .tour-body{display:grid;grid-template-columns:2fr 1fr;gap:32px;padding:32px}
    
    .tour-info h2{font-size:1.3rem;font-weight:700;color:#fff;margin-bottom:16px}
    .tour-info p{color:rgba(255,255,255,.7);line-height:1.7;margin-bottom:24px}
    
    .info-grid{display:grid;grid-template-columns:1fr 1fr;gap:16px;margin-bottom:24px}
    .info-item{background:rgba(255,255,255,.02);border:1px solid rgba(255,255,255,.06);border-radius:12px;padding:16px}
    .info-item-label{font-size:.75rem;text-transform:uppercase;letter-spacing:1px;color:rgba(255,255,255,.4);margin-bottom:6px}
    .info-item-value{font-size:1.1rem;font-weight:700;color:#fff}
    .info-item-value.price{color:#34D399}
    
    .tour-sidebar{position:sticky;top:100px;height:fit-content}
    .booking-card{background:linear-gradient(135deg,rgba(255,255,255,.04),rgba(255,255,255,.02));border:1px solid rgba(255,255,255,.1);border-radius:20px;padding:28px;box-shadow:0 8px 32px rgba(0,0,0,.3);backdrop-filter:blur(10px)}
    .booking-card h3{font-size:1.2rem;font-weight:800;color:#fff;margin-bottom:20px;display:flex;align-items:center;gap:10px}
    .booking-card h3::before{content:'';width:4px;height:24px;background:linear-gradient(135deg,#3B82F6,#10B981);border-radius:2px}
    .price-display{font-size:2.5rem;font-weight:900;background:linear-gradient(135deg,#34D399,#10B981);-webkit-background-clip:text;-webkit-text-fill-color:transparent;margin-bottom:24px;text-shadow:0 0 30px rgba(52,211,153,.3)}
    .price-display small{font-size:.9rem;color:rgba(255,255,255,.6);font-weight:600;display:block;margin-top:8px;-webkit-text-fill-color:rgba(255,255,255,.6)}
    
    .availability{display:flex;align-items:center;gap:10px;padding:14px 18px;background:linear-gradient(135deg,rgba(16,185,129,.15),rgba(16,185,129,.08));border:1px solid rgba(16,185,129,.3);border-radius:12px;margin-bottom:24px;backdrop-filter:blur(10px)}
    .availability.full{background:linear-gradient(135deg,rgba(239,68,68,.15),rgba(239,68,68,.08));border-color:rgba(239,68,68,.3)}
    .availability i{color:#34D399;font-size:1.2rem;animation:pulse 2s infinite}
    .availability.full i{color:#F87171;animation:shake .5s}
    .availability span{font-size:.92rem;color:#34D399;font-weight:700}
    .availability.full span{color:#F87171}
    
    @keyframes pulse{0%,100%{transform:scale(1)}50%{transform:scale(1.1)}}
    @keyframes shake{0%,100%{transform:translateX(0)}25%{transform:translateX(-5px)}75%{transform:translateX(5px)}}
    
    .btn-book{width:100%;padding:16px;font-size:1.05rem;margin-bottom:14px;font-weight:800;letter-spacing:.3px}
    .btn-book:disabled{opacity:.4;cursor:not-allowed;transform:none!important}
    .btn-book:disabled:hover{box-shadow:none;transform:none!important}
    
    @media (max-width: 768px) {
        .tour-body{grid-template-columns:1fr}
        .info-grid{grid-template-columns:1fr}
    }
    </style>
</head>
<body>

<!-- Use common header with cart icon -->
<jsp:include page="/common/_header.jsp" />

<!-- Main -->
<div class="container">
    <a href="${pageContext.request.contextPath}/explore" class="back-link">
        <i class="fas fa-arrow-left"></i> Quay lại danh sách tour
    </a>
    
    <c:choose>
        <c:when test="${not empty tour}">
            <div class="tour-detail">
                <div class="tour-header">
                    <h1>${tour.name}</h1>
                    <div class="tour-meta">
                        <div class="tour-meta-item">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>${tour.destination}</span>
                        </div>
                        <div class="tour-meta-item">
                            <i class="fas fa-calendar-alt"></i>
                            <span><fmt:formatDate value="${tour.startDate}" pattern="dd/MM/yyyy"/></span>
                        </div>
                        <div class="tour-meta-item">
                            <i class="fas fa-clock"></i>
                            <span>
                                <c:choose>
                                    <c:when test="${tour.startDate.time == tour.endDate.time}">
                                        1 ngày
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatDate value="${tour.startDate}" pattern="dd/MM"/> - <fmt:formatDate value="${tour.endDate}" pattern="dd/MM/yyyy"/>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </div>
                
                <div class="tour-body">
                    <div class="tour-info">
                        <h2>Thông tin tour</h2>
                        <p>${not empty tour.description ? tour.description : 'Chưa có mô tả chi tiết cho tour này.'}</p>
                        
                        <div class="info-grid">
                            <div class="info-item">
                                <div class="info-item-label">Điểm đến</div>
                                <div class="info-item-value">${tour.destination}</div>
                            </div>
                            <div class="info-item">
                                <div class="info-item-label">Ngày khởi hành</div>
                                <div class="info-item-value"><fmt:formatDate value="${tour.startDate}" pattern="dd/MM/yyyy"/></div>
                            </div>
                            <div class="info-item">
                                <div class="info-item-label">Số chỗ còn lại</div>
                                <div class="info-item-value">${tour.maxCapacity - tour.currentCapacity}/${tour.maxCapacity}</div>
                            </div>
                            <div class="info-item">
                                <div class="info-item-label">Giá tour</div>
                                <div class="info-item-value price"><fmt:formatNumber value="${tour.price}" pattern="#,###"/> VNĐ</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="tour-sidebar">
                        <div class="booking-card">
                            <h3>Đặt tour ngay</h3>
                            <div class="price-display">
                                <fmt:formatNumber value="${tour.price}" pattern="#,###"/> VNĐ
                                <br><small>/ người</small>
                            </div>
                            
                            <c:choose>
                                <c:when test="${tour.currentCapacity < tour.maxCapacity}">
                                    <div class="availability">
                                        <i class="fas fa-check-circle"></i>
                                        <span>Còn ${tour.maxCapacity - tour.currentCapacity} chỗ trống</span>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="availability full">
                                        <i class="fas fa-times-circle"></i>
                                        <span>Đã hết chỗ</span>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            
                            <c:choose>
                                <c:when test="${empty sessionScope.user}">
                                    <a href="${pageContext.request.contextPath}/login?redirect=tour-detail?id=${tour.id}" class="btn btn-primary btn-book">
                                        <i class="fas fa-lock"></i> 
                                        <span>Đăng nhập để đặt</span>
                                    </a>
                                </c:when>
                                <c:when test="${tour.currentCapacity >= tour.maxCapacity}">
                                    <button class="btn btn-secondary btn-book" disabled>
                                        <i class="fas fa-ban"></i> 
                                        <span>Đã hết chỗ</span>
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <!-- Số lượng người -->
                                    <div style="margin-bottom:20px">
                                        <label style="display:block;font-size:.9rem;color:rgba(255,255,255,.7);margin-bottom:10px;font-weight:700">
                                            <i class="fas fa-users" style="color:#60A5FA;margin-right:6px"></i>
                                            Số lượng người: <span style="color:rgba(255,255,255,.5);font-weight:500">(Tối đa ${tour.maxCapacity - tour.currentCapacity})</span>
                                        </label>
                                        <input type="number" id="quantityInput" value="1" min="1" max="${tour.maxCapacity - tour.currentCapacity}" 
                                               style="width:100%;padding:14px 16px;background:rgba(255,255,255,.06);border:2px solid rgba(255,255,255,.15);border-radius:12px;color:#fff;font-size:1.1rem;font-weight:700;transition:all .3s;text-align:center"
                                               onfocus="this.style.borderColor='#3B82F6';this.style.background='rgba(59,130,246,.1)'"
                                               onblur="this.style.borderColor='rgba(255,255,255,.15)';this.style.background='rgba(255,255,255,.06)'">
                                    </div>
                                    
                                    <!-- Nút Thêm vào giỏ hàng -->
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="margin-bottom:14px">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="tourId" value="${tour.id}">
                                        <input type="hidden" name="quantity" id="quantityHidden" value="1">
                                        <button type="submit" class="btn btn-cart btn-book">
                                            <i class="fas fa-shopping-cart"></i> 
                                            <span>Thêm vào giỏ hàng</span>
                                        </button>
                                    </form>
                                    
                                    <!-- Nút Đặt ngay - Thêm vào giỏ và chuyển đến checkout -->
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="margin-bottom:14px">
                                        <input type="hidden" name="action" value="addAndCheckout">
                                        <input type="hidden" name="tourId" value="${tour.id}">
                                        <input type="hidden" name="quantity" id="quantityHidden2" value="1">
                                        <button type="submit" class="btn btn-primary btn-book">
                                            <i class="fas fa-bolt"></i> 
                                            <span>Đặt tour ngay</span>
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                            
                            <a href="${pageContext.request.contextPath}/explore" class="btn btn-secondary btn-book">
                                <i class="fas fa-compass"></i> 
                                <span>Xem tour khác</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div style="text-align:center;padding:60px 20px">
                <i class="fas fa-exclamation-circle" style="font-size:3rem;color:rgba(255,255,255,.3);margin-bottom:16px"></i>
                <h2 style="color:#fff;margin-bottom:12px">Không tìm thấy tour</h2>
                <p style="color:rgba(255,255,255,.5);margin-bottom:24px">Tour bạn đang tìm không tồn tại hoặc đã bị xóa</p>
                <a href="${pageContext.request.contextPath}/explore" class="btn btn-primary">Quay lại trang chủ</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
// Đồng bộ số lượng người giữa input và hidden fields
const quantityInput = document.getElementById('quantityInput');
const quantityHidden = document.getElementById('quantityHidden');
const quantityHidden2 = document.getElementById('quantityHidden2');

if (quantityInput && quantityHidden && quantityHidden2) {
    quantityInput.addEventListener('input', function() {
        quantityHidden.value = this.value;
        quantityHidden2.value = this.value;
    });
}
</script>

</body>
</html>
