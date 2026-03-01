<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>So Sánh Nhà Cung Cấp | Da Nang Travel Hub</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <style>
                    :root {
                        --primary-color: #FF7F5C;
                        --secondary-color: #2C3E50;
                        --light-bg: #F8F9FA;
                        --card-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                        --success-color: #28a745;
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

                    .selection-card {
                        background: white;
                        border-radius: 15px;
                        padding: 30px;
                        box-shadow: var(--card-shadow);
                        margin-bottom: 30px;
                    }

                    .provider-select-item {
                        background: white;
                        border: 2px solid #dee2e6;
                        border-radius: 10px;
                        padding: 15px;
                        margin-bottom: 15px;
                        cursor: pointer;
                        transition: all 0.3s;
                        display: flex;
                        align-items: center;
                        gap: 15px;
                    }

                    .provider-select-item:hover {
                        border-color: var(--primary-color);
                        transform: translateX(5px);
                        box-shadow: 0 4px 10px rgba(255, 127, 92, 0.2);
                    }

                    .provider-select-item.selected {
                        border-color: var(--primary-color);
                        background: rgba(255, 127, 92, 0.05);
                    }

                    .provider-select-item input[type="checkbox"] {
                        width: 20px;
                        height: 20px;
                        cursor: pointer;
                    }

                    .provider-select-info {
                        flex: 1;
                    }

                    .provider-select-name {
                        font-weight: 700;
                        color: var(--secondary-color);
                        margin-bottom: 5px;
                    }

                    .provider-select-meta {
                        font-size: 0.9rem;
                        color: #6c757d;
                    }

                    .btn-compare {
                        background: var(--primary-color);
                        color: white;
                        border: none;
                        padding: 15px 40px;
                        border-radius: 25px;
                        font-weight: 700;
                        font-size: 1.1rem;
                        transition: all 0.3s;
                        width: 100%;
                    }

                    .btn-compare:hover:not(:disabled) {
                        background: #ff6a47;
                        transform: scale(1.05);
                        box-shadow: 0 6px 20px rgba(255, 127, 92, 0.4);
                    }

                    .btn-compare:disabled {
                        background: #dee2e6;
                        cursor: not-allowed;
                    }

                    .comparison-table {
                        background: white;
                        border-radius: 15px;
                        overflow: hidden;
                        box-shadow: var(--card-shadow);
                        margin-bottom: 30px;
                    }

                    .comparison-table table {
                        margin: 0;
                    }

                    .comparison-table thead {
                        background: linear-gradient(135deg, var(--secondary-color) 0%, #34495e 100%);
                        color: white;
                    }

                    .comparison-table thead th {
                        padding: 20px;
                        font-weight: 700;
                        border: none;
                        text-align: center;
                    }

                    .comparison-table tbody tr:nth-child(even) {
                        background: #f8f9fa;
                    }

                    .comparison-table tbody td {
                        padding: 20px;
                        vertical-align: middle;
                        text-align: center;
                        border: 1px solid #dee2e6;
                    }

                    .comparison-table tbody td:first-child {
                        font-weight: 700;
                        color: var(--secondary-color);
                        background: white;
                        text-align: left;
                        position: sticky;
                        left: 0;
                        z-index: 1;
                    }

                    .provider-header {
                        text-align: center;
                        padding: 10px;
                    }

                    .provider-header-name {
                        font-size: 1.2rem;
                        font-weight: 700;
                        color: white;
                        margin-bottom: 5px;
                    }

                    .provider-header-type {
                        font-size: 0.9rem;
                        opacity: 0.9;
                    }

                    .rating-stars {
                        color: #FFD700;
                        font-size: 1.2rem;
                    }

                    .price-value {
                        font-size: 1.3rem;
                        font-weight: 700;
                        color: var(--primary-color);
                    }

                    .best-badge {
                        display: inline-block;
                        background: var(--success-color);
                        color: white;
                        padding: 5px 15px;
                        border-radius: 20px;
                        font-size: 0.85rem;
                        font-weight: 600;
                        margin-left: 10px;
                    }

                    .verified-icon {
                        color: var(--success-color);
                        font-size: 1.5rem;
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

                    .alert-info-custom {
                        background: rgba(255, 127, 92, 0.1);
                        border-left: 4px solid var(--primary-color);
                        padding: 20px;
                        border-radius: 10px;
                        margin-bottom: 30px;
                    }

                    @media (max-width: 768px) {
                        .comparison-table {
                            overflow-x: auto;
                        }

                        .comparison-table table {
                            min-width: 600px;
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
                        <h1><i class="fas fa-balance-scale"></i> So Sánh Nhà Cung Cấp</h1>
                        <p>Chọn 2-3 nhà cung cấp để so sánh giá và chất lượng dịch vụ</p>
                    </div>
                </div>

                <div class="container mb-5">

                    <c:choose>
                        <c:when test="${empty compareProviders}">
                            <!-- Provider Selection Form -->
                            <div class="selection-card">
                                <h3 class="mb-4" style="color: var(--secondary-color); font-weight: 700;">
                                    <i class="fas fa-check-square"></i> Chọn nhà cung cấp để so sánh
                                </h3>

                                <div class="alert-info-custom">
                                    <i class="fas fa-info-circle"></i>
                                    <strong>Hướng dẫn:</strong> Vui lòng chọn từ 2 đến 3 nhà cung cấp để so sánh.
                                </div>

                                <form action="${pageContext.request.contextPath}/providers" method="get"
                                    id="compareForm">
                                    <input type="hidden" name="action" value="compare">

                                    <c:forEach items="${allProviders}" var="provider">
                                        <label class="provider-select-item">
                                            <input type="checkbox" name="providerIds" value="${provider.providerId}"
                                                class="provider-checkbox">
                                            <div class="provider-select-info">
                                                <div class="provider-select-name">
                                                    ${provider.businessName}
                                                    <c:if test="${provider.isVerified}">
                                                        <i class="fas fa-check-circle"
                                                            style="color: var(--success-color);"></i>
                                                    </c:if>
                                                </div>
                                                <div class="provider-select-meta">
                                                    <i class="fas fa-star" style="color: #FFD700;"></i>
                                                    <c:choose>
                                                        <c:when test="${not empty provider.rating}">
                                                            <fmt:formatNumber value="${provider.rating}"
                                                                maxFractionDigits="1" />
                                                        </c:when>
                                                        <c:otherwise>0.0</c:otherwise>
                                                    </c:choose>
                                                    •
                                                    <c:choose>
                                                        <c:when test="${provider.providerType == 'Hotel'}">Khách sạn
                                                        </c:when>
                                                        <c:when test="${provider.providerType == 'TourOperator'}">Tour
                                                        </c:when>
                                                        <c:otherwise>Vận chuyển</c:otherwise>
                                                    </c:choose>
                                                    • ${provider.totalTours} tours
                                                </div>
                                            </div>
                                        </label>
                                    </c:forEach>

                                    <button type="submit" class="btn-compare mt-4" id="compareBtn" disabled>
                                        <i class="fas fa-balance-scale"></i> So sánh (<span
                                            id="selectedCount">0</span>/3)
                                    </button>
                                </form>
                            </div>
                        </c:when>

                        <c:otherwise>
                            <!-- Comparison Table -->
                            <div class="comparison-table">
                                <table class="table table-bordered mb-0">
                                    <thead>
                                        <tr>
                                            <th style="text-align: left;">Tiêu chí</th>
                                            <c:forEach items="${compareProviders}" var="provider">
                                                <th>
                                                    <div class="provider-header">
                                                        <div class="provider-header-name">${provider.businessName}</div>
                                                        <div class="provider-header-type">
                                                            <c:choose>
                                                                <c:when test="${provider.providerType == 'Hotel'}">
                                                                    <i class="fas fa-hotel"></i> Khách sạn
                                                                </c:when>
                                                                <c:when
                                                                    test="${provider.providerType == 'TourOperator'}">
                                                                    <i class="fas fa-map-marked-alt"></i> Tour
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="fas fa-car"></i> Vận chuyển
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                </th>
                                            </c:forEach>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Rating Row -->
                                        <tr>
                                            <td><i class="fas fa-star" style="color: #FFD700;"></i> Đánh giá</td>
                                            <c:forEach items="${compareProviders}" var="provider">
                                                <td>
                                                    <div class="rating-stars">
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <c:choose>
                                                                <c:when
                                                                    test="${not empty provider.rating && i <= provider.rating}">
                                                                    <i class="fas fa-star"></i>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="far fa-star"></i>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </div>
                                                    <div style="margin-top: 5px; font-weight: 700;">
                                                        <fmt:formatNumber value="${provider.rating}"
                                                            maxFractionDigits="1" />/5
                                                    </div>
                                                </td>
                                            </c:forEach>
                                        </tr>

                                        <!-- Verified Row -->
                                        <tr>
                                            <td><i class="fas fa-check-circle"></i> Xác minh</td>
                                            <c:forEach items="${compareProviders}" var="provider">
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${provider.isVerified}">
                                                            <i class="fas fa-check-circle verified-icon"></i>
                                                            <div style="margin-top: 5px; color: var(--success-color);">
                                                                Đã
                                                                xác minh</div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fas fa-times-circle"
                                                                style="color: #dc3545; font-size: 1.5rem;"></i>
                                                            <div style="margin-top: 5px; color: #6c757d;">Chưa xác minh
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </c:forEach>
                                        </tr>

                                        <!-- Total Tours Row -->
                                        <tr>
                                            <td><i class="fas fa-route"></i> Tổng số tours</td>
                                            <c:forEach items="${compareProviders}" var="provider">
                                                <td>
                                                    <div
                                                        style="font-size: 1.5rem; font-weight: 700; color: var(--secondary-color);">
                                                        ${provider.totalTours}
                                                    </div>
                                                    <div style="font-size: 0.9rem; color: #6c757d;">tours</div>
                                                </td>
                                            </c:forEach>
                                        </tr>

                                        <!-- Business License Row -->
                                        <tr>
                                            <td><i class="fas fa-certificate"></i> Giấy phép</td>
                                            <c:forEach items="${compareProviders}" var="provider">
                                                <td style="font-weight: 600;">${provider.businessLicense}</td>
                                            </c:forEach>
                                        </tr>

                                        <!-- Average Price Row -->
                                        <tr>
                                            <td><i class="fas fa-dollar-sign"></i> Giá trung bình</td>
                                            <c:set var="minPrice" value="${999999999}" />
                                            <c:forEach items="${compareProviders}" var="provider">
                                                <c:if test="${provider.averagePrice < minPrice}">
                                                    <c:set var="minPrice" value="${provider.averagePrice}" />
                                                </c:if>
                                            </c:forEach>
                                            <c:forEach items="${compareProviders}" var="provider">
                                                <td>
                                                    <div class="price-value">
                                                        <fmt:formatNumber value="${provider.averagePrice}" type="number"
                                                            groupingUsed="true" />đ
                                                    </div>
                                                    <c:if test="${provider.averagePrice == minPrice}">
                                                        <span class="best-badge">
                                                            <i class="fas fa-trophy"></i> Tốt nhất
                                                        </span>
                                                    </c:if>
                                                </td>
                                            </c:forEach>
                                        </tr>

                                        <!-- Contact Row -->
                                        <tr>
                                            <td><i class="fas fa-phone"></i> Liên hệ</td>
                                            <c:forEach items="${compareProviders}" var="provider">
                                                <td>
                                                    <div style="margin-bottom: 10px;">
                                                        <i class="fas fa-envelope"
                                                            style="color: var(--primary-color);"></i>
                                                        ${provider.email}
                                                    </div>
                                                    <div>
                                                        <i class="fas fa-phone"
                                                            style="color: var(--primary-color);"></i>
                                                        ${provider.phone}
                                                    </div>
                                                </td>
                                            </c:forEach>
                                        </tr>

                                        <!-- Action Row -->
                                        <tr>
                                            <td><i class="fas fa-eye"></i> Chi tiết</td>
                                            <c:forEach items="${compareProviders}" var="provider">
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/providers?action=history&id=${provider.providerId}"
                                                        class="btn btn-sm"
                                                        style="background: var(--primary-color); color: white; border-radius: 20px; padding: 8px 20px; text-decoration: none;">
                                                        <i class="fas fa-history"></i> Xem lịch sử
                                                    </a>
                                                </td>
                                            </c:forEach>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Compare Again Button -->
                            <div class="text-center mt-4">
                                <a href="${pageContext.request.contextPath}/providers?action=compare"
                                    class="btn-compare" style="width: auto; display: inline-block;">
                                    <i class="fas fa-redo"></i> So sánh lại
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <!-- Back Button -->
                    <div class="text-center mt-4">
                        <a href="${pageContext.request.contextPath}/providers" class="btn-back">
                            <i class="fas fa-arrow-left"></i> Quay lại danh sách
                        </a>
                    </div>

                </div>

                <!-- Include Footer -->
                <jsp:include page="/common/_footer.jsp" />

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    // Handle provider selection
                    document.addEventListener('DOMContentLoaded', function () {
                        const checkboxes = document.querySelectorAll('.provider-checkbox');
                        const compareBtn = document.getElementById('compareBtn');
                        const selectedCount = document.getElementById('selectedCount');

                        function updateSelection() {
                            const checked = document.querySelectorAll('.provider-checkbox:checked');
                            const count = checked.length;

                            selectedCount.textContent = count;

                            // Enable button only if 2-3 providers selected
                            compareBtn.disabled = count < 2 || count > 3;

                            // Update visual state
                            checkboxes.forEach(cb => {
                                const item = cb.closest('.provider-select-item');
                                if (cb.checked) {
                                    item.classList.add('selected');
                                } else {
                                    item.classList.remove('selected');
                                }

                                // Disable unchecked items if 3 are already selected
                                if (count >= 3 && !cb.checked) {
                                    cb.disabled = true;
                                    item.style.opacity = '0.5';
                                } else {
                                    cb.disabled = false;
                                    item.style.opacity = '1';
                                }
                            });
                        }

                        checkboxes.forEach(cb => {
                            cb.addEventListener('change', updateSelection);
                        });

                        updateSelection();
                    });
                </script>
            </body>

            </html>