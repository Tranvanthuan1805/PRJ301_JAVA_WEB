<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hoàn Tất Đặt Tour | eztravel</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        body { background: #F8FAFC; }
        .booking-main { max-width: 920px; margin: 90px auto 100px; padding: 0 24px; }

        /* Step Progress */
        .step-progress { display: flex; justify-content: space-between; margin-bottom: 48px; position: relative; }
        .step-progress::before { content: ''; position: absolute; top: 18px; left: 12%; right: 12%; height: 2px; background: #E2E8F0; z-index: 1; }
        .step-progress .step-fill { position: absolute; top: 18px; left: 12%; width: ${(step - 1) * 38}%; height: 2px; background: #2563EB; z-index: 2; transition: 0.5s; border-radius: 2px; }
        .step-item { z-index: 3; text-align: center; }
        .step-circle { width: 36px; height: 36px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 10px; font-weight: 700; font-size: 0.85rem; transition: 0.3s; }
        .step-circle.active { background: #2563EB; color: white; box-shadow: 0 2px 8px rgba(37,99,235,0.25); }
        .step-circle.inactive { background: #E2E8F0; color: #94A3B8; }
        .step-label { font-size: 0.78rem; font-weight: 700; }
        .step-label.active { color: #2563EB; }
        .step-label.inactive { color: #94A3B8; }

        /* Grid Layout */
        .booking-grid { display: grid; grid-template-columns: 1fr 320px; gap: 32px; }

        /* Form Card */
        .form-card { background: white; border-radius: 16px; padding: 36px; border: 1px solid #E2E8F0; box-shadow: 0 1px 3px rgba(0,0,0,0.04), 0 6px 16px rgba(0,0,0,0.04); }
        .form-card h2 { font-family: 'Playfair Display', serif; font-size: 1.5rem; color: #1A2B49; margin-bottom: 24px; font-weight: 800; }

        .field { margin-bottom: 20px; }
        .field label { display: block; margin-bottom: 6px; font-weight: 600; font-size: 0.82rem; color: #1E293B; }
        .field input[type="date"],
        .field input[type="text"],
        .field input[type="tel"],
        .field input[type="number"] {
            width: 100%; padding: 12px 16px; border: 1.5px solid #E2E8F0; border-radius: 10px;
            font-size: 0.9rem; font-family: inherit; background: #F8FAFC; color: #1E293B; transition: 0.3s;
        }
        .field input:focus { outline: none; border-color: #2563EB; box-shadow: 0 0 0 3px rgba(37,99,235,0.08); background: white; }
        .field small { color: #94A3B8; font-size: 0.78rem; margin-top: 4px; display: block; }

        /* Payment */
        .payment-secure { background: #ECFDF5; border: 1px dashed #10B981; padding: 18px; border-radius: 10px; margin-bottom: 24px; display: flex; gap: 14px; align-items: center; }
        .payment-secure i { color: #10B981; font-size: 1.3rem; }
        .payment-secure p { font-size: 0.85rem; color: #059669; }

        .payment-option { display: flex; align-items: center; gap: 14px; padding: 14px 18px; border: 1.5px solid #E2E8F0; border-radius: 10px; cursor: pointer; transition: 0.3s; margin-bottom: 10px; }
        .payment-option:hover { border-color: #2563EB; background: rgba(37,99,235,0.02); }
        .payment-option input[type="radio"] { accent-color: #2563EB; }
        .payment-option img { width: 28px; }

        /* Buttons */
        .form-actions { margin-top: 36px; display: flex; justify-content: space-between; }
        .btn-back { padding: 12px 24px; background: white; border: 1.5px solid #E2E8F0; border-radius: 10px; font-weight: 600; font-size: 0.88rem; cursor: pointer; transition: 0.3s; font-family: inherit; color: #64748B; }
        .btn-back:hover { border-color: #CBD5E1; color: #1E293B; }
        .btn-next { padding: 12px 28px; background: #2563EB; color: white; border: none; border-radius: 10px; font-weight: 700; font-size: 0.88rem; cursor: pointer; transition: 0.3s; font-family: inherit; }
        .btn-next:hover { background: #3B82F6; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(37,99,235,0.25); }

        /* Sidebar Summary */
        .summary-card { position: sticky; top: 100px; height: fit-content; }
        .summary-inner { background: white; border-radius: 16px; padding: 24px; border: 1px solid #E2E8F0; box-shadow: 0 1px 3px rgba(0,0,0,0.04), 0 6px 16px rgba(0,0,0,0.04); }
        .summary-inner h4 { font-size: 0.92rem; font-weight: 700; margin-bottom: 16px; color: #2563EB; display: flex; align-items: center; gap: 8px; }
        .summary-inner img { width: 100%; border-radius: 10px; margin-bottom: 14px; }
        .summary-inner .tour-name { font-weight: 700; margin-bottom: 4px; font-size: 0.95rem; color: #1A2B49; }
        .summary-inner .tour-loc { color: #94A3B8; font-size: 0.8rem; display: flex; align-items: center; gap: 4px; }
        .summary-divider { border: 0; border-top: 1px solid #F1F5F9; margin: 18px 0; }
        .summary-row { display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 0.88rem; }
        .summary-row .lbl { color: #64748B; }
        .summary-row .val { font-weight: 600; color: #1E293B; }
        .summary-total { display: flex; justify-content: space-between; font-size: 1.15rem; font-weight: 800; color: #2563EB; margin-top: 18px; }

        @media(max-width:768px) {
            .booking-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <jsp:include page="/common/_header.jsp" />

    <main class="booking-main">
        <!-- Step Progress Bar -->
        <div class="step-progress">
            <div class="step-fill"></div>
            <div class="step-item">
                <div class="step-circle ${step >= 1 ? 'active' : 'inactive'}">1</div>
                <div class="step-label ${step >= 1 ? 'active' : 'inactive'}">Chi Tiết</div>
            </div>
            <div class="step-item">
                <div class="step-circle ${step >= 2 ? 'active' : 'inactive'}">2</div>
                <div class="step-label ${step >= 2 ? 'active' : 'inactive'}">Liên Hệ</div>
            </div>
            <div class="step-item">
                <div class="step-circle ${step >= 3 ? 'active' : 'inactive'}">3</div>
                <div class="step-label ${step >= 3 ? 'active' : 'inactive'}">Thanh Toán</div>
            </div>
        </div>

        <div class="booking-grid">
            <!-- Form Area -->
            <div class="form-card">
                <form action="${pageContext.request.contextPath}/customer/book" method="POST">
                    <input type="hidden" name="tourId" value="${tour.tourId}">
                    <input type="hidden" name="step" value="${step}">

                    <c:choose>
                        <c:when test="${step == 1}">
                            <h2>Chọn Chi Tiết Tour</h2>
                            <div class="field">
                                <label>Ngày Đi</label>
                                <input type="date" name="travelDate" required>
                            </div>
                            <div class="field">
                                <label>Số Người</label>
                                <input type="number" name="quantity" min="1" max="${tour.maxPeople}" value="1">
                                <small>Tối đa: ${tour.maxPeople} khách</small>
                            </div>
                        </c:when>

                        <c:when test="${step == 2}">
                            <h2>Thông Tin Hành Khách</h2>
                            <div class="field">
                                <label>Họ và Tên</label>
                                <input type="text" name="fullName" required placeholder="Theo CMND/Hộ chiếu">
                            </div>
                            <div class="field">
                                <label>Số Điện Thoại</label>
                                <input type="tel" name="phone" required placeholder="+84 000 000 000">
                            </div>
                        </c:when>

                        <c:when test="${step == 3}">
                            <h2>Thanh Toán An Toàn</h2>
                            <div class="payment-secure">
                                <i class="fas fa-shield-alt"></i>
                                <p>Thanh toán được mã hóa và xử lý bởi đối tác ngân hàng uy tín.</p>
                            </div>
                            <label class="payment-option">
                                <input type="radio" name="payment" value="momo" checked>
                                <img src="https://upload.wikimedia.org/wikipedia/vi/f/fe/MoMo_Logo.png" alt="MoMo">
                                <span style="font-weight:600;">Ví MoMo</span>
                            </label>
                            <label class="payment-option">
                                <input type="radio" name="payment" value="bank">
                                <i class="fas fa-university" style="font-size:1.2rem;color:#1A2B49;"></i>
                                <span style="font-weight:600;">Chuyển Khoản Ngân Hàng (NAPAS 24/7)</span>
                            </label>
                        </c:when>
                    </c:choose>

                    <div class="form-actions">
                        <c:if test="${step > 1}">
                            <button type="button" onclick="history.back()" class="btn-back"><i class="fas fa-arrow-left" style="margin-right:6px;font-size:.75rem;"></i> Quay Lại</button>
                        </c:if>
                        <c:if test="${step <= 1}"><div></div></c:if>
                        <button type="submit" class="btn-next">${step == 3 ? 'Xác Nhận & Thanh Toán' : 'Tiếp Tục'} <i class="fas fa-arrow-right" style="margin-left:6px;font-size:.75rem;"></i></button>
                    </div>
                </form>
            </div>

            <!-- Summary Sidebar -->
            <div class="summary-card">
                <div class="summary-inner">
                    <h4><i class="fas fa-receipt"></i> Tổng Quan Tour</h4>
                    <img src="${tour.imageUrl}" alt="${tour.tourName}">
                    <p class="tour-name">${tour.tourName}</p>
                    <p class="tour-loc"><i class="fas fa-map-marker-alt"></i> ${tour.startLocation}</p>

                    <hr class="summary-divider">

                    <div class="summary-row">
                        <span class="lbl">Giá mỗi khách</span>
                        <span class="val">$<fmt:formatNumber value="${tour.price}" /></span>
                    </div>
                    <div class="summary-total">
                        <span>Tổng Cộng</span>
                        <span>$<fmt:formatNumber value="${tour.price}" /></span>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="/common/_footer.jsp" />
</body>
</html>
