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
                        </div>

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
                            <div class="empty-state">
                                <i class="fas fa-star-half-alt"></i>
                                <p>Chưa có đánh giá nào cho tour này. Hãy là người đầu tiên!</p>
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

                <script>
                    function switchTab(e, tabId) {
                        document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
                        document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'));
                        e.target.classList.add('active');
                        document.getElementById(tabId).classList.add('active');
                    }
                </script>
            </body>

            </html>