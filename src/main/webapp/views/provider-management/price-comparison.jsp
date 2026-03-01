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

                    img {
                        max-width: 100%;
                        display: block;
                    }

                    /* ═══ HERO SECTION ═══ */
                    .hero {
                        position: relative;
                        background: linear-gradient(135deg, #1B1F3B 0%, #2D3561 100%);
                        padding: 140px 0 80px;
                        overflow: hidden;
                    }

                    .hero::before {
                        content: '';
                        position: absolute;
                        width: 600px;
                        height: 600px;
                        background: radial-gradient(circle, rgba(255, 111, 97, .15), transparent 60%);
                        top: -200px;
                        right: -100px;
                        border-radius: 50%;
                    }

                    .hero::after {
                        content: '';
                        position: absolute;
                        width: 500px;
                        height: 500px;
                        background: radial-gradient(circle, rgba(0, 180, 216, .12), transparent 60%);
                        bottom: -150px;
                        left: -100px;
                        border-radius: 50%;
                    }

                    .hero-content {
                        position: relative;
                        z-index: 1;
                        max-width: 1280px;
                        margin: 0 auto;
                        padding: 0 30px;
                        text-align: center;
                        color: white;
                    }

                    .hero-badge {
                        display: inline-flex;
                        align-items: center;
                        gap: 8px;
                        padding: 8px 20px;
                        background: rgba(255, 255, 255, .1);
                        backdrop-filter: blur(10px);
                        border: 1px solid rgba(255, 255, 255, .12);
                        border-radius: 999px;
                        font-size: .82rem;
                        font-weight: 600;
                        margin-bottom: 20px;
                    }

                    .hero h1 {
                        font-size: 3.2rem;
                        font-weight: 800;
                        margin-bottom: 20px;
                        letter-spacing: -1px;
                    }

                    .hero h1 .highlight {
                        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                    }

                    .hero p {
                        font-size: 1.1rem;
                        opacity: .8;
                        max-width: 600px;
                        margin: 0 auto 40px;
                    }

                    /* ═══ STATS BAR ═══ */
                    .stats-bar {
                        position: relative;
                        z-index: 10;
                        max-width: 1280px;
                        margin: -50px auto 60px;
                        padding: 0 30px;
                    }

                    .stats-grid {
                        display: grid;
                        grid-template-columns: repeat(4, 1fr);
                        gap: 20px;
                        background: white;
                        border-radius: 20px;
                        padding: 30px;
                        box-shadow: 0 10px 40px rgba(27, 31, 59, .08);
                    }

                    .stat-item {
                        text-align: center;
                        padding: 20px;
                        border-right: 1px solid #E8EAF0;
                    }

                    .stat-item:last-child {
                        border-right: none;
                    }

                    .stat-icon {
                        width: 56px;
                        height: 56px;
                        margin: 0 auto 15px;
                        border-radius: 16px;
                        background: linear-gradient(135deg, rgba(255, 111, 97, .1), rgba(255, 154, 139, .05));
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.5rem;
                        color: #FF6F61;
                    }

                    .stat-value {
                        font-size: 2rem;
                        font-weight: 800;
                        color: #1B1F3B;
                        margin-bottom: 5px;
                    }

                    .stat-label {
                        font-size: .85rem;
                        color: #6B7194;
                        font-weight: 500;
                    }

                    /* ═══ FILTER SECTION ═══ */
                    .filter-section {
                        max-width: 1280px;
                        margin: 0 auto 40px;
                        padding: 0 30px;
                    }

                    .filter-bar {
                        background: white;
                        border-radius: 16px;
                        padding: 25px;
                        box-shadow: 0 4px 20px rgba(27, 31, 59, .05);
                        display: flex;
                        gap: 15px;
                        flex-wrap: wrap;
                        align-items: center;
                    }

                    .search-box {
                        flex: 1;
                        min-width: 300px;
                        position: relative;
                    }

                    .search-box input {
                        width: 100%;
                        padding: 14px 20px 14px 50px;
                        border: 2px solid #E8EAF0;
                        border-radius: 12px;
                        font-size: .95rem;
                        font-family: inherit;
                        transition: .3s;
                    }

                    .search-box input:focus {
                        outline: none;
                        border-color: #FF6F61;
                    }

                    .search-box i {
                        position: absolute;
                        left: 18px;
                        top: 50%;
                        transform: translateY(-50%);
                        color: #A0A5C3;
                        font-size: 1.1rem;
                    }

                    .filter-select {
                        padding: 14px 20px;
                        border: 2px solid #E8EAF0;
                        border-radius: 12px;
                        font-size: .9rem;
                        font-family: inherit;
                        font-weight: 600;
                        color: #1B1F3B;
                        cursor: pointer;
                        transition: .3s;
                        background: white;
                    }

                    .filter-select:hover {
                        border-color: #FF6F61;
                    }

                    /* ═══ PROVIDERS GRID ═══ */
                    .providers-section {
                        max-width: 1280px;
                        margin: 0 auto 80px;
                        padding: 0 30px;
                    }

                    .section-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 30px;
                    }

                    .section-header h2 {
                        font-size: 1.8rem;
                        font-weight: 800;
                        color: #1B1F3B;
                    }

                    .view-toggle {
                        display: flex;
                        gap: 8px;
                        background: #F7F8FC;
                        padding: 6px;
                        border-radius: 12px;
                    }

                    .view-btn {
                        padding: 10px 16px;
                        border: none;
                        background: transparent;
                        border-radius: 8px;
                        cursor: pointer;
                        color: #6B7194;
                        font-size: .9rem;
                        transition: .3s;
                    }

                    .view-btn.active {
                        background: white;
                        color: #FF6F61;
                        box-shadow: 0 2px 8px rgba(0, 0, 0, .06);
                    }

                    .providers-grid {
                        display: grid;
                        grid-template-columns: repeat(3, 1fr);
                        gap: 28px;
                    }

                    /* ═══ PROVIDER CARD ═══ */
                    .provider-card {
                        background: white;
                        border-radius: 20px;
                        overflow: hidden;
                        border: 1px solid #E8EAF0;
                        box-shadow: 0 4px 20px rgba(27, 31, 59, .05);
                        transition: .4s;
                        cursor: pointer;
                    }

                    .provider-card:hover {
                        transform: translateY(-8px);
                        box-shadow: 0 20px 50px rgba(27, 31, 59, .12);
                    }

                    .provider-header {
                        position: relative;
                        height: 180px;
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
                        opacity: .3;
                    }

                    .provider-logo {
                        position: relative;
                        z-index: 1;
                        width: 80px;
                        height: 80px;
                        background: white;
                        border-radius: 16px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 2rem;
                        box-shadow: 0 8px 24px rgba(0, 0, 0, .15);
                    }

                    .provider-body {
                        padding: 24px;
                    }

                    .provider-name {
                        font-size: 1.2rem;
                        font-weight: 700;
                        color: #1B1F3B;
                        margin-bottom: 8px;
                        display: flex;
                        align-items: center;
                        gap: 8px;
                    }

                    .verified-badge {
                        color: #06D6A0;
                        font-size: 1.1rem;
                    }

                    .provider-type {
                        display: inline-block;
                        padding: 5px 12px;
                        background: rgba(255, 111, 97, .1);
                        color: #FF6F61;
                        border-radius: 6px;
                        font-size: .75rem;
                        font-weight: 700;
                        text-transform: uppercase;
                        letter-spacing: .5px;
                        margin-bottom: 15px;
                    }

                    .provider-meta {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 12px;
                        margin-bottom: 20px;
                    }

                    .meta-item {
                        display: flex;
                        align-items: center;
                        gap: 8px;
                        font-size: .85rem;
                        color: #6B7194;
                    }

                    .meta-item i {
                        color: #FF6F61;
                        font-size: .9rem;
                    }

                    .rating-stars {
                        color: #FFB703;
                        font-size: .9rem;
                    }

                    .provider-stats {
                        display: flex;
                        justify-content: space-between;
                        padding-top: 20px;
                        border-top: 1px solid #E8EAF0;
                    }

                    .stat-box {
                        text-align: center;
                    }

                    .stat-box .value {
                        font-size: 1.3rem;
                        font-weight: 800;
                        color: #1B1F3B;
                    }

                    .stat-box .label {
                        font-size: .75rem;
                        color: #A0A5C3;
                        margin-top: 2px;
                    }

                    .provider-actions {
                        display: flex;
                        gap: 10px;
                        margin-top: 20px;
                    }

                    .btn {
                        flex: 1;
                        padding: 12px;
                        border: none;
                        border-radius: 10px;
                        font-weight: 700;
                        font-size: .85rem;
                        cursor: pointer;
                        transition: .3s;
                        font-family: inherit;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        gap: 6px;
                    }

                    .btn-primary {
                        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
                        color: white;
                        box-shadow: 0 4px 12px rgba(255, 111, 97, .25);
                    }

                    .btn-primary:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 8px 20px rgba(255, 111, 97, .35);
                    }

                    .btn-outline {
                        background: transparent;
                        border: 2px solid #E8EAF0;
                        color: #1B1F3B;
                    }

                    .btn-outline:hover {
                        border-color: #FF6F61;
                        color: #FF6F61;
                    }

                    /* ═══ EMPTY STATE ═══ */
                    .empty-state {
                        text-align: center;
                        padding: 80px 30px;
                        background: white;
                        border-radius: 20px;
                        box-shadow: 0 4px 20px rgba(27, 31, 59, .05);
                    }

                    .empty-state i {
                        font-size: 5rem;
                        color: #E8EAF0;
                        margin-bottom: 20px;
                    }

                    .empty-state h3 {
                        font-size: 1.5rem;
                        color: #1B1F3B;
                        margin-bottom: 10px;
                    }

                    .empty-state p {
                        color: #6B7194;
                        max-width: 400px;
                        margin: 0 auto;
                    }

                    /* ═══ RESPONSIVE ═══ */
                    @media (max-width: 1024px) {
                        .providers-grid {
                            grid-template-columns: repeat(2, 1fr);
                        }

                        .stats-grid {
                            grid-template-columns: repeat(2, 1fr);
                        }
                    }

                    @media (max-width: 768px) {
                        .hero h1 {
                            font-size: 2rem;
                        }

                        .providers-grid {
                            grid-template-columns: 1fr;
                        }

                        .stats-grid {
                            grid-template-columns: 1fr;
                        }

                        .stat-item {
                            border-right: none;
                            border-bottom: 1px solid #E8EAF0;
                        }

                        .stat-item:last-child {
                            border-bottom: none;
                        }

                        .filter-bar {
                            flex-direction: column;
                        }

                        .search-box {
                            width: 100%;
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
                            <i class="fas fa-shield-alt"></i>
                            <span>Đối Tác Được Xác Minh</span>
                        </div>
                        <h1>
                            <i class="fas fa-building"></i> Nhà Cung Cấp <span class="highlight">Uy Tín</span>
                        </h1>
                        <p>Khám phá các đối tác du lịch hàng đầu tại Đà Nẵng. Tours xác minh bởi đối tác uy tín, đảm bảo
                            chất lượng dịch vụ tốt nhất.</p>
                    </div>
                </section>

                <!-- Stats Bar -->
                <section class="stats-bar">
                    <div class="stats-grid">
                        <div class="stat-item">
                            <div class="stat-icon">
                                <i class="fas fa-building"></i>
                            </div>
                            <div class="stat-value">0</div>
                            <div class="stat-label">Nhà Cung Cấp</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-icon">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <div class="stat-value">0</div>
                            <div class="stat-label">Đã Xác Minh</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-icon">
                                <i class="fas fa-star"></i>
                            </div>
                            <div class="stat-value">4.7</div>
                            <div class="stat-label">Đánh Giá TB</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-icon">
                                <i class="fas fa-route"></i>
                            </div>
                            <div class="stat-value">100%</div>
                            <div class="stat-label">Đã Xác Minh</div>
                        </div>
                    </div>
                </section>

                <!-- Filter Section -->
                <section class="filter-section">
                    <div class="filter-bar">
                        <div class="search-box">
                            <i class="fas fa-search"></i>
                            <input type="text" placeholder="Tìm kiếm nhà cung cấp...">
                        </div>
                        <select class="filter-select">
                            <option>Tất cả loại hình</option>
                            <option>Khách sạn</option>
                            <option>Tour Operator</option>
                            <option>Vận chuyển</option>
                        </select>
                        <select class="filter-select">
                            <option>Đánh giá</option>
                            <option>5 sao</option>
                            <option>4 sao trở lên</option>
                            <option>3 sao trở lên</option>
                        </select>
                        <select class="filter-select">
                            <option>Sắp xếp</option>
                            <option>Đánh giá cao nhất</option>
                            <option>Nhiều tour nhất</option>
                            <option>Mới nhất</option>
                        </select>
                    </div>
                </section>

                <!-- Providers Section -->
                <section class="providers-section">
                    <div class="section-header">
                        <h2><i class="fas fa-th-large"></i> Danh Sách Nhà Cung Cấp</h2>
                        <div class="view-toggle">
                            <button class="view-btn active"><i class="fas fa-th"></i> Lưới</button>
                            <button class="view-btn"><i class="fas fa-list"></i> Danh sách</button>
                        </div>
                    </div>

                    <c:choose>
                        <c:when test="${not empty providers}">
                            <div class="providers-grid">
                                <c:forEach items="${providers}" var="provider">
                                    <div class="provider-card"
                                        onclick="window.location.href='${pageContext.request.contextPath}/providers/${provider.providerId}'">
                                        <div class="provider-header">
                                            <div class="provider-logo">
                                                <i class="fas fa-hotel"></i>
                                            </div>
                                        </div>
                                        <div class="provider-body">
                                            <div class="provider-name">
                                                ${provider.businessName}
                                                <c:if test="${provider.isVerified}">
                                                    <i class="fas fa-check-circle verified-badge"></i>
                                                </c:if>
                                            </div>
                                            <span class="provider-type">
                                                <c:choose>
                                                    <c:when test="${provider.providerType == 'Hotel'}">Khách sạn
                                                    </c:when>
                                                    <c:when test="${provider.providerType == 'TourOperator'}">Tour
                                                        Operator</c:when>
                                                    <c:otherwise>Vận chuyển</c:otherwise>
                                                </c:choose>
                                            </span>

                                            <div class="provider-meta">
                                                <div class="meta-item">
                                                    <i class="fas fa-star"></i>
                                                    <span class="rating-stars">
                                                        <fmt:formatNumber value="${provider.rating}"
                                                            maxFractionDigits="1" />
                                                    </span>
                                                </div>
                                                <div class="meta-item">
                                                    <i class="fas fa-route"></i>
                                                    <span>${provider.totalTours} tours</span>
                                                </div>
                                                <div class="meta-item">
                                                    <i class="fas fa-certificate"></i>
                                                    <span>Giấy phép</span>
                                                </div>
                                                <div class="meta-item">
                                                    <i class="fas fa-map-marker-alt"></i>
                                                    <span>Đà Nẵng</span>
                                                </div>
                                            </div>

                                            <div class="provider-stats">
                                                <div class="stat-box">
                                                    <div class="value">${provider.totalTours}</div>
                                                    <div class="label">Tours</div>
                                                </div>
                                                <div class="stat-box">
                                                    <div class="value">
                                                        <fmt:formatNumber value="${provider.rating}"
                                                            maxFractionDigits="1" />
                                                    </div>
                                                    <div class="label">Đánh giá</div>
                                                </div>
                                                <div class="stat-box">
                                                    <div class="value">
                                                        <c:choose>
                                                            <c:when test="${provider.isVerified}">
                                                                <i class="fas fa-check" style="color: #06D6A0;"></i>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="fas fa-times" style="color: #FA5252;"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="label">Xác minh</div>
                                                </div>
                                            </div>

                                            <div class="provider-actions">
                                                <button class="btn btn-primary">
                                                    <i class="fas fa-eye"></i> Xem chi tiết
                                                </button>
                                                <button class="btn btn-outline">
                                                    <i class="fas fa-chart-line"></i> Lịch sử
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-building"></i>
                                <h3>Chưa có nhà cung cấp nào</h3>
                                <p>Hiện tại chưa có nhà cung cấp nào trong hệ thống. Vui lòng quay lại sau.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </section>

                <!-- Include Footer -->
                <jsp:include page="/common/_footer.jsp" />
            </body>

            </html>