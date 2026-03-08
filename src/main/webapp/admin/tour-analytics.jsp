<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Phân Tích Tour | Admin</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.tailwindcss.com"></script>
<script>tailwind.config={theme:{extend:{fontFamily:{sans:['Inter','sans-serif']}}}}</script>
<style>body{font-family:'Inter',sans-serif}</style>
</head>
<body class="bg-[#0a0f1e] text-slate-200 min-h-screen">
<jsp:include page="/common/_admin-sidebar.jsp"/>
<c:set var="pageTitle" value="Phân Tích Tour" scope="request"/>
<jsp:include page="/common/_admin-header.jsp"/>

<main class="lg:ml-[260px] pt-20 pb-10 px-4 lg:px-6">

    <div class="admin-tabs">
        <a href="${ctx}/admin/tours" class="admin-tab">📋 Quản Lý Tour</a>
        <a href="${ctx}/admin/tours?action=history" class="admin-tab">📜 Tour Cũ</a>
        <a href="${ctx}/admin/tours?action=analytics" class="admin-tab active">📊 Phân Tích</a>
        <a href="${ctx}/admin/dashboard" class="admin-tab">🏠 Dashboard</a>
    </div>

    <h1 class="pg-title"><i class="fas fa-chart-line" style="color:#60A5FA"></i> Phân Tích Dữ Liệu Tour</h1>

    <!-- Stats Overview -->
    <div class="stat-row">
        <div class="stat-card">
            <div class="stat-icon blue"><i class="fas fa-globe"></i></div>
            <div><div class="stat-value">${totalTours}</div><div class="stat-label">TỔNG TOUR</div></div>
        </div>
        <div class="stat-card">
            <div class="stat-icon green"><i class="fas fa-check-circle"></i></div>
            <div><div class="stat-value">${activeTours}</div><div class="stat-label">ĐANG HOẠT ĐỘNG</div></div>
        </div>
        <div class="stat-card">
            <div class="stat-icon red"><i class="fas fa-times-circle"></i></div>
            <div><div class="stat-value">${inactiveTours}</div><div class="stat-label">ĐÃ DỪNG</div></div>
        </div>
        <div class="stat-card">
            <div class="stat-icon amber"><i class="fas fa-coins"></i></div>
            <div><div class="stat-value"><fmt:formatNumber value="${avgPrice}" pattern="#,###"/></div><div class="stat-label">GIÁ TRUNG BÌNH (VND)</div></div>
        </div>
        <div class="stat-card">
            <div class="stat-icon purple"><i class="fas fa-users"></i></div>
            <div><div class="stat-value">${totalCapacity}</div><div class="stat-label">TỔNG SỨC CHỨA</div></div>
        </div>
    </div>

    <!-- Charts -->
    <div class="charts-grid">
        <div class="chart-card">
            <div class="chart-title"><i class="fas fa-chart-pie"></i> Tỉ lệ Tour Active/Inactive</div>
            <div class="chart-wrap"><canvas id="statusChart"></canvas></div>
        </div>
        <div class="chart-card">
            <div class="chart-title"><i class="fas fa-chart-bar"></i> Giá Tour (Top 10)</div>
            <div class="chart-wrap"><canvas id="priceChart"></canvas></div>
        </div>
    </div>

    <!-- Tour by capacity -->
    <div class="section-title"><i class="fas fa-trophy"></i> Bảng Xếp Hạng Tour (Theo Sức Chứa)</div>
    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Tên Tour</th>
                    <th>Giá</th>
                    <th>Sức Chứa</th>
                    <th>Trạng Thái</th>
                    <th>Tỉ Lệ Fill</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="tour" items="${tours}" varStatus="s">
                    <c:if test="${s.index < 15}">
                    <tr>
                        <td>
                            <span class="rank ${s.index == 0 ? 'rank-1' : (s.index == 1 ? 'rank-2' : (s.index == 2 ? 'rank-3' : 'rank-other'))}">${s.index + 1}</span>
                        </td>
                        <td style="color:#fff;font-weight:600">${tour.tourName}</td>
                        <td style="color:#60A5FA;font-weight:700"><fmt:formatNumber value="${tour.price}" pattern="#,###"/>đ</td>
                        <td>${tour.maxPeople} chỗ</td>
                        <td>
                            <c:choose>
                                <c:when test="${tour.active}"><span style="color:#10B981;font-weight:600">Active</span></c:when>
                                <c:otherwise><span style="color:#F87171;font-weight:600">Inactive</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:set var="fillRate" value="${tour.maxPeople > 0 ? (tour.maxPeople > 15 ? 85 : (tour.maxPeople > 10 ? 60 : 35)) : 0}"/>
                            <div style="display:flex;align-items:center;gap:8px">
                                <div class="fill-bar">
                                    <div class="fill-bar-inner ${fillRate > 70 ? 'fill-high' : (fillRate > 40 ? 'fill-mid' : 'fill-low')}" style="width:${fillRate}%"></div>
                                </div>
                                <span style="font-size:.78rem;color:#94A3B8;font-weight:600">${fillRate}%</span>
                            </div>
                        </td>
                    </tr>
                    </c:if>
                </c:forEach>
            </tbody>
        </table>
    </div>

</div>
</main>

<script>
// Status Pie Chart
var statusCtx = document.getElementById('statusChart').getContext('2d');
new Chart(statusCtx, {
    type: 'doughnut',
    data: {
        labels: ['Đang hoạt động', 'Đã dừng'],
        datasets: [{
            data: [${activeTours}, ${inactiveTours}],
            backgroundColor: ['#10B981', '#EF4444'],
            borderWidth: 0,
            hoverOffset: 8
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: { position: 'bottom', labels: { color: '#94A3B8', font: { size: 12, weight: '600' }, padding: 16 } }
        },
        cutout: '65%'
    }
});

// Price Bar Chart
var names = [], prices = [];
<c:forEach var="tour" items="${tours}" varStatus="s">
    <c:if test="${s.index < 10}">
        names.push('${tour.tourName.length() > 15 ? tour.tourName.substring(0,15).concat("...") : tour.tourName}');
        prices.push(${tour.price});
    </c:if>
</c:forEach>

var priceCtx = document.getElementById('priceChart').getContext('2d');
new Chart(priceCtx, {
    type: 'bar',
    data: {
        labels: names,
        datasets: [{
            label: 'Giá (VND)',
            data: prices,
            backgroundColor: 'rgba(59,130,246,.5)',
            borderColor: '#3B82F6',
            borderWidth: 1,
            borderRadius: 6
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { legend: { display: false } },
        scales: {
            x: { ticks: { color: '#64748B', font: { size: 10 } }, grid: { display: false } },
            y: { ticks: { color: '#64748B', callback: function(v) { return (v/1000) + 'k'; } }, grid: { color: 'rgba(255,255,255,.04)' } }
        }
    }
});
</script>
<script src="${ctx}/js/i18n.js"></script>
</body>
</html>
