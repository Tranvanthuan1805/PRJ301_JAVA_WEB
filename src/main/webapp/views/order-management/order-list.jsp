<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Đơn Hàng | Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
    body{font-family:'Plus Jakarta Sans',system-ui,sans-serif;background:#F7F8FC;color:#1B1F3B;-webkit-font-smoothing:antialiased}
    .dashboard-wrapper{display:flex;min-height:100vh}
    .main-content{flex:1;margin-left:260px;padding:30px 35px}

    .page-title{font-size:1.8rem;font-weight:800;color:#1B1F3B;margin-bottom:28px;display:flex;align-items:center;gap:12px;letter-spacing:-.3px}
    .page-title i{color:#FF6F61}

    /* Stats Row */
    .stat-row{display:grid;grid-template-columns:repeat(5,1fr);gap:16px;margin-bottom:28px}
    .stat-item{background:#fff;padding:22px 20px;border-radius:16px;box-shadow:0 2px 10px rgba(27,31,59,.04);border:1px solid #E8EAF0;text-align:center;transition:.3s;position:relative;overflow:hidden}
    .stat-item:hover{transform:translateY(-3px);box-shadow:0 8px 20px rgba(27,31,59,.07)}
    .stat-item .num{font-size:1.8rem;font-weight:800;color:#1B1F3B;letter-spacing:-1px}
    .stat-item .label{font-size:.78rem;color:#A0A5C3;margin-top:5px;font-weight:600}
    .stat-item::after{content:'';position:absolute;bottom:0;left:0;right:0;height:3px;border-radius:0 0 16px 16px}
    .stat-item.warning .num{color:#F59E0B}
    .stat-item.warning::after{background:linear-gradient(90deg,#F59E0B,#FBBF24)}
    .stat-item.info .num{color:#0284C7}
    .stat-item.info::after{background:linear-gradient(90deg,#0284C7,#38BDF8)}
    .stat-item.success .num{color:#059669}
    .stat-item.success::after{background:linear-gradient(90deg,#059669,#34D399)}
    .stat-item.danger .num{color:#DC2626}
    .stat-item.danger::after{background:linear-gradient(90deg,#DC2626,#F87171)}
    .stat-item.revenue .num{color:#7C3AED}
    .stat-item.revenue::after{background:linear-gradient(90deg,#7C3AED,#A78BFA)}

    /* Filters */
    .filter-tabs{display:flex;gap:8px;margin-bottom:22px;flex-wrap:wrap}
    .filter-tabs a{padding:8px 20px;border-radius:999px;font-size:.82rem;font-weight:700;text-decoration:none;transition:.3s;border:2px solid #E8EAF0;color:#6B7194;background:#fff}
    .filter-tabs a.active,.filter-tabs a:hover{background:#1B1F3B;color:#fff;border-color:#1B1F3B}

    /* Table */
    .table-card{background:#fff;border-radius:18px;overflow:hidden;box-shadow:0 4px 20px rgba(27,31,59,.05);border:1px solid #E8EAF0}
    .data-table{width:100%;border-collapse:collapse}
    .data-table th{background:#F7F8FC;padding:14px 20px;text-align:left;font-size:.72rem;text-transform:uppercase;letter-spacing:1.2px;color:#A0A5C3;font-weight:700;border-bottom:1px solid #E8EAF0}
    .data-table th:first-child{padding-left:28px}
    .data-table td{padding:14px 20px;border-bottom:1px solid #F5F6FA;font-size:.88rem;color:#4A4E6F}
    .data-table td:first-child{padding-left:28px}
    .data-table tr:last-child td{border-bottom:none}
    .data-table tr{transition:.2s}
    .data-table tr:hover{background:#FAFBFF}

    .badge{padding:5px 14px;border-radius:999px;font-size:.72rem;font-weight:700;letter-spacing:.3px;display:inline-block}
    .badge-warning{background:#FFF8E1;color:#D97706}
    .badge-info{background:#E0F2FE;color:#0284C7}
    .badge-success{background:#ECFDF5;color:#059669}
    .badge-danger{background:#FEF2F2;color:#DC2626}

    .btn-sm{display:inline-flex;align-items:center;gap:6px;padding:7px 16px;border-radius:10px;font-size:.78rem;font-weight:700;border:none;cursor:pointer;transition:.3s;text-decoration:none;font-family:inherit}
    .btn-view{background:rgba(0,180,216,.08);color:#0284C7}
    .btn-view:hover{background:#0284C7;color:#fff}

    .money{font-weight:800;color:#059669}
    .order-id{font-weight:800;color:#1B1F3B;font-size:.85rem}
    .date{color:#A0A5C3;font-size:.82rem}

    /* Empty */
    .empty-state{text-align:center;padding:70px 30px}
    .empty-state i{font-size:3.5rem;color:#E8EAF0;margin-bottom:16px}
    .empty-state h3{color:#6B7194;font-size:1.1rem}

    @media(max-width:1024px){.stat-row{grid-template-columns:repeat(3,1fr)}}
    @media(max-width:768px){.main-content{margin-left:0;padding:16px}.stat-row{grid-template-columns:repeat(2,1fr)}.table-card{overflow-x:auto}.data-table{min-width:800px}}
    </style>
</head>
<body>
    <div class="dashboard-wrapper">
        <jsp:include page="/common/_sidebar.jsp" />

        <div class="main-content">
            <h1 class="page-title"><i class="fas fa-shopping-bag"></i> Quản Lý Đơn Hàng</h1>

            <div class="stat-row">
                <div class="stat-item warning">
                    <div class="num">${pendingCount}</div>
                    <div class="label">Chờ Xác Nhận</div>
                </div>
                <div class="stat-item info">
                    <div class="num">${confirmedCount}</div>
                    <div class="label">Đã Xác Nhận</div>
                </div>
                <div class="stat-item success">
                    <div class="num">${completedCount}</div>
                    <div class="label">Hoàn Thành</div>
                </div>
                <div class="stat-item danger">
                    <div class="num">${cancelledCount}</div>
                    <div class="label">Đã Hủy</div>
                </div>
                <div class="stat-item revenue">
                    <div class="num"><fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true"/>đ</div>
                    <div class="label">Tổng Doanh Thu</div>
                </div>
            </div>

            <div class="filter-tabs">
                <a href="${pageContext.request.contextPath}/admin/orders" class="${empty selectedStatus ? 'active' : ''}">Tất Cả</a>
                <c:forEach items="${statuses}" var="s">
                    <a href="${pageContext.request.contextPath}/admin/orders?action=filter&status=${s.name()}"
                       class="${selectedStatus == s.name() ? 'active' : ''}">${s.displayName}</a>
                </c:forEach>
            </div>

            <c:choose>
                <c:when test="${not empty orders}">
                    <div class="table-card">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Mã ĐH</th>
                                    <th>Khách Hàng</th>
                                    <th>Tour</th>
                                    <th>Tổng Tiền</th>
                                    <th>Trạng Thái</th>
                                    <th>Thanh Toán</th>
                                    <th>Ngày Đặt</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${orders}" var="o">
                                    <tr>
                                        <td class="order-id">#${o.orderId}</td>
                                        <td>${o.customerName}</td>
                                        <td>${o.tourName}</td>
                                        <td class="money"><fmt:formatNumber value="${o.totalAmount}" type="number" groupingUsed="true"/>đ</td>
                                        <td><span class="badge badge-${o.statusBadgeClass}">${o.statusDisplay}</span></td>
                                        <td><span class="badge ${o.paymentStatus == 'Paid' ? 'badge-success' : 'badge-warning'}">${o.paymentStatus}</span></td>
                                        <td class="date"><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy"/></td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/orders?action=view&id=${o.orderId}" class="btn-sm btn-view">
                                                <i class="fas fa-eye"></i> Xem
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
                        <div class="empty-state">
                            <i class="fas fa-inbox"></i>
                            <h3>Chưa có đơn hàng nào</h3>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
