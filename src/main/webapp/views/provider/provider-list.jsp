<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Nhà Cung Cấp Uy Tín | Da Nang Travel Hub</title>
                <link
                    href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
                <style>
                    /* ═══ RESET & BASE ═══ */
                    *,
                    *::before,
                    *::after {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }

                    html {
                        scroll-behavior: smooth;
                    }

                    body {
                        font-family: 'Plus Jakarta Sans', system-ui, sans-serif;
                        background: #F7F8FC;
                        color: #1B1F3B;
                        line-height: 1.65;
                        -webkit-font-smoothing: antialiased;
                        overflow-x: hidden;
                    }

                    a {
                        text-decoration: none;
                        color: inherit;
                        transition: .3s;
                    }

                    /* ═══ HERO SECTION ═══ */
                    .hero {
                        position: relative;
                        background: linear-gradient(135deg, #1B1F3B 0%, #2D3561 100%);
                        padding: 140px 30px 100px;
                        overflow: hidden;
                    }

                    .hero::before {
                        content: '';
                        position: absolute;
                        width: 600px;
                        height: 600px;
                        background: radial-gradient(circle, rgba(255, 111, 97, .15), transparent 70%);
                        top: -200px;
                        right: -100px;
                        border-radius: 50%;
                        animation: float 20s ease-in-out infinite;
                    }

                    .hero::after {
                        content: '';
                        position: absolute;
                        width: 500px;
                        height: 500px;
                        background: radial-gradient(circle, rgba(0, 180, 216, .12), transparent 70%);
                        bottom: -150px;
                        left: -100px;
                        border-radius: 50%;
                        animation: float 15s ease-in-out infinite reverse;
                    }

                    @keyframes float {

                        0%,
                        100% {
                            transform: translate(0, 0) scale(1);
                        }

                        50% {
                            transform: translate(30px, -30px) scale(1.1);
                        }
                    }

                    .hero-content {
                        position: relative;
                        z-index: 2;
                        max-width: 1280px;
                        margin: 0 auto;
                        text-align: center;
                    }

                    .hero-badge {
                        display: inline-flex;
                        align-items: center;
                        gap: 8px;
                        padding: 10px 24px;
                        background: rgba(255, 255, 255, .12);
                        backdrop-filter: blur(10px);
                        border: 1px solid rgba(255, 255, 255, .15);
                        border-radius: 999px;
                        font-size: .88rem;
                        font-weight: 600;
                        color: rgba(255, 255, 255, .95);
                        margin-bottom: 24px;
                        animation: fadeInUp .8s ease;
                    }

                    .hero-badge .pulse-dot {
                        width: 8px;
                        height: 8px;
                        background: #06D6A0;
                        border-radius: 50%;
                        animation: pulse 2s ease infinite;
                    }

                    @keyframes pulse {

                        0%,
                        100% {
                            opacity: 1;
                            transform: scale(1);
                        }

                        50% {
                            opacity: .5;
                            transform: scale(1.5);
                        }
                    }

                    .hero h1 {
                        font-size: 3.8rem;
                        font-weight: 800;
                        color: white;
                        margin-bottom: 20px;
                        letter-spacing: -1.5px;
                        animation: fadeInUp .8s ease .1s both;
                    }

                    .hero h1 .icon {
                        display: inline-block;
                        animation: bounce 2s ease infinite;
                    }

                    @keyframes bounce {

                        0%,
                        100% {
                            transform: translateY(0);
                        }

                        50% {
                            transform: translateY(-10px);
                        }
                    }

                    .hero h1 .highlight {
                        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                    }

                    .hero p {
                        font-size: 1.2rem;
                        color: rgba(255, 255, 255, .85);
                        margin-bottom: 50px;
                        animation: fadeInUp .8s ease .2s both;
                    }

                    @keyframes fadeInUp {
                        from {
                            opacity: 0;
                            transform: translateY(30px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    /* ═══ STATS ═══ */
                    .stats {
                        display: flex;
                        justify-content: center;
                        gap: 80px;
                        flex-wrap: wrap;
                        animation: fadeInUp .8s ease .3s both;
                    }

                    .stat-item {
                        text-align: center;
                    }

                    .stat-value {
                        font-size: 3.5rem;
                        font-weight: 800;
                        margin-bottom: 8px;
                        background: linear-gradient(135deg, #FF6F61, #FFB703);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                    }

                    .stat-label {
                        font-size: 1rem;
                        color: rgba(255, 255, 255, .75);
                        font-weight: 500;
                    }

                    /* ═══ MAIN CONTENT ═══ */
                    .main-content {
                        max-width: 1280px;
                        margin: -60px auto 80px;
                        padding: 0 30px;
                        position: relative;
                        z-index: 10;
                    }

                    /* ═══ FILTER SECTION ═══ */
                    .filter-card {
                        background: white;
                        border-radius: 24px;
                        padding: 35px;
                        box-shadow: 0 10px 40px rgba(27, 31, 59, .08);
                        margin-bottom: 50px;
                        border: 1px solid #E8EAF0;
                    }

                    .filter-header {
                        display: flex;
                        align-items: center;
                        gap: 12px;
                        margin-bottom: 25px;
                    }

                    .filter-header h3 {
                        font-size: 1.3rem;
                        font-weight: 800;
                        color: #1B1F3B;
                        margin: 0;
                    }

                    .filter-header .icon {
                        width: 40px;
                        height: 40px;
                        background: linear-gradient(135deg, rgba(255, 111, 97, .1), rgba(255, 154, 139, .05));
                        border-radius: 12px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: #FF6F61;
                        font-size: 1.1rem;
                    }

                    .filter-tabs {
                        display: flex;
                        gap: 12px;
                        flex-wrap: wrap;
                        margin-bottom: 25px;
                    }

                    .filter-tab {
                        padding: 14px 28px;
                        border-radius: 999px;
                        font-weight: 700;
                        font-size: .9rem;
                        border: 2px solid #E8EAF0;
                        background: white;
                        color: #6B7194;
                        cursor: pointer;
                        transition: all .3s cubic-bezier(.175, .885, .32, 1.275);
                        display: inline-flex;
                        align-items: center;
                        gap: 8px;
                    }

                    .filter-tab:hover {
                        border-color: #FF6F61;
                        transform: translateY(-2px);
                    }

                    .filter-tab.active {
                        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
                        color: white;
                        border-color: #FF6F61;
                        box-shadow: 0 6px 20px rgba(255, 111, 97, .3);
                    }

                    .search-wrapper {
                        position: relative;
                    }

                    .search-input {
                        width: 100%;
                        padding: 16px 60px 16px 24px;
                        border: 2px solid #E8EAF0;
                        border-radius: 16px;
                        font-size: 1rem;
                        font-family: inherit;
                        transition: .3s;
                        background: #F7F8FC;
                    }

                    .search-input:focus {
                        outline: none;
                        border-color: #FF6F61;
                        background: white;
                        box-shadow: 0 4px 20px rgba(255, 111, 97, .15);
                    }

                    .search-btn {
                        position: absolute;
                        right: 8px;
                        top: 50%;
                        transform: translateY(-50%);
                        width: 48px;
                        height: 48px;
                        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
                        border: none;
                        border-radius: 12px;
                        color: white;
                        font-size: 1.1rem;
                        cursor: pointer;
                        transition: .3s;
                    }

                    .search-btn:hover {
                        transform: translateY(-50%) scale(1.05);
                        box-shadow: 0 6px 20px rgba(255, 111, 97, .4);
                    }

                    /* ═══ PROVIDERS GRID ═══ */
                    .providers-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
                        gap: 32px;
                        margin-bottom: 60px;
                    }

                    /* ═══ PROVIDER CARD ═══ */
                    .provider-card {
                        background: white;
                        border-radius: 24px;
                        overflow: hidden;
                        border: 2px solid #E8EAF0;
                        box-shadow: 0 4px 20px rgba(27, 31, 59, .06);
                        transition: all .4s cubic-bezier(.175, .885, .32, 1.275);
                        cursor: pointer;
                    }

                    .provider-card:hover {
                        transform: translateY(-12px);
                        box-shadow: 0 25px 60px rgba(27, 31, 59, .15);
                        border-color: #FF6F61;
                    }

                    .provider-header {
                        position: relative;
                        height: 140px;
                        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        overflow: hidden;
                    }

                    .provider-header::before {
                        content: '';
                        position: absolute;
                        inset: 0;
                        background: url('data:image/svg+xml,<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><defs><pattern id="grid" width="20" height="20" patternUnits="userSpaceOnUse"><path d="M 20 0 L 0 0 0 20" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="1"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
                        opacity: .4;
                    }

                    .provider-type-badge {
                        position: absolute;
                        top: 16px;
                        right: 16px;
                        padding: 8px 16px;
                        background: rgba(255, 255, 255, .25);
                        backdrop-filter: blur(10px);
                        border-radius: 999px;
                        font-size: .8rem;
                        font-weight: 700;
                        color: white;
                        border: 1px solid rgba(255, 255, 255, .3);
                    }

                    .provider-icon {
                        position: relative;
                        z-index: 1;
                        width: 80px;
                        height: 80px;
                        background: white;
                        border-radius: 20px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 2.2rem;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, .2);
                        transition: .3s;
                    }

                    .provider-card:hover .provider-icon {
                        transform: scale(1.1) rotate(-5deg);
                    }

                    .provider-body {
                        padding: 28px;
                    }

                    .provider-name {
                        font-size: 1.35rem;
                        font-weight: 800;
                        color: #1B1F3B;
                        margin-bottom: 12px;
                        line-height: 1.3;
                    }

                    .rating-box {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        margin-bottom: 18px;
                    }

                    .stars {
                        color: #FFB703;
                        font-size: 1rem;
                    }

                    .rating-value {
                        font-weight: 800;
                        color: #1B1F3B;
                        font-size: 1.1rem;
                    }

                    .provider-info {
                        display: flex;
                        flex-direction: column;
                        gap: 10px;
                        margin-bottom: 18px;
                    }

                    .info-item {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        color: #6B7194;
                        font-size: .95rem;
                    }

                    .info-item i {
                        width: 24px;
                        color: #FF6F61;
                        font-size: 1rem;
                    }

                    .verified-badge {
                        display: inline-flex;
                        align-items: center;
                        gap: 6px;
                        padding: 8px 16px;
                        background: rgba(6, 214, 160, .1);
                        color: #06D6A0;
                        border-radius: 999px;
                        font-size: .85rem;
                        font-weight: 700;
                        margin-bottom: 20px;
                    }

                    .provider-actions {
                        display: flex;
                        gap: 10px;
                    }

                    .btn {
                        flex: 1;
                        padding: 14px;
                        border: none;
                        border-radius: 14px;
                        font-weight: 700;
                        font-size: .9rem;
                        cursor: pointer;
                        transition: all .3s;
                        font-family: inherit;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        gap: 8px;
                    }

                    .btn-primary {
                        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
                        color: white;
                        box-shadow: 0 6px 20px rgba(255, 111, 97, .3);
                    }

                    .btn-primary:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 10px 30px rgba(255, 111, 97, .45);
                    }

                    .btn-outline {
                        background: transparent;
                        border: 2px solid #E8EAF0;
                        color: #6B7194;
                    }

                    .btn-outline:hover {
                        border-color: #FF6F61;
                        color: #FF6F61;
                        background: rgba(255, 111, 97, .05);
                    }

                    /* ═══ EMPTY STATE ═══ */
                    .empty-state {
                        text-align: center;
                        padding: 100px 30px;
                        background: white;
                        border-radius: 24px;
                        box-shadow: 0 4px 20px rgba(27, 31, 59, .06);
                        margin-bottom: 60px;
                    }

                    .empty-state .icon {
                        font-size: 6rem;
                        color: #E8EAF0;
                        margin-bottom: 24px;
                        animation: float 3s ease-in-out infinite;
                    }

                    .empty-state h3 {
                        font-size: 1.8rem;
                        font-weight: 800;
                        color: #1B1F3B;
                        margin-bottom: 12px;
                    }

                    .empty-state p {
                        color: #6B7194;
                        font-size: 1.05rem;
                        max-width: 500px;
                        margin: 0 auto;
                    }

                    /* ═══ QUICK ACTIONS ═══ */
                    .quick-actions {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                        gap: 24px;
                    }

                    .action-card {
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        gap: 12px;
                        padding: 24px;
                        border-radius: 20px;
                        font-weight: 800;
                        font-size: 1.1rem;
                        color: white;
                        box-shadow: 0 6px 24px rgba(0, 0, 0, .15);
                        transition: all .3s;
                    }

                    .action-card:hover {
                        transform: translateY(-6px);
                        box-shadow: 0 12px 40px rgba(0, 0, 0, .25);
                    }

                    .action-card.compare {
                        background: linear-gradient(135deg, #00B4D8, #48CAE4);
                    }

                    .action-card.register {
                        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
                    }

                    .action-card i {
                        font-size: 1.5rem;
                    }

                    /* ═══ RESPONSIVE ═══ */
                    @media (max-width: 768px) {
                        .hero {
                            padding: 120px 20px 80px;
                        }

                        .hero h1 {
                            font-size: 2.5rem;
                        }

                        .stats {
                            gap: 40px;
                        }

                        .stat-value {
                            font-size: 2.5rem;
                        }

                        .providers-grid {
                            grid-template-columns: 1fr;
                        }

                        .filter-tabs {
                            flex-direction: column;
                        }

                        .filter-tab {
                            width: 100%;
                            justify-content: center;
                        }
                    }
                </style>
            </head>

            <body>
                <!-- Include Header -->
                <jsp:include page="/common/_header.jsp" />

                <!-- Hero Section -->
                <section class="hero">
                    <div class="hero-content">
                        <div class="hero-badge">
                            <span class="pulse-dot"></span>
                            <span>Đối Tác Được Xác Minh</span>
                        </div>
                        <h1>
                            <span class="icon">🏢</span> Nhà Cung Cấp <span class="highlight">Uy Tín</span>
                        </h1>
                        <p>Khám phá các đối tác du lịch hàng đầu tại Đà Nẵng với chất lượng dịch vụ được đảm bảo</p>

                        <div class="stats">
                            <div class="stat-item">
                                <div class="stat-value">${totalProviders}</div>
                                <div class="stat-label">Nhà Cung Cấp</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-value">⭐ 4.7</div>
                                <div class="stat-label">Đánh Giá TB</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-value">✓ 100%</div>
                                <div class="stat-label">Đã Xác Minh</div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Main Content -->
                <div class="main-content">
                    <!-- Filter Card -->
                    <div class="filter-card">
                        <div class="filter-header">
                            <div class="icon">
                                <i class="fas fa-filter"></i>
                            </div>
                            <h3>Lọc & Tìm Kiếm</h3>
                        </div>

                        <div class="filter-tabs">
                            <a href="${pageContext.request.contextPath}/providers"
                                class="filter-tab ${empty selectedType ? 'active' : ''}">
                                <i class="fas fa-th"></i> Tất cả
                            </a>
                            <a href="${pageContext.request.contextPath}/providers?type=Hotel"
                                class="filter-tab ${selectedType == 'Hotel' ? 'active' : ''}">
                                <i class="fas fa-hotel"></i> Khách sạn
                            </a>
                            <a href="${pageContext.request.contextPath}/providers?type=TourOperator"
                                class="filter-tab ${selectedType == 'TourOperator' ? 'active' : ''}">
                                <i class="fas fa-map-marked-alt"></i> Tour Operator
                            </a>
                            <a href="${pageContext.request.contextPath}/providers?type=Transport"
                                class="filter-tab ${selectedType == 'Transport' ? 'active' : ''}">
                                <i class="fas fa-car"></i> Vận chuyển
                            </a>
                        </div>

                        <form action="${pageContext.request.contextPath}/providers" method="get">
                            <div class="search-wrapper">
                                <input type="text" name="search" class="search-input"
                                    placeholder="Tìm kiếm nhà cung cấp theo tên, loại hình..." value="${searchKeyword}">
                                <button type="submit" class="search-btn">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </form>
                    </div>

                    <!-- Providers Grid -->
                    <c:choose>
                        <c:when test="${not empty providers}">
                            <div class="providers-grid">
                                <c:forEach items="${providers}" var="provider">
                                    <div class="provider-card"
                                        onclick="window.location.href='${pageContext.request.contextPath}/providers?action=history&id=${provider.providerId}'">
                                        <div class="provider-header">
                                            <span class="provider-type-badge">
                                                <c:choose>
                                                    <c:when test="${provider.providerType == 'Hotel'}">
                                                        <i class="fas fa-hotel"></i> Khách sạn
                                                    </c:when>
                                                    <c:when test="${provider.providerType == 'TourOperator'}">
                                                        <i class="fas fa-map-marked-alt"></i> Tour
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-car"></i> Vận chuyển
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                            <div class="provider-icon">
                                                <c:choose>
                                                    <c:when test="${provider.providerType == 'Hotel'}">🏨</c:when>
                                                    <c:when test="${provider.providerType == 'TourOperator'}">🗺️
                                                    </c:when>
                                                    <c:otherwise>🚗</c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>

                                        <div class="provider-body">
                                            <h3 class="provider-name">${provider.businessName}</h3>

                                            <div class="rating-box">
                                                <div class="stars">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <i
                                                            class="${not empty provider.rating && i <= provider.rating ? 'fas' : 'far'} fa-star"></i>
                                                    </c:forEach>
                                                </div>
                                                <span class="rating-value">
                                                    <fmt:formatNumber value="${provider.rating}"
                                                        maxFractionDigits="1" />
                                                </span>
                                            </div>

                                            <div class="provider-info">
                                                <div class="info-item">
                                                    <i class="fas fa-certificate"></i>
                                                    <span>${provider.businessLicense}</span>
                                                </div>
                                                <div class="info-item">
                                                    <i class="fas fa-route"></i>
                                                    <span>${provider.totalTours} tours đang hoạt động</span>
                                                </div>
                                                <div class="info-item">
                                                    <i class="fas fa-map-marker-alt"></i>
                                                    <span>Đà Nẵng, Việt Nam</span>
                                                </div>
                                            </div>

                                            <c:if test="${provider.isVerified}">
                                                <div class="verified-badge">
                                                    <i class="fas fa-check-circle"></i>
                                                    <span>Đã xác minh</span>
                                                </div>
                                            </c:if>

                                            <div class="provider-actions">
                                                <a href="${pageContext.request.contextPath}/providers?action=history&id=${provider.providerId}"
                                                    class="btn btn-primary" onclick="event.stopPropagation()">
                                                    <i class="fas fa-eye"></i> Xem chi tiết
                                                </a>
                                                <button class="btn btn-outline" onclick="event.stopPropagation()">
                                                    <i class="fas fa-heart"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <div class="icon">
                                    <i class="fas fa-search"></i>
                                </div>
                                <h3>Không tìm thấy nhà cung cấp</h3>
                                <p>Vui lòng thử lại với từ khóa khác hoặc chọn loại dịch vụ khác để xem kết quả</p>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <!-- Quick Actions -->
                    <div class="quick-actions">
                        <a href="${pageContext.request.contextPath}/providers?action=compare"
                            class="action-card compare">
                            <i class="fas fa-balance-scale"></i>
                            <span>So sánh nhà cung cấp</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/providers?action=register"
                            class="action-card register">
                            <i class="fas fa-user-plus"></i>
                            <span>Đăng ký làm nhà cung cấp</span>
                        </a>
                    </div>
                </div>

                <!-- Include Footer -->
                <jsp:include page="/common/_footer.jsp" />
            </body>

            </html>