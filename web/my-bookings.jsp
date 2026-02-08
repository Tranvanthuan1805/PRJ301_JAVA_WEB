<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Đặt Tour | Travel Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .booking-card { transition: transform 0.2s; }
        .booking-card:hover { transform: translateY(-3px); box-shadow: 0 8px 25px rgba(0,0,0,0.1) !important; }
        .booking-img { width: 140px; height: 100px; object-fit: cover; border-radius: 8px; }
    </style>
</head>
<body class="bg-light d-flex flex-column min-vh-100">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-airplane-engines"></i> TRAVEL BOOKING
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/my-bookings">Đơn của tôi</a></li>
                    <li class="nav-item ms-2">
                        <span class="text-white">Xin chào, <strong>hieu</strong></span>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container flex-grow-1">
        <!-- Title -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold text-primary mb-0">
                <i class="bi bi-clock-history"></i> Lịch Sử Đặt Tour
            </h3>
            <span class="badge bg-primary fs-6">${bookings.size()} đơn hàng</span>
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
        <!-- Error -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="bi bi-exclamation-triangle"></i> ${error}
            </div>
        </c:if>
        <!-- Booking List -->
        <c:forEach items="${bookings}" var="b">
            <div class="card shadow-sm mb-3 booking-card border-0">
                <div class="card-body">
                    <div class="row align-items-center">
                        <!-- Image -->
                        <div class="col-auto">
                            <a href="${pageContext.request.contextPath}/detail?id=${b.tourId}">
                                <img src="${b.imageUrl}" class="booking-img" alt="${b.tourName}">
                            </a>
                        </div>
                        
                        <!-- Info -->
                        <div class="col">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h5 class="mb-1">
                                        <a href="${pageContext.request.contextPath}/detail?id=${b.tourId}" 
                                           class="text-primary text-decoration-none fw-bold">
                                            ${b.tourName}
                                        </a>
                                    </h5>
                                    <p class="text-muted small mb-1">
                                        <i class="bi bi-calendar3"></i> 
                                        <fmt:formatDate value="${b.bookingDate}" pattern="dd/MM/yyyy"/>
                                        <span class="mx-2">|</span>
                                        <i class="bi bi-people-fill"></i> ${b.numberOfPeople} người
                                        <span class="mx-2">|</span>
                                        <i class="bi bi-geo-alt"></i> ${b.startLocation}
                                    </p>
                                </div>
                                <div class="text-end">
                                    <c:choose>
                                        <c:when test="${b.status == 'Pending'}">
                                            <span class="badge bg-warning text-dark">Chờ xác nhận</span>
                                        </c:when>
                                        <c:when test="${b.status == 'Confirmed'}">
                                            <span class="badge bg-info">Đã xác nhận</span>
                                        </c:when>
                                        <c:when test="${b.status == 'InProgress'}">
                                            <span class="badge bg-primary">Đang thực hiện</span>
                                        </c:when>
                                        <c:when test="${b.status == 'Completed'}">
                                            <span class="badge bg-success">Hoàn thành</span>
                                        </c:when>
                                        <c:when test="${b.status == 'Cancelled'}">
                                            <span class="badge bg-danger">Đã hủy</span>
                                        </c:when>
                                    </c:choose>
                                    <p class="text-danger fw-bold mb-0 mt-2 fs-5">
                                        <fmt:formatNumber value="${b.totalPrice}" type="currency" currencySymbol=""/>đ
                                    </p>
                                    <small class="text-muted">
                                        <c:choose>
                                            <c:when test="${b.paymentStatus == 'PAID'}">
                                                <i class="bi bi-check-circle text-success"></i> Đã thanh toán
                                            </c:when>
                                            <c:when test="${b.paymentStatus == 'REFUNDED'}">
                                                <i class="bi bi-arrow-return-left text-secondary"></i> Đã hoàn tiền
                                            </c:when>
                                            <c:otherwise>
                                                <i class="bi bi-clock text-warning"></i> Chưa thanh toán
                                            </c:otherwise>
                                        </c:choose>
                                    </small>
                                </div>
                            </div>
                            
                            <!-- Cancel Reason -->
                            <c:if test="${b.status == 'Cancelled' && not empty b.cancelReason}">
                                <div class="alert alert-danger py-2 px-3 mt-2 mb-0 small">
                                    <i class="bi bi-exclamation-triangle"></i> <strong>Lý do hủy:</strong> ${b.cancelReason}
                                    <c:if test="${b.refundAmount > 0}">
                                        <br><i class="bi bi-cash"></i> <strong>Hoàn tiền:</strong> 
                                        <fmt:formatNumber value="${b.refundAmount}" type="currency" currencySymbol=""/>đ
                                    </c:if>
                                </div>
                            </c:if>
                        </div>
                        
                        <!-- Actions -->
                        <div class="col-auto">
                            <div class="d-flex flex-column gap-2">
                                <a href="${pageContext.request.contextPath}/detail?id=${b.tourId}" 
                                   class="btn btn-outline-primary btn-sm">
                                    <i class="bi bi-eye"></i> Xem tour
                                </a>
                                
                                <c:if test="${b.status == 'Pending' || b.status == 'Confirmed'}">
                                    <button class="btn btn-outline-danger btn-sm" 
                                            data-bs-toggle="modal" data-bs-target="#cancelModal${b.bookingId}">
                                        <i class="bi bi-x-lg"></i> Hủy đơn
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Cancel Modal -->
            <c:if test="${b.status == 'Pending' || b.status == 'Confirmed'}">
                <div class="modal fade" id="cancelModal${b.bookingId}" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="${pageContext.request.contextPath}/order/cancel" method="POST">
                                <div class="modal-header bg-danger text-white">
                                    <h5 class="modal-title">
                                        <i class="bi bi-exclamation-triangle"></i> Hủy đơn hàng #${b.bookingId}
                                    </h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="bookingId" value="${b.bookingId}">
                                    <input type="hidden" name="redirect" value="my-bookings">
                                    
                                    <p>Bạn có chắc muốn hủy đơn đặt tour <strong>${b.tourName}</strong>?</p>
                                    
                                    <c:if test="${b.paymentStatus == 'PAID'}">
                                        <div class="alert alert-warning py-2">
                                            <i class="bi bi-info-circle"></i> Bạn đã thanh toán. Sẽ được hoàn lại 80%: 
                                            <strong><fmt:formatNumber value="${b.totalPrice * 0.8}" type="currency" currencySymbol=""/>đ</strong>
                                        </div>
                                    </c:if>
                                    
                                    <div class="mb-3">
                                        <label class="form-label">Lý do hủy:</label>
                                        <textarea name="reason" class="form-control" rows="3"
                                                  placeholder="Nhập lý do bạn muốn hủy đơn..." required></textarea>
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
        </c:forEach>
        <!-- Empty State -->
        <c:if test="${empty bookings}">
            <div class="card shadow-sm border-0">
                <div class="card-body text-center py-5">
                    <i class="bi bi-inbox text-muted" style="font-size: 4rem;"></i>
                    <h5 class="text-muted mt-3">Bạn chưa có đơn đặt tour nào</h5>
                    <p class="text-muted">Hãy khám phá các tour hấp dẫn của chúng tôi!</p>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary mt-2">
                        <i class="bi bi-search"></i> Khám phá tour ngay
                    </a>
                </div>
            </div>
        </c:if>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>