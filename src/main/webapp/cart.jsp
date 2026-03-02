<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng | EZTravel Đà Nẵng</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
    body{font-family:'Plus Jakarta Sans',system-ui,sans-serif;background:#F7F8FC;color:#1B1F3B;-webkit-font-smoothing:antialiased}
    .cart-page{max-width:1280px;margin:0 auto;padding:100px 30px 80px}

    /* Header */
    .page-head{margin-bottom:36px;display:flex;justify-content:space-between;align-items:flex-end;flex-wrap:wrap;gap:12px}
    .page-head h1{font-size:2.2rem;font-weight:800;color:#1B1F3B;letter-spacing:-.5px;display:flex;align-items:center;gap:12px}
    .page-head h1 i{color:#FF6F61}
    .page-head p{color:#6B7194;margin-top:4px;font-size:.92rem}
    .item-count{background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;font-size:.75rem;font-weight:800;padding:4px 12px;border-radius:999px;letter-spacing:.3px}

    /* Cart Layout: Image left + Content right */
    .cart-layout{display:grid;grid-template-columns:1fr 400px;gap:30px;align-items:start}
    .cart-items{display:flex;flex-direction:column;gap:16px}

    /* Cart Item - IMAGE LEFT LAYOUT */
    .cart-item{background:#fff;border-radius:20px;overflow:hidden;box-shadow:0 2px 12px rgba(27,31,59,.05);border:1px solid #E8EAF0;transition:.3s;display:grid;grid-template-columns:220px 1fr;min-height:180px}
    .cart-item:hover{box-shadow:0 8px 30px rgba(27,31,59,.1);transform:translateY(-2px)}

    /* Image Section */
    .cart-item .item-image{position:relative;overflow:hidden}
    .cart-item .item-image img{width:100%;height:100%;object-fit:cover;transition:.5s}
    .cart-item:hover .item-image img{transform:scale(1.05)}
    .item-badge{position:absolute;top:12px;left:12px;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;font-size:.68rem;font-weight:800;padding:5px 12px;border-radius:999px;letter-spacing:.3px;box-shadow:0 2px 8px rgba(255,111,97,.3)}

    /* Content Section */
    .cart-item .item-content{padding:22px 24px;display:flex;flex-direction:column;justify-content:space-between}
    .item-top{display:flex;justify-content:space-between;align-items:flex-start;gap:12px}
    .item-top h3{font-size:1.08rem;font-weight:800;color:#1B1F3B;line-height:1.35;flex:1}
    .btn-remove{width:36px;height:36px;border-radius:10px;border:1px solid #E8EAF0;background:#fff;color:#A0A5C3;display:flex;align-items:center;justify-content:center;cursor:pointer;transition:.3s;font-size:.82rem;flex-shrink:0}
    .btn-remove:hover{background:#FEF2F2;border-color:#FECACA;color:#DC2626}

    .item-meta{display:flex;gap:14px;margin-top:8px;flex-wrap:wrap}
    .item-meta span{font-size:.8rem;color:#6B7194;display:flex;align-items:center;gap:5px}
    .item-meta span i{color:#FF6F61;font-size:.7rem}

    .item-bottom{display:flex;justify-content:space-between;align-items:center;margin-top:16px;padding-top:14px;border-top:1px solid #F0F1F5}

    /* Quantity Controls */
    .qty-control{display:flex;align-items:center;gap:0;border:2px solid #E8EAF0;border-radius:12px;overflow:hidden;background:#FAFBFF}
    .qty-btn{width:36px;height:36px;display:flex;align-items:center;justify-content:center;border:none;background:transparent;cursor:pointer;font-size:.85rem;color:#6B7194;transition:.2s;font-weight:800}
    .qty-btn:hover{background:rgba(255,111,97,.08);color:#FF6F61}
    .qty-value{width:42px;text-align:center;font-weight:800;font-size:.92rem;color:#1B1F3B;border-left:1px solid #E8EAF0;border-right:1px solid #E8EAF0;line-height:36px;background:#fff}

    .item-price{text-align:right}
    .item-price .unit{font-size:.78rem;color:#A0A5C3;font-weight:600}
    .item-price .total{font-size:1.2rem;font-weight:800;color:#FF6F61;margin-top:2px}

    /* Empty state */
    .cart-empty{text-align:center;padding:80px 30px;background:#fff;border-radius:24px;border:1px solid #E8EAF0;box-shadow:0 4px 20px rgba(27,31,59,.04);grid-column:span 2}
    .cart-empty .icon{font-size:4.5rem;margin-bottom:18px;opacity:.8}
    .cart-empty h3{font-size:1.3rem;color:#1B1F3B;margin-bottom:8px;font-weight:800}
    .cart-empty p{color:#6B7194;max-width:360px;margin:0 auto 28px;line-height:1.7}
    .btn-explore{display:inline-flex;align-items:center;gap:8px;padding:14px 32px;border-radius:999px;font-weight:800;font-size:.92rem;border:none;cursor:pointer;font-family:inherit;transition:.3s;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;box-shadow:0 4px 15px rgba(255,111,97,.3);text-decoration:none}
    .btn-explore:hover{transform:translateY(-2px);box-shadow:0 8px 25px rgba(255,111,97,.4)}

    /* Order Summary - Sticky */
    .order-summary{position:sticky;top:90px}
    .summary-card{background:#fff;border-radius:24px;box-shadow:0 8px 35px rgba(27,31,59,.08);border:1px solid #E8EAF0;overflow:hidden}
    .summary-head{background:linear-gradient(135deg,#1B1F3B,#2D3561);padding:24px 28px;color:#fff}
    .summary-head h3{font-size:1.08rem;font-weight:800;display:flex;align-items:center;gap:10px}
    .summary-head .sub{font-size:.78rem;opacity:.6;margin-top:4px}
    .summary-body{padding:24px 28px}
    .sum-item{display:flex;justify-content:space-between;align-items:center;padding:11px 0;border-bottom:1px solid #F5F6FA;font-size:.88rem}
    .sum-item:last-of-type{border-bottom:none}
    .sum-item .name{color:#4A4E6F;font-weight:600;flex:1;margin-right:12px}
    .sum-item .name small{display:block;color:#A0A5C3;font-size:.72rem;font-weight:500;margin-top:2px}
    .sum-item .amount{font-weight:800;color:#1B1F3B;white-space:nowrap}

    .sum-divider{height:1px;background:linear-gradient(90deg,transparent,#E8EAF0,transparent);margin:10px 0}

    .sum-fees{padding:6px 0}
    .sum-fees .sum-item{border-bottom:none;padding:7px 0;font-size:.84rem}
    .sum-fees .sum-item .name{color:#A0A5C3}
    .sum-fees .sum-item .amount{color:#059669;font-weight:700;font-size:.84rem}

    .sum-total{display:flex;justify-content:space-between;align-items:center;padding:18px 0 6px;border-top:2px solid #E8EAF0;margin-top:8px}
    .sum-total span:first-child{font-weight:700;color:#4A4E6F;font-size:.92rem}
    .sum-total span:last-child{font-size:1.5rem;font-weight:800;color:#FF6F61;letter-spacing:-.5px}

    .summary-actions{padding:0 28px 28px;display:flex;flex-direction:column;gap:10px}
    .btn-checkout{display:flex;align-items:center;justify-content:center;gap:10px;width:100%;padding:17px;border-radius:14px;font-weight:800;font-size:1rem;border:none;cursor:pointer;font-family:inherit;transition:.3s;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;box-shadow:0 6px 20px rgba(255,111,97,.25);letter-spacing:.3px}
    .btn-checkout:hover{transform:translateY(-3px);box-shadow:0 12px 35px rgba(255,111,97,.4)}
    .btn-continue{display:flex;align-items:center;justify-content:center;gap:8px;width:100%;padding:14px;border-radius:14px;font-weight:700;font-size:.88rem;border:2px solid #E8EAF0;cursor:pointer;font-family:inherit;transition:.3s;background:#fff;color:#1B1F3B;text-decoration:none}
    .btn-continue:hover{border-color:#1B1F3B;background:rgba(27,31,59,.02)}

    .secure-section{padding:16px 28px;background:#FAFBFF;font-size:.78rem;color:#A0A5C3;display:flex;flex-direction:column;align-items:center;gap:8px;border-top:1px solid #F0F1F5}
    .secure-section .badges{display:flex;gap:6px;flex-wrap:wrap;justify-content:center}
    .secure-section .sbadge{display:flex;align-items:center;gap:4px;background:#fff;border:1px solid #E8EAF0;padding:4px 10px;border-radius:8px;font-size:.7rem;font-weight:700;color:#6B7194}
    .secure-section .sbadge i{color:#06D6A0;font-size:.65rem}

    @media(max-width:1024px){.cart-layout{grid-template-columns:1fr}.order-summary{position:relative;top:0}}
    @media(max-width:768px){.cart-item{grid-template-columns:1fr}.cart-item .item-image{height:180px}.page-head h1{font-size:1.6rem}.cart-empty{grid-column:span 1}}
    </style>
</head>
<body>

<jsp:include page="/common/_header.jsp" />

<div class="cart-page">
    <div class="page-head">
        <div>
            <h1><i class="fas fa-shopping-bag"></i> Giỏ Hàng
                <c:if test="${not empty sessionScope.cart}">
                    <span class="item-count">${sessionScope.cart.size()} tour</span>
                </c:if>
            </h1>
            <p>Xem lại các tour bạn đã chọn trước khi thanh toán</p>
        </div>
    </div>

    <c:choose>
        <c:when test="${not empty sessionScope.cart}">
            <div class="cart-layout">
                <!-- LEFT: Cart Items with Images -->
                <div class="cart-items">
                    <c:forEach items="${sessionScope.cart}" var="item" varStatus="idx">
                        <div class="cart-item">
                            <div class="item-image">
                                <img src="${not empty item.tour.imageUrl ? item.tour.imageUrl : 'https://images.unsplash.com/photo-1559592442-7e182c3c03fb?auto=format&fit=crop&w=500&q=80'}"
                                     alt="${item.tour.tourName}">
                                <c:if test="${item.quantity >= 3}">
                                    <span class="item-badge"><i class="fas fa-fire"></i> Hot</span>
                                </c:if>
                            </div>
                            <div class="item-content">
                                <div>
                                    <div class="item-top">
                                        <h3>${item.tour.tourName}</h3>
                                        <a href="${pageContext.request.contextPath}/cart?action=remove&id=${item.tour.tourId}"
                                           class="btn-remove" title="Xóa khỏi giỏ"
                                           onclick="return confirm('Bạn muốn xóa tour này?')">
                                            <i class="fas fa-trash-alt"></i>
                                        </a>
                                    </div>
                                    <div class="item-meta">
                                        <span><i class="fas fa-map-marker-alt"></i> Đà Nẵng</span>
                                        <span><i class="fas fa-clock"></i> ${item.tour.duration}</span>
                                        <c:if test="${not empty item.travelDate}">
                                            <span><i class="fas fa-calendar-alt"></i> <fmt:formatDate value="${item.travelDate}" pattern="dd/MM/yyyy"/></span>
                                        </c:if>
                                        <span><i class="fas fa-star"></i> 4.8</span>
                                    </div>
                                </div>
                                <div class="item-bottom">
                                    <div class="qty-control">
                                        <a href="${pageContext.request.contextPath}/cart?action=decrease&id=${item.tour.tourId}" class="qty-btn">−</a>
                                        <span class="qty-value">${item.quantity}</span>
                                        <a href="${pageContext.request.contextPath}/cart?action=increase&id=${item.tour.tourId}" class="qty-btn">+</a>
                                    </div>
                                    <div class="item-price">
                                        <div class="unit"><fmt:formatNumber value="${item.tour.price}" type="number" groupingUsed="true"/>đ/người</div>
                                        <div class="total"><fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true"/>đ</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- RIGHT: Order Summary -->
                <div class="order-summary">
                    <div class="summary-card">
                        <div class="summary-head">
                            <h3><i class="fas fa-receipt"></i> Tóm Tắt Đơn Hàng</h3>
                            <div class="sub">${sessionScope.cart.size()} tour du lịch đã chọn</div>
                        </div>
                        <div class="summary-body">
                            <c:set var="subtotal" value="0"/>
                            <c:forEach items="${sessionScope.cart}" var="item">
                                <div class="sum-item">
                                    <span class="name">${item.tour.tourName}
                                        <small>x${item.quantity} người</small>
                                    </span>
                                    <span class="amount"><fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true"/>đ</span>
                                </div>
                                <c:set var="subtotal" value="${subtotal + item.totalPrice}"/>
                            </c:forEach>

                            <div class="sum-divider"></div>

                            <div class="sum-fees">
                                <div class="sum-item">
                                    <span class="name">Phí dịch vụ</span>
                                    <span class="amount" style="color:#059669">Miễn phí</span>
                                </div>
                                <div class="sum-item">
                                    <span class="name">Bảo hiểm du lịch</span>
                                    <span class="amount" style="color:#059669">Đã bao gồm</span>
                                </div>
                            </div>

                            <div class="sum-total">
                                <span>Tổng Thanh Toán</span>
                                <span><fmt:formatNumber value="${subtotal}" type="number" groupingUsed="true"/>đ</span>
                            </div>
                        </div>
                        <div class="summary-actions">
                            <a href="${pageContext.request.contextPath}/checkout" class="btn-checkout">
                                <i class="fas fa-lock"></i> TIẾN HÀNH THANH TOÁN
                            </a>
                            <a href="${pageContext.request.contextPath}/tour" class="btn-continue">
                                <i class="fas fa-compass"></i> Tiếp Tục Khám Phá
                            </a>
                        </div>
                        <div class="secure-section">
                            <div style="display:flex;align-items:center;gap:5px"><i class="fas fa-shield-alt" style="color:#06D6A0"></i> Thanh toán an toàn & bảo mật</div>
                            <div class="badges">
                                <span class="sbadge"><i class="fas fa-check-circle"></i> SePay</span>
                                <span class="sbadge"><i class="fas fa-check-circle"></i> VietQR</span>
                                <span class="sbadge"><i class="fas fa-check-circle"></i> MB Bank</span>
                                <span class="sbadge"><i class="fas fa-check-circle"></i> SSL 256-bit</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="cart-layout">
                <div class="cart-empty">
                    <div class="icon">🛒</div>
                    <h3>Giỏ hàng trống</h3>
                    <p>Bạn chưa thêm tour nào vào giỏ hàng. Hãy khám phá những tour du lịch Đà Nẵng hấp dẫn nhất!</p>
                    <a href="${pageContext.request.contextPath}/tour" class="btn-explore">
                        <i class="fas fa-compass"></i> Khám Phá Tours Đà Nẵng
                    </a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/common/_footer.jsp" />
</body>
</html>
