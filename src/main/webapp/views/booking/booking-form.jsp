<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Tour ${tour.tourName} | EZTravel</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
    body{font-family:'Plus Jakarta Sans',system-ui,sans-serif;background:#F7F8FC;color:#1B1F3B;-webkit-font-smoothing:antialiased}

    .booking-page{max-width:1100px;margin:0 auto;padding:100px 30px 80px}

    /* Breadcrumb */
    .breadcrumb{display:flex;gap:8px;align-items:center;font-size:.85rem;color:#A0A5C3;margin-bottom:24px}
    .breadcrumb a{color:#6B7194;transition:.3s;text-decoration:none}
    .breadcrumb a:hover{color:#FF6F61}
    .breadcrumb .sep{opacity:.3}

    /* Layout */
    .booking-layout{display:grid;grid-template-columns:1fr 420px;gap:30px;align-items:start}

    /* Tour Card */
    .tour-preview{background:#fff;border-radius:24px;overflow:hidden;box-shadow:0 8px 35px rgba(27,31,59,.06);border:1px solid #E8EAF0}
    .tour-preview .img-wrap{position:relative;height:280px;overflow:hidden}
    .tour-preview .img-wrap img{width:100%;height:100%;object-fit:cover;transition:.5s}
    .tour-preview:hover .img-wrap img{transform:scale(1.03)}
    .tour-preview .img-overlay{position:absolute;inset:0;background:linear-gradient(180deg,transparent 50%,rgba(27,31,59,.6) 100%)}
    .tour-preview .img-badge{position:absolute;top:16px;left:16px;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;padding:6px 16px;border-radius:999px;font-size:.75rem;font-weight:800;letter-spacing:.3px;box-shadow:0 4px 12px rgba(255,111,97,.3)}
    .tour-preview .img-price{position:absolute;bottom:16px;right:16px;background:rgba(255,255,255,.95);backdrop-filter:blur(10px);padding:8px 18px;border-radius:14px;font-size:1.3rem;font-weight:800;color:#FF6F61;letter-spacing:-.5px;box-shadow:0 4px 12px rgba(0,0,0,.1)}
    .tour-preview .img-price small{font-size:.72rem;font-weight:500;color:#A0A5C3}
    .tour-info{padding:24px 28px}
    .tour-info h2{font-size:1.4rem;font-weight:800;color:#1B1F3B;margin-bottom:12px;line-height:1.35}
    .tour-meta{display:flex;flex-wrap:wrap;gap:14px;margin-bottom:16px}
    .tour-meta span{display:flex;align-items:center;gap:6px;font-size:.82rem;color:#6B7194;font-weight:600}
    .tour-meta span i{color:#FF6F61;font-size:.78rem}
    .tour-desc{font-size:.88rem;color:#6B7194;line-height:1.7;margin-bottom:16px}
    .tour-features{display:flex;flex-wrap:wrap;gap:8px}
    .tour-features .feat{display:flex;align-items:center;gap:5px;padding:6px 14px;background:#F7F8FC;border-radius:999px;font-size:.75rem;font-weight:700;color:#4A4E6F;border:1px solid #E8EAF0}
    .tour-features .feat i{color:#059669;font-size:.7rem}

    /* Booking Form */
    .booking-form-card{position:sticky;top:90px}
    .form-card{background:#fff;border-radius:24px;box-shadow:0 8px 40px rgba(27,31,59,.08);border:1px solid #E8EAF0;overflow:hidden}
    .form-head{background:linear-gradient(135deg,#1B1F3B,#2D3561);padding:24px 28px;color:#fff}
    .form-head h3{font-size:1.1rem;font-weight:800;display:flex;align-items:center;gap:10px}
    .form-head h3 i{color:#FF6F61}
    .form-head .sub{font-size:.78rem;opacity:.6;margin-top:4px}
    .form-body{padding:24px 28px}

    .field{margin-bottom:20px}
    .field label{display:block;font-size:.82rem;font-weight:700;color:#4A4E6F;margin-bottom:8px}
    .field label i{color:#FF6F61;margin-right:4px}
    .field input,.field select{width:100%;padding:14px 16px;border:2px solid #E8EAF0;border-radius:14px;font-size:.92rem;font-family:inherit;font-weight:600;outline:none;transition:.3s;background:#FAFBFF;color:#1B1F3B}
    .field input:focus,.field select:focus{border-color:#FF6F61;background:#fff;box-shadow:0 0 0 3px rgba(255,111,97,.08)}

    /* Quantity picker */
    .qty-picker{display:flex;align-items:center;gap:0;border:2px solid #E8EAF0;border-radius:14px;overflow:hidden;background:#FAFBFF}
    .qty-picker button{width:48px;height:48px;border:none;background:transparent;cursor:pointer;font-size:1.1rem;color:#6B7194;font-weight:800;transition:.2s;font-family:inherit}
    .qty-picker button:hover{background:rgba(255,111,97,.08);color:#FF6F61}
    .qty-picker input{width:70px;text-align:center;border:none;background:transparent;font-size:1.1rem;font-weight:800;color:#1B1F3B;font-family:inherit;outline:none;border-left:2px solid #E8EAF0;border-right:2px solid #E8EAF0}

    /* Price Summary */
    .price-summary{padding:20px 0;border-top:1px solid #F0F1F5;margin-top:8px}
    .price-row{display:flex;justify-content:space-between;align-items:center;padding:8px 0;font-size:.88rem}
    .price-row .label{color:#6B7194;font-weight:600}
    .price-row .value{font-weight:700;color:#1B1F3B}
    .price-row.total{padding:14px 0 0;border-top:2px solid #E8EAF0;margin-top:8px}
    .price-row.total .label{font-weight:700;font-size:.95rem;color:#4A4E6F}
    .price-row.total .value{font-size:1.5rem;font-weight:800;color:#FF6F61;letter-spacing:-.5px}

    /* Submit Button */
    .btn-book-submit{display:flex;align-items:center;justify-content:center;gap:10px;width:100%;padding:18px;border-radius:14px;font-weight:800;font-size:1rem;border:none;cursor:pointer;font-family:inherit;transition:.3s;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;box-shadow:0 6px 20px rgba(255,111,97,.25);letter-spacing:.3px;margin-top:20px}
    .btn-book-submit:hover{transform:translateY(-3px);box-shadow:0 12px 35px rgba(255,111,97,.4)}
    .btn-book-submit:disabled{opacity:.6;cursor:not-allowed;transform:none}

    .secure-note{text-align:center;font-size:.78rem;color:#A0A5C3;margin-top:14px;display:flex;align-items:center;justify-content:center;gap:5px}
    .secure-note i{color:#06D6A0}

    .bank-info{margin-top:16px;padding:14px 16px;background:#FAFBFF;border:1px solid #E8EAF0;border-radius:14px;font-size:.82rem}
    .bank-info .bank-title{font-weight:700;color:#4A4E6F;margin-bottom:8px;display:flex;align-items:center;gap:6px}
    .bank-info .bank-title i{color:#059669}
    .bank-info .bank-row{display:flex;justify-content:space-between;padding:4px 0;color:#6B7194}
    .bank-info .bank-row .bval{font-weight:700;color:#1B1F3B}

    @media(max-width:900px){.booking-layout{grid-template-columns:1fr}.booking-form-card{position:relative;top:0}}
    @media(max-width:600px){.tour-preview .img-wrap{height:200px}}
    </style>
</head>
<body>

<jsp:include page="/common/_header.jsp" />

<div class="booking-page">
    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Trang chủ</a>
        <span class="sep">›</span>
        <a href="${pageContext.request.contextPath}/tour">Tours</a>
        <span class="sep">›</span>
        <a href="${pageContext.request.contextPath}/tour?action=view&id=${tour.tourId}">${tour.tourName}</a>
        <span class="sep">›</span>
        <span style="color:#FF6F61;font-weight:700">Đặt Tour</span>
    </div>

    <div class="booking-layout">
        <!-- LEFT: Tour Preview -->
        <div class="tour-preview">
            <div class="img-wrap">
                <img src="${not empty tour.imageUrl ? tour.imageUrl : 'https://images.unsplash.com/photo-1559592442-7e182c3c03fb?auto=format&fit=crop&w=800&q=80'}"
                     alt="${tour.tourName}">
                <div class="img-overlay"></div>
                <c:if test="${not empty tour.category}">
                    <div class="img-badge"><i class="fas fa-tag"></i> ${tour.category.categoryName}</div>
                </c:if>
                <div class="img-price">
                    <fmt:formatNumber value="${tour.price}" type="number" groupingUsed="true"/>đ
                    <small>/người</small>
                </div>
            </div>
            <div class="tour-info">
                <h2>${tour.tourName}</h2>
                <div class="tour-meta">
                    <span><i class="fas fa-map-marker-alt"></i> ${not empty tour.startLocation ? tour.startLocation : 'Đà Nẵng'}</span>
                    <c:if test="${not empty tour.duration}">
                        <span><i class="fas fa-clock"></i> ${tour.duration}</span>
                    </c:if>
                    <span><i class="fas fa-bus"></i> ${not empty tour.transport ? tour.transport : 'Xe du lịch'}</span>
                    <span><i class="fas fa-star" style="color:#FFB703"></i> 4.8</span>
                </div>
                <c:if test="${not empty tour.shortDesc}">
                    <div class="tour-desc">${tour.shortDesc}</div>
                </c:if>
                <div class="tour-features">
                    <div class="feat"><i class="fas fa-check"></i> Hướng dẫn viên</div>
                    <div class="feat"><i class="fas fa-check"></i> Bảo hiểm</div>
                    <div class="feat"><i class="fas fa-check"></i> Xe đưa đón</div>
                    <div class="feat"><i class="fas fa-check"></i> Nước uống</div>
                </div>
            </div>
        </div>

        <!-- RIGHT: Booking Form -->
        <div class="booking-form-card">
            <div class="form-card">
                <div class="form-head">
                    <h3><i class="fas fa-bolt"></i> ĐẶT TOUR NHANH</h3>
                    <div class="sub">Đặt tour trực tiếp - Thanh toán QR tiện lợi</div>
                </div>
                <form action="${pageContext.request.contextPath}/booking" method="POST" id="bookingForm">
                    <div class="form-body">
                        <input type="hidden" name="tourId" value="${tour.tourId}">

                        <div class="field">
                            <label><i class="fas fa-users"></i> Số Lượng Người</label>
                            <div class="qty-picker">
                                <button type="button" onclick="changeQty(-1)">−</button>
                                <input type="number" name="numberOfPeople" id="qty" value="1" min="1" max="${tour.maxPeople}" readonly>
                                <button type="button" onclick="changeQty(1)">+</button>
                            </div>
                        </div>

                        <div class="field">
                            <label><i class="fas fa-calendar-alt"></i> Ngày Khởi Hành</label>
                            <input type="date" name="travelDate" id="travelDate"
                                   min="${java.time.LocalDate.now().plusDays(1)}"
                                   required>
                        </div>

                        <div class="field">
                            <label><i class="fas fa-user"></i> Họ Tên Người Đặt</label>
                            <input type="text" name="fullName"
                                   value="${sessionScope.user.fullName}"
                                   placeholder="Nhập họ tên" required>
                        </div>

                        <div class="field">
                            <label><i class="fas fa-phone"></i> Số Điện Thoại</label>
                            <input type="tel" name="phone"
                                   value="${sessionScope.user.phoneNumber}"
                                   placeholder="Nhập số điện thoại" required>
                        </div>

                        <!-- Price Summary -->
                        <div class="price-summary">
                            <div class="price-row">
                                <span class="label">Giá tour</span>
                                <span class="value"><fmt:formatNumber value="${tour.price}" type="number" groupingUsed="true"/>đ/người</span>
                            </div>
                            <div class="price-row">
                                <span class="label">Số người</span>
                                <span class="value" id="qtyDisplay">1</span>
                            </div>
                            <div class="price-row total">
                                <span class="label">Tổng Thanh Toán</span>
                                <span class="value" id="totalDisplay">
                                    <fmt:formatNumber value="${tour.price}" type="number" groupingUsed="true"/>đ
                                </span>
                            </div>
                        </div>

                        <button type="submit" class="btn-book-submit" id="btnSubmit">
                            <i class="fas fa-lock"></i> ĐẶT TOUR & THANH TOÁN
                        </button>

                        <div class="secure-note">
                            <i class="fas fa-shield-alt"></i> Thanh toán an toàn qua SePay & VietQR
                        </div>

                        <div class="bank-info">
                            <div class="bank-title"><i class="fas fa-university"></i> Thông Tin Thanh Toán</div>
                            <div class="bank-row">
                                <span>Ngân hàng</span>
                                <span class="bval">MB Bank</span>
                            </div>
                            <div class="bank-row">
                                <span>Số tài khoản</span>
                                <span class="bval">2806281106</span>
                            </div>
                            <div class="bank-row">
                                <span>Phương thức</span>
                                <span class="bval">QR SePay / VietQR</span>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/common/_footer.jsp" />

<script>
const PRICE = ${tour.price};

function changeQty(delta) {
    const input = document.getElementById('qty');
    let val = parseInt(input.value) + delta;
    if (val < 1) val = 1;
    if (val > ${tour.maxPeople}) val = ${tour.maxPeople};
    input.value = val;
    updateTotal();
}

function updateTotal() {
    const qty = parseInt(document.getElementById('qty').value);
    document.getElementById('qtyDisplay').textContent = qty;
    const total = PRICE * qty;
    document.getElementById('totalDisplay').textContent = total.toLocaleString('vi-VN') + 'đ';
}

// Set min date to tomorrow
document.addEventListener('DOMContentLoaded', () => {
    const dateInput = document.getElementById('travelDate');
    const tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);
    dateInput.min = tomorrow.toISOString().split('T')[0];
    dateInput.value = tomorrow.toISOString().split('T')[0];
});
</script>
</body>
</html>
