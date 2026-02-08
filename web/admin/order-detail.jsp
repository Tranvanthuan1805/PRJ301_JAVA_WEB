<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn #${order.bookingId} | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .tour-img { width: 100%; height: 200px; object-fit: cover; border-radius: 10px; }
        .info-label { color: #6c757d; font-size: 0.875rem; }
        .info-value { font-weight: 600; }
    </style>
</head>
<body class="bg-light">
    <!-- Navbar -->
    <nav class="navbar navbar-dark bg-primary shadow-sm mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-airplane-engines"></i> TRAVEL BOOKING
            </a>
            <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-outline-light btn-sm">
                <i class="bi bi-arrow-left"></i> Quay lại danh sách
            </a>
        </div>
    </nav>
    <!-- Breadcrumb -->
    <div class="bg-white py-2 border-bottom shadow-sm mb-4">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0 small">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/orders" class="text-decoration-none">Quản lý đơn hàng</a></li>
                    <li class="breadcrumb-item active">Chi tiết đơn #${order.bookingId}</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="container mb-5">
        <!-- Flash Message -->
        <c:if test="${not empty sessionScope.flashMessage}">
            <div class="alert alert-${sessionScope.flashType} alert-dismissible fade show">
                ${sessionScope.flashMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="flashMessage" scope="session"/>
            <c:remove var="flashType" scope="session"/>
        </c:if>
        <div class="row">
            <!-- Left Column: Order Info -->
            <div class="col-lg-7">
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="bi bi-receipt"></i> Thông Tin Đơn Hàng #${order.bookingId}</h5>
                    </div>
                    <div class="card-body">
                        <div class="row mb-3">
                            <div class="col-6">
                                <p class="info-label mb-1">Mã đơn hàng</p>
                                <p class="info-value text-primary">#${order.bookingId}</p>
                            </div>
                            <div class="col-6">
                                <p class="info-label mb-1">Trạng thái</p>
                                <p class="info-value">
                                    <c:choose>
                                        <c:when test="${order.status == 'Pending'}">
                                            <span class="badge bg-warning text-dark fs-6">Chờ xác nhận</span>
                                        </c:when>
                                        <c:when test="${order.status == 'Confirmed'}">
                                            <span class="badge bg-info fs-6">Đã xác nhận</span>
                                        </c:when>
                                        <c:when test="${order.status == 'InProgress'}">
                                            <span class="badge bg-primary fs-6">Đang thực hiện</span>
                                        </c:when>
                                        <c:when test="${order.status == 'Completed'}">
                                            <span class="badge bg-success fs-6">Hoàn thành</span>
                                        </c:when>
                                        <c:when test="${order.status == 'Cancelled'}">
                                            <span class="badge bg-danger fs-6">Đã hủy</span>
                                        </c:when>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                        
                        <hr>
                        
                        <div class="row mb-3">
                            <div class="col-6">
                                <p class="info-label mb-1"><i class="bi bi-person"></i> Khách hàng</p>
                                <p class="info-value">${order.username}</p>
                            </div>
                            <div class="col-6">
                                <p class="info-label mb-1"><i class="bi bi-calendar"></i> Ngày đặt</p>
                                <p class="info-value"><fmt:formatDate value="${order.bookingDate}" pattern="dd/MM/yyyy HH:mm"/></p>
                            </div>
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-6">
                                <p class="info-label mb-1"><i class="bi bi-people"></i> Số người</p>
                                <p class="info-value">${order.numberOfPeople} người</p>
                            </div>
                            <div class="col-6">
                                <p class="info-label mb-1"><i class="bi bi-credit-card"></i> Thanh toán</p>
                                <p class="info-value">
                                    <c:choose>
                                        <c:when test="${order.paymentStatus == 'PAID'}">
                                            <span class="text-success"><i class="bi bi-check-circle-fill"></i> Đã thanh toán</span>
                                        </c:when>
                                        <c:when test="${order.paymentStatus == 'REFUNDED'}">
                                            <span class="text-secondary"><i class="bi bi-arrow-return-left"></i> Đã hoàn tiền</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-warning"><i class="bi bi-clock"></i> Chưa thanh toán</span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-12">
                                <p class="info-label mb-1"><i class="bi bi-cash-stack"></i> Tổng tiền</p>
                                <p class="info-value text-danger fs-4">
                                    <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol=""/>đ
                                </p>
                            </div>
                        </div>
                        
                        <!-- Cancel Reason -->
                        <c:if test="${order.status == 'Cancelled' && not empty order.cancelReason}">
                            <hr>
                            <div class="alert alert-danger mb-0">
                                <p class="mb-1"><strong><i class="bi bi-exclamation-triangle"></i> Lý do hủy:</strong></p>
                                <p class="mb-0">${order.cancelReason}</p>
                                <c:if test="${order.refundAmount > 0}">
                                    <hr class="my-2">
                                    <p class="mb-0"><strong>Số tiền hoàn lại:</strong> 
                                        <fmt:formatNumber value="${order.refundAmount}" type="currency" currencySymbol=""/>đ
                                    </p>
                                </c:if>
                            </div>
                        </c:if>
                        
                        <!-- Updated At -->
                        <c:if test="${not empty order.updatedAt}">
                            <hr>
                            <p class="text-muted small mb-0">
                                <i class="bi bi-clock-history"></i> Cập nhật lần cuối: 
                                <fmt:formatDate value="${order.updatedAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                            </p>
                        </c:if>
                    </div>
                </div>
                
                <!-- Action Buttons -->
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-secondary text-white">
                        <h6 class="mb-0"><i class="bi bi-gear"></i> Thao tác</h6>
                    </div>
                    <div class="card-body">
                        <div class="d-flex flex-wrap gap-2">
                            <c:choose>
                                <c:when test="${order.status == 'Pending'}">
                                    <form action="${pageContext.request.contextPath}/order/confirm" method="POST" class="d-inline">
                                        <input type="hidden" name="bookingId" value="${order.bookingId}">
                                        <input type="hidden" name="redirect" value="admin/orders?action=view&id=${order.bookingId}">
                                        <button type="submit" class="btn btn-success">
                                            <i class="bi bi-check-lg"></i> Xác nhận đơn
                                        </button>
                                    </form>
                                    <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#cancelModal">
                                        <i class="bi bi-x-lg"></i> Hủy đơn
                                    </button>
                                </c:when>
                                
                                <c:when test="${order.status == 'Confirmed'}">
                                    <form action="${pageContext.request.contextPath}/order/start" method="POST" class="d-inline">
                                        <input type="hidden" name="bookingId" value="${order.bookingId}">
                                        <input type="hidden" name="redirect" value="admin/orders?action=view&id=${order.bookingId}">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-play-fill"></i> Bắt đầu tour
                                        </button>
                                    </form>
                                    <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#cancelModal">
                                        <i class="bi bi-x-lg"></i> Hủy đơn
                                    </button>
                                </c:when>
                                
                                <c:when test="${order.status == 'InProgress'}">
                                    <form action="${pageContext.request.contextPath}/order/complete" method="POST" class="d-inline">
                                        <input type="hidden" name="bookingId" value="${order.bookingId}">
                                        <input type="hidden" name="redirect" value="admin/orders?action=view&id=${order.bookingId}">
                                        <button type="submit" class="btn btn-success">
                                            <i class="bi bi-check-circle"></i> Hoàn thành tour
                                        </button>
                                    </form>
                                </c:when>
                                
                                <c:when test="${order.status == 'Completed'}">
                                    <span class="text-success"><i class="bi bi-check-circle-fill"></i> Đơn hàng đã hoàn thành</span>
                                </c:when>
                                
                                <c:when test="${order.status == 'Cancelled'}">
                                    <span class="text-danger"><i class="bi bi-x-circle-fill"></i> Đơn hàng đã bị hủy</span>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Right Column: Tour Info -->
            <div class="col-lg-5">
                <div class="card shadow-sm border-0 sticky-top" style="top: 20px;">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0"><i class="bi bi-map"></i> Thông Tin Tour</h5>
                    </div>
                    <img src="${order.imageUrl}" class="tour-img card-img-top rounded-0" alt="${order.tourName}">
                    <div class="card-body">
                        <h5 class="card-title text-primary fw-bold">${order.tourName}</h5>
                        <ul class="list-unstyled">
                            <li class="mb-2">
                                <i class="bi bi-clock text-muted"></i> 
                                <strong>Thời gian:</strong> ${order.duration}
                            </li>
                            <li class="mb-2">
                                <i class="bi bi-geo-alt text-muted"></i> 
                                <strong>Khởi hành:</strong> ${order.startLocation}
                            </li>
                            <li class="mb-2">
                                <i class="bi bi-tag text-muted"></i> 
                                <strong>Giá/người:</strong> 
                                <span class="text-danger"><fmt:formatNumber value="${order.tourPrice}" type="currency" currencySymbol=""/>đ</span>
                            </li>
                        </ul>
                        <a href="${pageContext.request.contextPath}/detail?id=${order.tourId}" 
                           class="btn btn-outline-primary w-100" target="_blank">
                            <i class="bi bi-eye"></i> Xem trang tour
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Cancel Modal -->
    <c:if test="${order.status == 'Pending' || order.status == 'Confirmed'}">
        <div class="modal fade" id="cancelModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/order/cancel" method="POST">
                        <div class="modal-header bg-danger text-white">
                            <h5 class="modal-title"><i class="bi bi-exclamation-triangle"></i> Hủy đơn hàng</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="bookingId" value="${order.bookingId}">
                            <input type="hidden" name="redirect" value="admin/orders?action=view&id=${order.bookingId}">
                            
                            <p>Bạn có chắc muốn hủy đơn hàng <strong>#${order.bookingId}</strong>?</p>
                            
                            <c:if test="${order.paymentStatus == 'PAID'}">
                                <div class="alert alert-warning py-2">
                                    <i class="bi bi-info-circle"></i> Khách đã thanh toán. Sẽ hoàn lại 80%: 
                                    <strong><fmt:formatNumber value="${order.totalPrice * 0.8}" type="currency" currencySymbol=""/>đ</strong>
                                </div>
                            </c:if>
                            
                            <div class="mb-3">
                                <label class="form-label">Lý do hủy <span class="text-danger">*</span></label>
                                <textarea name="reason" class="form-control" rows="3" 
                                          placeholder="Nhập lý do hủy đơn hàng..." required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-danger">
                                <i class="bi bi-x-lg"></i> Xác nhận hủy
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </c:if>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>