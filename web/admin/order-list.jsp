<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Đơn Hàng | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .stat-card { transition: transform 0.2s; cursor: pointer; }
        .stat-card:hover { transform: translateY(-3px); }
        .stat-card.active { border: 2px solid #0d6efd !important; }
    </style>
</head>
<body class="bg-light">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-airplane-engines"></i> TRAVEL BOOKING
            </a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/orders">Quản lý đơn</a></li>
                    <li class="nav-item ms-2">
                        <span class="badge bg-light text-primary"><i class="bi bi-person-circle"></i> Admin</span>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container">
        <!-- Title -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold text-primary mb-0">
                <i class="bi bi-list-check"></i> Quản Lý Đơn Hàng
            </h3>
            <span class="text-muted">Tổng: <strong>${orders.size()}</strong> đơn</span>
        </div>
        <!-- Flash Message -->
        <c:if test="${not empty sessionScope.flashMessage}">
            <div class="alert alert-${sessionScope.flashType} alert-dismissible fade show" role="alert">
                <i class="bi bi-${sessionScope.flashType == 'success' ? 'check-circle' : 'exclamation-triangle'}"></i>
                ${sessionScope.flashMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="flashMessage" scope="session"/>
            <c:remove var="flashType" scope="session"/>
        </c:if>
        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col">
                <div class="card stat-card shadow-sm border-0 text-center py-3" onclick="filterByStatus('Pending')">
                    <div class="card-body py-2">
                        <h4 class="text-warning mb-0">${pendingCount}</h4>
                        <small class="text-muted">Chờ xác nhận</small>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card stat-card shadow-sm border-0 text-center py-3" onclick="filterByStatus('Confirmed')">
                    <div class="card-body py-2">
                        <h4 class="text-info mb-0">${confirmedCount}</h4>
                        <small class="text-muted">Đã xác nhận</small>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card stat-card shadow-sm border-0 text-center py-3" onclick="filterByStatus('InProgress')">
                    <div class="card-body py-2">
                        <h4 class="text-primary mb-0">${inProgressCount}</h4>
                        <small class="text-muted">Đang thực hiện</small>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card stat-card shadow-sm border-0 text-center py-3" onclick="filterByStatus('Completed')">
                    <div class="card-body py-2">
                        <h4 class="text-success mb-0">${completedCount}</h4>
                        <small class="text-muted">Hoàn thành</small>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card stat-card shadow-sm border-0 text-center py-3" onclick="filterByStatus('Cancelled')">
                    <div class="card-body py-2">
                        <h4 class="text-danger mb-0">${cancelledCount}</h4>
                        <small class="text-muted">Đã hủy</small>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card shadow-sm border-0 text-center py-3 bg-success text-white">
                    <div class="card-body py-2">
                        <h5 class="mb-0"><fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol=""/>đ</h5>
                        <small>Doanh thu</small>
                    </div>
                </div>
            </div>
        </div>
        <!-- Filter Bar -->
        <div class="card shadow-sm border-0 mb-3">
            <div class="card-body py-2">
                <form action="${pageContext.request.contextPath}/admin/orders" method="GET" class="row align-items-center">
                    <input type="hidden" name="action" value="filter">
                    <div class="col-auto">
                        <label class="form-label mb-0 fw-bold">Lọc theo trạng thái:</label>
                    </div>
                    <div class="col-auto">
                        <select name="status" class="form-select form-select-sm" onchange="this.form.submit()">
                            <option value="all" ${empty selectedStatus || selectedStatus == 'all' ? 'selected' : ''}>Tất cả</option>
                            <option value="Pending" ${selectedStatus == 'Pending' ? 'selected' : ''}>Chờ xác nhận</option>
                            <option value="Confirmed" ${selectedStatus == 'Confirmed' ? 'selected' : ''}>Đã xác nhận</option>
                            <option value="InProgress" ${selectedStatus == 'InProgress' ? 'selected' : ''}>Đang thực hiện</option>
                            <option value="Completed" ${selectedStatus == 'Completed' ? 'selected' : ''}>Hoàn thành</option>
                            <option value="Cancelled" ${selectedStatus == 'Cancelled' ? 'selected' : ''}>Đã hủy</option>
                        </select>
                    </div>
                    <div class="col-auto">
                        <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-outline-secondary btn-sm">
                            <i class="bi bi-arrow-counterclockwise"></i> Reset
                        </a>
                    </div>
                </form>
            </div>
        </div>
        <!-- Orders Table -->
        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <table class="table table-hover mb-0 align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th class="text-center" style="width: 60px;">ID</th>
                            <th>Khách hàng</th>
                            <th>Tour</th>
                            <th class="text-center">Ngày đặt</th>
                            <th class="text-center">Số người</th>
                            <th class="text-end">Tổng tiền</th>
                            <th class="text-center">Thanh toán</th>
                            <th class="text-center">Trạng thái</th>
                            <th class="text-center" style="width: 150px;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orders}" var="o">
                            <tr>
                                <td class="text-center fw-bold">#${o.bookingId}</td>
                                <td><i class="bi bi-person-circle text-muted"></i> ${o.username}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/detail?id=${o.tourId}" 
                                       class="text-decoration-none text-primary fw-bold">
                                        ${o.tourName}
                                    </a>
                                </td>
                                <td class="text-center">
                                    <fmt:formatDate value="${o.bookingDate}" pattern="dd/MM/yyyy"/>
                                </td>
                                <td class="text-center">${o.numberOfPeople}</td>
                                <td class="text-end text-danger fw-bold">
                                    <fmt:formatNumber value="${o.totalPrice}" type="currency" currencySymbol=""/>đ
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${o.paymentStatus == 'PAID'}">
                                            <span class="badge bg-success">Đã TT</span>
                                        </c:when>
                                        <c:when test="${o.paymentStatus == 'REFUNDED'}">
                                            <span class="badge bg-secondary">Hoàn tiền</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-warning text-dark">Chưa TT</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${o.status == 'Pending'}">
                                            <span class="badge bg-warning text-dark">Chờ xác nhận</span>
                                        </c:when>
                                        <c:when test="${o.status == 'Confirmed'}">
                                            <span class="badge bg-info">Đã xác nhận</span>
                                        </c:when>
                                        <c:when test="${o.status == 'InProgress'}">
                                            <span class="badge bg-primary">Đang thực hiện</span>
                                        </c:when>
                                        <c:when test="${o.status == 'Completed'}">
                                            <span class="badge bg-success">Hoàn thành</span>
                                        </c:when>
                                        <c:when test="${o.status == 'Cancelled'}">
                                            <span class="badge bg-danger">Đã hủy</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/admin/orders?action=view&id=${o.bookingId}" 
                                       class="btn btn-outline-primary btn-sm" title="Xem chi tiết">
                                        <i class="bi bi-eye"></i>
                                    </a>
                                    
                                    <c:if test="${o.status == 'Pending'}">
                                        <form action="${pageContext.request.contextPath}/order/confirm" method="POST" class="d-inline">
                                            <input type="hidden" name="bookingId" value="${o.bookingId}">
                                            <input type="hidden" name="redirect" value="admin/orders">
                                            <button type="submit" class="btn btn-success btn-sm" title="Xác nhận">
                                                <i class="bi bi-check-lg"></i>
                                            </button>
                                        </form>
                                    </c:if>
                                    
                                    <c:if test="${o.status == 'Pending' || o.status == 'Confirmed'}">
                                        <button type="button" class="btn btn-danger btn-sm" title="Hủy đơn"
                                                data-bs-toggle="modal" data-bs-target="#cancelModal${o.bookingId}">
                                            <i class="bi bi-x-lg"></i>
                                        </button>
                                    </c:if>
                                </td>
                            </tr>
                            
                            <!-- Cancel Modal -->
                            <c:if test="${o.status == 'Pending' || o.status == 'Confirmed'}">
                                <div class="modal fade" id="cancelModal${o.bookingId}" tabindex="-1">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <form action="${pageContext.request.contextPath}/order/cancel" method="POST">
                                                <div class="modal-header bg-danger text-white">
                                                    <h5 class="modal-title"><i class="bi bi-exclamation-triangle"></i> Hủy đơn #${o.bookingId}</h5>
                                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <input type="hidden" name="bookingId" value="${o.bookingId}">
                                                    <input type="hidden" name="redirect" value="admin/orders">
                                                    
                                                    <p>Bạn có chắc muốn hủy đơn đặt tour <strong>${o.tourName}</strong> của khách <strong>${o.username}</strong>?</p>
                                                    
                                                    <c:if test="${o.paymentStatus == 'PAID'}">
                                                        <div class="alert alert-warning py-2">
                                                            <i class="bi bi-info-circle"></i> Đơn này đã thanh toán. Hoàn lại 80%: 
                                                            <strong><fmt:formatNumber value="${o.totalPrice * 0.8}" type="currency" currencySymbol=""/>đ</strong>
                                                        </div>
                                                    </c:if>
                                                    
                                                    <div class="mb-3">
                                                        <label class="form-label">Lý do hủy:</label>
                                                        <textarea name="reason" class="form-control" rows="2" 
                                                                  placeholder="Nhập lý do hủy đơn..." required></textarea>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                    <button type="submit" class="btn btn-danger">Xác nhận hủy</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                        
                        <c:if test="${empty orders}">
                            <tr>
                                <td colspan="9" class="text-center py-5 text-muted">
                                    <i class="bi bi-inbox fs-1"></i>
                                    <p class="mt-2 mb-0">Không có đơn hàng nào.</p>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function filterByStatus(status) {
            window.location.href = '${pageContext.request.contextPath}/admin/orders?action=filter&status=' + status;
        }
    </script>
</body>
</html>