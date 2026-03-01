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
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Inter',sans-serif;background:#0F172A;color:#E2E8F0;min-height:100vh}
a{text-decoration:none;color:inherit}
.container{max-width:1360px;margin:0 auto;padding:0 24px}
.page{padding:110px 0 60px}

.admin-tabs{display:flex;gap:4px;margin-bottom:24px;background:rgba(30,41,59,.5);border-radius:10px;padding:4px;border:1px solid rgba(255,255,255,.06)}
.admin-tab{padding:9px 20px;border-radius:8px;font-weight:600;font-size:.83rem;color:#64748B;cursor:pointer;transition:.3s}
.admin-tab:hover{color:#fff}
.admin-tab.active{background:#2563EB;color:#fff}

.pg-title{font-size:1.5rem;font-weight:800;color:#fff;margin-bottom:24px}

/* Stats */
.stat-row{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:14px;margin-bottom:28px}
.stat-card{background:rgba(30,41,59,.5);border:1px solid rgba(255,255,255,.06);border-radius:12px;padding:20px;display:flex;align-items:center;gap:14px}
.stat-icon{width:46px;height:46px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:1.1rem}
.stat-icon.blue{background:rgba(59,130,246,.15);color:#60A5FA}
.stat-icon.green{background:rgba(16,185,129,.15);color:#10B981}
.stat-icon.amber{background:rgba(245,158,11,.15);color:#F59E0B}
.stat-icon.purple{background:rgba(139,92,246,.15);color:#A78BFA}
.stat-icon.red{background:rgba(239,68,68,.15);color:#F87171}
.stat-value{font-size:1.5rem;font-weight:800;color:#fff}
.stat-label{font-size:.72rem;color:#64748B;font-weight:600;letter-spacing:.5px}

/* Charts */
.charts-grid{display:grid;grid-template-columns:1fr 1fr;gap:20px;margin-bottom:28px}
.chart-card{background:rgba(30,41,59,.5);border:1px solid rgba(255,255,255,.06);border-radius:14px;padding:20px}
.chart-title{font-size:.95rem;font-weight:700;color:#fff;margin-bottom:16px;display:flex;align-items:center;gap:8px}
.chart-title i{color:#60A5FA}
.chart-wrap{position:relative;height:280px}

/* Table */
.section-title{font-size:1.1rem;font-weight:700;color:#fff;margin-bottom:14px;display:flex;align-items:center;gap:8px}
.section-title i{color:#F59E0B}
.table-wrap{background:rgba(30,41,59,.4);border:1px solid rgba(255,255,255,.06);border-radius:14px;overflow:hidden;margin-bottom:28px}
table{width:100%;border-collapse:collapse}
thead{background:rgba(15,23,42,.6)}
th{padding:12px 16px;text-align:left;font-size:.72rem;font-weight:700;color:#64748B;letter-spacing:1px;text-transform:uppercase;border-bottom:1px solid rgba(255,255,255,.06)}
td{padding:12px 16px;border-bottom:1px solid rgba(255,255,255,.04);font-size:.88rem}
tr:hover{background:rgba(255,255,255,.02)}
.rank{width:28px;height:28px;border-radius:50%;display:inline-flex;align-items:center;justify-content:center;font-weight:800;font-size:.75rem}
.rank-1{background:rgba(245,158,11,.2);color:#F59E0B}
.rank-2{background:rgba(148,163,184,.15);color:#94A3B8}
.rank-3{background:rgba(180,83,9,.2);color:#D97706}
.rank-other{background:rgba(30,41,59,.5);color:#64748B}

.fill-bar{height:8px;border-radius:4px;background:rgba(255,255,255,.06);overflow:hidden;width:120px}
.fill-bar-inner{height:100%;border-radius:4px;transition:.5s}
.fill-high{background:linear-gradient(90deg,#10B981,#34D399)}
.fill-mid{background:linear-gradient(90deg,#F59E0B,#FBBF24)}
.fill-low{background:linear-gradient(90deg,#EF4444,#F87171)}

@media(max-width:768px){.charts-grid{grid-template-columns:1fr}}
</style>
</head>
<body>
<jsp:include page="/common/_header.jsp"/>

<main class="page">
<div class="container">

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
