<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Lịch Sử Tour | Admin</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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

.pg-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;flex-wrap:wrap;gap:12px}
.pg-title{font-size:1.5rem;font-weight:800;color:#fff}

.toolbar{display:flex;gap:10px;margin-bottom:20px}
.tb-search{flex:1;min-width:200px;position:relative}
.tb-search input{width:100%;padding:9px 14px 9px 38px;border-radius:8px;border:1px solid rgba(255,255,255,.1);background:rgba(15,23,42,.8);color:#fff;font-size:.85rem;outline:none}
.tb-search input:focus{border-color:#3B82F6}
.tb-search i{position:absolute;left:12px;top:50%;transform:translateY(-50%);color:#64748B;font-size:.8rem}

.table-wrap{background:rgba(30,41,59,.4);border:1px solid rgba(255,255,255,.06);border-radius:14px;overflow:hidden}
table{width:100%;border-collapse:collapse}
thead{background:rgba(15,23,42,.6)}
th{padding:12px 16px;text-align:left;font-size:.72rem;font-weight:700;color:#64748B;letter-spacing:1px;text-transform:uppercase;border-bottom:1px solid rgba(255,255,255,.06)}
td{padding:12px 16px;border-bottom:1px solid rgba(255,255,255,.04);font-size:.88rem}
tr:hover{background:rgba(255,255,255,.02)}
.tour-thumb{width:56px;height:40px;border-radius:6px;object-fit:cover}
.status-badge{display:inline-flex;align-items:center;gap:4px;padding:3px 10px;border-radius:6px;font-size:.72rem;font-weight:700;background:rgba(239,68,68,.15);color:#F87171}
.btn-restore{padding:6px 14px;border-radius:6px;background:rgba(16,185,129,.15);color:#10B981;font-size:.78rem;font-weight:700;border:none;cursor:pointer;transition:.3s}
.btn-restore:hover{background:rgba(16,185,129,.3)}

.pagination{display:flex;justify-content:center;gap:6px;margin-top:20px}
.pg-btn{width:34px;height:34px;border-radius:6px;border:1px solid rgba(255,255,255,.1);background:transparent;color:#94A3B8;display:flex;align-items:center;justify-content:center;font-weight:600;font-size:.82rem;cursor:pointer;transition:.3s}
.pg-btn:hover{border-color:#3B82F6;color:#fff}
.pg-btn.active{background:#2563EB;border-color:#2563EB;color:#fff}
.pg-btn.disabled{opacity:.3;pointer-events:none}

.empty-msg{text-align:center;padding:60px 20px;color:#475569}
.empty-msg i{font-size:2.5rem;margin-bottom:12px;display:block}
</style>
</head>
<body>
<jsp:include page="/common/_header.jsp"/>

<main class="page">
<div class="container">

    <div class="admin-tabs">
        <a href="${ctx}/admin/tours" class="admin-tab">📋 Quản Lý Tour</a>
        <a href="${ctx}/admin/tours?action=history" class="admin-tab active">📜 Tour Cũ</a>
        <a href="${ctx}/admin/tours?action=analytics" class="admin-tab">📊 Phân Tích</a>
        <a href="${ctx}/admin/dashboard" class="admin-tab">🏠 Dashboard</a>
    </div>

    <div class="pg-header">
        <h1 class="pg-title"><i class="fas fa-history"></i> Lịch Sử Tour Cũ</h1>
        <div style="color:#64748B;font-size:.85rem">Tổng: <b style="color:#60A5FA">${totalTours}</b> tour đã kết thúc</div>
    </div>

    <form action="${ctx}/admin/tours" method="get" class="toolbar">
        <input type="hidden" name="action" value="history">
        <div class="tb-search">
            <i class="fas fa-search"></i>
            <input type="text" name="search" placeholder="Tìm tour cũ..." value="${search}">
        </div>
    </form>

    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Ảnh</th>
                    <th>Tên Tour</th>
                    <th>Giá</th>
                    <th>Chỗ</th>
                    <th>Ngày tạo</th>
                    <th>Trạng Thái</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="tour" items="${tours}">
                    <tr>
                        <td style="color:#64748B;font-weight:600">#${tour.tourId}</td>
                        <td><img class="tour-thumb" src="${not empty tour.imageUrl ? tour.imageUrl : 'https://via.placeholder.com/56x40'}" alt=""></td>
                        <td style="color:#fff;font-weight:600">${tour.tourName}</td>
                        <td style="color:#60A5FA;font-weight:700"><fmt:formatNumber value="${tour.price}" pattern="#,###"/>đ</td>
                        <td>${tour.maxPeople}</td>
                        <td style="color:#94A3B8"><fmt:formatDate value="${tour.createdAt}" pattern="dd/MM/yyyy"/></td>
                        <td><span class="status-badge"><i class="fas fa-circle" style="font-size:.4rem"></i> Đã dừng</span></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty tours}">
                    <tr><td colspan="7" class="empty-msg"><i class="fas fa-inbox"></i>Không có tour cũ nào</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <c:if test="${totalPages > 1}">
        <div class="pagination">
            <a href="${ctx}/admin/tours?action=history&page=${currentPage-1}&search=${search}" class="pg-btn ${currentPage<=1?'disabled':''}"><i class="fas fa-chevron-left"></i></a>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="${ctx}/admin/tours?action=history&page=${i}&search=${search}" class="pg-btn ${i==currentPage?'active':''}">${i}</a>
            </c:forEach>
            <a href="${ctx}/admin/tours?action=history&page=${currentPage+1}&search=${search}" class="pg-btn ${currentPage>=totalPages?'disabled':''}"><i class="fas fa-chevron-right"></i></a>
        </div>
    </c:if>

</div>
</main>
<script src="${ctx}/js/i18n.js"></script>
</body>
</html>
