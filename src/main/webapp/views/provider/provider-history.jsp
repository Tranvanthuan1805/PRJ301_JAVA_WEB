<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Lịch Sử Giá - ${provider.businessName} | Da Nang Travel Hub</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <style>
                    :root {
                        --primary-color: #FF7F5C;
                        --secondary-color: #2C3E50;
                        --light-bg: #F8F9FA;
                        --card-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                        --success-color: #28a745;
                        --danger-color: #dc3545;
                    }

                    body {
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                        background-color: var(--light-bg);
                    }

                    .page-header {
                        background: linear-gradient(135deg, var(--secondary-color) 0%, #34495e 100%);
                        color: white;
                        padding: 60px 0 40px;
                        margin-bottom: 40px;
                        border-radius: 0 0 30px 30px;
                        box-shadow: var(--card-shadow);
                    }

                    .provider-info-card {
                        background: white;
                        border-radius: 15px;
                        padding: 30px;
                        box-shadow: var(--card-shadow);
                        margin-bottom: 30px;
                    }

                    .provider-name {
                        font-size: 2rem;
                        font-weight: 700;
                        color: var(--secondary-color);
                        margin-bottom: 15px;
                    }

                    .provider-meta {
                        display: flex;
                        gap: 30px;
                        flex-wrap: wrap;
                        margin-top: 20px;
                    }

                    .meta-item {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                    }

                    .meta-item i {
                        color: var(--primary-color);
                        font-size: 1.2rem;
                    }

                    .rating-stars {
                        color: #FFD700;
                        font-size: 1.3rem;
                    }

                    .history-timeline {
                        position: relative;
                        padding-left: 40px;
                    }

                    .history-timeline::before {
                        content: '';
                        position: absolute;
                        left: 15px;
                        top: 0;
                        bottom: 0;
                        width: 3px;
                        background: linear-gradient(to bottom, var(--primary-color), #dee2e6);
                    }

                    .history-item {
                        background: white;
                        border-radius: 15px;
                        padding: 25px;
                        margin-bottom: 25px;
                        box-shadow: var(--card-shadow);
                        position: relative;
                        transition: all 0.3s;
                    }

                    .history-item:hover {
                        transform: translateX(5px);
                        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
                    }

                    .history-item::before {
                        content: '';
                        position: absolute;
                        left: -33px;
                        top: 30px;
                        width: 15px;
                        height: 15px;
                        background: var(--primary-color);
                        border: 3px solid white;
                        border-radius: 50%;
                        box-shadow: 0 0 0 3px var(--primary-color);
                    }

                    .service-name {
                        font-size: 1.3rem;
                        font-weight: 700;
                        color: var(--secondary-color);
                        margin-bottom: 10px;
                    }

                    .service-type-badge {
                        display: inline-block;
                        background: var(--primary-color);
                        color: white;
                        padding: 5px 15px;
                        border-radius: 20px;
                        font-size: 0.85rem;
                        font-weight: 600;
                        margin-left: 10px;
                    }

                    .price-comparison {
                        display: flex;
                        align-items: center;
                        gap: 20px;
                        margin: 20px 0;
                        flex-wrap: wrap;
                    }

                    .price-box {
                        flex: 1;
                        min-width: 150px;
                        padding: 15px;
                        border-radius: 10px;
                        text-align: center;
                    }

                    .price-box.old {
                        background: #f8f9fa;
                        border: 2px dashed #dee2e6;
                    }

                    .price-box.new {
                        background: linear-gradient(135deg, var(--primary-color), #ff9a7f);
                        color: white;
                    }

                    .price-label {
                        font-size: 0.85rem;
                        opacity: 0.8;
                        margin-bottom: 5px;
                    }

                    .price-value {
                        font-size: 1.5rem;
                        font-weight: 700;
                    }

                    .price-arrow {
                        font-size: 2rem;
                        color: var(--primary-color);
                    }

                    .price-change {
                        display: inline-block;
                        padding: 8px 15px;
                        border-radius: 20px;
                        font-weight: 700;
                        font-size: 1.1rem;
                    }

                    .price-change.increase {
                        background: rgba(220, 53, 69, 0.1);
                        color: var(--danger-color);
                    }

                    .price-change.decrease {
                        background: rgba(40, 167, 69, 0.1);
                        color: var(--success-color);
                    }

                    .change-date {
                        color: #6c757d;
                        font-size: 0.9rem;
                        margin-top: 10px;
                    }

                    .change-note {
                        background: #f8f9fa;
                        padding: 15px;
                        border-left: 4px solid var(--primary-color);
                        border-radius: 5px;
                        margin-top: 15px;
                        font-style: italic;
                        color: #495057;
                    }

                    .btn-back {
                        background: var(--secondary-color);
                        color: white;
                        border: none;
                        padding: 12px 30px;
                        border-radius: 25px;
                        font-weight: 600;
                        transition: all 0.3s;
                        text-decoration: none;
                        display: inline-block;
                    }

                    .btn-back:hover {
                        background: #1a252f;
                        transform: translateY(-2px);
                        box-shadow: 0 4px 15px rgba(44, 62, 80, 0.3);
                        color: white;
                    }

                    .empty-state {
                        text-align: center;
                        padding: 60px 20px;
                        background: white;
                        border-radius: 15px;
                        box-shadow: var(--card-shadow);
                    }

                    .empty-state i {
                        font-size: 5rem;
                        color: #dee2e6;
                        margin-bottom: 20px;
                    }

                    @media (max-width: 768px) {
                        .provider-meta {
                            flex-direction: column;
                            gap: 15px;
                        }

                        .price-comparison {
                            flex-direction: column;
                        }

                        .price-arrow {
                            transform: rotate(90deg);
                        }

                        .history-timeline {
                            padding-left: 30px;
                        }
                    }
                </style>
            </head>

            <body>

                <!-- Include Header -->
                <jsp:include page="/common/_header.jsp" />

                <!-- Page Header -->
                <div class="page-header">
                    <div class="container">
                        <h1><i class="fas fa-history"></i> Lịch Sử Biến Động Giá</h1>
                        <p>Theo dõi thay đổi giá dịch vụ của nhà cung cấp</p>
                    </div>
                </div>

                <div class="container mb-5">

                    <c:if test="${not empty provider}">
                        <!-- Provider Info Card -->
                        <div class="provider-info-card">
                            <div class="provider-name">
                                ${provider.businessName}
                                <c:if test="${provider.isVerified}">
                                    <i class="fas fa-check-circle"
                                        style="color: var(--success-color); font-size: 1.5rem;"></i>
                                </c:if>
                            </div>

                            <div class="provider-meta">
                                <div class="meta-item">
                                    <i class="fas fa-star"></i>
                                    <div class="rating-stars">
                                        <c:forEach begin="1" end="5" var="i">
                                            <c:choose>
                                                <c:when test="${i <= provider.rating}">
                                                    <i class="fas fa-star"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="far fa-star"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <span style="color: var(--secondary-color); margin-left: 10px;">
                                            <fmt:formatNumber value="${provider.rating}" maxFractionDigits="1" />
                                        </span>
                                    </div>
                                </div>

                                <div class="meta-item">
                                    <i class="fas fa-certificate"></i>
                                    <span>${provider.businessLicense}</span>
                                </div>

                                <div class="meta-item">
                                    <i class="fas fa-route"></i>
                                    <span>${provider.totalTours} tours</span>
                                </div>

                                <div class="meta-item">
                                    <i class="fas fa-tag"></i>
                                    <span>
                                        <c:choose>
                                            <c:when test="${provider.providerType == 'Hotel'}">Khách sạn</c:when>
                                            <c:when test="${provider.providerType == 'TourOperator'}">Tour</c:when>
                                            <c:otherwise>Vận chuyển</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <!-- Price History Timeline -->
                        <h3 class="mb-4" style="color: var(--secondary-color); font-weight: 700;">
                            <i class="fas fa-chart-line"></i> Lịch Sử Thay Đổi Giá
                        </h3>

                        <c:choose>
                            <c:when test="${not empty priceHistory}">
                                <div class="history-timeline">
                                    <c:forEach items="${priceHistory}" var="history">
                                        <div class="history-item">
                                            <div class="service-name">
                                                ${history.serviceName}
                                                <span class="service-type-badge">${history.serviceType}</span>
                                            </div>

                                            <div class="price-comparison">
                                                <div class="price-box old">
                                                    <div class="price-label">Giá cũ</div>
                                                    <div class="price-value">
                                                        <fmt:formatNumber value="${history.oldPrice}" type="number"
                                                            groupingUsed="true" />đ
                                                    </div>
                                                </div>

                                                <div class="price-arrow">
                                                    <i class="fas fa-arrow-right"></i>
                                                </div>

                                                <div class="price-box new">
                                                    <div class="price-label">Giá mới</div>
                                                    <div class="price-value">
                                                        <fmt:formatNumber value="${history.newPrice}" type="number"
                                                            groupingUsed="true" />đ
                                                    </div>
                                                </div>

                                                <div>
                                                    <c:set var="changePercent" value="${history.priceChangePercent}" />
                                                    <c:choose>
                                                        <c:when test="${changePercent > 0}">
                                                            <div class="price-change increase">
                                                                <i class="fas fa-arrow-up"></i> +
                                                                <fmt:formatNumber value="${changePercent}"
                                                                    maxFractionDigits="1" />%
                                                            </div>
                                                        </c:when>
                                                        <c:when test="${changePercent < 0}">
                                                            <div class="price-change decrease">
                                                                <i class="fas fa-arrow-down"></i>
                                                                <fmt:formatNumber value="${changePercent}"
                                                                    maxFractionDigits="1" />%
                                                            </div>
                                                        </c:when>
                                                    </c:choose>
                                                </div>
                                            </div>

                                            <div class="change-date">
                                                <i class="fas fa-calendar-alt"></i>
                                                <fmt:formatDate value="${history.changeDate}"
                                                    pattern="dd/MM/yyyy HH:mm" />
                                            </div>

                                            <c:if test="${not empty history.note}">
                                                <div class="change-note">
                                                    <i class="fas fa-info-circle"></i> ${history.note}
                                                </div>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <i class="fas fa-chart-line"></i>
                                    <h3>Chưa có lịch sử thay đổi giá</h3>
                                    <p>Nhà cung cấp này chưa có dữ liệu biến động giá</p>
                                </div>
                            </c:otherwise>
                        </c:choose>

                    </c:if>

                    <!-- Back Button -->
                    <div class="text-center mt-5">
                        <a href="${pageContext.request.contextPath}/providers" class="btn-back">
                            <i class="fas fa-arrow-left"></i> Quay lại danh sách
                        </a>
                    </div>

                </div>

                <!-- Include Footer -->
                <jsp:include page="/common/_footer.jsp" />

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>