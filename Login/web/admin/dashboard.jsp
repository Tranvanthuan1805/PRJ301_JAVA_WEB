<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    // Auth guard
    String role = (String) session.getAttribute("role");
    if (!"ADMIN".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String adminName = (String) session.getAttribute("username");
    if (adminName == null) adminName = "Admin";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | eztravel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>
<body class="admin-dash">

<!-- ============================================== -->
<!--  SIDEBAR                                       -->
<!-- ============================================== -->
<aside class="dash-sidebar" id="dashSidebar">
    <div class="dash-sidebar-brand">
        <div class="brand-icon"><i class="fas fa-plane"></i></div>
        <div>
            <div class="brand-text">eztravel</div>
            <div class="brand-sub">Admin Panel</div>
        </div>
    </div>

    <nav class="dash-nav">
        <div class="dash-nav-section">
            <div class="dash-nav-title">Tổng Quan</div>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="dash-nav-item active">
                <i class="fas fa-th-large"></i> Dashboard
            </a>
        </div>

        <div class="dash-nav-section">
            <div class="dash-nav-title">Quản Lý</div>
            <a href="${pageContext.request.contextPath}/admin/tours.jsp" class="dash-nav-item">
                <i class="fas fa-route"></i> Quản Lý Tour
                <span class="dash-nav-badge">${totalTours}</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/customers" class="dash-nav-item">
                <i class="fas fa-users"></i> Khách Hàng
                <span class="dash-nav-badge">${totalCustomers}</span>
            </a>
            <a href="${pageContext.request.contextPath}/order?action=list" class="dash-nav-item">
                <i class="fas fa-shopping-cart"></i> Đơn Hàng
                <c:if test="${pendingOrders > 0}">
                    <span class="dash-nav-badge">${pendingOrders}</span>
                </c:if>
            </a>
        </div>

        <div class="dash-nav-section">
            <div class="dash-nav-title">Phân Tích</div>
            <a href="${pageContext.request.contextPath}/admin/history.jsp" class="dash-nav-item">
                <i class="fas fa-history"></i> Lịch Sử Tour
            </a>
            <a href="${pageContext.request.contextPath}/admin/tour-analytics.jsp" class="dash-nav-item">
                <i class="fas fa-chart-bar"></i> Tour Analytics
            </a>
            <a href="${pageContext.request.contextPath}/admin/forecast.jsp" class="dash-nav-item">
                <i class="fas fa-brain"></i> AI Forecast
            </a>
        </div>

        <div class="dash-nav-section">
            <div class="dash-nav-title">Hệ Thống</div>
            <a href="${pageContext.request.contextPath}/explore" class="dash-nav-item">
                <i class="fas fa-globe"></i> Xem Website
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="dash-nav-item">
                <i class="fas fa-sign-out-alt"></i> Đăng Xuất
            </a>
        </div>
    </nav>

    <div class="dash-sidebar-footer">
        <div class="dash-admin-card">
            <div class="dash-admin-avatar"><%= adminName.substring(0,1).toUpperCase() %></div>
            <div class="dash-admin-info">
                <div class="name"><%= adminName %></div>
                <div class="role-tag"><i class="fas fa-shield-alt"></i> Super Admin</div>
            </div>
        </div>
    </div>
</aside>

<!-- ============================================== -->
<!--  MAIN CONTENT                                  -->
<!-- ============================================== -->
<div class="dash-main">

    <!-- Top Bar -->
    <header class="dash-topbar">
        <div class="dash-topbar-left">
            <h1>Admin Dashboard</h1>
            <p><span class="live-dot"></span>Dữ liệu realtime — <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy HH:mm"/></p>
        </div>
        <div class="dash-topbar-right">
            <div class="dash-search">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Tìm kiếm tour, khách hàng...">
            </div>
            <button class="dash-icon-btn" title="Thông báo">
                <i class="fas fa-bell"></i>
                <c:if test="${pendingOrders > 0}"><span class="notif-dot"></span></c:if>
            </button>
            <button class="dash-icon-btn" title="Cài đặt">
                <i class="fas fa-cog"></i>
            </button>
        </div>
    </header>

    <!-- Content Area -->
    <div class="dash-content">

        <!-- ========== KPI CARDS ========== -->
        <div class="kpi-grid">
            <!-- Revenue -->
            <div class="kpi-card kpi-revenue">
                <div class="kpi-top">
                    <div class="kpi-info">
                        <div class="kpi-label">Tổng Doanh Thu</div>
                        <div class="kpi-value"><fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/>₫</div>
                    </div>
                    <div class="kpi-icon"><i class="fas fa-wallet"></i></div>
                </div>
                <div class="kpi-bottom">
                    <span class="kpi-trend up"><i class="fas fa-arrow-up"></i> ${completedOrders} đơn</span>
                    <span>hoàn thành</span>
                </div>
            </div>

            <!-- Orders -->
            <div class="kpi-card kpi-orders">
                <div class="kpi-top">
                    <div class="kpi-info">
                        <div class="kpi-label">Tổng Đơn Hàng</div>
                        <div class="kpi-value">${totalOrders}</div>
                    </div>
                    <div class="kpi-icon"><i class="fas fa-shopping-bag"></i></div>
                </div>
                <div class="kpi-bottom">
                    <span class="kpi-trend up"><i class="fas fa-clock"></i> ${pendingOrders} chờ</span>
                    <span>cần xử lý</span>
                </div>
            </div>

            <!-- Tours -->
            <div class="kpi-card kpi-tours">
                <div class="kpi-top">
                    <div class="kpi-info">
                        <div class="kpi-label">Tour Hiện Tại</div>
                        <div class="kpi-value">${totalTours}</div>
                    </div>
                    <div class="kpi-icon"><i class="fas fa-map-marked-alt"></i></div>
                </div>
                <div class="kpi-bottom">
                    <span class="kpi-trend up"><i class="fas fa-database"></i> ${historicalTours}</span>
                    <span>tour lịch sử (2020-2025)</span>
                </div>
            </div>

            <!-- Customers -->
            <div class="kpi-card kpi-customers">
                <div class="kpi-top">
                    <div class="kpi-info">
                        <div class="kpi-label">Khách Hàng</div>
                        <div class="kpi-value">${totalCustomers}</div>
                    </div>
                    <div class="kpi-icon"><i class="fas fa-users"></i></div>
                </div>
                <div class="kpi-bottom">
                    <span class="kpi-trend up"><i class="fas fa-user-check"></i> ${activeCustomers}</span>
                    <span>đang hoạt động</span>
                </div>
            </div>
        </div>

        <!-- ========== ROW 2: Order Status + Performance ========== -->
        <div class="dash-grid-2">
            <!-- Order Status Breakdown -->
            <div class="dash-panel">
                <div class="dash-panel-header">
                    <h3><i class="fas fa-chart-pie"></i> Trạng Thái Đơn Hàng</h3>
                    <div class="dash-panel-actions">
                        <a href="${pageContext.request.contextPath}/order?action=list" class="dash-panel-btn">Xem Tất Cả</a>
                    </div>
                </div>
                <div class="dash-panel-body">
                    <div class="order-status-grid">
                        <div class="order-status-item os-pending">
                            <div class="os-count">${pendingOrders}</div>
                            <div class="os-label" style="color:var(--dash-text-3)">Chờ Xử Lý</div>
                            <div class="os-bar"></div>
                        </div>
                        <div class="order-status-item os-confirmed">
                            <div class="os-count">${confirmedOrders}</div>
                            <div class="os-label" style="color:var(--dash-text-3)">Đã Xác Nhận</div>
                            <div class="os-bar"></div>
                        </div>
                        <div class="order-status-item os-completed">
                            <div class="os-count">${completedOrders}</div>
                            <div class="os-label" style="color:var(--dash-text-3)">Hoàn Thành</div>
                            <div class="os-bar"></div>
                        </div>
                        <div class="order-status-item os-cancelled">
                            <div class="os-count">${cancelledOrders}</div>
                            <div class="os-label" style="color:var(--dash-text-3)">Đã Huỷ</div>
                            <div class="os-bar"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Performance Metrics -->
            <div class="dash-panel">
                <div class="dash-panel-header">
                    <h3><i class="fas fa-tachometer-alt"></i> Hiệu Suất</h3>
                </div>
                <div class="dash-panel-body">
                    <div class="perf-grid">
                        <div class="perf-item">
                            <div class="perf-value" style="color:var(--dash-green)">${conversionRate}%</div>
                            <div class="perf-label">Tỷ Lệ Hoàn Thành</div>
                            <div class="perf-bar">
                                <div class="perf-bar-fill" style="width:${conversionRate}%; background:var(--dash-green)"></div>
                            </div>
                        </div>
                        <div class="perf-item">
                            <div class="perf-value" style="color:var(--dash-blue)">${avgOccupancy}%</div>
                            <div class="perf-label">Tỷ Lệ Lấp Đầy</div>
                            <div class="perf-bar">
                                <div class="perf-bar-fill" style="width:${avgOccupancy}%; background:var(--dash-blue)"></div>
                            </div>
                        </div>
                        <div class="perf-item">
                            <div class="perf-value" style="color:var(--dash-purple)">${totalTours + historicalTours}</div>
                            <div class="perf-label">Tổng Tour Hệ Thống</div>
                            <div class="perf-bar">
                                <div class="perf-bar-fill" style="width:100%; background:linear-gradient(90deg,var(--dash-purple),var(--dash-pink))"></div>
                            </div>
                        </div>
                        <div class="perf-item">
                            <c:set var="cancelRate" value="${totalOrders > 0 ? (cancelledOrders * 100 / totalOrders) : 0}" />
                            <div class="perf-value" style="color:var(--dash-red)">
                                <fmt:formatNumber value="${cancelRate}" maxFractionDigits="1"/>%
                            </div>
                            <div class="perf-label">Tỷ Lệ Huỷ Đơn</div>
                            <div class="perf-bar">
                                <div class="perf-bar-fill" style="width:${cancelRate}%; background:var(--dash-red)"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ========== ROW 3: Recent Orders ========== -->
        <div class="dash-panel" style="margin-bottom:28px">
            <div class="dash-panel-header">
                <h3><i class="fas fa-receipt"></i> Đơn Hàng Gần Đây</h3>
                <div class="dash-panel-actions">
                    <a href="${pageContext.request.contextPath}/order?action=list" class="dash-panel-btn">Xem Tất Cả <i class="fas fa-arrow-right" style="font-size:10px;margin-left:4px"></i></a>
                </div>
            </div>
            <div class="dash-panel-body" style="padding:0">
                <c:choose>
                    <c:when test="${not empty recentOrders}">
                        <div style="overflow-x:auto">
                            <table class="dash-table">
                                <thead>
                                    <tr>
                                        <th>Mã Đơn</th>
                                        <th>Tour ID</th>
                                        <th>Số Người</th>
                                        <th>Tổng Tiền</th>
                                        <th>Trạng Thái</th>
                                        <th>Thanh Toán</th>
                                        <th>Ngày Đặt</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${recentOrders}">
                                        <tr>
                                            <td>
                                                <span class="order-id-badge">
                                                    <i class="fas fa-hashtag" style="font-size:10px"></i>#${order.orderId}
                                                </span>
                                            </td>
                                            <td><i class="fas fa-route" style="color:var(--dash-purple);margin-right:6px;font-size:11px"></i>Tour #${order.tourId}</td>
                                            <td><i class="fas fa-user-friends" style="color:var(--dash-cyan);margin-right:6px;font-size:11px"></i>${order.numberOfPeople}</td>
                                            <td class="price-text"><fmt:formatNumber value="${order.totalPrice}" pattern="#,##0"/>₫</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.status == 'Pending'}"><span class="status-pill sp-pending"><i class="fas fa-clock"></i> Chờ</span></c:when>
                                                    <c:when test="${order.status == 'Confirmed'}"><span class="status-pill sp-confirmed"><i class="fas fa-check"></i> Xác nhận</span></c:when>
                                                    <c:when test="${order.status == 'Completed'}"><span class="status-pill sp-completed"><i class="fas fa-check-double"></i> Hoàn thành</span></c:when>
                                                    <c:when test="${order.status == 'Cancelled'}"><span class="status-pill sp-cancelled"><i class="fas fa-times"></i> Huỷ</span></c:when>
                                                    <c:otherwise><span class="status-pill sp-pending">${order.status}</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.paymentStatus == 'Paid'}"><span class="status-pill sp-paid"><i class="fas fa-check-circle"></i> Đã TT</span></c:when>
                                                    <c:when test="${order.paymentStatus == 'Refunded'}"><span class="status-pill sp-refunded"><i class="fas fa-undo"></i> Hoàn tiền</span></c:when>
                                                    <c:otherwise><span class="status-pill sp-unpaid"><i class="fas fa-exclamation-circle"></i> Chưa TT</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="color:var(--dash-text-3);font-size:12px">
                                                <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="dash-empty">
                            <i class="fas fa-inbox"></i>
                            <p>Chưa có đơn hàng nào</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- ========== ROW 4: Top Tours + Customer Stats + Quick Actions ========== -->
        <div class="dash-grid-3">
            <!-- Top Tours -->
            <div class="dash-panel">
                <div class="dash-panel-header">
                    <h3><i class="fas fa-trophy"></i> Top Tour Đặt Nhiều</h3>
                    <div class="dash-panel-actions">
                        <a href="${pageContext.request.contextPath}/admin/tour-analytics.jsp" class="dash-panel-btn">Analytics</a>
                    </div>
                </div>
                <div class="dash-panel-body">
                    <c:choose>
                        <c:when test="${not empty topTours}">
                            <ul class="top-tour-list">
                                <c:forEach var="tour" items="${topTours}" varStatus="idx">
                                    <li class="top-tour-item">
                                        <div class="tour-rank ${idx.index == 0 ? 'rank-1' : (idx.index == 1 ? 'rank-2' : (idx.index == 2 ? 'rank-3' : 'rank-n'))}">
                                            ${idx.index + 1}
                                        </div>
                                        <div class="tour-info">
                                            <div class="tour-name">${tour[0]}</div>
                                            <div class="tour-meta"><fmt:formatNumber value="${tour[2]}" pattern="#,##0"/>₫ • ${tour[3]}/${tour[4]} chỗ</div>
                                        </div>
                                        <div class="tour-booking-count">${tour[1]}</div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <div class="dash-empty">
                                <i class="fas fa-chart-bar"></i>
                                <p>Chưa có dữ liệu booking</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Customer Statistics -->
            <div class="dash-panel">
                <div class="dash-panel-header">
                    <h3><i class="fas fa-user-shield"></i> Phân Loại Khách Hàng</h3>
                    <div class="dash-panel-actions">
                        <a href="${pageContext.request.contextPath}/admin/customers" class="dash-panel-btn">Chi Tiết</a>
                    </div>
                </div>
                <div class="dash-panel-body">
                    <div class="customer-stats">
                        <div class="cust-stat-row">
                            <div class="cust-stat-dot" style="background:var(--dash-green)"></div>
                            <div class="cs-label">Đang Hoạt Động</div>
                            <div class="cs-count">${activeCustomers}</div>
                            <div class="cs-bar">
                                <c:set var="activePct" value="${totalCustomers > 0 ? (activeCustomers * 100 / totalCustomers) : 0}" />
                                <div class="cs-bar-fill" style="width:${activePct}%; background:var(--dash-green)"></div>
                            </div>
                        </div>
                        <div class="cust-stat-row">
                            <div class="cust-stat-dot" style="background:var(--dash-yellow)"></div>
                            <div class="cs-label">Tạm Ngưng</div>
                            <div class="cs-count">${inactiveCustomers}</div>
                            <div class="cs-bar">
                                <c:set var="inactivePct" value="${totalCustomers > 0 ? (inactiveCustomers * 100 / totalCustomers) : 0}" />
                                <div class="cs-bar-fill" style="width:${inactivePct}%; background:var(--dash-yellow)"></div>
                            </div>
                        </div>
                        <div class="cust-stat-row">
                            <div class="cust-stat-dot" style="background:var(--dash-red)"></div>
                            <div class="cs-label">Bị Khoá</div>
                            <div class="cs-count">${bannedCustomers}</div>
                            <div class="cs-bar">
                                <c:set var="bannedPct" value="${totalCustomers > 0 ? (bannedCustomers * 100 / totalCustomers) : 0}" />
                                <div class="cs-bar-fill" style="width:${bannedPct}%; background:var(--dash-red)"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Summary Stats -->
                    <div style="display:grid; grid-template-columns:1fr 1fr; gap:10px; margin-top:18px">
                        <div style="background:var(--dash-bg-2); padding:14px; border-radius:var(--r-md); border:1px solid var(--dash-border); text-align:center">
                            <div style="font-size:20px; font-weight:800; color:var(--dash-white)">${totalCustomers}</div>
                            <div style="font-size:10px; color:var(--dash-text-3); text-transform:uppercase; letter-spacing:0.5px; font-weight:600; margin-top:2px">Tổng Cộng</div>
                        </div>
                        <div style="background:var(--dash-bg-2); padding:14px; border-radius:var(--r-md); border:1px solid var(--dash-border); text-align:center">
                            <c:set var="activeRatio" value="${totalCustomers > 0 ? (activeCustomers * 100 / totalCustomers) : 0}" />
                            <div style="font-size:20px; font-weight:800; color:var(--dash-green)"><fmt:formatNumber value="${activeRatio}" maxFractionDigits="0"/>%</div>
                            <div style="font-size:10px; color:var(--dash-text-3); text-transform:uppercase; letter-spacing:0.5px; font-weight:600; margin-top:2px">Tỷ Lệ Active</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="dash-panel">
                <div class="dash-panel-header">
                    <h3><i class="fas fa-bolt"></i> Thao Tác Nhanh</h3>
                </div>
                <div class="dash-panel-body">
                    <div class="quick-actions">
                        <a href="${pageContext.request.contextPath}/admin/tours.jsp" class="qa-btn qa-tours">
                            <i class="fas fa-route"></i>
                            <span>Quản Lý Tour</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/customers" class="qa-btn qa-customers">
                            <i class="fas fa-users-cog"></i>
                            <span>Quản Lý KH</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/order?action=list" class="qa-btn qa-orders">
                            <i class="fas fa-clipboard-list"></i>
                            <span>Xem Đơn Hàng</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/history.jsp" class="qa-btn qa-history">
                            <i class="fas fa-archive"></i>
                            <span>Tour Lịch Sử</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/forecast.jsp" class="qa-btn qa-forecast">
                            <i class="fas fa-chart-line"></i>
                            <span>AI Dự Báo</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/tour-analytics.jsp" class="qa-btn qa-analytics">
                            <i class="fas fa-chart-area"></i>
                            <span>Phân Tích</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>

    </div><!-- /.dash-content -->
</div><!-- /.dash-main -->

<!-- ========== MOBILE SIDEBAR TOGGLE ========== -->
<script>
    // Mobile toggle
    document.addEventListener('DOMContentLoaded', function() {
        // Animate numbers on KPI cards
        document.querySelectorAll('.kpi-value').forEach(el => {
            const text = el.textContent.trim();
            // Only animate pure numbers
            const num = parseInt(text.replace(/[^0-9]/g, ''));
            if (!isNaN(num) && num > 0 && num < 100000) {
                const suffix = text.replace(/[0-9,.]/g, '');
                el.textContent = '0' + suffix;
                let current = 0;
                const step = Math.ceil(num / 40);
                const timer = setInterval(() => {
                    current += step;
                    if (current >= num) {
                        current = num;
                        clearInterval(timer);
                    }
                    el.textContent = current.toLocaleString('vi-VN') + suffix;
                }, 30);
            }
        });

        // Animate performance bars
        setTimeout(() => {
            document.querySelectorAll('.perf-bar-fill, .cs-bar-fill').forEach(bar => {
                const w = bar.style.width;
                bar.style.width = '0%';
                setTimeout(() => { bar.style.width = w; }, 100);
            });
        }, 500);
    });
</script>

</body>
</html>
