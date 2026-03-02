<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Quản Lý Tour | Admin</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Inter',sans-serif;background:#0F172A;color:#E2E8F0;min-height:100vh}
a{text-decoration:none;color:inherit}
.container{max-width:1360px;margin:0 auto;padding:0 24px}
.page{padding:110px 0 60px}
.stat-row{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:14px;margin-bottom:28px}
.stat-card{background:rgba(30,41,59,.5);border:1px solid rgba(255,255,255,.06);border-radius:12px;padding:18px 20px;display:flex;align-items:center;gap:14px}
.stat-icon{width:42px;height:42px;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:1rem}
.stat-icon.blue{background:rgba(59,130,246,.15);color:#60A5FA}
.stat-icon.green{background:rgba(16,185,129,.15);color:#10B981}
.stat-icon.amber{background:rgba(245,158,11,.15);color:#F59E0B}
.stat-value{font-size:1.4rem;font-weight:800;color:#fff}
.stat-label{font-size:.72rem;color:#64748B;font-weight:600;letter-spacing:.5px}
.pg-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;flex-wrap:wrap;gap:12px}
.pg-title{font-size:1.5rem;font-weight:800;color:#fff}
.btn{display:inline-flex;align-items:center;gap:6px;padding:9px 18px;border-radius:8px;font-weight:600;font-size:.83rem;cursor:pointer;transition:.3s;border:none;font-family:inherit}
.btn-primary{background:#2563EB;color:#fff}.btn-primary:hover{background:#3B82F6}
.toolbar{display:flex;gap:10px;margin-bottom:20px;flex-wrap:wrap}
.tb-search{flex:1;min-width:200px;position:relative}
.tb-search input{width:100%;padding:9px 14px 9px 38px;border-radius:8px;border:1px solid rgba(255,255,255,.1);background:rgba(15,23,42,.8);color:#fff;font-size:.85rem;outline:none}
.tb-search input:focus{border-color:#3B82F6}
.tb-search i{position:absolute;left:12px;top:50%;transform:translateY(-50%);color:#64748B;font-size:.8rem}
.tb-select{padding:9px 12px;border-radius:8px;border:1px solid rgba(255,255,255,.1);background:rgba(15,23,42,.8);color:#E2E8F0;font-size:.83rem;outline:none;cursor:pointer}
.table-wrap{background:rgba(30,41,59,.4);border:1px solid rgba(255,255,255,.06);border-radius:14px;overflow:hidden}
table{width:100%;border-collapse:collapse}
thead{background:rgba(15,23,42,.6)}
th{padding:12px 16px;text-align:left;font-size:.72rem;font-weight:700;color:#64748B;letter-spacing:1px;text-transform:uppercase;border-bottom:1px solid rgba(255,255,255,.06)}
td{padding:12px 16px;border-bottom:1px solid rgba(255,255,255,.04);font-size:.88rem;vertical-align:middle}
tr:hover{background:rgba(255,255,255,.02)}
.tour-thumb{width:56px;height:40px;border-radius:6px;object-fit:cover;background:#1E293B}
.tour-name-cell{font-weight:600;color:#fff;max-width:220px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.status-badge{display:inline-flex;align-items:center;gap:4px;padding:3px 10px;border-radius:6px;font-size:.72rem;font-weight:700}
.status-active{background:rgba(16,185,129,.15);color:#10B981}
.status-inactive{background:rgba(239,68,68,.15);color:#F87171}
.actions-cell{display:flex;gap:6px}
.act-btn{width:30px;height:30px;border-radius:6px;border:none;cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:.75rem;transition:.3s}
.act-view{background:rgba(59,130,246,.15);color:#60A5FA}.act-view:hover{background:rgba(59,130,246,.3)}
.act-edit{background:rgba(245,158,11,.15);color:#F59E0B}.act-edit:hover{background:rgba(245,158,11,.3)}
.act-del{background:rgba(239,68,68,.15);color:#F87171}.act-del:hover{background:rgba(239,68,68,.3)}
.pagination{display:flex;justify-content:center;gap:6px;margin-top:20px}
.pg-btn{width:34px;height:34px;border-radius:6px;border:1px solid rgba(255,255,255,.1);background:transparent;color:#94A3B8;display:flex;align-items:center;justify-content:center;font-weight:600;font-size:.82rem;cursor:pointer;transition:.3s}
.pg-btn:hover{border-color:#3B82F6;color:#fff}
.pg-btn.active{background:#2563EB;border-color:#2563EB;color:#fff}
.pg-btn.disabled{opacity:.3;pointer-events:none}
.admin-tabs{display:flex;gap:4px;margin-bottom:24px;background:rgba(30,41,59,.5);border-radius:10px;padding:4px;border:1px solid rgba(255,255,255,.06)}
.admin-tab{padding:9px 20px;border-radius:8px;font-weight:600;font-size:.83rem;color:#64748B;cursor:pointer;transition:.3s;border:none;background:transparent;font-family:inherit}
.admin-tab:hover{color:#fff}
.admin-tab.active{background:#2563EB;color:#fff}
.admin-tab.nn-tab{background:rgba(124,58,237,.15);color:#A78BFA;border:1px solid rgba(124,58,237,.2)}
.admin-tab.nn-tab.active{background:linear-gradient(135deg,#7C3AED,#6D28D9);color:#fff;border-color:#7C3AED}
.section-panel{display:none}.section-panel.active{display:block}
.nn-header{display:flex;align-items:center;gap:16px;margin-bottom:28px}
.nn-icon{width:52px;height:52px;border-radius:14px;background:linear-gradient(135deg,#7C3AED,#A78BFA);display:flex;align-items:center;justify-content:center;color:#fff;font-size:1.3rem;box-shadow:0 8px 32px rgba(124,58,237,.3);position:relative;overflow:hidden}
.nn-icon::after{content:'';position:absolute;inset:0;background:linear-gradient(135deg,transparent,rgba(255,255,255,.2));animation:nnP 3s ease-in-out infinite}
@keyframes nnP{0%,100%{opacity:0}50%{opacity:1}}
.nn-badge{display:inline-flex;align-items:center;gap:6px;padding:3px 10px;border-radius:999px;font-size:.68rem;font-weight:700;background:rgba(16,185,129,.15);color:#34D399;border:1px solid rgba(16,185,129,.2);margin-left:10px}
.nn-badge .dot{width:6px;height:6px;border-radius:50%;background:#34D399;animation:db 2s ease infinite}
@keyframes db{0%,100%{opacity:1}50%{opacity:.3}}
.ai-metrics{display:grid;grid-template-columns:repeat(4,1fr);gap:14px;margin-bottom:24px}
.ai-metric{padding:18px;background:rgba(255,255,255,.03);border-radius:12px;border:1px solid rgba(255,255,255,.05);transition:.3s}
.ai-metric:hover{border-color:rgba(124,58,237,.2);transform:translateY(-2px)}
.ai-metric small{font-size:.68rem;color:rgba(255,255,255,.35);text-transform:uppercase;letter-spacing:.8px;font-weight:700;display:block;margin-bottom:4px}
.ai-metric .val{font-weight:800;color:#fff;font-size:1.1rem}
.ai-metric .val.success{color:#34D399}.ai-metric .val.warning{color:#FBBF24}.ai-metric .val.purple{color:#A78BFA}
.card{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:14px;padding:22px;margin-bottom:20px}
.card h3{font-size:1rem;font-weight:700;color:#fff;margin-bottom:16px;display:flex;align-items:center;gap:8px}
.card h3 i{color:#60A5FA;font-size:.85rem}
.chart-box{position:relative;height:300px;background:rgba(255,255,255,.02);border-radius:12px;border:1px solid rgba(255,255,255,.04);padding:14px}
.nn-sub-tabs{display:flex;gap:4px;background:rgba(255,255,255,.04);border-radius:10px;padding:4px;margin-bottom:20px;border:1px solid rgba(255,255,255,.06)}
.nn-sub-tab{padding:8px 16px;border-radius:8px;font-size:.8rem;font-weight:600;color:rgba(255,255,255,.5);cursor:pointer;transition:.3s;border:none;background:transparent;font-family:inherit}
.nn-sub-tab:hover{color:#fff}
.nn-sub-tab.active{background:rgba(124,58,237,.2);color:#fff}
.nn-sub-content{display:none}.nn-sub-content.active{display:block}
.grid-2{display:grid;grid-template-columns:1fr 1fr;gap:20px}
.nn-vis{background:linear-gradient(135deg,rgba(124,58,237,.08),rgba(59,130,246,.08));border:1px solid rgba(124,58,237,.15);border-radius:14px;padding:22px;position:relative;overflow:hidden}
.nn-layers{display:flex;align-items:center;justify-content:center;gap:32px;padding:16px 0}
.nn-layer{display:flex;flex-direction:column;align-items:center;gap:6px}
.nn-layer-label{font-size:.65rem;font-weight:700;color:rgba(255,255,255,.4);text-transform:uppercase;letter-spacing:1px;margin-bottom:4px}
.nn-neuron{width:28px;height:28px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:.6rem;font-weight:700}
.nn-input .nn-neuron{background:rgba(59,130,246,.2);border:2px solid rgba(59,130,246,.4);color:#60A5FA}
.nn-hidden .nn-neuron{background:rgba(124,58,237,.2);border:2px solid rgba(124,58,237,.4);color:#A78BFA}
.nn-output .nn-neuron{background:rgba(16,185,129,.2);border:2px solid rgba(16,185,129,.4);color:#34D399}
.nn-arrow{color:rgba(255,255,255,.15);font-size:1rem}
.nn-layer-info{font-size:.65rem;color:rgba(255,255,255,.45);margin-top:6px;text-align:center;max-width:90px}
.pred-card{background:linear-gradient(135deg,rgba(16,185,129,.06),rgba(34,211,238,.06));border:1px solid rgba(16,185,129,.12);border-radius:14px;padding:22px}
.pred-grid{display:grid;grid-template-columns:repeat(6,1fr);gap:12px;margin-top:14px}
.pred-item{text-align:center;padding:14px 8px;background:rgba(255,255,255,.03);border-radius:10px;border:1px solid rgba(255,255,255,.04)}
.pred-item .pred-val{font-size:1.2rem;font-weight:800;margin-top:4px}
.pred-item small{font-size:.7rem;color:rgba(255,255,255,.4);font-weight:600}
.toast{position:fixed;top:100px;right:20px;padding:12px 22px;background:#10B981;color:#fff;border-radius:8px;font-weight:600;font-size:.85rem;z-index:9999;animation:sIn .4s ease}
@keyframes sIn{from{transform:translateX(100px);opacity:0}to{transform:translateX(0);opacity:1}}
@media(max-width:1200px){.ai-metrics{grid-template-columns:repeat(2,1fr)}.pred-grid{grid-template-columns:repeat(3,1fr)}.grid-2{grid-template-columns:1fr}}
@media(max-width:768px){table{font-size:.78rem}th,td{padding:8px 10px}.ai-metrics{grid-template-columns:1fr}.pred-grid{grid-template-columns:repeat(2,1fr)}.nn-layers{flex-wrap:wrap;gap:16px}}
</style>
</head>
<body>
<jsp:include page="/common/_header.jsp"/>
<main class="page"><div class="container">
    <div class="admin-tabs">
        <button class="admin-tab active" onclick="showSection('tours-section',this)">📋 Quản Lý Tour</button>
        <a href="${ctx}/admin/tours?action=history" class="admin-tab">📜 Tour Cũ</a>
        <a href="${ctx}/admin/tours?action=analytics" class="admin-tab">📊 Phân Tích</a>
        <a href="${ctx}/admin/dashboard" class="admin-tab">🏠 Dashboard</a>
        <button class="admin-tab nn-tab" onclick="showSection('nn-section',this)">🧠 Mạng Neural</button>
    </div>

    <!-- SECTION 1: TOURS -->
    <div class="section-panel active" id="tours-section">
        <div class="stat-row">
            <div class="stat-card"><div class="stat-icon blue"><i class="fas fa-globe"></i></div><div><div class="stat-value">${totalTours}</div><div class="stat-label">TỔNG TOUR</div></div></div>
            <div class="stat-card"><div class="stat-icon green"><i class="fas fa-check-circle"></i></div><div><div class="stat-value">${activeTours}</div><div class="stat-label">ĐANG HOẠT ĐỘNG</div></div></div>
            <div class="stat-card"><div class="stat-icon amber"><i class="fas fa-pause-circle"></i></div><div><div class="stat-value">${totalTours - activeTours}</div><div class="stat-label">ĐÃ DỪNG</div></div></div>
        </div>
        <div class="pg-header"><h1 class="pg-title"><i class="fas fa-map"></i> Quản Lý Tour</h1><div><a href="${ctx}/admin/tours?action=add" class="btn btn-primary"><i class="fas fa-plus"></i> Thêm Tour Mới</a></div></div>
        <form action="${ctx}/admin/tours" method="get" class="toolbar">
            <div class="tb-search"><i class="fas fa-search"></i><input type="text" name="search" placeholder="Tìm tour..." value="${search}"></div>
            <select name="status" class="tb-select" onchange="this.form.submit()"><option value="">Tất cả trạng thái</option><option value="active" ${filterStatus=='active'?'selected':''}>Đang hoạt động</option><option value="inactive" ${filterStatus=='inactive'?'selected':''}>Đã dừng</option></select>
            <select name="sortBy" class="tb-select" onchange="this.form.submit()"><option value="">Sắp xếp</option><option value="name_asc" ${sortBy=='name_asc'?'selected':''}>Tên A-Z</option><option value="name_desc" ${sortBy=='name_desc'?'selected':''}>Tên Z-A</option><option value="price_asc" ${sortBy=='price_asc'?'selected':''}>Giá thấp-cao</option><option value="price_desc" ${sortBy=='price_desc'?'selected':''}>Giá cao-thấp</option><option value="newest" ${sortBy=='newest'?'selected':''}>Mới nhất</option></select>
        </form>
        <div class="table-wrap"><table>
            <thead><tr><th>ID</th><th>Ảnh</th><th>Tên Tour</th><th>Danh Mục</th><th>Giá</th><th>Chỗ</th><th>Trạng Thái</th><th>Hành Động</th></tr></thead>
            <tbody>
                <c:forEach var="tour" items="${tours}"><tr>
                    <td style="color:#64748B;font-weight:600">#${tour.tourId}</td>
                    <td><img class="tour-thumb" src="${not empty tour.imageUrl ? tour.imageUrl : 'https://via.placeholder.com/56x40'}" alt=""></td>
                    <td class="tour-name-cell">${tour.tourName}</td>
                    <td style="color:#94A3B8">${not empty tour.category ? tour.category.categoryName : '-'}</td>
                    <td style="color:#60A5FA;font-weight:700"><fmt:formatNumber value="${tour.price}" pattern="#,###"/>d</td>
                    <td>${tour.maxPeople}</td>
                    <td><c:choose><c:when test="${tour.active}"><span class="status-badge status-active"><i class="fas fa-circle" style="font-size:.4rem"></i> Active</span></c:when><c:otherwise><span class="status-badge status-inactive"><i class="fas fa-circle" style="font-size:.4rem"></i> Inactive</span></c:otherwise></c:choose></td>
                    <td><div class="actions-cell"><a href="${ctx}/tour?action=view&id=${tour.tourId}" class="act-btn act-view"><i class="fas fa-eye"></i></a><a href="${ctx}/admin/tours?action=edit&id=${tour.tourId}" class="act-btn act-edit"><i class="fas fa-pen"></i></a><a href="${ctx}/admin/tours?action=delete&id=${tour.tourId}" class="act-btn act-del" onclick="return confirm('Vô hiệu hóa tour này?')"><i class="fas fa-trash"></i></a></div></td>
                </tr></c:forEach>
                <c:if test="${empty tours}"><tr><td colspan="8" style="text-align:center;padding:40px;color:#64748B">Không có tour nào</td></tr></c:if>
            </tbody>
        </table></div>
        <c:if test="${totalPages > 1}"><div class="pagination">
            <a href="${ctx}/admin/tours?page=${currentPage-1}&search=${search}&status=${filterStatus}&sortBy=${sortBy}" class="pg-btn ${currentPage<=1?'disabled':''}"><i class="fas fa-chevron-left"></i></a>
            <c:forEach begin="1" end="${totalPages}" var="i"><a href="${ctx}/admin/tours?page=${i}&search=${search}&status=${filterStatus}&sortBy=${sortBy}" class="pg-btn ${i==currentPage?'active':''}">${i}</a></c:forEach>
            <a href="${ctx}/admin/tours?page=${currentPage+1}&search=${search}&status=${filterStatus}&sortBy=${sortBy}" class="pg-btn ${currentPage>=totalPages?'disabled':''}"><i class="fas fa-chevron-right"></i></a>
        </div></c:if>
    </div>

    <!-- SECTION 2: NEURAL NETWORK -->
    <div class="section-panel" id="nn-section">
        <c:if test="${aiDataLoaded}">
        <div class="nn-header"><div class="nn-icon"><i class="fas fa-brain"></i></div><div>
            <h2 style="font-size:1.5rem;font-weight:800;color:#fff">Du Bao Mang Neural <span class="nn-badge"><span class="dot"></span> AI Active</span></h2>
            <p style="font-size:.85rem;color:rgba(255,255,255,.4);margin-top:4px">Phan tich du lieu 5 nam (2020-2025) - Feedforward Neural Network - Du bao 6 thang toi</p>
        </div></div>
        <div class="ai-metrics">
            <div class="ai-metric"><small>Tong Diem Du Lieu</small><div class="val purple">${totalDataPoints} mau</div></div>
            <div class="ai-metric"><small>Mo Hinh</small><div class="val" style="font-size:.9rem">3-Layer Feedforward NN</div></div>
            <div class="ai-metric"><small>Do Chinh Xac (R2)</small><div class="val success" id="r2Val">Dang tinh...</div></div>
            <div class="ai-metric"><small>Sai So MAE</small><div class="val warning" id="maeVal">Dang tinh...</div></div>
        </div>
        <div class="nn-sub-tabs">
            <button class="nn-sub-tab active" onclick="switchNNTab('revenue',this)"><i class="fas fa-chart-line"></i> Doanh Thu</button>
            <button class="nn-sub-tab" onclick="switchNNTab('guests',this)"><i class="fas fa-users"></i> Du Khach</button>
            <button class="nn-sub-tab" onclick="switchNNTab('tours',this)"><i class="fas fa-trophy"></i> Top Tours</button>
            <button class="nn-sub-tab" onclick="switchNNTab('weather',this)"><i class="fas fa-cloud-sun"></i> Thoi Tiet</button>
            <button class="nn-sub-tab" onclick="switchNNTab('arch',this)"><i class="fas fa-project-diagram"></i> Kien Truc NN</button>
        </div>
        <div class="nn-sub-content active" id="nntab-revenue"><div class="card"><h3><i class="fas fa-chart-line"></i> Doanh Thu Du Lich 5 Nam - Du Lieu Thuc vs Du Doan Neural Network</h3><div class="chart-box"><canvas id="revenueChart"></canvas></div></div></div>
        <div class="nn-sub-content" id="nntab-guests"><div class="card"><h3><i class="fas fa-users"></i> Luong Du Khach - Phan Tich Theo Mua + Du Doan</h3><div class="chart-box"><canvas id="guestChart"></canvas></div></div></div>
        <div class="nn-sub-content" id="nntab-tours"><div class="card"><h3><i class="fas fa-trophy"></i> Top Tours Doanh Thu Cao Nhat - Tong 5 Nam</h3><div class="chart-box"><canvas id="tourChart"></canvas></div></div></div>
        <div class="nn-sub-content" id="nntab-weather"><div class="card"><h3><i class="fas fa-cloud-sun"></i> Tuong Quan Thoi Tiet - Nhiet Do va Luong Mua TB</h3><div class="chart-box"><canvas id="weatherChart"></canvas></div></div></div>
        <div class="nn-sub-content" id="nntab-arch"><div class="grid-2">
            <div class="nn-vis"><h3 style="color:#A78BFA;margin-bottom:6px;font-size:.95rem"><i class="fas fa-project-diagram"></i> Kien Truc Neural Network</h3><p style="font-size:.78rem;color:rgba(255,255,255,.35);margin-bottom:16px">Feedforward NN - 3 lop - ${totalDataPoints} diem huan luyen</p>
                <div class="nn-layers">
                    <div class="nn-layer nn-input"><div class="nn-layer-label">Input</div><div class="nn-neuron">T</div><div class="nn-neuron">M</div><div class="nn-neuron">S</div><div class="nn-neuron">W</div><div class="nn-layer-info">Thang, Mua, Season, Trend</div></div>
                    <div class="nn-arrow"><i class="fas fa-long-arrow-alt-right"></i></div>
                    <div class="nn-layer nn-hidden"><div class="nn-layer-label">Hidden 1</div><div class="nn-neuron">H1</div><div class="nn-neuron">H2</div><div class="nn-neuron">H3</div><div class="nn-neuron">H4</div><div class="nn-neuron">H5</div><div class="nn-neuron">H6</div><div class="nn-layer-info">6 neurons, ReLU</div></div>
                    <div class="nn-arrow"><i class="fas fa-long-arrow-alt-right"></i></div>
                    <div class="nn-layer nn-hidden"><div class="nn-layer-label">Hidden 2</div><div class="nn-neuron">H1</div><div class="nn-neuron">H2</div><div class="nn-neuron">H3</div><div class="nn-neuron">H4</div><div class="nn-layer-info">4 neurons, ReLU</div></div>
                    <div class="nn-arrow"><i class="fas fa-long-arrow-alt-right"></i></div>
                    <div class="nn-layer nn-output"><div class="nn-layer-label">Output</div><div class="nn-neuron">R</div><div class="nn-neuron">G</div><div class="nn-layer-info">Revenue, Guests</div></div>
                </div>
            </div>
            <div class="pred-card"><h3 style="color:#34D399;font-size:.95rem;margin-bottom:4px"><i class="fas fa-magic"></i> Ket Qua Du Doan - 6 Thang 2026</h3><p style="font-size:.78rem;color:rgba(255,255,255,.35)">Du doan doanh thu va luong du khach</p><div class="pred-grid" id="predGrid"></div></div>
        </div></div>
        </c:if>
        <c:if test="${!aiDataLoaded}"><div class="card" style="text-align:center;padding:60px"><i class="fas fa-database" style="font-size:3rem;color:rgba(255,255,255,.15);margin-bottom:16px;display:block"></i><h3 style="color:#fff;margin-bottom:8px;justify-content:center">Chua Co Du Lieu AI Analytics</h3><p style="color:rgba(255,255,255,.4);max-width:500px;margin:0 auto">Chay file ai_analytics_schema.sql va ai_analytics_data.sql trong Supabase SQL Editor.</p></div></c:if>
    </div>
</div></main>

<c:if test="${param.success != null}"><div class="toast" id="toast"><i class="fas fa-check-circle"></i> <c:choose><c:when test="${param.success=='created'}">Tao tour thanh cong!</c:when><c:when test="${param.success=='updated'}">Cap nhat thanh cong!</c:when><c:when test="${param.success=='deleted'}">Da vo hieu hoa tour!</c:when></c:choose></div><script>setTimeout(function(){document.getElementById('toast').style.display='none';},3000);</script></c:if>

<script>
function showSection(id,btn){document.querySelectorAll('.section-panel').forEach(function(p){p.classList.remove('active')});document.querySelectorAll('.admin-tab').forEach(function(t){t.classList.remove('active')});document.getElementById(id).classList.add('active');btn.classList.add('active');if(id==='nn-section'&&!window.nnInit)initNN();}
function switchNNTab(name,btn){document.querySelectorAll('.nn-sub-content').forEach(function(t){t.classList.remove('active')});document.querySelectorAll('.nn-sub-tab').forEach(function(b){b.classList.remove('active')});document.getElementById('nntab-'+name).classList.add('active');btn.classList.add('active');}
</script>

<c:if test="${aiDataLoaded}">
<script>
var labels=${chartLabels},bookingRevData=${chartBookingRev},flightRevData=${chartFlightRev},guestData=${chartGuestCounts},seasons=${chartSeasons};
var topTourNames=${topTourNames},topTourRevenues=${topTourRevenues},topTourBookings=${topTourBookings};
var weatherMonths=${weatherMonths},weatherTemps=${weatherTemps},weatherRain=${weatherRain};
window.nnInit=false;
function initNN(){if(window.nnInit)return;window.nnInit=true;
Chart.defaults.color='rgba(255,255,255,.5)';Chart.defaults.borderColor='rgba(255,255,255,.06)';Chart.defaults.font.family="'Inter',sans-serif";
function normalize(a){var mn=Math.min.apply(null,a),mx=Math.max.apply(null,a);return{data:a.map(function(v){return(mx-mn)?(v-mn)/(mx-mn):0}),min:mn,max:mx};}
function denorm(v,mn,mx){return v*(mx-mn)+mn;}
var w1=[],w2=[],b1=[],b2=[];
function initW(i,h,o){var a,b;for(a=0;a<h;a++){w1.push([]);for(b=0;b<i;b++)w1[a].push((Math.random()-.5)*.5);b1.push(0);}for(a=0;a<o;a++){w2.push([]);for(b=0;b<h;b++)w2[a].push((Math.random()-.5)*.5);b2.push(0);}}
function relu(x){return x>0?x:0;}
function forward(inp){var h=b1.map(function(b,i){var s=0;for(var j=0;j<inp.length;j++)s+=inp[j]*w1[i][j];return relu(s+b);});return b2.map(function(b,i){var s=0;for(var j=0;j<h.length;j++)s+=h[j]*w2[i][j];return s+b;});}
function train(inputs,targets,ep,lr){for(var e=0;e<ep;e++){for(var d=0;d<inputs.length;d++){var inp=inputs[d],tgt=targets[d];var h=b1.map(function(b,i){var s=0;for(var j=0;j<inp.length;j++)s+=inp[j]*w1[i][j];return relu(s+b);});var out=b2.map(function(b,i){var s=0;for(var j=0;j<h.length;j++)s+=h[j]*w2[i][j];return s+b;});var err=out.map(function(o,i){return o-tgt[i];});var i,j,k;for(i=0;i<w2.length;i++)for(j=0;j<h.length;j++)w2[i][j]-=lr*err[i]*h[j];for(i=0;i<b2.length;i++)b2[i]-=lr*err[i];for(i=0;i<w1.length;i++){var g=0;for(k=0;k<w2.length;k++)g+=err[k]*w2[k][i];var rh=0;for(j=0;j<inp.length;j++)rh+=inp[j]*w1[i][j];rh+=b1[i];if(rh>0){for(j=0;j<inp.length;j++)w1[i][j]-=lr*g*inp[j];b1[i]-=lr*g;}}}}}
initW(4,6,2);
var nR=normalize(bookingRevData),nG=normalize(guestData);
var sMap={'Cao \u0111i\u1EC3m (H\u00E8)':1,'B\u00ECnh th\u01B0\u1EDDng':0.5,'Th\u1EA5p \u0111i\u1EC3m (M\u01B0a)':0};
var tIn=[],tTg=[];
for(var i=1;i<labels.length;i++){var p=labels[i].split('/');tIn.push([parseInt(p[0])/12,(parseInt(p[1])-2020)/6,sMap[seasons[i]]||.5,nR.data[i-1]]);tTg.push([nR.data[i],nG.data[i]]);}
train(tIn,tTg,800,0.005);
var ssRes=0,ssTot=0,meanR=0;for(i=0;i<nR.data.length;i++)meanR+=nR.data[i];meanR/=nR.data.length;
var maeS=0;for(i=0;i<tIn.length;i++){var pr=forward(tIn[i]);ssRes+=Math.pow(pr[0]-tTg[i][0],2);ssTot+=Math.pow(tTg[i][0]-meanR,2);maeS+=Math.abs(denorm(pr[0],nR.min,nR.max)-denorm(tTg[i][0],nR.min,nR.max));}
var r2=Math.max(0,1-ssRes/ssTot);
document.getElementById('r2Val').textContent=(r2*100).toFixed(1)+'%';
document.getElementById('maeVal').textContent=(maeS/tIn.length).toFixed(1)+' ty VND';
var preds=[],pM=['01/2026','02/2026','03/2026','04/2026','05/2026','06/2026'];
var lastR=nR.data[nR.data.length-1],sL=[0,.5,.5,0,0,.5,1,1,1,1,.5,0,0];
for(i=0;i<6;i++){var pr2=forward([(i+1)/12,6/6,sL[i+1],lastR]);preds.push({m:pM[i],r:denorm(Math.max(0,pr2[0]),nR.min,nR.max),g:Math.round(denorm(Math.max(0,pr2[1]),nG.min,nG.max))});lastR=pr2[0];}
var pg=document.getElementById('predGrid');
for(i=0;i<preds.length;i++){pg.innerHTML+='<div class="pred-item"><small>'+preds[i].m+'</small><div class="pred-val" style="color:#34D399">'+preds[i].r.toFixed(0)+' <span style="font-size:.6rem;color:rgba(255,255,255,.3)">ty</span></div><div style="font-size:.72rem;color:#60A5FA;margin-top:3px"><i class="fas fa-users"></i> '+preds[i].g.toLocaleString()+'</div></div>';}
var pLabels=labels.concat(pM);
var nnLine=[];for(i=0;i<bookingRevData.length;i++)nnLine.push(null);nnLine[bookingRevData.length-1]=bookingRevData[bookingRevData.length-1];for(i=0;i<preds.length;i++)nnLine.push(preds[i].r);
new Chart(document.getElementById('revenueChart'),{type:'line',data:{labels:pLabels,datasets:[{label:'Doanh Thu Booking (ty VND)',data:bookingRevData.concat(new Array(6).fill(null)),borderColor:'#3B82F6',backgroundColor:'rgba(59,130,246,.08)',fill:true,tension:.4,pointRadius:1.5,borderWidth:2},{label:'Doanh Thu Ve Bay',data:flightRevData.concat(new Array(6).fill(null)),borderColor:'#F59E0B',backgroundColor:'rgba(245,158,11,.05)',fill:true,tension:.4,pointRadius:1,borderWidth:1.5},{label:'Du Doan NN',data:nnLine,borderColor:'#A78BFA',backgroundColor:'rgba(167,139,250,.1)',fill:true,tension:.4,borderWidth:3,borderDash:[8,4],pointRadius:4,pointBackgroundColor:'#A78BFA',pointBorderColor:'#fff',pointBorderWidth:2}]},options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{labels:{usePointStyle:true,padding:16,font:{size:10}}}},scales:{y:{grid:{color:'rgba(255,255,255,.04)'}},x:{grid:{display:false},ticks:{font:{size:8},maxRotation:45,autoSkip:true,maxTicksLimit:18}}}}});
var gColors=guestData.map(function(v,i){return seasons[i]==='Cao \u0111i\u1EC3m (H\u00E8)'?'rgba(59,130,246,.6)':seasons[i]==='Th\u1EA5p \u0111i\u1EC3m (M\u01B0a)'?'rgba(239,68,68,.4)':'rgba(245,158,11,.5)';});
new Chart(document.getElementById('guestChart'),{type:'bar',data:{labels:pLabels,datasets:[{label:'Du Khach (thuc te)',data:guestData.concat(new Array(6).fill(null)),backgroundColor:gColors,borderRadius:3},{label:'Du Doan NN',data:new Array(guestData.length).fill(null).concat(preds.map(function(p){return p.g})),backgroundColor:'rgba(167,139,250,.6)',borderRadius:3}]},options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{labels:{usePointStyle:true,padding:16}}},scales:{y:{grid:{color:'rgba(255,255,255,.04)'},ticks:{callback:function(v){return(v/1000).toFixed(0)+'K'}}},x:{grid:{display:false},ticks:{font:{size:8},autoSkip:true,maxTicksLimit:18}}}}});
var tc=['#3B82F6','#8B5CF6','#EC4899','#F59E0B','#10B981','#06B6D4'];
new Chart(document.getElementById('tourChart'),{type:'bar',data:{labels:topTourNames.map(function(n){return n.length>28?n.substring(0,28)+'...':n}),datasets:[{label:'Tong Doanh Thu',data:topTourRevenues,backgroundColor:tc.map(function(c){return c+'99'}),borderColor:tc,borderWidth:2,borderRadius:6}]},options:{indexAxis:'y',responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false}},scales:{x:{grid:{color:'rgba(255,255,255,.04)'},ticks:{callback:function(v){return(v/1e6).toFixed(0)+'M'}}},y:{grid:{display:false},ticks:{font:{size:10}}}}}});
new Chart(document.getElementById('weatherChart'),{type:'line',data:{labels:weatherMonths,datasets:[{label:'Nhiet Do TB (C)',data:weatherTemps,borderColor:'#EF4444',backgroundColor:'rgba(239,68,68,.08)',fill:true,tension:.4,pointRadius:5,pointBackgroundColor:'#EF4444',borderWidth:2.5,yAxisID:'y'},{label:'Luong Mua TB (mm)',data:weatherRain,borderColor:'#06B6D4',backgroundColor:'rgba(6,182,212,.08)',fill:true,tension:.4,pointRadius:5,pointBackgroundColor:'#06B6D4',borderWidth:2.5,yAxisID:'y1'}]},options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{labels:{usePointStyle:true,padding:16}}},scales:{y:{position:'left',title:{display:true,text:'C',color:'#EF4444'},grid:{color:'rgba(255,255,255,.04)'}},y1:{position:'right',title:{display:true,text:'mm',color:'#06B6D4'},grid:{display:false}},x:{grid:{display:false}}}}});
}
</script>
</c:if>
<script src="${ctx}/js/i18n.js"></script>
</body>
</html>
