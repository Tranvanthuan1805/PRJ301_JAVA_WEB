<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Dashboard Nhà Cung Cấp | EZTravel</title>
                <link
                    href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
                <style>
                    * {
                        box-sizing: border-box
                    }

                    body {
                        font-family: 'Plus Jakarta Sans', system-ui, sans-serif;
                        background: #F4F5FA;
                        color: #1B1F3B
                    }

                    .dash-hero {
                        margin-top: 64px;
                        background: linear-gradient(135deg, #0F172A, #1E293B 60%, #334155);
                        padding: 48px 0 80px;
                        position: relative;
                        overflow: hidden
                    }

                    .dash-hero::before {
                        content: '';
                        position: absolute;
                        width: 500px;
                        height: 500px;
                        background: radial-gradient(circle, rgba(59, 130, 246, .1), transparent 65%);
                        top: -200px;
                        right: -100px;
                        border-radius: 50%
                    }

                    .dash-content {
                        max-width: 1200px;
                        margin: 0 auto;
                        padding: 0 30px;
                        position: relative;
                        z-index: 2;
                        display: flex;
                        justify-content: space-between;
                        align-items: center
                    }

                    .dash-left h1 {
                        font-size: 1.8rem;
                        font-weight: 900;
                        color: #fff;
                        margin-bottom: 4px;
                        display: flex;
                        align-items: center;
                        gap: 10px
                    }

                    .dash-left h1 i {
                        color: #60A5FA
                    }

                    .dash-left p {
                        color: rgba(255, 255, 255, .5);
                        font-size: .88rem
                    }

                    .dash-left .biz-name {
                        color: #60A5FA;
                        font-weight: 800
                    }

                    .dash-right {
                        display: flex;
                        gap: 10px
                    }

                    .dash-btn {
                        padding: 12px 24px;
                        border-radius: 12px;
                        font-weight: 700;
                        font-size: .85rem;
                        font-family: inherit;
                        text-decoration: none;
                        display: flex;
                        align-items: center;
                        gap: 8px;
                        transition: .3s;
                        border: none;
                        cursor: pointer
                    }

                    .dash-btn-primary {
                        background: linear-gradient(135deg, #3B82F6, #60A5FA);
                        color: #fff;
                        box-shadow: 0 4px 15px rgba(59, 130, 246, .2)
                    }

                    .dash-btn-primary:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 8px 25px rgba(59, 130, 246, .4)
                    }

                    .page-body {
                        max-width: 1200px;
                        margin: 0 auto;
                        padding: 0 30px
                    }

                    /* Stats */
                    .dash-stats {
                        display: grid;
                        grid-template-columns: repeat(3, 1fr);
                        gap: 16px;
                        margin: -45px 0 32px;
                        position: relative;
                        z-index: 10
                    }

                    .d-stat {
                        background: #fff;
                        padding: 24px;
                        border-radius: 18px;
                        text-align: center;
                        box-shadow: 0 6px 25px rgba(0, 0, 0, .04);
                        border: 1px solid #E8EAF0;
                        transition: .3s
                    }

                    .d-stat:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 10px 35px rgba(0, 0, 0, .08)
                    }

                    .d-stat .d-icon {
                        width: 44px;
                        height: 44px;
                        border-radius: 12px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1rem;
                        margin: 0 auto 10px
                    }

                    .d-stat:nth-child(1) .d-icon {
                        background: rgba(59, 130, 246, .08);
                        color: #3B82F6
                    }

                    .d-stat:nth-child(2) .d-icon {
                        background: rgba(245, 158, 11, .08);
                        color: #F59E0B
                    }

                    .d-stat:nth-child(3) .d-icon {
                        background: rgba(5, 150, 105, .08);
                        color: #059669
                    }

                    .d-stat .d-num {
                        font-size: 2rem;
                        font-weight: 900;
                        letter-spacing: -1px
                    }

                    .d-stat:nth-child(1) .d-num {
                        color: #3B82F6
                    }

                    .d-stat:nth-child(2) .d-num {
                        color: #D97706
                    }

                    .d-stat:nth-child(3) .d-num {
                        color: #059669
                    }

                    .d-stat .d-label {
                        font-size: .78rem;
                        color: #A0A5C3;
                        font-weight: 700;
                        margin-top: 4px;
                        text-transform: uppercase;
                        letter-spacing: .3px
                    }

                    /* Tour Listing */
                    .section-head {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 16px
                    }

                    .section-head h2 {
                        font-size: 1.3rem;
                        font-weight: 800;
                        display: flex;
                        align-items: center;
                        gap: 8px
                    }

                    .section-head h2 i {
                        color: #3B82F6;
                        font-size: 1rem
                    }

                    .tour-grid {
                        display: grid;
                        gap: 14px;
                        margin-bottom: 60px
                    }

                    .t-card {
                        background: #fff;
                        border-radius: 18px;
                        box-shadow: 0 4px 16px rgba(0, 0, 0, .03);
                        border: 1px solid #E8EAF0;
                        overflow: hidden;
                        transition: .3s
                    }

                    .t-card:hover {
                        box-shadow: 0 8px 30px rgba(0, 0, 0, .07);
                        transform: translateY(-2px)
                    }

                    .t-inner {
                        display: grid;
                        grid-template-columns: 140px 1fr auto;
                        gap: 0
                    }

                    .t-thumb {
                        width: 140px;
                        height: 100%;
                        min-height: 110px;
                        overflow: hidden
                    }

                    .t-thumb img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                        transition: .4s
                    }

                    .t-card:hover .t-thumb img {
                        transform: scale(1.05)
                    }

                    .t-body {
                        padding: 18px 22px;
                        display: flex;
                        flex-direction: column;
                        justify-content: center;
                        gap: 4px
                    }

                    .t-name {
                        font-size: 1rem;
                        font-weight: 800;
                        color: #1B1F3B
                    }

                    .t-meta {
                        display: flex;
                        align-items: center;
                        gap: 14px;
                        font-size: .78rem;
                        color: #A0A5C3;
                        font-weight: 600
                    }

                    .t-meta i {
                        font-size: .7rem;
                        color: #6B7194
                    }

                    .t-price {
                        font-weight: 800;
                        color: #059669;
                        font-size: 1rem
                    }

                    .t-status {
                        display: inline-flex;
                        align-items: center;
                        gap: 5px;
                        padding: 5px 12px;
                        border-radius: 999px;
                        font-size: .72rem;
                        font-weight: 800
                    }

                    .t-status-active {
                        background: #ECFDF5;
                        color: #059669;
                        border: 1px solid rgba(5, 150, 105, .15)
                    }

                    .t-status-pending {
                        background: #FFF8E1;
                        color: #D97706;
                        border: 1px solid rgba(245, 158, 11, .15)
                    }

                    .t-actions {
                        display: flex;
                        flex-direction: column;
                        gap: 6px;
                        padding: 18px 22px;
                        justify-content: center;
                        align-items: flex-end;
                        border-left: 1px solid #F0F1F5
                    }

                    .t-btn {
                        padding: 8px 16px;
                        border-radius: 10px;
                        font-size: .78rem;
                        font-weight: 700;
                        font-family: inherit;
                        text-decoration: none;
                        transition: .3s;
                        display: flex;
                        align-items: center;
                        gap: 5px;
                        border: 1px solid #E8EAF0;
                        background: #FAFBFF;
                        color: #6B7194;
                        cursor: pointer
                    }

                    .t-btn:hover {
                        background: #1E293B;
                        color: #fff;
                        border-color: #1E293B
                    }

                    .t-btn-3d {
                        background: rgba(59, 130, 246, .06);
                        color: #3B82F6;
                        border-color: rgba(59, 130, 246, .15)
                    }

                    .t-btn-3d:hover {
                        background: #3B82F6;
                        color: #fff
                    }

                    /* Empty */
                    .empty {
                        text-align: center;
                        padding: 60px 30px;
                        background: #fff;
                        border-radius: 20px;
                        border: 1px solid #E8EAF0;
                        margin-bottom: 60px
                    }

                    .empty .icon {
                        font-size: 3rem;
                        margin-bottom: 14px
                    }

                    .empty h3 {
                        font-size: 1.1rem;
                        font-weight: 800;
                        margin-bottom: 6px
                    }

                    .empty p {
                        color: #6B7194;
                        margin-bottom: 20px
                    }

                    /* Alerts */
                    .alert {
                        padding: 14px 20px;
                        border-radius: 14px;
                        margin-bottom: 20px;
                        font-size: .88rem;
                        font-weight: 600;
                        display: flex;
                        align-items: center;
                        gap: 8px
                    }

                    .alert-success {
                        background: #ECFDF5;
                        color: #059669;
                        border: 1px solid rgba(5, 150, 105, .15)
                    }

                    .alert-error {
                        background: #FEF2F2;
                        color: #DC2626;
                        border: 1px solid rgba(220, 38, 38, .15)
                    }

                    @media(max-width:900px) {
                        .dash-stats {
                            grid-template-columns: 1fr 1fr 1fr
                        }

                        .t-inner {
                            grid-template-columns: 100px 1fr
                        }

                        .t-actions {
                            grid-column: 1/-1;
                            flex-direction: row;
                            border-left: none;
                            border-top: 1px solid #F0F1F5;
                            padding: 12px 22px
                        }

                        .dash-content {
                            flex-direction: column;
                            gap: 16px;
                            text-align: center
                        }
                    }

                    @media(max-width:600px) {
                        .dash-stats {
                            grid-template-columns: 1fr
                        }

                        .t-inner {
                            grid-template-columns: 1fr
                        }

                        .t-thumb {
                            width: 100%;
                            height: 160px
                        }
                    }
                </style>
            </head>

            <body>
                <jsp:include page="/common/_header.jsp" />

                <div class="dash-hero">
                    <div class="dash-content">
                        <div class="dash-left">
                            <h1><i class="fas fa-store"></i> Dashboard Nhà Cung Cấp</h1>
                            <p>Chào mừng, <span class="biz-name">${provider.businessName}</span> •
                                ${provider.providerType}</p>
                        </div>
                        <div class="dash-right">
                            <a href="${pageContext.request.contextPath}/provider?action=create-tour"
                                class="dash-btn dash-btn-primary">
                                <i class="fas fa-plus"></i> Tạo Tour Mới
                            </a>
                        </div>
                    </div>
                </div>

                <div class="page-body">
                    <!-- Alerts -->
                    <c:if test="${not empty sessionScope.success}">
                        <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${sessionScope.success}
                        </div>
                        <c:remove var="success" scope="session" />
                    </c:if>
                    <c:if test="${not empty sessionScope.error}">
                        <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> ${sessionScope.error}
                        </div>
                        <c:remove var="error" scope="session" />
                    </c:if>

                    <!-- Stats -->
                    <div class="dash-stats">
                        <div class="d-stat">
                            <div class="d-icon"><i class="fas fa-map-marked-alt"></i></div>
                            <div class="d-num">${tours.size()}</div>
                            <div class="d-label">Tổng Tours</div>
                        </div>
                        <div class="d-stat">
                            <div class="d-icon"><i class="fas fa-hourglass-half"></i></div>
                            <div class="d-num">${pendingCount}</div>
                            <div class="d-label">Chờ Duyệt</div>
                        </div>
                        <div class="d-stat">
                            <div class="d-icon"><i class="fas fa-check-circle"></i></div>
                            <div class="d-num">${activeCount}</div>
                            <div class="d-label">Đang Hoạt Động</div>
                        </div>
                    </div>

                    <!-- Tour List -->
                    <div class="section-head">
                        <h2><i class="fas fa-list"></i> Danh Sách Tour Của Bạn</h2>
                    </div>

                    <c:choose>
                        <c:when test="${not empty tours}">
                            <div class="tour-grid">
                                <c:forEach items="${tours}" var="t">
                                    <div class="t-card">
                                        <div class="t-inner">
                                            <div class="t-thumb">
                                                <img src="${not empty t.imageUrl ? t.imageUrl : 'https://images.unsplash.com/photo-1559592442-7e182c3c03fb?auto=format&fit=crop&w=300&q=80'}"
                                                    alt="${t.tourName}" loading="lazy">
                                            </div>
                                            <div class="t-body">
                                                <div class="t-name">${t.tourName}</div>
                                                <div class="t-meta">
                                                    <span><i class="fas fa-clock"></i> ${t.duration}</span>
                                                    <span><i class="fas fa-map-marker-alt"></i>
                                                        ${t.startLocation}</span>
                                                    <span><i class="fas fa-calendar"></i>
                                                        <fmt:formatDate value="${t.createdAt}" pattern="dd/MM/yyyy" />
                                                    </span>
                                                </div>
                                                <div style="display:flex;align-items:center;gap:10px;margin-top:4px">
                                                    <span class="t-price">
                                                        <fmt:formatNumber value="${t.price}" type="number"
                                                            groupingUsed="true" />đ
                                                    </span>
                                                    <c:choose>
                                                        <c:when test="${t.active}"><span
                                                                class="t-status t-status-active"><i
                                                                    class="fas fa-check"></i> Hoạt động</span></c:when>
                                                        <c:otherwise><span class="t-status t-status-pending"><i
                                                                    class="fas fa-clock"></i> Chờ duyệt</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            <div class="t-actions">
                                                <a href="${pageContext.request.contextPath}/tour?action=view&id=${t.tourId}"
                                                    class="t-btn"><i class="fas fa-eye"></i> Xem</a>
                                                <c:if test="${not empty t.images && t.images.size() > 0}">
                                                    <a href="${pageContext.request.contextPath}/tour?action=view&id=${t.tourId}#tour3d"
                                                        class="t-btn t-btn-3d"><i class="fas fa-cube"></i> 3D</a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty">
                                <div class="icon">🗺️</div>
                                <h3>Chưa có tour nào</h3>
                                <p>Bắt đầu tạo tour đầu tiên để đưa lên nền tảng EZTravel!</p>
                                <a href="${pageContext.request.contextPath}/provider?action=create-tour"
                                    class="dash-btn dash-btn-primary" style="display:inline-flex">
                                    <i class="fas fa-plus"></i> Tạo Tour Mới
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <jsp:include page="/common/_footer.jsp" />
            </body>

            </html>