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
<script src="https://cdn.tailwindcss.com"></script>
<script>tailwind.config={theme:{extend:{fontFamily:{sans:['Inter','sans-serif']}}}}</script>
<style>
body{font-family:'Inter',sans-serif}
.row-hover{transition:all .15s}.row-hover:hover{background:rgba(255,255,255,.03)!important}
</style>
</head>
<body class="bg-[#0a0f1e] text-slate-200 min-h-screen">
<jsp:include page="/common/_admin-sidebar.jsp"/>
<c:set var="pageTitle" value="Lịch Sử Tour" scope="request"/>
<jsp:include page="/common/_admin-header.jsp"/>

<main class="lg:ml-[260px] pt-20 pb-10 px-4 lg:px-6">

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
