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

    .qty-input{width:50px;text-align:center;font-weight:800;font-size:.92rem;color:#1B1F3B;border:1px solid #E8EAF0;background:#fff;outline:none;padding:0;font-family:inherit;transition:.2s}
    .qty-input:focus{border-color:#FF6F61;box-shadow:0 0 0 2px rgba(255,111,97,.1)}
    .qty-input::-webkit-outer-spin-button,.qty-input::-webkit-inner-spin-button{-webkit-appearance:none;appearance:none;margin:0}
    .qty-input[type=number]{-moz-appearance:textfield;appearance:textfield}

    .qty-error{display:none;margin-top:12px;padding:10px 12px;background:rgba(239,68,68,.08);border:1px solid rgba(239,68,68,.2);border-radius:10px;display:flex;align-items:flex-start;gap:8px;font-size:.85rem;animation:slideDown .3s ease}

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

    @keyframes slideDown {
        from { opacity:0; transform:translateY(-10px); }
        to { opacity:1; transform:translateY(0); }
    }

    .coupon-section{padding:16px 0;border-top:1px solid #F0F1F5;margin-top:8px}
    .coupon-title{font-size:.82rem;font-weight:700;color:#4A4E6F;margin-bottom:10px;display:flex;align-items:center;gap:6px}
    .coupon-title i{color:#FF6F61}
    .coupon-form{display:flex;gap:8px}
    .coupon-input{flex:1;padding:12px 14px;border:2px solid #E8EAF0;border-radius:12px;font-size:.88rem;font-family:inherit;font-weight:600;text-transform:uppercase;letter-spacing:1px;outline:none;transition:.3s;background:#FAFBFF;color:#1B1F3B}
    .coupon-input:focus{border-color:#FF6F61;background:#fff;box-shadow:0 0 0 3px rgba(255,111,97,.1)}
    .coupon-input::placeholder{text-transform:none;letter-spacing:0;font-weight:500;color:#A0A5C3}
    .btn-coupon{padding:12px 20px;border:none;border-radius:12px;font-weight:800;font-size:.82rem;cursor:pointer;font-family:inherit;transition:.3s;white-space:nowrap}
    .btn-apply{background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;box-shadow:0 3px 12px rgba(255,111,97,.2)}
    .btn-apply:hover{transform:translateY(-1px);box-shadow:0 6px 18px rgba(255,111,97,.35)}
    .btn-apply:disabled{opacity:.6;cursor:not-allowed;transform:none}
    .coupon-msg{margin-top:8px;font-size:.78rem;padding:8px 12px;border-radius:10px;display:none;align-items:center;gap:6px;animation:fadeIn .3s ease}
    .coupon-msg.success{display:flex;background:rgba(6,214,160,.08);color:#059669;border:1px solid rgba(6,214,160,.15)}
    .coupon-msg.error{display:flex;background:rgba(239,68,68,.06);color:#DC2626;border:1px solid rgba(239,68,68,.1)}
    .coupon-applied{display:flex;align-items:center;justify-content:space-between;padding:10px 14px;background:linear-gradient(135deg,rgba(6,214,160,.06),rgba(6,214,160,.02));border:1px solid rgba(6,214,160,.15);border-radius:12px;margin-top:8px}
    .coupon-applied .coupon-tag{display:flex;align-items:center;gap:8px;font-size:.82rem;font-weight:700;color:#059669}
    .coupon-applied .coupon-tag i{font-size:.9rem}
    .coupon-applied .coupon-tag code{background:rgba(6,214,160,.12);padding:3px 10px;border-radius:6px;font-family:'Plus Jakarta Sans',sans-serif;letter-spacing:1px;font-size:.78rem}
    .btn-remove-coupon{background:none;border:none;color:#A0A5C3;cursor:pointer;font-size:.82rem;padding:4px 8px;border-radius:6px;transition:.2s}
    .btn-remove-coupon:hover{color:#DC2626;background:rgba(239,68,68,.06)}
    .discount-row{display:flex;justify-content:space-between;align-items:center;padding:8px 0;font-size:.86rem;color:#059669;font-weight:700}
    .discount-row .discount-amount{color:#059669}

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
                                        <button class="qty-btn" data-tour-id="${item.tour.tourId}" data-action="decrease" onclick="handleQtyBtn(this)" title="Giảm">−</button>
                                        <input type="number" class="qty-input" id="qty-${item.tour.tourId}" value="${item.quantity}" min="1" max="${item.tour.maxPeople}" 
                                               data-max="${item.tour.maxPeople}"
                                               data-tour-id="${item.tour.tourId}"
                                               data-tour-name="${item.tour.tourName}"
                                               oninput="validateQtyInput(this)"
                                               onchange="updateQuantityFromInput(this)">
                                        <button class="qty-btn" data-tour-id="${item.tour.tourId}" data-action="increase" onclick="handleQtyBtn(this)" title="Tăng">+</button>
                                    </div>
                                    <div class="item-price">
                                        <div class="unit"><fmt:formatNumber value="${item.tour.price}" type="number" groupingUsed="true"/>đ/người</div>
                                        <div class="total"><fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true"/>đ</div>
                                    </div>
                                </div>
                                
                                <!-- Thông báo lỗi nếu vượt quá sức chứa -->
                                <div id="error-${item.tour.tourId}" class="qty-error" style="display:none;margin-top:12px;padding:10px 12px;background:rgba(239,68,68,.08);border:1px solid rgba(239,68,68,.2);border-radius:10px;align-items:flex-start;gap:8px;font-size:.85rem">
                                    <i class="fas fa-exclamation-circle" style="color:#DC2626;flex-shrink:0;margin-top:2px"></i>
                                    <div style="color:#991B1B;font-weight:600" id="error-msg-${item.tour.tourId}"></div>
                                </div>
                                <c:if test="${not empty sessionScope['cartError_'.concat(item.tour.tourId)]}">
                                    <c:set var="errorMsg" value="${sessionScope['cartError_'.concat(item.tour.tourId)]}"/>
                                    <script>
                                        document.addEventListener('DOMContentLoaded', function() {
                                            const errorDiv = document.getElementById('error-${item.tour.tourId}');
                                            const errorMsgEl = document.getElementById('error-msg-${item.tour.tourId}');
                                            if (errorDiv && errorMsgEl) {
                                                errorMsgEl.textContent = '${errorMsg}';
                                                errorDiv.style.display = 'flex';
                                            }
                                        });
                                    </script>
                                </c:if>
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

                            <!-- ═══ MÃ GIẢM GIÁ ═══ -->
                            <div class="coupon-section">
                                <div class="coupon-title"><i class="fas fa-ticket-alt"></i> Mã Giảm Giá</div>
                                <div id="coupon-form-area">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.appliedCoupon}">
                                            <div class="coupon-applied" id="coupon-applied">
                                                <div class="coupon-tag">
                                                    <i class="fas fa-check-circle"></i>
                                                    <code>${sessionScope.appliedCoupon.code}</code>
                                                    <span>${sessionScope.appliedCoupon.discountLabel}</span>
                                                </div>
                                                <button class="btn-remove-coupon" onclick="removeCoupon()" title="Xóa mã">
                                                    <i class="fas fa-times"></i>
                                                </button>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="coupon-form" id="coupon-form">
                                                <input type="text" id="coupon-code" class="coupon-input"
                                                       placeholder="Nhập mã giảm giá..." maxlength="30">
                                                <button class="btn-coupon btn-apply" id="btn-apply" onclick="applyCoupon()">
                                                    Áp dụng
                                                </button>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="coupon-msg" id="coupon-msg"></div>
                                </div>
                            </div>

                            <!-- Discount display -->
                            <div id="discount-row" class="discount-row" <c:if test="${empty sessionScope.couponDiscount}">style="display:none"</c:if>>
                                <span><i class="fas fa-tag"></i> Giảm giá</span>
                                <span class="discount-amount" id="discount-amount">
                                    -<fmt:formatNumber value="${sessionScope.couponDiscount != null ? sessionScope.couponDiscount : 0}" type="number" groupingUsed="true"/>đ
                                </span>
                            </div>

                            <div class="sum-total">
                                <span>Tổng Thanh Toán</span>
                                <c:set var="finalTotal" value="${subtotal - (sessionScope.couponDiscount != null ? sessionScope.couponDiscount : 0)}"/>
                                <span id="final-total"><fmt:formatNumber value="${finalTotal}" type="number" groupingUsed="true"/>đ</span>
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

<script>
const CTX = '${pageContext.request.contextPath}';

/**
 * Hiển thị error message
 */
function showQtyError(tourId, message) {
    console.log('showQtyError called:', tourId, message);
    const errorDiv = document.getElementById('error-' + tourId);
    const errorMsg = document.getElementById('error-msg-' + tourId);
    console.log('errorDiv:', errorDiv, 'errorMsg:', errorMsg);
    if (errorDiv && errorMsg) {
        errorMsg.textContent = message;
        errorDiv.style.display = 'flex';
        console.log('Error displayed');
    }
}

/**
 * Ẩn error message
 */
function hideQtyError(tourId) {
    const errorDiv = document.getElementById('error-' + tourId);
    if (errorDiv) {
        errorDiv.style.display = 'none';
    }
}

/**
 * Validate input realtime - chỉ cho phép số dương
 */
function validateQtyInput(input) {
    const tourId = input.dataset.tourId;
    const maxPeople = parseInt(input.dataset.max);
    const tourName = input.dataset.tourName;
    let value = input.value.trim();
    
    console.log('validateQtyInput:', tourId, 'value:', value, 'max:', maxPeople);
    
    // Xóa ký tự không phải số
    value = value.replace(/[^0-9]/g, '');
    
    // Nếu rỗng, để trống
    if (value === '') {
        input.value = '';
        hideQtyError(tourId);
        return;
    }
    
    let num = parseInt(value);
    
    // Nếu < 1, set về 1
    if (num < 1) {
        num = 1;
    }
    
    // Nếu > maxPeople, hiển thị error và reset về giá trị cũ
    if (num > maxPeople) {
        showQtyError(tourId, `❌ Vượt quá sức chứa! Tour "${tourName}" chỉ có tối đa ${maxPeople} chỗ.`);
        // Không thay đổi input value, để người dùng thấy lỗi
        return;
    }
    
    input.value = num;
    hideQtyError(tourId);
}

/**
 * Tăng số lượng
 */
function increaseQty(tourId, maxPeople) {
    console.log('increaseQty:', tourId, maxPeople);
    const input = document.getElementById('qty-' + tourId);
    if (!input) {
        console.log('Input not found');
        return;
    }
    
    let current = parseInt(input.value) || 1;
    let newQty = current + 1;
    
    console.log('current:', current, 'newQty:', newQty);
    
    if (newQty > maxPeople) {
        showQtyError(tourId, `❌ Vượt quá sức chứa! Tối đa ${maxPeople} chỗ.`);
        return;
    }
    
    input.value = newQty;
    hideQtyError(tourId);
    updateQuantity(tourId, newQty, maxPeople);
}

/**
 * Giảm số lượng
 */
function decreaseQty(tourId, maxPeople) {
    console.log('decreaseQty:', tourId, maxPeople);
    const input = document.getElementById('qty-' + tourId);
    if (!input) return;
    
    let current = parseInt(input.value) || 1;
    let newQty = current - 1;
    
    if (newQty <= 0) {
        if (confirm('Bạn muốn xóa tour này khỏi giỏ hàng?')) {
            window.location.href = CTX + '/cart?action=remove&id=' + tourId;
        }
        return;
    }
    
    input.value = newQty;
    hideQtyError(tourId);
    updateQuantity(tourId, newQty, maxPeople);
}

/**
 * Xử lý click button +/-
 */
function handleQtyBtn(btn) {
    const tourId = parseInt(btn.dataset.tourId);
    const action = btn.dataset.action;
    const input = document.getElementById('qty-' + tourId);
    if (!input) {
        console.log('Input not found for tourId:', tourId);
        return;
    }
    
    const maxPeople = parseInt(input.dataset.max);
    
    if (action === 'increase') {
        increaseQty(tourId, maxPeople);
    } else if (action === 'decrease') {
        decreaseQty(tourId, maxPeople);
    }
}

/**
 * Cập nhật số lượng từ input change event
 */
function updateQuantityFromInput(input) {
    const tourId = parseInt(input.dataset.tourId);
    const maxPeople = parseInt(input.dataset.max);
    updateQuantity(tourId, input.value, maxPeople);
}

/**
 * Cập nhật số lượng - gửi request đến server
 */
function updateQuantity(tourId, newQty, maxPeople) {
    newQty = parseInt(newQty);
    
    console.log('updateQuantity:', tourId, newQty, maxPeople);
    
    // Validate
    if (isNaN(newQty) || newQty <= 0) {
        if (confirm('Bạn muốn xóa tour này khỏi giỏ hàng?')) {
            window.location.href = CTX + '/cart?action=remove&id=' + tourId;
        }
        return;
    }
    
    if (newQty > maxPeople) {
        // Không gửi request, chỉ hiển thị error
        const input = document.getElementById('qty-' + tourId);
        const tourName = input.dataset.tourName;
        showQtyError(tourId, `❌ Vượt quá sức chứa! Tour "${tourName}" chỉ có tối đa ${maxPeople} chỗ.`);
        return;
    }
    
    // Gửi request
    console.log('Redirecting to:', CTX + '/cart?action=setqty&id=' + tourId + '&qty=' + newQty);
    window.location.href = CTX + '/cart?action=setqty&id=' + tourId + '&qty=' + newQty;
}

// Event delegation cho qty buttons và input
document.addEventListener('DOMContentLoaded', function() {
    console.log('DOMContentLoaded - setting up event listeners');
    
    // Qty input events
    document.addEventListener('input', function(e) {
        if (e.target.classList.contains('qty-input')) {
            console.log('Input event on qty-input');
            validateQtyInput(e.target);
        }
    });
    
    document.addEventListener('change', function(e) {
        if (e.target.classList.contains('qty-input')) {
            console.log('Change event on qty-input');
            const tourId = parseInt(e.target.dataset.tourId);
            const maxPeople = parseInt(e.target.dataset.max);
            updateQuantity(tourId, e.target.value, maxPeople);
        }
    });
    
    document.addEventListener('keypress', function(e) {
        if (e.target.classList.contains('qty-input') && e.key === 'Enter') {
            console.log('Enter key on qty-input');
            const tourId = parseInt(e.target.dataset.tourId);
            const maxPeople = parseInt(e.target.dataset.max);
            updateQuantity(tourId, e.target.value, maxPeople);
        }
    });
});

function applyCoupon() {
    const code = document.getElementById('coupon-code').value.trim();
    if (!code) { showMsg('error', 'Vui lòng nhập mã giảm giá'); return; }

    const btn = document.getElementById('btn-apply');
    btn.disabled = true;
    btn.textContent = '...';

    fetch(CTX + '/coupon', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'action=apply&code=' + encodeURIComponent(code)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            showMsg('success', data.message);
            // Show applied coupon tag
            document.getElementById('coupon-form-area').innerHTML =
                '<div class="coupon-applied" id="coupon-applied">' +
                    '<div class="coupon-tag">' +
                        '<i class="fas fa-check-circle"></i>' +
                        '<code>' + data.couponCode + '</code>' +
                        '<span>' + data.discountLabel + '</span>' +
                    '</div>' +
                    '<button class="btn-remove-coupon" onclick="removeCoupon()" title="Xóa mã">' +
                        '<i class="fas fa-times"></i>' +
                    '</button>' +
                '</div>' +
                '<div class="coupon-msg success" id="coupon-msg"><i class="fas fa-check-circle"></i> ' + data.message + '</div>';

            // Update discount row
            document.getElementById('discount-row').style.display = 'flex';
            document.getElementById('discount-amount').textContent = '-' + data.discountFormatted + 'đ';
            document.getElementById('final-total').textContent = data.finalTotalFormatted + 'đ';
        } else {
            showMsg('error', data.message);
            btn.disabled = false;
            btn.textContent = 'Áp dụng';
        }
    })
    .catch(() => {
        showMsg('error', 'Lỗi kết nối. Vui lòng thử lại.');
        btn.disabled = false;
        btn.textContent = 'Áp dụng';
    });
}

function removeCoupon() {
    fetch(CTX + '/coupon', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'action=remove'
    })
    .then(r => r.json())
    .then(data => {
        // Reload page to reset totals
        location.reload();
    });
}

function showMsg(type, msg) {
    const el = document.getElementById('coupon-msg');
    if (!el) return;
    el.className = 'coupon-msg ' + type;
    el.innerHTML = '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + '"></i> ' + msg;
    el.style.display = 'flex';
    if (type === 'error') setTimeout(() => { el.style.display = 'none'; }, 4000);
}

// Enter key to apply coupon
document.addEventListener('DOMContentLoaded', () => {
    const input = document.getElementById('coupon-code');
    if (input) input.addEventListener('keypress', e => { if (e.key === 'Enter') applyCoupon(); });
});
</script>
</body>
</html>
