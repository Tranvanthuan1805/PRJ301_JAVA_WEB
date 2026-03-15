<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${tour.tourName} | Da Nang Travel Hub</title>
                <link
                    href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
                <style>
                    *,
                    *::before,
                    *::after {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box
                    }

                    html {
                        scroll-behavior: smooth
                    }

                    body {
                        font-family: 'Plus Jakarta Sans', system-ui, sans-serif;
                        background: #F7F8FC;
                        color: #1B1F3B;
                        line-height: 1.65;
                        -webkit-font-smoothing: antialiased;
                        overflow-x: hidden
                    }

                    a {
                        text-decoration: none;
                        color: inherit;
                        transition: .3s
                    }

                    img {
                        max-width: 100%;
                        display: block
                    }

                    .btn-accent:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 8px 25px rgba(255, 111, 97, .45)
                    }

                    /* ═══ HERO IMAGE ═══ */
                    .detail-hero {
                        position: relative;
                        height: 520px;
                        margin-top: 64px;
                        overflow: hidden
                    }

                    .detail-hero img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                        animation: slowZoom 20s ease-in-out infinite alternate
                    }

                    @keyframes slowZoom {
                        0% {
                            transform: scale(1)
                        }

                        100% {
                            transform: scale(1.08)
                        }
                    }

                    .detail-hero .overlay {
                        position: absolute;
                        inset: 0;
                        background: linear-gradient(180deg, rgba(27, 31, 59, .1) 0%, rgba(27, 31, 59, .7) 100%)
                    }

                    .detail-hero .hero-info {
                        position: absolute;
                        bottom: 40px;
                        left: 0;
                        right: 0;
                        padding: 0 30px
                    }

                    .detail-hero .hero-info .inner {
                        max-width: 1280px;
                        margin: 0 auto;
                        color: #fff
                    }

                    .detail-hero .breadcrumb {
                        display: flex;
                        gap: 8px;
                        align-items: center;
                        font-size: .82rem;
                        color: rgba(255, 255, 255, .7);
                        margin-bottom: 16px
                    }

                    .detail-hero .breadcrumb a:hover {
                        color: #fff
                    }

                    .detail-hero .breadcrumb .sep {
                        opacity: .4
                    }

                    .detail-hero h1 {
                        font-size: 2.6rem;
                        font-weight: 800;
                        margin-bottom: 10px;
                        letter-spacing: -.5px;
                        text-shadow: 0 2px 20px rgba(0, 0, 0, .3)
                    }

                    .detail-hero .meta {
                        display: flex;
                        gap: 20px;
                        flex-wrap: wrap;
                        align-items: center
                    }

                    .detail-hero .meta-item {
                        display: flex;
                        align-items: center;
                        gap: 6px;
                        font-size: .88rem;
                        color: rgba(255, 255, 255, .85)
                    }

                    .detail-hero .meta-item i {
                        color: #FF6F61;
                        font-size: .85rem
                    }

                    /* ═══ CONTENT AREA ═══ */
                    .detail-wrap {
                        max-width: 1280px;
                        margin: -60px auto 80px;
                        padding: 0 30px;
                        position: relative;
                        z-index: 10;
                        display: grid;
                        grid-template-columns: 1fr 380px;
                        gap: 30px;
                        align-items: start
                    }

                    /* Left column */
                    .detail-main {
                        display: flex;
                        flex-direction: column;
                        gap: 24px
                    }

                    /* Tabs */
                    .tabs {
                        display: flex;
                        gap: 4px;
                        background: #fff;
                        border-radius: 16px;
                        padding: 6px;
                        box-shadow: 0 2px 12px rgba(27, 31, 59, .06);
                        border: 1px solid #E8EAF0
                    }

                    .tab-btn {
                        padding: 12px 24px;
                        border-radius: 12px;
                        font-weight: 700;
                        font-size: .88rem;
                        color: #6B7194;
                        cursor: pointer;
                        border: none;
                        background: transparent;
                        font-family: inherit;
                        transition: .3s
                    }

                    .tab-btn.active {
                        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
                        color: #fff;
                        box-shadow: 0 4px 12px rgba(255, 111, 97, .2)
                    }

                    .tab-btn:hover:not(.active) {
                        background: #F7F8FC;
                        color: #1B1F3B
                    }

                    .tab-panel {
                        display: none;
                        background: #fff;
                        border-radius: 20px;
                        padding: 36px;
                        box-shadow: 0 4px 20px rgba(27, 31, 59, .05);
                        border: 1px solid #E8EAF0;
                        line-height: 1.9;
                        color: #4A4E6F;
                        font-size: .95rem
                    }

                    .tab-panel.active {
                        display: block;
                        animation: fadeIn .4s ease
                    }

                    @keyframes fadeIn {
                        from {
                            opacity: 0;
                            transform: translateY(10px)
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0)
                        }
                    }

                    .tab-panel h4 {
                        color: #1B1F3B;
                        font-size: 1.1rem;
                        margin: 20px 0 10px
                    }

                    .tab-panel ul {
                        padding-left: 20px
                    }

                    .tab-panel ul li {
                        margin-bottom: 8px
                    }

                    .empty-state {
                        text-align: center;
                        padding: 50px 20px;
                        color: #A0A5C3
                    }

                    .empty-state i {
                        font-size: 3rem;
                        margin-bottom: 12px;
                        display: block;
                        opacity: .4
                    }

                    /* Right sidebar */
                    .detail-sidebar {
                        position: sticky;
                        top: 90px
                    }

                    .info-card {
                        background: #fff;
                        border-radius: 20px;
                        overflow: hidden;
                        box-shadow: 0 8px 30px rgba(27, 31, 59, .08);
                        border: 1px solid #E8EAF0
                    }

                    .info-card .card-head {
                        background: linear-gradient(135deg, #1B1F3B, #2D3561);
                        padding: 24px 28px;
                        color: #fff
                    }

                    .info-card .card-head h3 {
                        font-size: 1.1rem;
                        font-weight: 700;
                        display: flex;
                        align-items: center;
                        gap: 10px
                    }

                    .info-card .card-head h3 i {
                        color: #FF6F61
                    }

                    .info-card .card-body {
                        padding: 24px 28px
                    }

                    .info-row {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding: 14px 0;
                        border-bottom: 1px solid #F0F1F5
                    }

                    .info-row:last-child {
                        border-bottom: none
                    }

                    .info-row .label {
                        display: flex;
                        align-items: center;
                        gap: 8px;
                        font-size: .88rem;
                        color: #6B7194
                    }

                    .info-row .label i {
                        color: #A0A5C3;
                        width: 18px;
                        text-align: center;
                        font-size: .85rem
                    }

                    .info-row .val {
                        font-weight: 700;
                        font-size: .9rem;
                        color: #1B1F3B
                    }

                    .badge-slot {
                        padding: 5px 14px;
                        border-radius: 999px;
                        font-size: .78rem;
                        font-weight: 700;
                        letter-spacing: .3px
                    }

                    .badge-green {
                        background: rgba(6, 214, 160, .1);
                        color: #059669
                    }

                    .badge-red {
                        background: rgba(239, 68, 68, .1);
                        color: #DC2626
                    }

                    /* Price */
                    .price-box {
                        padding: 24px 28px;
                        border-top: 1px solid #F0F1F5
                    }

                    .price-old {
                        font-size: .88rem;
                        color: #A0A5C3;
                        text-decoration: line-through;
                        margin-bottom: 4px
                    }

                    .price-current {
                        font-size: 2rem;
                        font-weight: 800;
                        color: #FF6F61;
                        letter-spacing: -1px
                    }

                    .price-current span {
                        font-size: .88rem;
                        font-weight: 500;
                        color: #A0A5C3
                    }

                    /* CTA buttons */
                    .cta-box {
                        padding: 0 28px 28px;
                        display: flex;
                        flex-direction: column;
                        gap: 10px
                    }

                    .btn-book-lg {
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        gap: 8px;
                        padding: 16px;
                        border-radius: 14px;
                        font-weight: 800;
                        font-size: 1rem;
                        border: none;
                        cursor: pointer;
                        font-family: inherit;
                        transition: .3s;
                        width: 100%
                    }

                    .btn-book-primary {
                        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
                        color: #fff;
                        box-shadow: 0 6px 20px rgba(255, 111, 97, .25)
                    }

                    .btn-book-primary:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 12px 30px rgba(255, 111, 97, .4)
                    }

                    .btn-book-outline {
                        background: transparent;
                        color: #1B1F3B;
                        border: 2px solid #E8EAF0
                    }

                    .btn-book-outline:hover {
                        border-color: #1B1F3B;
                        background: rgba(27, 31, 59, .03)
                    }

                    .btn-disabled {
                        background: #E8EAF0;
                        color: #A0A5C3;
                        cursor: not-allowed;
                        box-shadow: none
                    }

                    .support-note {
                        text-align: center;
                        font-size: .78rem;
                        color: #A0A5C3;
                        padding: 0 28px 20px
                    }

                    /* ═══ FOOTER ═══ */
                    .foot {
                        background: #1B1F3B;
                        color: #fff;
                        padding: 60px 0 30px
                    }

                    .foot-inner {
                        max-width: 1280px;
                        margin: 0 auto;
                        padding: 0 30px
                    }

                    .foot-bottom {
                        display: flex;
                        justify-content: space-between;
                        flex-wrap: wrap;
                        gap: 10px;
                        color: rgba(255, 255, 255, .3);
                        font-size: .78rem
                    }

                    /* ═══ RESPONSIVE ═══ */
                    @media(max-width:1024px) {
                        .detail-wrap {
                            grid-template-columns: 1fr;
                            margin-top: -40px
                        }

                        .detail-sidebar {
                            position: relative;
                            top: 0
                        }
                    }

                    @media(max-width:768px) {
                        .nav-links {
                            display: none
                        }

                        .detail-hero {
                            height: 350px
                        }

                        .detail-hero h1 {
                            font-size: 1.8rem
                        }

                        .detail-wrap {
                            padding: 0 16px
                        }

                        .tabs {
                            flex-wrap: wrap
                        }
                    }
                </style>
            </head>

            <body>
                <jsp:include page="/common/_header.jsp" />

                <!-- ═══ HERO ═══ -->
                <section class="detail-hero">
                    <img src="${tour.imageUrl}" alt="${tour.tourName}">
                    <div class="overlay"></div>
                    <div class="hero-info">
                        <div class="inner">
                            <div class="breadcrumb">
                                <a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Trang chủ</a>
                                <span class="sep">›</span>
                                <a href="${pageContext.request.contextPath}/tour">Tours</a>
                                <span class="sep">›</span>
                                <span>Chi tiết</span>
                            </div>
                            <h1>${tour.tourName}</h1>
                            <div class="meta">
                                <div class="meta-item"><i class="fas fa-map-marker-alt"></i> ${not empty
                                    tour.startLocation ? tour.startLocation : 'Đà Nẵng'}</div>
                                <c:if test="${not empty tour.duration}">
                                    <div class="meta-item"><i class="fas fa-clock"></i> ${tour.duration}</div>
                                </c:if>
                                <c:if test="${not empty tour.category}">
                                    <div class="meta-item"><i class="fas fa-tag"></i> ${tour.category.categoryName}
                                    </div>
                                </c:if>
                                <div class="meta-item"><i class="fas fa-star" style="color:#FFB703"></i> 4.8 (128 đánh
                                    giá)</div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- ═══ CONTENT ═══ -->
                <div class="detail-wrap">
                    <!-- Left -->
                    <div class="detail-main">
                        <div class="tabs">
                            <button class="tab-btn active" onclick="switchTab(event, 'desc')">Giới Thiệu</button>
                            <button class="tab-btn" onclick="switchTab(event, 'schedule')">Lịch Trình</button>
                            <button class="tab-btn" onclick="switchTab(event, 'policy')">Chính Sách</button>
                            <button class="tab-btn" onclick="switchTab(event, 'reviews')">Đánh Giá</button>
                            <a href="${pageContext.request.contextPath}/tour-3d?id=${tour.tourId}" class="tab-btn tab-btn-3d" style="background:linear-gradient(135deg,#7C3AED,#A855F7);color:#fff;text-decoration:none;box-shadow:0 4px 12px rgba(124,58,237,.2);display:flex;align-items:center;gap:6px;animation:pulse3d 2s infinite">
                                <i class="fas fa-cube" style="animation:spin3d 3s linear infinite"></i> Xem 3D
                            </a>
                        </div>
                        <style>
                        @keyframes pulse3d{0%,100%{box-shadow:0 4px 12px rgba(124,58,237,.2)}50%{box-shadow:0 4px 24px rgba(124,58,237,.5)}}
                        @keyframes spin3d{0%{transform:rotateY(0)}100%{transform:rotateY(360deg)}}
                        </style>

                        <div class="tab-panel active" id="desc">
                            <c:choose>
                                <c:when test="${not empty tour.description}">
                                    ${tour.description}
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-state">
                                        <i class="fas fa-pen-fancy"></i>
                                        <p>Thông tin giới thiệu đang được cập nhật.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="tab-panel" id="schedule">
                            <c:choose>
                                <c:when test="${not empty tour.itinerary}">
                                    ${tour.itinerary}
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-state">
                                        <i class="fas fa-calendar-alt"></i>
                                        <p>Lịch trình chi tiết đang được cập nhật.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="tab-panel" id="policy">
                            <h4>🛡️ Chính Sách Hoàn Hủy</h4>
                            <ul>
                                <li>Hủy trước 7 ngày: hoàn 100% tiền tour.</li>
                                <li>Hủy trước 3-7 ngày: hoàn 50% tiền tour.</li>
                                <li>Hủy trước dưới 3 ngày: không hoàn tiền.</li>
                            </ul>
                            <h4>📦 Bao Gồm</h4>
                            <ul>
                                <li>Xe đưa đón khách sạn - điểm tham quan</li>
                                <li>Hướng dẫn viên chuyên nghiệp</li>
                                <li>Bảo hiểm du lịch</li>
                                <li>Nước uống trên xe</li>
                            </ul>
                            <h4>🚫 Không Bao Gồm</h4>
                            <ul>
                                <li>Chi phí cá nhân</li>
                                <li>Tiền tip cho hướng dẫn viên</li>
                                <li>Bữa ăn (trừ khi có ghi chú)</li>
                            </ul>
                        </div>

                        <div class="tab-panel" id="reviews">
                            <div id="reviews-container">
                                <div style="text-align:center;padding:30px;color:#A0A5C3">
                                    <i class="fas fa-spinner fa-spin" style="font-size:1.5rem"></i>
                                    <p style="margin-top:10px">Đang tải đánh giá...</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right Sidebar -->
                    <aside class="detail-sidebar">
                        <div class="info-card">
                            <div class="card-head">
                                <h3><i class="fas fa-info-circle"></i> THÔNG TIN TOUR</h3>
                            </div>
                            <div class="card-body">
                                <div class="info-row">
                                    <div class="label"><i class="fas fa-clock"></i> Thời gian</div>
                                    <div class="val">${tour.duration}</div>
                                </div>
                                <div class="info-row">
                                    <div class="label"><i class="fas fa-calendar-check"></i> Khởi hành</div>
                                    <div class="val">Hàng ngày</div>
                                </div>
                                <div class="info-row">
                                    <div class="label"><i class="fas fa-bus"></i> Phương tiện</div>
                                    <div class="val">${not empty tour.transport ? tour.transport : "Xe du lịch"}</div>
                                </div>
                                <div class="info-row">
                                    <div class="label"><i class="fas fa-ticket-alt"></i> Tình trạng</div>
                                    <div class="val">
                                        <c:choose>
                                            <c:when test="${remaining > 0}">
                                                <span class="badge-slot badge-green">Còn ${remaining} chỗ</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-slot badge-red">HẾT CHỖ</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                            <div class="price-box">
                                <div class="price-old">
                                    <fmt:formatNumber value="${tour.price * 1.2}" type="number" groupingUsed="true" />đ
                                </div>
                                <div class="price-current">
                                    <fmt:formatNumber value="${tour.price}" type="number" groupingUsed="true" />đ
                                    <span>/người</span>
                                </div>
                            </div>

                            <div class="cta-box">
                                <c:choose>
                                    <c:when test="${remaining > 0}">
                                        <a href="booking?id=${tour.tourId}" class="btn-book-lg btn-book-primary">
                                            <i class="fas fa-bolt"></i> ĐẶT TOUR NGAY
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn-book-lg btn-disabled" disabled>
                                            <i class="fas fa-ban"></i> TẠM HẾT VÉ
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                                <a href="${pageContext.request.contextPath}/tour-3d?id=${tour.tourId}" class="btn-book-lg" style="background:linear-gradient(135deg,#7C3AED,#A855F7);color:#fff;box-shadow:0 6px 20px rgba(124,58,237,.25);position:relative;overflow:hidden">
                                    <i class="fas fa-cube" style="animation:spin3d 3s linear infinite"></i> XEM TOUR 3D 360°
                                </a>
                                <a href="#" class="btn-book-lg btn-book-outline">
                                    <i class="fas fa-phone-alt"></i> Liên Hệ Tư Vấn
                                </a>
                            </div>
                            <div class="support-note">
                                <i class="fas fa-headset"></i> Hỗ trợ 24/7 — Hotline: 1900 xxxx
                            </div>
                        </div>
                    </aside>
                </div>

                <!-- ═══ FOOTER ═══ -->
                <jsp:include page="/common/_footer.jsp" />

                <style>
                /* ═══ REVIEW STYLES ═══ */
                .review-summary{display:grid;grid-template-columns:200px 1fr;gap:30px;padding:24px;background:#FAFBFF;border-radius:16px;margin-bottom:28px;border:1px solid #E8EAF0}
                .review-avg{text-align:center;display:flex;flex-direction:column;align-items:center;justify-content:center}
                .review-avg .big-num{font-size:3.5rem;font-weight:900;color:#1B1F3B;line-height:1;letter-spacing:-2px}
                .review-avg .stars{color:#FFB703;font-size:1.2rem;margin:8px 0 4px;letter-spacing:2px}
                .review-avg .count{font-size:.82rem;color:#A0A5C3;font-weight:600}
                .review-bars{display:flex;flex-direction:column;gap:8px;justify-content:center}
                .bar-row{display:flex;align-items:center;gap:10px;font-size:.82rem}
                .bar-row .bar-label{width:50px;text-align:right;color:#6B7194;font-weight:600;white-space:nowrap}
                .bar-row .bar-track{flex:1;height:10px;background:#E8EAF0;border-radius:999px;overflow:hidden}
                .bar-row .bar-fill{height:100%;border-radius:999px;background:linear-gradient(90deg,#FFB703,#FF9500);transition:width .6s ease}
                .bar-row .bar-count{width:30px;font-weight:700;color:#4A4E6F;font-size:.78rem}

                /* Review Cards */
                .review-list{display:flex;flex-direction:column;gap:16px}
                .review-card{background:#fff;border:1px solid #E8EAF0;border-radius:16px;padding:22px;transition:.3s}
                .review-card:hover{box-shadow:0 4px 16px rgba(27,31,59,.06)}
                .review-header{display:flex;align-items:center;gap:14px;margin-bottom:12px}
                .review-avatar{width:44px;height:44px;border-radius:50%;background:linear-gradient(135deg,#FF6F61,#FF9A8B);display:flex;align-items:center;justify-content:center;color:#fff;font-weight:800;font-size:1rem;flex-shrink:0;overflow:hidden}
                .review-avatar img{width:100%;height:100%;object-fit:cover}
                .review-user-info{flex:1}
                .review-user-info .name{font-weight:700;color:#1B1F3B;font-size:.92rem}
                .review-user-info .time{font-size:.75rem;color:#A0A5C3;margin-top:2px}
                .review-stars{color:#FFB703;font-size:.9rem;letter-spacing:1px}
                .review-comment{color:#4A4E6F;line-height:1.75;font-size:.9rem}

                /* Review Form */
                .review-form-section{margin-top:28px;padding:28px;background:linear-gradient(135deg,rgba(255,111,97,.03),rgba(255,154,139,.02));border:1px solid #E8EAF0;border-radius:16px}
                .review-form-title{font-size:1.05rem;font-weight:800;color:#1B1F3B;margin-bottom:16px;display:flex;align-items:center;gap:8px}
                .review-form-title i{color:#FF6F61}
                .star-picker{display:flex;gap:6px;margin-bottom:16px}
                .star-picker .star{font-size:2rem;cursor:pointer;color:#D4D4D4;transition:.2s}
                .star-picker .star:hover,.star-picker .star.active{color:#FFB703;transform:scale(1.15)}
                .review-textarea{width:100%;padding:16px;border:2px solid #E8EAF0;border-radius:14px;font-size:.92rem;font-family:inherit;resize:vertical;min-height:100px;outline:none;transition:.3s;background:#fff;color:#1B1F3B;line-height:1.7}
                .review-textarea:focus{border-color:#FF6F61;box-shadow:0 0 0 3px rgba(255,111,97,.08)}
                .review-textarea::placeholder{color:#A0A5C3}
                .btn-submit-review{margin-top:14px;padding:14px 32px;border:none;border-radius:14px;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;font-weight:800;font-size:.92rem;cursor:pointer;font-family:inherit;transition:.3s;box-shadow:0 4px 15px rgba(255,111,97,.2);display:flex;align-items:center;gap:8px}
                .btn-submit-review:hover{transform:translateY(-2px);box-shadow:0 8px 25px rgba(255,111,97,.35)}
                .btn-submit-review:disabled{opacity:.6;cursor:not-allowed;transform:none}
                .review-login-prompt{text-align:center;padding:24px;background:#FAFBFF;border-radius:14px;border:1px solid #E8EAF0}
                .review-login-prompt a{color:#FF6F61;font-weight:700;text-decoration:underline}
                .review-toast{position:fixed;top:20px;right:20px;padding:14px 24px;border-radius:14px;font-weight:700;font-size:.88rem;z-index:9999;animation:slideIn .3s ease;display:flex;align-items:center;gap:8px;box-shadow:0 8px 30px rgba(0,0,0,.15)}
                .review-toast.success{background:#059669;color:#fff}
                .review-toast.error{background:#DC2626;color:#fff}
                @keyframes slideIn{from{transform:translateX(100%);opacity:0}to{transform:translateX(0);opacity:1}}
                @media(max-width:768px){.review-summary{grid-template-columns:1fr;text-align:center}.review-avg .big-num{font-size:2.5rem}}
                </style>

                <script>
                const CTX = '${pageContext.request.contextPath}';
                const TOUR_ID = ${tour.tourId};
                const IS_LOGGED_IN = ${not empty sessionScope.user};

                function switchTab(e, tabId) {
                    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
                    document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'));
                    e.target.classList.add('active');
                    document.getElementById(tabId).classList.add('active');
                    if (tabId === 'reviews') loadReviews();
                }

                function loadReviews() {
                    fetch(CTX + '/review?tourId=' + TOUR_ID)
                    .then(r => r.json())
                    .then(data => {
                        if (!data.success) return;
                        renderReviews(data);
                    })
                    .catch(() => {
                        document.getElementById('reviews-container').innerHTML =
                            '<div class="empty-state"><i class="fas fa-exclamation-triangle"></i><p>Không thể tải đánh giá.</p></div>';
                    });
                }

                function renderReviews(data) {
                    const c = document.getElementById('reviews-container');
                    let html = '';

                    // Summary
                    const total = data.totalReviews || 0;
                    const avg = data.avgRating || 0;
                    const dist = data.distribution || [0,0,0,0,0];
                    const maxDist = Math.max(...dist, 1);

                    if (total > 0) {
                        html += '<div class="review-summary">';
                        html += '<div class="review-avg">';
                        html += '<div class="big-num">' + avg.toFixed(1) + '</div>';
                        html += '<div class="stars">';
                        for (let i = 1; i <= 5; i++) html += i <= Math.round(avg) ? '★' : '☆';
                        html += '</div>';
                        html += '<div class="count">' + total + ' đánh giá</div>';
                        html += '</div>';
                        html += '<div class="review-bars">';
                        for (let i = 5; i >= 1; i--) {
                            const count = dist[i-1];
                            const pct = (count / maxDist * 100).toFixed(0);
                            html += '<div class="bar-row">';
                            html += '<span class="bar-label">' + i + ' sao</span>';
                            html += '<div class="bar-track"><div class="bar-fill" style="width:' + pct + '%"></div></div>';
                            html += '<span class="bar-count">' + count + '</span>';
                            html += '</div>';
                        }
                        html += '</div></div>';
                    }

                    // Review form
                    if (IS_LOGGED_IN) {
                        const hasReviewed = data.userHasReviewed;
                        const userRating = data.userRating || 0;
                        const userComment = data.userComment || '';

                        html += '<div class="review-form-section">';
                        html += '<div class="review-form-title"><i class="fas fa-pen"></i> ' +
                                (hasReviewed ? 'Cập Nhật Đánh Giá' : 'Viết Đánh Giá') + '</div>';
                        html += '<div class="star-picker" id="star-picker">';
                        for (let i = 1; i <= 5; i++) {
                            html += '<span class="star' + (i <= userRating ? ' active' : '') +
                                    '" data-rating="' + i + '" onclick="selectStar(' + i + ')">★</span>';
                        }
                        html += '</div>';
                        html += '<textarea class="review-textarea" id="review-comment" placeholder="Chia sẻ trải nghiệm của bạn về tour này...">' +
                                escapeHtml(userComment) + '</textarea>';
                        html += '<button class="btn-submit-review" id="btn-submit" onclick="submitReview()">';
                        html += '<i class="fas fa-paper-plane"></i> ' + (hasReviewed ? 'Cập Nhật' : 'Gửi Đánh Giá');
                        html += '</button></div>';
                    } else {
                        html += '<div class="review-login-prompt">';
                        html += '<p>🔒 <a href="' + CTX + '/login.jsp">Đăng nhập</a> để viết đánh giá</p>';
                        html += '</div>';
                    }

                    // Review list
                    if (data.reviews && data.reviews.length > 0) {
                        html += '<div class="review-list" style="margin-top:24px">';
                        data.reviews.forEach(r => {
                            const initial = (r.userName || 'U').charAt(0).toUpperCase();
                            html += '<div class="review-card">';
                            html += '<div class="review-header">';
                            if (r.userAvatar) {
                                html += '<div class="review-avatar"><img src="' + r.userAvatar + '" alt=""></div>';
                            } else {
                                html += '<div class="review-avatar">' + initial + '</div>';
                            }
                            html += '<div class="review-user-info">';
                            html += '<div class="name">' + escapeHtml(r.userName) + '</div>';
                            html += '<div class="time">' + r.timeAgo + '</div>';
                            html += '</div>';
                            html += '<div class="review-stars">';
                            for (let i = 1; i <= 5; i++) html += i <= r.rating ? '★' : '☆';
                            html += '</div></div>';
                            if (r.comment) {
                                html += '<div class="review-comment">' + escapeHtml(r.comment) + '</div>';
                            }
                            html += '</div>';
                        });
                        html += '</div>';
                    } else if (total === 0) {
                        html += '<div class="empty-state" style="margin-top:20px">';
                        html += '<i class="fas fa-star-half-alt"></i>';
                        html += '<p>Chưa có đánh giá nào. Hãy là người đầu tiên!</p></div>';
                    }

                    c.innerHTML = html;
                }

                let selectedRating = 0;
                function selectStar(rating) {
                    selectedRating = rating;
                    document.querySelectorAll('#star-picker .star').forEach((s, i) => {
                        s.classList.toggle('active', i < rating);
                    });
                }

                function submitReview() {
                    if (selectedRating === 0) { showToast('error', 'Vui lòng chọn số sao'); return; }
                    const comment = document.getElementById('review-comment').value.trim();
                    const btn = document.getElementById('btn-submit');
                    btn.disabled = true;

                    fetch(CTX + '/review', {
                        method: 'POST',
                        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                        body: 'tourId=' + TOUR_ID + '&rating=' + selectedRating +
                              '&comment=' + encodeURIComponent(comment)
                    })
                    .then(r => r.json())
                    .then(data => {
                        showToast(data.success ? 'success' : 'error', data.message);
                        if (data.success) {
                            // Update hero rating
                            const metaItems = document.querySelectorAll('.meta-item');
                            metaItems.forEach(m => {
                                if (m.innerHTML.includes('fa-star')) {
                                    m.innerHTML = '<i class="fas fa-star" style="color:#FFB703"></i> ' +
                                        data.newAvgRating.toFixed(1) + ' (' + data.newTotalReviews + ' đánh giá)';
                                }
                            });
                            loadReviews();
                        }
                        btn.disabled = false;
                    })
                    .catch(() => {
                        showToast('error', 'Lỗi kết nối. Vui lòng thử lại.');
                        btn.disabled = false;
                    });
                }

                function showToast(type, msg) {
                    const toast = document.createElement('div');
                    toast.className = 'review-toast ' + type;
                    toast.innerHTML = '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + '"></i> ' + msg;
                    document.body.appendChild(toast);
                    setTimeout(() => toast.remove(), 3000);
                }

                function escapeHtml(text) {
                    if (!text) return '';
                    const d = document.createElement('div');
                    d.textContent = text;
                    return d.innerHTML;
                }
                </script>
            </body>

            </html>