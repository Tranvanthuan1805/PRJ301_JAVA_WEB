<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Đặt Tour | eztravel</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
    *{margin:0;padding:0;box-sizing:border-box}
    body{font-family:'Inter',sans-serif;background:#F1F5F9;color:#1A2B49}

    .history-page{max-width:1280px;margin:0 auto;padding:30px 30px 80px}

    /* Hero */
    .page-hero{background:linear-gradient(135deg,#1A2B49 0%,#2563EB 100%);border-radius:24px;padding:48px;margin-bottom:35px;position:relative;overflow:hidden;color:#fff}
    .page-hero::before{content:'';position:absolute;width:500px;height:500px;background:radial-gradient(circle,rgba(255,255,255,.08),transparent 60%);top:-250px;right:-150px;border-radius:50%}
    .page-hero::after{content:'';position:absolute;width:300px;height:300px;background:radial-gradient(circle,rgba(96,165,250,.15),transparent 60%);bottom:-150px;left:-100px;border-radius:50%}
    .page-hero h1{font-family:'Playfair Display',serif;font-size:2.2rem;font-weight:800;margin-bottom:8px;position:relative;z-index:1}
    .page-hero p{color:rgba(255,255,255,.7);position:relative;z-index:1;font-size:.95rem}

    /* Stats */
    .hist-stats{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:16px;margin-bottom:30px}
    .hist-stat{background:#fff;border-radius:16px;padding:22px 24px;border:1px solid #E2E8F0;box-shadow:0 1px 3px rgba(0,0,0,.04),0 6px 16px rgba(0,0,0,.04);display:flex;align-items:center;gap:16px;transition:transform .3s,box-shadow .3s}
    .hist-stat:hover{transform:translateY(-4px);box-shadow:0 8px 30px rgba(0,0,0,.08)}
    .hist-stat .icon{width:52px;height:52px;border-radius:14px;display:flex;align-items:center;justify-content:center;font-size:1.2rem;flex-shrink:0}
    .hist-stat .icon.blue{background:linear-gradient(135deg,rgba(37,99,235,.1),rgba(37,99,235,.2));color:#2563EB}
    .hist-stat .icon.green{background:linear-gradient(135deg,rgba(16,185,129,.1),rgba(16,185,129,.2));color:#10B981}
    .hist-stat .icon.orange{background:linear-gradient(135deg,rgba(245,158,11,.1),rgba(245,158,11,.2));color:#F59E0B}
    .hist-stat .icon.red{background:linear-gradient(135deg,rgba(239,68,68,.1),rgba(239,68,68,.2));color:#EF4444}
    .hist-stat .num{font-size:1.6rem;font-weight:800;color:#1A2B49}
    .hist-stat .lab{font-size:.78rem;color:#94A3B8;margin-top:2px}

    /* Table */
    .table-card{background:#fff;border-radius:20px;overflow:hidden;box-shadow:0 1px 3px rgba(0,0,0,.04),0 6px 16px rgba(0,0,0,.04);border:1px solid #E2E8F0}
    .table-card table{width:100%;border-collapse:collapse}
    .table-card thead th{background:#F8FAFC;padding:14px 20px;text-align:left;font-size:.72rem;text-transform:uppercase;letter-spacing:1.2px;color:#94A3B8;font-weight:700;border-bottom:1px solid #E2E8F0}
    .table-card thead th:first-child{padding-left:28px}
    .table-card tbody td{padding:16px 20px;border-bottom:1px solid #F1F5F9;font-size:.88rem;color:#475569}
    .table-card tbody td:first-child{padding-left:28px;font-weight:700;color:#1A2B49}
    .table-card tbody tr:last-child td{border-bottom:none}
    .table-card tbody tr{transition:background .2s}
    .table-card tbody tr:hover{background:#F8FAFC}
    .tour-name{font-weight:700;color:#1A2B49!important}
    .money{font-weight:800;color:#2563EB}
    .badge{padding:5px 14px;border-radius:999px;font-size:.72rem;font-weight:700;letter-spacing:.3px;display:inline-block}
    .badge-pending{background:#FFF8E1;color:#F59E0B}
    .badge-confirmed{background:#E0F2FE;color:#0284C7}
    .badge-completed{background:#ECFDF5;color:#059669}
    .badge-cancelled{background:#FEF2F2;color:#DC2626}

    .btn-view{display:inline-flex;align-items:center;gap:5px;padding:6px 14px;border-radius:8px;font-size:.78rem;font-weight:600;background:rgba(37,99,235,.08);color:#2563EB;text-decoration:none;transition:.3s;border:none;cursor:pointer}
    .btn-view:hover{background:rgba(37,99,235,.15)}

    /* Empty */
    .empty-box{text-align:center;padding:80px 30px}
    .empty-box .icon{font-size:4rem;margin-bottom:16px}
    .empty-box h3{font-size:1.2rem;color:#1A2B49;margin-bottom:8px}
    .empty-box p{color:#64748B}
    .btn-explore{display:inline-flex;align-items:center;gap:8px;padding:12px 28px;border-radius:12px;font-weight:700;font-size:.88rem;background:linear-gradient(135deg,#2563EB,#3B82F6);color:#fff;margin-top:20px;box-shadow:0 4px 14px rgba(37,99,235,.3);transition:.3s;text-decoration:none}
    .btn-explore:hover{transform:translateY(-2px);box-shadow:0 8px 25px rgba(37,99,235,.4)}

    @media(max-width:768px){
        .table-card{overflow-x:auto}
        .table-card table{min-width:700px}
        .page-hero{padding:30px 20px}
        .hist-stats{grid-template-columns:1fr 1fr}
    }
    @media(max-width:480px){
        .hist-stats{grid-template-columns:1fr}
    }
    </style>
</head>
<body>

<jsp:include page="/common/_header.jsp" />

<div class="history-page">
    <div class="page-hero">
        <h1><i class="fas fa-clock-rotate-left" style="margin-right:12px"></i> Lịch Sử Đặt Tour</h1>
        <p>Theo dõi tất cả các đơn đặt tour của bạn tại đây</p>
    </div>

    <!-- Stats -->
    <div class="hist-stats">
        <div class="hist-stat">
            <div class="icon blue"><i class="fas fa-receipt"></i></div>
            <div>
                <div class="num">${totalOrders != null ? totalOrders : 0}</div>
                <div class="lab">Tổng Đơn Hàng</div>
            </div>
        </div>
        <div class="hist-stat">
            <div class="icon green"><i class="fas fa-check-circle"></i></div>
            <div>
                <div class="num">${completedCount != null ? completedCount : 0}</div>
                <div class="lab">Hoàn Thành</div>
            </div>
        </div>
        <div class="hist-stat">
            <div class="icon red"><i class="fas fa-times-circle"></i></div>
            <div>
                <div class="num">${cancelledCount != null ? cancelledCount : 0}</div>
                <div class="lab">Đã Hủy</div>
            </div>
        </div>
        <div class="hist-stat">
            <div class="icon orange"><i class="fas fa-coins"></i></div>
            <div>
                <div class="num"><fmt:formatNumber value="${totalSpent != null ? totalSpent : 0}" type="number" groupingUsed="true"/>đ</div>
                <div class="lab">Tổng Chi Tiêu</div>
            </div>
        </div>
    </div>

    <c:choose>
        <c:when test="${not empty bookingList}">
            <div class="table-card">
                <table>
                    <thead>
                        <tr>
                            <th>Mã Đơn</th>
                            <th>Tour</th>
                            <th>Ngày Đặt</th>
                            <th>Số Khách</th>
                            <th>Tổng Tiền</th>
                            <th>Trạng Thái</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${bookingList}" var="o">
                            <tr>
                                <td>#${o.orderId}</td>
                                <td class="tour-name">${o.tourName != null ? o.tourName : 'N/A'}</td>
                                <td><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td><i class="fas fa-user" style="color:#A0A5C3;margin-right:4px;font-size:.75rem"></i> ${o.quantity}</td>
                                <td class="money"><fmt:formatNumber value="${o.totalAmount}" type="number" groupingUsed="true"/>đ</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${o.status == 'Pending'}"><span class="badge badge-pending">Chờ XN</span></c:when>
                                        <c:when test="${o.status == 'Confirmed'}"><span class="badge badge-confirmed">Đã XN</span></c:when>
                                        <c:when test="${o.status == 'Completed'}"><span class="badge badge-completed">Hoàn thành</span></c:when>
                                        <c:when test="${o.status == 'Cancelled'}"><span class="badge badge-cancelled">Đã hủy</span></c:when>
                                        <c:otherwise><span class="badge badge-pending">${o.status}</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/my-orders?action=view&id=${o.orderId}" class="btn-view">
                                        <i class="fas fa-eye"></i> Chi tiết
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-card">
                <div class="empty-box">
                    <div class="icon">🎫</div>
                    <h3>Chưa có lịch sử đặt tour</h3>
                    <p>Hãy khám phá và đặt tour du lịch Đà Nẵng ngay!</p>
                    <a href="${pageContext.request.contextPath}/tour" class="btn-explore">
                        <i class="fas fa-compass"></i> Khám Phá Tours
                    </a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/common/_footer.jsp" />
</body>
</html>