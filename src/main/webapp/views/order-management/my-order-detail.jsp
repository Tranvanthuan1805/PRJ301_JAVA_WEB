<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Đơn #${order.orderId} | eztravel</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
    *{margin:0;padding:0;box-sizing:border-box}
    body{font-family:'Inter',sans-serif;background:#F1F5F9;color:#1A2B49}
    .detail-page{max-width:900px;margin:0 auto;padding:30px 30px 80px}
    .back-link{display:inline-flex;align-items:center;gap:8px;color:#64748B;font-weight:600;font-size:.88rem;text-decoration:none;margin-bottom:24px;transition:.3s}
    .back-link:hover{color:#2563EB}

    .detail-card{background:#fff;border-radius:20px;overflow:hidden;box-shadow:0 1px 3px rgba(0,0,0,.04),0 6px 16px rgba(0,0,0,.04);border:1px solid #E2E8F0}
    .detail-header{background:linear-gradient(135deg,#1A2B49,#2563EB);padding:32px;color:#fff;display:flex;justify-content:space-between;align-items:center}
    .detail-header h1{font-family:'Playfair Display',serif;font-size:1.5rem;font-weight:800}
    .detail-header .order-num{font-size:.85rem;opacity:.7;margin-top:4px}

    .badge{padding:6px 16px;border-radius:999px;font-size:.75rem;font-weight:700;letter-spacing:.3px}
    .badge-pending{background:#FFF8E1;color:#F59E0B}
    .badge-confirmed{background:#E0F2FE;color:#0284C7}
    .badge-completed{background:#ECFDF5;color:#059669}
    .badge-cancelled{background:#FEF2F2;color:#DC2626}

    .detail-body{padding:32px}
    .info-grid{display:grid;grid-template-columns:1fr 1fr;gap:20px;margin-bottom:30px}
    .info-item{display:flex;flex-direction:column;gap:4px}
    .info-item .label{font-size:.75rem;text-transform:uppercase;letter-spacing:1px;color:#94A3B8;font-weight:700}
    .info-item .value{font-size:1rem;font-weight:600;color:#1A2B49}
    .info-item .value.highlight{color:#2563EB;font-size:1.2rem;font-weight:800}

    .tour-info{background:#F8FAFC;border-radius:16px;padding:24px;border:1px solid #E2E8F0;margin-bottom:24px}
    .tour-info h3{font-size:1.1rem;font-weight:700;margin-bottom:12px;display:flex;align-items:center;gap:8px}
    .tour-info h3 i{color:#2563EB}
    .tour-meta{display:flex;gap:20px;flex-wrap:wrap}
    .tour-meta span{display:flex;align-items:center;gap:6px;font-size:.85rem;color:#64748B}
    .tour-meta span i{color:#94A3B8;font-size:.8rem}

    .cancel-box{background:#FEF2F2;border-radius:12px;padding:16px 20px;border:1px solid rgba(239,68,68,.15);margin-top:16px}
    .cancel-box .label{font-size:.75rem;font-weight:700;color:#DC2626;margin-bottom:4px}
    .cancel-box .reason{color:#991B1B;font-size:.88rem}

    .action-bar{display:flex;gap:12px;justify-content:flex-end;padding-top:20px;border-top:1px solid #E2E8F0;margin-top:16px}
    .btn{display:inline-flex;align-items:center;gap:6px;padding:10px 22px;border-radius:12px;font-weight:700;font-size:.85rem;cursor:pointer;border:none;transition:.3s;text-decoration:none;font-family:inherit}
    .btn-cancel{background:rgba(239,68,68,.08);color:#DC2626;border:1px solid rgba(239,68,68,.15)}
    .btn-cancel:hover{background:#DC2626;color:#fff}

    @media(max-width:768px){.info-grid{grid-template-columns:1fr}}
    </style>
</head>
<body>
<jsp:include page="/common/_header.jsp" />

<div class="detail-page">
    <a href="${pageContext.request.contextPath}/my-orders" class="back-link">
        <i class="fas fa-arrow-left"></i> Quay lại đơn hàng
    </a>

    <c:if test="${not empty order}">
        <div class="detail-card">
            <div class="detail-header">
                <div>
                    <h1>Chi Tiết Đơn Hàng</h1>
                    <div class="order-num">Mã đơn: #${order.orderId}</div>
                </div>
                <c:choose>
                    <c:when test="${order.status == 'Pending'}"><span class="badge badge-pending">Chờ Xác Nhận</span></c:when>
                    <c:when test="${order.status == 'Confirmed'}"><span class="badge badge-confirmed">Đã Xác Nhận</span></c:when>
                    <c:when test="${order.status == 'Completed'}"><span class="badge badge-completed">Hoàn Thành</span></c:when>
                    <c:when test="${order.status == 'Cancelled'}"><span class="badge badge-cancelled">Đã Hủy</span></c:when>
                    <c:otherwise><span class="badge badge-pending">${order.status}</span></c:otherwise>
                </c:choose>
            </div>

            <div class="detail-body">
                <div class="info-grid">
                    <div class="info-item">
                        <span class="label">Ngày đặt</span>
                        <span class="value"><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                    </div>
                    <div class="info-item">
                        <span class="label">Thanh toán</span>
                        <span class="value">${order.paymentStatus}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">Số người</span>
                        <span class="value">${order.quantity} người</span>
                    </div>
                    <div class="info-item">
                        <span class="label">Tổng tiền</span>
                        <span class="value highlight"><fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>đ</span>
                    </div>
                </div>

                <c:if test="${not empty order.tourName}">
                    <div class="tour-info">
                        <h3><i class="fas fa-map-marked-alt"></i> ${order.tourName}</h3>
                        <div class="tour-meta">
                            <c:if test="${not empty order.tourDuration}">
                                <span><i class="fas fa-clock"></i> ${order.tourDuration}</span>
                            </c:if>
                            <c:if test="${not empty order.tourLocation}">
                                <span><i class="fas fa-map-marker-alt"></i> ${order.tourLocation}</span>
                            </c:if>
                            <span><i class="fas fa-tag"></i> <fmt:formatNumber value="${order.tourPrice}" type="number" groupingUsed="true"/>đ / người</span>
                        </div>
                    </div>
                </c:if>

                <c:if test="${order.status == 'Cancelled' && not empty order.cancelReason}">
                    <div class="cancel-box">
                        <div class="label">Lý do hủy</div>
                        <div class="reason">${order.cancelReason}</div>
                    </div>
                </c:if>

                <c:if test="${order.canCancel()}">
                    <div class="action-bar">
                        <form action="${pageContext.request.contextPath}/my-orders" method="post"
                              onsubmit="return confirm('Bạn có chắc muốn hủy đơn hàng #${order.orderId}?')">
                            <input type="hidden" name="action" value="cancel">
                            <input type="hidden" name="orderId" value="${order.orderId}">
                            <button type="submit" class="btn btn-cancel">
                                <i class="fas fa-times"></i> Hủy Đơn Hàng
                            </button>
                        </form>
                    </div>
                </c:if>
            </div>
        </div>
    </c:if>

    <c:if test="${empty order}">
        <div class="detail-card" style="padding:60px;text-align:center;">
            <i class="fas fa-exclamation-triangle" style="font-size:3rem;color:#F59E0B;margin-bottom:16px"></i>
            <h3>Không tìm thấy đơn hàng</h3>
            <p style="color:#64748B;margin-top:8px">Đơn hàng không tồn tại hoặc bạn không có quyền xem.</p>
        </div>
    </c:if>
</div>

<jsp:include page="/common/_footer.jsp" />
</body>
</html>
