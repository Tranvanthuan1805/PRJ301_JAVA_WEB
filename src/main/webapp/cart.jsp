<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng | Da Nang Travel Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
    .cart-page{max-width:1280px;margin:0 auto;padding:100px 30px 80px}
    .page-head{margin-bottom:40px}
    .page-head h1{font-size:2.2rem;font-weight:800;color:#1B1F3B;letter-spacing:-.5px}
    .page-head p{color:#6B7194;margin-top:6px}

    .cart-layout{display:grid;grid-template-columns:1fr 380px;gap:30px;align-items:start}

    /* Cart items */
    .cart-items{display:flex;flex-direction:column;gap:16px}
    .cart-item{background:#fff;border-radius:20px;padding:20px;display:flex;gap:20px;align-items:center;box-shadow:0 2px 12px rgba(27,31,59,.05);border:1px solid #E8EAF0;transition:.3s}
    .cart-item:hover{box-shadow:0 8px 25px rgba(27,31,59,.08);transform:translateY(-2px)}
    .cart-item .thumb{width:140px;height:100px;border-radius:14px;overflow:hidden;flex-shrink:0}
    .cart-item .thumb img{width:100%;height:100%;object-fit:cover}
    .cart-item .info{flex:1}
    .cart-item .info h3{font-size:1.05rem;font-weight:700;color:#1B1F3B;margin-bottom:4px}
    .cart-item .info .meta{font-size:.82rem;color:#A0A5C3;display:flex;gap:12px;margin-bottom:8px}
    .cart-item .info .meta i{color:#FF6F61;margin-right:3px}
    .cart-item .pricing{display:flex;align-items:center;gap:20px}
    .cart-item .qty{font-size:.88rem;color:#6B7194;background:#F7F8FC;padding:6px 14px;border-radius:10px;font-weight:600}
    .cart-item .total{font-size:1.15rem;font-weight:800;color:#1B1F3B;white-space:nowrap}
    .btn-remove{width:38px;height:38px;border-radius:12px;border:1px solid #E8EAF0;background:#fff;color:#A0A5C3;display:flex;align-items:center;justify-content:center;cursor:pointer;transition:.3s;font-size:.85rem;flex-shrink:0}
    .btn-remove:hover{background:#FEF2F2;border-color:#FECACA;color:#DC2626}

    /* Empty state */
    .cart-empty{text-align:center;padding:80px 30px;background:#fff;border-radius:24px;border:1px solid #E8EAF0;box-shadow:0 4px 20px rgba(27,31,59,.04)}
    .cart-empty .icon{font-size:4rem;margin-bottom:18px;filter:grayscale(.2)}
    .cart-empty h3{font-size:1.3rem;color:#1B1F3B;margin-bottom:8px}
    .cart-empty p{color:#6B7194;max-width:350px;margin:0 auto 25px}
    .btn-primary{display:inline-flex;align-items:center;gap:8px;padding:14px 30px;border-radius:999px;font-weight:700;font-size:.9rem;border:none;cursor:pointer;font-family:inherit;transition:.3s;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;box-shadow:0 4px 15px rgba(255,111,97,.3)}
    .btn-primary:hover{transform:translateY(-2px);box-shadow:0 8px 25px rgba(255,111,97,.4)}

    /* Order Summary */
    .order-summary{position:sticky;top:90px}
    .summary-card{background:#fff;border-radius:20px;box-shadow:0 8px 30px rgba(27,31,59,.08);border:1px solid #E8EAF0;overflow:hidden}
    .summary-card .head{background:linear-gradient(135deg,#1B1F3B,#2D3561);padding:24px 28px;color:#fff}
    .summary-card .head h3{font-size:1.05rem;font-weight:700;display:flex;align-items:center;gap:10px}
    .summary-card .body{padding:24px 28px}
    .sum-row{display:flex;justify-content:space-between;padding:10px 0;font-size:.9rem;color:#6B7194;border-bottom:1px solid #F0F1F5}
    .sum-row:last-of-type{border-bottom:none}
    .sum-row.total{border-top:2px solid #E8EAF0;margin-top:8px;padding-top:16px}
    .sum-row.total span{font-size:1.3rem;font-weight:800;color:#FF6F61}
    .summary-card .actions{padding:0 28px 28px;display:flex;flex-direction:column;gap:10px}
    .btn-checkout{display:flex;align-items:center;justify-content:center;gap:8px;width:100%;padding:16px;border-radius:14px;font-weight:800;font-size:1rem;border:none;cursor:pointer;font-family:inherit;transition:.3s;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;box-shadow:0 6px 20px rgba(255,111,97,.25)}
    .btn-checkout:hover{transform:translateY(-3px);box-shadow:0 12px 30px rgba(255,111,97,.4)}
    .btn-continue{display:flex;align-items:center;justify-content:center;gap:8px;width:100%;padding:14px;border-radius:14px;font-weight:700;font-size:.9rem;border:2px solid #E8EAF0;cursor:pointer;font-family:inherit;transition:.3s;background:#fff;color:#1B1F3B}
    .btn-continue:hover{border-color:#1B1F3B;background:rgba(27,31,59,.02)}

    .secure-note{text-align:center;padding:16px 28px;font-size:.78rem;color:#A0A5C3;display:flex;align-items:center;justify-content:center;gap:6px}
    .secure-note i{color:#06D6A0}

    @media(max-width:1024px){.cart-layout{grid-template-columns:1fr}.order-summary{position:relative;top:0}}
    @media(max-width:768px){.cart-item{flex-direction:column;align-items:flex-start}.cart-item .thumb{width:100%;height:160px}.cart-item .pricing{width:100%;justify-content:space-between}}
    </style>
</head>
<body>

<jsp:include page="/common/_header.jsp" />

<div class="cart-page">
    <div class="page-head">
        <h1><i class="fas fa-shopping-bag" style="color:#FF6F61"></i> Giỏ Hàng</h1>
        <p>Xem lại các tour bạn đã chọn trước khi thanh toán</p>
    </div>

    <c:choose>
        <c:when test="${not empty sessionScope.cart}">
            <div class="cart-layout">
                <div class="cart-items">
                    <c:forEach items="${sessionScope.cart}" var="item">
                        <div class="cart-item">
                            <div class="thumb">
                                <img src="${not empty item.tour.imageUrl ? item.tour.imageUrl : 'https://images.unsplash.com/photo-1559592442-7e182c3c03fb?auto=format&fit=crop&w=300&q=80'}" alt="${item.tour.tourName}">
                            </div>
                            <div class="info">
                                <h3>${item.tour.tourName}</h3>
                                <div class="meta">
                                    <span><i class="fas fa-map-marker-alt"></i> Đà Nẵng</span>
                                    <span><i class="fas fa-clock"></i> ${item.tour.duration}</span>
                                </div>
                                <div class="pricing">
                                    <span class="qty"><i class="fas fa-user"></i> x${item.quantity}</span>
                                    <span class="total"><fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true"/>đ</span>
                                </div>
                            </div>
                            <a href="cart?action=remove&id=${item.tour.tourId}" class="btn-remove" title="Xóa">
                                <i class="fas fa-trash-alt"></i>
                            </a>
                        </div>
                    </c:forEach>
                </div>

                <div class="order-summary">
                    <div class="summary-card">
                        <div class="head">
                            <h3><i class="fas fa-receipt"></i> Tóm Tắt Đơn Hàng</h3>
                        </div>
                        <div class="body">
                            <c:forEach items="${sessionScope.cart}" var="item">
                                <div class="sum-row">
                                    <span>${item.tour.tourName}</span>
                                    <span><fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true"/>đ</span>
                                </div>
                            </c:forEach>
                            <div class="sum-row total">
                                <span>Tổng Cộng</span>
                                <span><fmt:formatNumber value="${cartTotal}" type="number" groupingUsed="true"/>đ</span>
                            </div>
                        </div>
                        <div class="actions">
                            <a href="checkout" class="btn-checkout">
                                <i class="fas fa-credit-card"></i> THANH TOÁN
                            </a>
                            <a href="${pageContext.request.contextPath}/" class="btn-continue">
                                <i class="fas fa-compass"></i> Tiếp Tục Khám Phá
                            </a>
                        </div>
                        <div class="secure-note">
                            <i class="fas fa-shield-alt"></i> Thanh toán an toàn qua QR SePay
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="cart-empty">
                <div class="icon">🛒</div>
                <h3>Giỏ hàng trống</h3>
                <p>Bạn chưa thêm tour nào. Hãy khám phá và chọn tour yêu thích!</p>
                <a href="${pageContext.request.contextPath}/tour" class="btn-primary">
                    <i class="fas fa-compass"></i> Khám Phá Tours
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/common/_footer.jsp" />
</body>
</html>
