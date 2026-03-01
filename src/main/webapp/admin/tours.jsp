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
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Inter',sans-serif;background:#0F172A;color:#E2E8F0;min-height:100vh}
a{text-decoration:none;color:inherit}
.container{max-width:1360px;margin:0 auto;padding:0 24px}
.page{padding:110px 0 60px}

/* Cards */
.stat-row{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:14px;margin-bottom:28px}
.stat-card{background:rgba(30,41,59,.5);border:1px solid rgba(255,255,255,.06);border-radius:12px;padding:18px 20px;display:flex;align-items:center;gap:14px}
.stat-icon{width:42px;height:42px;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:1rem}
.stat-icon.blue{background:rgba(59,130,246,.15);color:#60A5FA}
.stat-icon.green{background:rgba(16,185,129,.15);color:#10B981}
.stat-icon.amber{background:rgba(245,158,11,.15);color:#F59E0B}
.stat-icon.red{background:rgba(239,68,68,.15);color:#EF4444}
.stat-value{font-size:1.4rem;font-weight:800;color:#fff}
.stat-label{font-size:.72rem;color:#64748B;font-weight:600;letter-spacing:.5px}

/* Header */
.pg-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;flex-wrap:wrap;gap:12px}
.pg-title{font-size:1.5rem;font-weight:800;color:#fff}
.pg-actions{display:flex;gap:8px;flex-wrap:wrap}
.btn{display:inline-flex;align-items:center;gap:6px;padding:9px 18px;border-radius:8px;font-weight:600;font-size:.83rem;cursor:pointer;transition:.3s;border:none;font-family:inherit}
.btn-primary{background:#2563EB;color:#fff}
.btn-primary:hover{background:#3B82F6}
.btn-ghost{background:rgba(255,255,255,.06);color:#94A3B8;border:1px solid rgba(255,255,255,.1)}
.btn-ghost:hover{color:#fff;background:rgba(255,255,255,.1)}
.btn-danger{background:rgba(239,68,68,.15);color:#F87171;border:1px solid rgba(239,68,68,.2)}
.btn-danger:hover{background:rgba(239,68,68,.25)}

/* Toolbar */
.toolbar{display:flex;gap:10px;margin-bottom:20px;flex-wrap:wrap}
.tb-search{flex:1;min-width:200px;position:relative}
.tb-search input{width:100%;padding:9px 14px 9px 38px;border-radius:8px;border:1px solid rgba(255,255,255,.1);background:rgba(15,23,42,.8);color:#fff;font-size:.85rem;outline:none}
.tb-search input:focus{border-color:#3B82F6}
.tb-search i{position:absolute;left:12px;top:50%;transform:translateY(-50%);color:#64748B;font-size:.8rem}
.tb-select{padding:9px 12px;border-radius:8px;border:1px solid rgba(255,255,255,.1);background:rgba(15,23,42,.8);color:#E2E8F0;font-size:.83rem;outline:none;cursor:pointer}

/* Table */
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
.act-view{background:rgba(59,130,246,.15);color:#60A5FA}
.act-view:hover{background:rgba(59,130,246,.3)}
.act-edit{background:rgba(245,158,11,.15);color:#F59E0B}
.act-edit:hover{background:rgba(245,158,11,.3)}
.act-del{background:rgba(239,68,68,.15);color:#F87171}
.act-del:hover{background:rgba(239,68,68,.3)}

/* Pagination */
.pagination{display:flex;justify-content:center;gap:6px;margin-top:20px}
.pg-btn{width:34px;height:34px;border-radius:6px;border:1px solid rgba(255,255,255,.1);background:transparent;color:#94A3B8;display:flex;align-items:center;justify-content:center;font-weight:600;font-size:.82rem;cursor:pointer;transition:.3s}
.pg-btn:hover{border-color:#3B82F6;color:#fff}
.pg-btn.active{background:#2563EB;border-color:#2563EB;color:#fff}
.pg-btn.disabled{opacity:.3;pointer-events:none}

/* Toast */
.toast{position:fixed;top:100px;right:20px;padding:12px 22px;background:#10B981;color:#fff;border-radius:8px;font-weight:600;font-size:.85rem;z-index:9999;animation:slideIn .4s ease}
@keyframes slideIn{from{transform:translateX(100px);opacity:0}to{transform:translateX(0);opacity:1}}

/* Tabs */
.admin-tabs{display:flex;gap:4px;margin-bottom:24px;background:rgba(30,41,59,.5);border-radius:10px;padding:4px;border:1px solid rgba(255,255,255,.06)}
.admin-tab{padding:9px 20px;border-radius:8px;font-weight:600;font-size:.83rem;color:#64748B;cursor:pointer;transition:.3s}
.admin-tab:hover{color:#fff}
.admin-tab.active{background:#2563EB;color:#fff}

@media(max-width:768px){table{font-size:.78rem}th,td{padding:8px 10px}.pg-header{flex-direction:column;align-items:flex-start}}
</style>
</head>
<body>
<jsp:include page="/common/_header.jsp"/>

<main class="page">
<div class="container">

    <!-- Tabs -->
    <div class="admin-tabs">
        <a href="${ctx}/admin/tours" class="admin-tab active">📋 Quản Lý Tour</a>
        <a href="${ctx}/admin/tours?action=history" class="admin-tab">📜 Tour Cũ</a>
        <a href="${ctx}/admin/tours?action=analytics" class="admin-tab">📊 Phân Tích</a>
        <a href="${ctx}/admin/dashboard" class="admin-tab">🏠 Dashboard</a>
    </div>

    <!-- Stats -->
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
            <div class="stat-icon amber"><i class="fas fa-pause-circle"></i></div>
            <div><div class="stat-value">${totalTours - activeTours}</div><div class="stat-label">ĐÃ DỪNG</div></div>
        </div>
    </div>

    <!-- Header -->
    <div class="pg-header">
        <h1 class="pg-title"><i class="fas fa-map"></i> Quản Lý Tour</h1>
        <div class="pg-actions">
            <a href="${ctx}/admin/tours?action=add" class="btn btn-primary"><i class="fas fa-plus"></i> Thêm Tour Mới</a>
        </div>
    </div>

    <!-- Toolbar -->
    <form action="${ctx}/admin/tours" method="get" class="toolbar">
        <div class="tb-search">
            <i class="fas fa-search"></i>
            <input type="text" name="search" placeholder="Tìm tour..." value="${search}">
        </div>
        <select name="status" class="tb-select" onchange="this.form.submit()">
            <option value="">Tất cả trạng thái</option>
            <option value="active" ${filterStatus == 'active' ? 'selected' : ''}>Đang hoạt động</option>
            <option value="inactive" ${filterStatus == 'inactive' ? 'selected' : ''}>Đã dừng</option>
        </select>
        <select name="sortBy" class="tb-select" onchange="this.form.submit()">
            <option value="">Sắp xếp</option>
            <option value="name_asc" ${sortBy == 'name_asc' ? 'selected' : ''}>Tên A → Z</option>
            <option value="name_desc" ${sortBy == 'name_desc' ? 'selected' : ''}>Tên Z → A</option>
            <option value="price_asc" ${sortBy == 'price_asc' ? 'selected' : ''}>Giá thấp → cao</option>
            <option value="price_desc" ${sortBy == 'price_desc' ? 'selected' : ''}>Giá cao → thấp</option>
            <option value="newest" ${sortBy == 'newest' ? 'selected' : ''}>Mới nhất</option>
        </select>
    </form>

    <!-- Table -->
    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Ảnh</th>
                    <th>Tên Tour</th>
                    <th>Danh Mục</th>
                    <th>Giá</th>
                    <th>Chỗ</th>
                    <th>Trạng Thái</th>
                    <th>Hành Động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="tour" items="${tours}">
                    <tr>
                        <td style="color:#64748B;font-weight:600">#${tour.tourId}</td>
                        <td>
                            <img class="tour-thumb" src="${not empty tour.imageUrl ? tour.imageUrl : 'https://via.placeholder.com/56x40'}" alt="">
                        </td>
                        <td class="tour-name-cell">${tour.tourName}</td>
                        <td style="color:#94A3B8">${not empty tour.category ? tour.category.categoryName : '—'}</td>
                        <td style="color:#60A5FA;font-weight:700"><fmt:formatNumber value="${tour.price}" pattern="#,###"/>đ</td>
                        <td>${tour.maxPeople}</td>
                        <td>
                            <c:choose>
                                <c:when test="${tour.active}">
                                    <span class="status-badge status-active"><i class="fas fa-circle" style="font-size:.4rem"></i> Active</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-inactive"><i class="fas fa-circle" style="font-size:.4rem"></i> Inactive</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <div class="actions-cell">
                                <a href="${ctx}/tour?action=view&id=${tour.tourId}" class="act-btn act-view" title="Xem"><i class="fas fa-eye"></i></a>
                                <a href="${ctx}/admin/tours?action=edit&id=${tour.tourId}" class="act-btn act-edit" title="Sửa"><i class="fas fa-pen"></i></a>
                                <a href="${ctx}/admin/tours?action=delete&id=${tour.tourId}" class="act-btn act-del" title="Xóa" onclick="return confirm('Bạn có chắc muốn vô hiệu hóa tour này?')"><i class="fas fa-trash"></i></a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty tours}">
                    <tr><td colspan="8" style="text-align:center;padding:40px;color:#64748B">Không có tour nào</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- Pagination -->
    <c:if test="${totalPages > 1}">
        <div class="pagination">
            <a href="${ctx}/admin/tours?page=${currentPage-1}&search=${search}&status=${filterStatus}&sortBy=${sortBy}" class="pg-btn ${currentPage<=1?'disabled':''}"><i class="fas fa-chevron-left"></i></a>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="${ctx}/admin/tours?page=${i}&search=${search}&status=${filterStatus}&sortBy=${sortBy}" class="pg-btn ${i==currentPage?'active':''}">${i}</a>
            </c:forEach>
            <a href="${ctx}/admin/tours?page=${currentPage+1}&search=${search}&status=${filterStatus}&sortBy=${sortBy}" class="pg-btn ${currentPage>=totalPages?'disabled':''}"><i class="fas fa-chevron-right"></i></a>
        </div>
    </c:if>

</div>
</main>

<!-- Toast -->
<c:if test="${param.success != null}">
    <div class="toast" id="toast"><i class="fas fa-check-circle"></i> 
        <c:choose>
            <c:when test="${param.success == 'created'}">Tạo tour thành công!</c:when>
            <c:when test="${param.success == 'updated'}">Cập nhật thành công!</c:when>
            <c:when test="${param.success == 'deleted'}">Đã vô hiệu hóa tour!</c:when>
        </c:choose>
    </div>
    <script>setTimeout(function(){document.getElementById('toast').style.display='none';},3000);</script>
</c:if>

<script src="${ctx}/js/i18n.js"></script>
</body>
</html>
