<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Thanh Toán | EZTravel Đà Nẵng</title>
                <link
                    href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
                <style>
                    body {
                        font-family: 'Plus Jakarta Sans', system-ui, sans-serif;
                        background: #F7F8FC;
                        color: #1B1F3B;
                        -webkit-font-smoothing: antialiased
                    }

                    .checkout-page {
                        max-width: 1100px;
                        margin: 0 auto;
                        padding: 100px 30px 80px
                    }

                    .checkout-header {
                        text-align: center;
                        margin-bottom: 40px
                    }

                    .checkout-header h1 {
                        font-size: 2rem;
                        font-weight: 800;
                        letter-spacing: -.5px
                    }

                    .checkout-header h1 i {
                        color: #FF6F61
                    }

                    .checkout-header p {
                        color: #6B7194;
                        margin-top: 6px
                    }

                    /* Steps */
                    .steps {
                        display: flex;
                        justify-content: center;
                        gap: 0;
                        margin-bottom: 40px
                    }

                    .step {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        padding: 12px 24px;
                        position: relative
                    }

                    .step .num {
                        width: 32px;
                        height: 32px;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-weight: 800;
                        font-size: .82rem;
                        border: 2px solid #E8EAF0;
                        color: #A0A5C3;
                        background: #fff;
                        transition: .3s
                    }

                    .step.active .num {
                        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
                        color: #fff;
                        border-color: #FF6F61
                    }

                    .step.done .num {
                        background: #059669;
                        border-color: #059669;
                        color: #fff
                    }

                    .step .text {
                        font-weight: 700;
                        font-size: .85rem;
                        color: #A0A5C3
                    }

                    .step.active .text {
                        color: #1B1F3B
                    }

                    .step.done .text {
                        color: #059669
                    }

                    .step-line {
                        width: 80px;
                        height: 2px;
                        background: #E8EAF0;
                        align-self: center
                    }

                    .step-line.done {
                        background: #059669
                    }

                    .checkout-layout {
                        display: grid;
                        grid-template-columns: 1fr 400px;
                        gap: 30px;
                        align-items: start
                    }

                    /* Form */
                    .form-card {
                        background: #fff;
                        border-radius: 20px;
                        padding: 32px;
                        box-shadow: 0 4px 20px rgba(27, 31, 59, .05);
                        border: 1px solid #E8EAF0
                    }

                    .form-card h3 {
                        font-size: 1.1rem;
                        font-weight: 800;
                        margin-bottom: 20px;
                        display: flex;
                        align-items: center;
                        gap: 10px
                    }

                    .form-card h3 i {
                        color: #FF6F61
                    }

                    .form-row {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 16px;
                        margin-bottom: 16px
                    }

                    .form-group {
                        display: flex;
                        flex-direction: column;
                        gap: 6px
                    }

                    .form-group.full {
                        grid-column: span 2
                    }

                    .form-group label {
                        font-size: .82rem;
                        font-weight: 700;
                        color: #4A4E6F
                    }

                    .form-group input,
                    .form-group textarea {
                        padding: 12px 16px;
                        border-radius: 12px;
                        border: 2px solid #E8EAF0;
                        font-family: inherit;
                        font-size: .9rem;
                        color: #1B1F3B;
                        transition: .3s;
                        outline: none;
                        background: #FAFBFF
                    }

                    .form-group input:focus,
                    .form-group textarea:focus {
                        border-color: #FF6F61;
                        background: #fff;
                        box-shadow: 0 0 0 4px rgba(255, 111, 97, .08)
                    }

                    .form-group textarea {
                        resize: vertical;
                        min-height: 80px
                    }

                    /* Summary */
                    .summary-card {
                        background: #fff;
                        border-radius: 20px;
                        box-shadow: 0 8px 30px rgba(27, 31, 59, .08);
                        border: 1px solid #E8EAF0;
                        overflow: hidden;
                        position: sticky;
                        top: 90px
                    }

                    .summary-head {
                        background: linear-gradient(135deg, #1B1F3B, #2D3561);
                        padding: 24px 28px;
                        color: #fff
                    }

                    .summary-head h3 {
                        font-size: 1.05rem;
                        font-weight: 700;
                        display: flex;
                        align-items: center;
                        gap: 10px
                    }

                    .summary-body {
                        padding: 24px 28px
                    }

                    .summary-item {
                        display: flex;
                        gap: 14px;
                        padding: 14px 0;
                        border-bottom: 1px solid #F0F1F5;
                        align-items: center
                    }

                    .summary-item:last-child {
                        border-bottom: none
                    }

                    .summary-item .thumb {
                        width: 60px;
                        height: 45px;
                        border-radius: 10px;
                        overflow: hidden;
                        flex-shrink: 0
                    }

                    .summary-item .thumb img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover
                    }

                    .summary-item .name {
                        font-weight: 700;
                        font-size: .85rem;
                        color: #1B1F3B;
                        flex: 1
                    }

                    .summary-item .name small {
                        display: block;
                        font-weight: 500;
                        color: #A0A5C3;
                        font-size: .75rem;
                        margin-top: 2px
                    }

                    .summary-item .price {
                        font-weight: 800;
                        color: #1B1F3B;
                        white-space: nowrap;
                        font-size: .88rem
                    }

                    .total-row {
                        display: flex;
                        justify-content: space-between;
                        padding: 18px 0;
                        border-top: 2px solid #E8EAF0;
                        margin-top: 8px
                    }

                    .total-row span:first-child {
                        font-weight: 700;
                        color: #6B7194
                    }

                    .total-row span:last-child {
                        font-size: 1.4rem;
                        font-weight: 800;
                        color: #FF6F61
                    }

                    .summary-actions {
                        padding: 0 28px 28px
                    }

                    .btn-place-order {
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        gap: 10px;
                        width: 100%;
                        padding: 16px;
                        border-radius: 14px;
                        font-weight: 800;
                        font-size: 1rem;
                        border: none;
                        cursor: pointer;
                        font-family: inherit;
                        transition: .3s;
                        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
                        color: #fff;
                        box-shadow: 0 6px 20px rgba(255, 111, 97, .25)
                    }

                    .btn-place-order:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 12px 30px rgba(255, 111, 97, .4)
                    }

                    .btn-place-order:disabled {
                        opacity: .5;
                        cursor: not-allowed;
                        transform: none
                    }

                    .secure-badge {
                        text-align: center;
                        padding: 14px 28px;
                        font-size: .78rem;
                        color: #A0A5C3;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        gap: 6px
                    }

                    .secure-badge i {
                        color: #06D6A0
                    }

                    .payment-methods {
                        display: flex;
                        gap: 8px;
                        justify-content: center;
                        margin-top: 6px
                    }

                    .payment-methods img {
                        height: 20px;
                        opacity: .5
                    }

                    @media(max-width:1024px) {
                        .checkout-layout {
                            grid-template-columns: 1fr
                        }

                        .summary-card {
                            position: relative;
                            top: 0
                        }
                    }

                    @media(max-width:768px) {
                        .form-row {
                            grid-template-columns: 1fr
                        }

                        .form-group.full {
                            grid-column: span 1
                        }

                        .steps {
                            flex-wrap: wrap
                        }

                        .step-line {
                            width: 30px
                        }
                    }
                </style>
            </head>

            <body>
                <jsp:include page="/common/_header.jsp" />

                <div class="checkout-page">
                    <div class="checkout-header">
                        <h1><i class="fas fa-credit-card"></i> Xác Nhận Đơn Hàng</h1>
                        <p>Điền thông tin và tiến hành thanh toán</p>
                    </div>

                    <!-- Steps -->
                    <div class="steps">
                        <div class="step done">
                            <div class="num"><i class="fas fa-check"></i></div>
                            <div class="text">Giỏ Hàng</div>
                        </div>
                        <div class="step-line done"></div>
                        <div class="step active">
                            <div class="num">2</div>
                            <div class="text">Xác Nhận</div>
                        </div>
                        <div class="step-line"></div>
                        <div class="step">
                            <div class="num">3</div>
                            <div class="text">Thanh Toán</div>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm">
                        <div class="checkout-layout">
                            <!-- Left: Form -->
                            <div class="form-card">
                                <h3><i class="fas fa-user"></i> Thông Tin Liên Hệ</h3>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label>Họ và tên *</label>
                                        <input type="text" name="fullName" required placeholder="Nguyễn Văn A"
                                            value="${user.fullName}">
                                    </div>
                                    <div class="form-group">
                                        <label>Số điện thoại *</label>
                                        <input type="tel" name="phone" required placeholder="0912 345 678"
                                            value="${user.phone}">
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group full">
                                        <label>Email *</label>
                                        <input type="email" name="email" required placeholder="email@example.com"
                                            value="${user.email}">
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group full">
                                        <label>Ghi chú (tùy chọn)</label>
                                        <textarea name="notes"
                                            placeholder="Yêu cầu đặc biệt, dị ứng thực phẩm..."></textarea>
                                    </div>
                                </div>

                                <h3 style="margin-top:28px"><i class="fas fa-shield-alt"></i> Phương Thức Thanh Toán
                                </h3>
                                <div style="display:flex;gap:12px;flex-wrap:wrap">
                                    <label
                                        style="display:flex;align-items:center;gap:10px;padding:16px 20px;border-radius:14px;border:2px solid #FF6F61;background:rgba(255,111,97,.04);flex:1;cursor:pointer;min-width:200px">
                                        <input type="radio" name="paymentMethod" value="qr" checked
                                            style="accent-color:#FF6F61">
                                        <div>
                                            <div style="font-weight:700;font-size:.88rem;color:#1B1F3B">🏦 QR SePay /
                                                VietQR</div>
                                            <div style="font-size:.75rem;color:#A0A5C3;margin-top:2px">Quét QR chuyển
                                                khoản ngân hàng</div>
                                        </div>
                                    </label>
                                    <label
                                        style="display:flex;align-items:center;gap:10px;padding:16px 20px;border-radius:14px;border:2px solid #E8EAF0;background:#FAFBFF;flex:1;cursor:pointer;min-width:200px;opacity:.6">
                                        <input type="radio" name="paymentMethod" value="cod" disabled>
                                        <div>
                                            <div style="font-weight:700;font-size:.88rem;color:#1B1F3B">💵 Thanh toán
                                                khi nhận tour</div>
                                            <div style="font-size:.75rem;color:#A0A5C3;margin-top:2px">Đang phát triển
                                            </div>
                                        </div>
                                    </label>
                                </div>

                                <!-- Coupon Section -->
                                <div style="margin-top:28px">
                                    <h3><i class="fas fa-tag"></i> Mã Giảm Giá</h3>
                                    <div style="display:flex;gap:10px">
                                        <input type="text" id="couponInput" placeholder="Nhập mã giảm giá..."
                                            style="flex:1;padding:12px 16px;border-radius:12px;border:2px solid #E8EAF0;font-family:inherit;font-size:.9rem;color:#1B1F3B;outline:none;background:#FAFBFF;text-transform:uppercase">
                                        <button type="button" id="btnApplyCoupon"
                                            style="padding:12px 24px;border-radius:12px;border:none;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;font-weight:700;font-size:.88rem;cursor:pointer;font-family:inherit;white-space:nowrap;transition:.3s">
                                            Áp dụng
                                        </button>
                                    </div>
                                    <div id="couponMessage"
                                        style="margin-top:8px;font-size:.82rem;font-weight:600;display:none"></div>
                                    <input type="hidden" name="couponCode" id="couponCodeHidden" value="">
                                </div>
                            </div>

                            <!-- Right: Summary -->
                            <div class="summary-card">
                                <div class="summary-head">
                                    <h3><i class="fas fa-receipt"></i> Đơn Hàng (${sessionScope.cart.size()} tour)</h3>
                                </div>
                                <div class="summary-body">
                                    <c:forEach items="${sessionScope.cart}" var="item">
                                        <div class="summary-item">
                                            <div class="thumb">
                                                <img src="${not empty item.tour.imageUrl ? item.tour.imageUrl : 'https://images.unsplash.com/photo-1559592442-7e182c3c03fb?auto=format&fit=crop&w=100&q=80'}"
                                                    alt="">
                                            </div>
                                            <div class="name">
                                                ${item.tour.tourName}
                                                <small><i class="fas fa-user"></i> x${item.quantity} người</small>
                                            </div>
                                            <div class="price">
                                                <fmt:formatNumber value="${item.totalPrice}" type="number"
                                                    groupingUsed="true" />đ
                                            </div>
                                        </div>
                                    </c:forEach>

                                    <div id="discountRow"
                                        style="display:none;justify-content:space-between;padding:10px 0;color:#059669;font-weight:700;font-size:.9rem;border-top:1px dashed #E8EAF0;margin-top:8px">
                                        <span><i class="fas fa-tag"></i> Giảm giá</span>
                                        <span id="discountDisplay">-0đ</span>
                                    </div>

                                    <div class="total-row">
                                        <span>Tổng Thanh Toán</span>
                                        <span id="totalDisplay">
                                            <fmt:formatNumber value="${cartTotal}" type="number" groupingUsed="true" />đ
                                        </span>
                                    </div>
                                </div>
                                <div class="summary-actions">
                                    <button type="submit" class="btn-place-order" id="btnSubmit">
                                        <i class="fas fa-lock"></i> ĐẶT HÀNG & THANH TOÁN
                                    </button>
                                </div>
                                <div class="secure-badge">
                                    <i class="fas fa-shield-alt"></i> Thanh toán an toàn qua SePay & VietQR
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <jsp:include page="/common/_footer.jsp" />

                <script>
                    // Form submit lock
                    document.getElementById('checkoutForm').addEventListener('submit', function (e) {
                        var btn = document.getElementById('btnSubmit');
                        btn.disabled = true;
                        btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
                    });

                    // Coupon AJAX validation
                    var originalTotal = ${ cartTotal };
                    document.getElementById('btnApplyCoupon').addEventListener('click', function () {
                        var code = document.getElementById('couponInput').value.trim();
                        var msgEl = document.getElementById('couponMessage');
                        var discountRow = document.getElementById('discountRow');
                        var discountDisplay = document.getElementById('discountDisplay');
                        var totalDisplay = document.getElementById('totalDisplay');
                        var hiddenInput = document.getElementById('couponCodeHidden');

                        if (!code) {
                            msgEl.style.display = 'block';
                            msgEl.style.color = '#DC2626';
                            msgEl.textContent = 'Vui lòng nhập mã giảm giá';
                            return;
                        }

                        var btn = this;
                        btn.textContent = '...';
                        btn.disabled = true;

                        fetch('${pageContext.request.contextPath}/api/validate-coupon?code=' + encodeURIComponent(code) + '&total=' + originalTotal)
                            .then(function (r) { return r.json(); })
                            .then(function (data) {
                                msgEl.style.display = 'block';
                                if (data.valid) {
                                    msgEl.style.color = '#059669';
                                    msgEl.textContent = data.message;
                                    discountRow.style.display = 'flex';
                                    discountDisplay.textContent = '-' + data.discountDisplay + 'đ';
                                    totalDisplay.textContent = data.newTotalDisplay + 'đ';
                                    hiddenInput.value = code;
                                    btn.textContent = '✓ Đã áp dụng';
                                    btn.style.background = '#059669';
                                    document.getElementById('couponInput').readOnly = true;
                                } else {
                                    msgEl.style.color = '#DC2626';
                                    msgEl.textContent = data.message;
                                    discountRow.style.display = 'none';
                                    hiddenInput.value = '';
                                    btn.textContent = 'Áp dụng';
                                    btn.disabled = false;
                                }
                            })
                            .catch(function () {
                                msgEl.style.display = 'block';
                                msgEl.style.color = '#DC2626';
                                msgEl.textContent = 'Lỗi kết nối';
                                btn.textContent = 'Áp dụng';
                                btn.disabled = false;
                            });
                    });
                </script>
            </body>

            </html>