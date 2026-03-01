<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Quản lý Nhà cung cấp | Da Nang Travel Hub</title>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
                <style>
                    .provider-stats {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                        gap: 20px;
                        margin-bottom: 30px;
                    }

                    .stat-card {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: white;
                        padding: 25px;
                        border-radius: 15px;
                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                    }

                    .stat-card h3 {
                        font-size: 2.5rem;
                        margin: 10px 0;
                    }

                    .filter-bar {
                        background: white;
                        padding: 20px;
                        border-radius: 10px;
                        margin-bottom: 20px;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
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
                        padding: 12px 45px 12px 15px;
                        border: 2px solid #e0e0e0;
                        border-radius: 8px;
                        font-size: 14px;
                    }

                    .search-box button {
                        position: absolute;
                        right: 5px;
                        top: 50%;
                        transform: translateY(-50%);
                        background: #667eea;
                        color: white;
                        border: none;
                        padding: 8px 15px;
                        border-radius: 6px;
                        cursor: pointer;
                    }

                    .filter-select {
                        padding: 12px 15px;
                        border: 2px solid #e0e0e0;
                        border-radius: 8px;
                        font-size: 14px;
                        cursor: pointer;
                    }

                    .provider-card {
                        background: white;
                        border-radius: 12px;
                        padding: 20px;
                        margin-bottom: 15px;
                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
                        transition: all 0.3s;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }

                    .provider-card:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
                    }

                    .provider-info {
                        flex: 1;
                    }

                    .provider-name {
                        font-size: 1.3rem;
                        font-weight: 700;
                        color: #2c3e50;
                        margin-bottom: 5px;
                    }

                    .provider-meta {
                        display: flex;
                        gap: 20px;
                        margin-top: 10px;
                        flex-wrap: wrap;
                    }

                    .meta-item {
                        display: flex;
                        align-items: center;
                        gap: 5px;
                        color: #7f8c8d;
                        font-size: 0.9rem;
                    }

                    .rating-stars {
                        color: #f39c12;
                        font-size: 1.1rem;
                    }

                    .badge {
                        padding: 6px 12px;
                        border-radius: 20px;
                        font-size: 0.85rem;
                        font-weight: 600;
                    }

                    .badge-verified {
                        background: #d4edda;
                        color: #155724;
                    }

                    .badge-pending {
                        background: #fff3cd;
                        color: #856404;
                    }

                    .badge-active {
                        background: #d1ecf1;
                        color: #0c5460;
                    }

                    .action-buttons {
                        display: flex;
                        gap: 10px;
                    }

                    .btn-icon {
                        width: 40px;
                        height: 40px;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        border: none;
                        cursor: pointer;
                        transition: all 0.3s;
                    }

                    .btn-view {
                        background: #e3f2fd;
                        color: #1976d2;
                    }

                    .btn-view:hover {
                        background: #1976d2;
                        color: white;
                    }

                    .btn-compare {
                        background: #f3e5f5;
                        color: #7b1fa2;
                    }

                    .btn-compare:hover {
                        background: #7b1fa2;
                        color: white;
                    }

                    .comparison-bar {
                        background: #fff3e0;
                        padding: 15px 20px;
                        border-radius: 10px;
                        margin-bottom: 20px;
                        display: none;
                        align-items: center;
                        justify-content: space-between;
                    }

                    .comparison-bar.active {
                        display: flex;
                    }
                </style>
            </head>

            <body>
                <div class="dashboard-wrapper">
                    <jsp:include page="/common/_sidebar.jsp" />

                    <main class="main-content">
                        <!-- Header -->
                        <header style="margin-bottom: 30px;">
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <div>
                                    <h1 style="color: #2c3e50; font-size: 2rem; margin-bottom: 5px;">
                                        <i class="fas fa-building"></i> Quản lý Nhà cung cấp
                                    </h1>
                                    <p style="color: #7f8c8d;">Quản lý đối tác khách sạn, vận chuyển và tour</p>
                                </div>
                                <div style="display: flex; gap: 10px;">
                                    <a href="${pageContext.request.contextPath}/admin/providers?action=comparison"
                                        class="btn"
                                        style="background: white; border: 2px solid #667eea; color: #667eea;">
                                        <i class="fas fa-balance-scale"></i> So sánh NCC
                                    </a>
                                    <button class="btn btn-primary">
                                        <i class="fas fa-plus"></i> Thêm NCC mới
                                    </button>
                                </div>
                            </div>
                        </header>

                        <!-- Statistics -->
                        <div class="provider-stats">
                            <div class="stat-card">
                                <i class="fas fa-building" style="font-size: 2rem; opacity: 0.8;"></i>
                                <h3>${totalProviders}</h3>
                                <p>Tổng số NCC</p>
                            </div>
                            <div class="stat-card"
                                style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
                                <i class="fas fa-star" style="font-size: 2rem; opacity: 0.8;"></i>
                                <h3>${topRated.size()}</h3>
                                <p>NCC uy tín</p>
                            </div>
                            <div class="stat-card"
                                style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
                                <i class="fas fa-check-circle" style="font-size: 2rem; opacity: 0.8;"></i>
                                <h3>
                                    <c:set var="verifiedCount" value="0" />
                                    <c:forEach items="${providers}" var="p">
                                        <c:if test="${p.verified}">
                                            <c:set var="verifiedCount" value="${verifiedCount + 1}" />
                                        </c:if>
                                    </c:forEach>
                                    ${verifiedCount}
                                </h3>
                                <p>Đã xác minh</p>
                            </div>
                        </div>

                        <!-- Filter Bar -->
                        <div class="filter-bar">
                            <div class="search-box">
                                <form action="${pageContext.request.contextPath}/admin/providers" method="get">
                                    <input type="hidden" name="action" value="search">
                                    <input type="text" name="keyword" placeholder="Tìm kiếm theo tên nhà cung cấp..."
                                        value="${searchKeyword}">
                                    <button type="submit"><i class="fas fa-search"></i></button>
                                </form>
                            </div>

                            <select class="filter-select" onchange="filterByType(this.value)">
                                <option value="">Tất cả loại hình</option>
                                <option value="Hotel" ${selectedType=='Hotel' ? 'selected' : '' }>Khách sạn</option>
                                <option value="TourOperator" ${selectedType=='TourOperator' ? 'selected' : '' }>Công ty
                                    Tour</option>
                                <option value="Transport" ${selectedType=='Transport' ? 'selected' : '' }>Vận chuyển
                                </option>
                            </select>
                        </div>

                        <!-- Comparison Bar -->
                        <div class="comparison-bar" id="comparisonBar">
                            <div>
                                <strong>Đã chọn: <span id="selectedCount">0</span> nhà cung cấp</strong>
                            </div>
                            <div style="display: flex; gap: 10px;">
                                <button onclick="clearSelection()" class="btn" style="background: #e0e0e0;">
                                    <i class="fas fa-times"></i> Hủy
                                </button>
                                <button onclick="compareSelected()" class="btn btn-primary">
                                    <i class="fas fa-balance-scale"></i> So sánh ngay
                                </button>
                            </div>
                        </div>

                        <!-- Provider List -->
                        <section class="card animate-up" style="padding: 0;">
                            <c:choose>
                                <c:when test="${empty providers}">
                                    <div style="text-align: center; padding: 80px 20px;">
                                        <i class="fas fa-building"
                                            style="font-size: 5rem; color: #e0e0e0; margin-bottom: 20px;"></i>
                                        <h3 style="color: #7f8c8d;">Chưa có nhà cung cấp nào</h3>
                                        <p style="color: #bdc3c7;">Bắt đầu bằng cách thêm nhà cung cấp đầu tiên!</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div style="padding: 20px;">
                                        <c:forEach items="${providers}" var="p">
                                            <div class="provider-card">
                                                <div class="provider-info">
                                                    <div class="provider-name">
                                                        ${p.businessName}
                                                        <c:if test="${p.verified}">
                                                            <i class="fas fa-check-circle"
                                                                style="color: #27ae60; font-size: 1rem;"></i>
                                                        </c:if>
                                                    </div>
                                                    <div class="provider-meta">
                                                        <div class="meta-item">
                                                            <i class="fas fa-id-card"></i>
                                                            <span>ID: #${p.providerId}</span>
                                                        </div>
                                                        <div class="meta-item">
                                                            <i class="fas fa-tag"></i>
                                                            <span>${p.providerType}</span>
                                                        </div>
                                                        <div class="meta-item rating-stars">
                                                            <i class="fas fa-star"></i>
                                                            <span>
                                                                <fmt:formatNumber value="${p.rating}" pattern="#.#" />
                                                            </span>
                                                        </div>
                                                        <div class="meta-item">
                                                            <i class="fas fa-map-marker-alt"></i>
                                                            <span>${p.totalTours} tours</span>
                                                        </div>
                                                    </div>
                                                    <div style="margin-top: 10px; display: flex; gap: 10px;">
                                                        <span
                                                            class="badge ${p.verified ? 'badge-verified' : 'badge-pending'}">
                                                            <i
                                                                class="fas ${p.verified ? 'fa-check-circle' : 'fa-clock'}"></i>
                                                            ${p.verified ? 'Đã xác minh' : 'Chờ duyệt'}
                                                        </span>
                                                        <span class="badge badge-active">
                                                            ${p.active ? 'Hoạt động' : 'Tạm ngưng'}
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="action-buttons">
                                                    <button class="btn-icon btn-view"
                                                        onclick="location.href='${pageContext.request.contextPath}/admin/providers?action=detail&id=${p.providerId}'"
                                                        title="Xem chi tiết">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                    <button class="btn-icon btn-compare"
                                                        onclick="toggleCompare(${p.providerId})"
                                                        id="compare-${p.providerId}" title="Chọn để so sánh">
                                                        <i class="fas fa-check"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </section>
                    </main>
                </div>

                <script>
                    let selectedProviders = [];

                    function filterByType(type) {
                        const url = new URL(window.location.href);
                        if (type) {
                            url.searchParams.set('type', type);
                        } else {
                            url.searchParams.delete('type');
                        }
                        window.location.href = url.toString();
                    }

                    function toggleCompare(providerId) {
                        const index = selectedProviders.indexOf(providerId);
                        const btn = document.getElementById('compare-' + providerId);

                        if (index > -1) {
                            selectedProviders.splice(index, 1);
                            btn.style.background = '#f3e5f5';
                            btn.style.color = '#7b1fa2';
                        } else {
                            if (selectedProviders.length >= 5) {
                                alert('Chỉ có thể so sánh tối đa 5 nhà cung cấp!');
                                return;
                            }
                            selectedProviders.push(providerId);
                            btn.style.background = '#7b1fa2';
                            btn.style.color = 'white';
                        }

                        updateComparisonBar();
                    }

                    function updateComparisonBar() {
                        const bar = document.getElementById('comparisonBar');
                        const count = document.getElementById('selectedCount');

                        count.textContent = selectedProviders.length;

                        if (selectedProviders.length > 0) {
                            bar.classList.add('active');
                        } else {
                            bar.classList.remove('active');
                        }
                    }

                    function clearSelection() {
                        selectedProviders.forEach(id => {
                            const btn = document.getElementById('compare-' + id);
                            if (btn) {
                                btn.style.background = '#f3e5f5';
                                btn.style.color = '#7b1fa2';
                            }
                        });
                        selectedProviders = [];
                        updateComparisonBar();
                    }

                    function compareSelected() {
                        if (selectedProviders.length < 2) {
                            alert('Vui lòng chọn ít nhất 2 nhà cung cấp để so sánh!');
                            return;
                        }

                        const params = selectedProviders.map(id => 'ids=' + id).join('&');
                        window.location.href = '${pageContext.request.contextPath}/admin/providers?action=comparison&' + params;
                    }
                </script>
            </body>

            </html>