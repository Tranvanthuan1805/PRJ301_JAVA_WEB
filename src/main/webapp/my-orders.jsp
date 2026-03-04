<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn Hàng Của Tôi | ezTravel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #0a0e27; color: #fff; }
        
        .container { max-width: 1200px; margin: 100px auto 60px; padding: 0 20px; }
        
        .page-title { font-size: 2rem; margin-bottom: 30px; display: flex; align-items: center; gap: 12px; }
        .page-title i { color: #4299e1; }
        
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 40px; }
        .stat-box { background: linear-gradient(135deg, #1a1f3a 0%, #2d3748 100%); padding: 25px; border-radius: 12px; text-align: center; border: 1px solid rgba(66, 153, 225, 0.2); }
        .stat-box .number { font-size: 2.5rem; font-weight: 800; margin-bottom: 8px; }
        .stat-box .label { color: #a0aec0; font-size: 0.9rem; text-transform: uppercase; letter-spacing: 1px; }
        
        .order-card { background: linear-gradient(135deg, #1a1f3a 0%, #2d3748 100%); border-radius: 12px; padding: 25px; margin-bottom: 20px; border: 1px solid rgba(66, 153, 225, 0.2); transition: 0.3s; }
        .order-card:hover { transform: translateY(-2px); box-shadow: 0 8px 25px rgba(66, 153, 225, 0.3); }
        
        .order-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px solid rgba(66, 153, 225, 0.2); }
        .order-id { font-size: 1.3rem; font-weight: 700; color: #4299e1; }
        .order-date { color: #a0aec0; font-size: 0.9rem; margin-top: 5px; }
        
        .order-content { display: grid; grid-template-columns: 1fr auto; gap: 30px; align-items: center; }
        .order-info h3 { font-size: 1.2rem; margin-bottom: 10px; }
        .order-meta { display: flex; gap: 20px; color: #a0aec0; font-size: 0.9rem; margin-top: 8px; }
        .order-meta span { display: flex; align-items: center; gap: 5px; }
        
        .order-right { text-align: right; }
        .order-amount { font-size: 1.5rem; font-weight: 800; color: #10b981; margin-bottom: 15px; }
        
        .badge { padding: 6px 14px; border-radius: 20px; font-size: 0.85rem; font-weight: 600; display: inline-block; }
        .badge-warning { background: rgba(245, 158, 11, 0.2); color: #f59e0b; border: 1px solid rgba(245, 158, 11, 0.3); }
        .badge-info { background: rgba(2, 132, 199, 0.2); color: #0284c7; border: 1px solid rgba(2, 132, 199, 0.3); }
        .badge-success { background: rgba(16, 185, 129, 0.2); color: #10b981; border: 1px solid rgba(16, 185, 129, 0.3); }
        .badge-danger { background: rgba(239, 68, 68, 0.2); color: #ef4444; border: 1px solid rgba(239, 68, 68, 0.3); }
        
        .btn-cancel { padding: 10px 20px; background: rgba(239, 68, 68, 0.2); color: #ef4444; border: 1px solid rgba(239, 68, 68, 0.3); border-radius: 8px; cursor: pointer; font-weight: 600; transition: 0.3s; font-family: inherit; display: inline-flex; align-items: center; gap: 8px; }
        .btn-cancel:hover { background: #ef4444; color: white; transform: translateY(-2px); }
        
        .empty-state { text-align: center; padding: 80px 20px; background: linear-gradient(135deg, #1a1f3a 0%, #2d3748 100%); border-radius: 15px; border: 1px solid rgba(66, 153, 225, 0.2); }
        .empty-state .icon { font-size: 5rem; margin-bottom: 20px; opacity: 0.5; }
        .empty-state h3 { font-size: 1.5rem; margin-bottom: 10px; }
        .empty-state p { color: #a0aec0; margin-bottom: 25px; font-size: 1.1rem; }
        .btn-explore { display: inline-flex; align-items: center; gap: 10px; padding: 12px 30px; background: linear-gradient(135deg, #4299e1 0%, #3182ce 100%); color: white; text-decoration: none; border-radius: 8px; font-weight: 600; transition: 0.3s; }
        .btn-explore:hover { transform: translateY(-2px); box-shadow: 0 8px 25px rgba(66, 153, 225, 0.4); }
        
        @media(max-width:768px) {
            .stats-grid { grid-template-columns: repeat(2, 1fr); }
            .order-content { grid-template-columns: 1fr; }
            .order-right { text-align: left; margin-top: 15px; }
        }
    </style>
</head>
<body>
    <jsp:include page="/common/_header.jsp" />

    <div class="container">
        <h1 class="page-title">
            <i class="fas fa-box"></i> Đơn Hàng Của Tôi
        </h1>
        
        <div class="stats-grid">
            <div class="stat-box">
                <div class="number" style="color:#f59e0b">${pendingCount}</div>
                <div class="label">Chờ Xác Nhận</div>
            </div>
            <div class="stat-box">
                <div class="number" style="color:#0284c7">${confirmedCount}</div>
                <div class="label">Đã Xác Nhận</div>
            </div>
            <div class="stat-box">
                <div class="number" style="color:#10b981">${completedCount}</div>
                <div class="label">Hoàn Thành</div>
            </div>
            <div class="stat-box">
                <div class="number" style="color:#ef4444">${cancelledCount}</div>
                <div class="label">Đã Hủy</div>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty orders}">
                <c:forEach items="${orders}" var="o">
                    <div class="order-card">
                        <div class="order-header">
                            <div>
                                <div class="order-id">#${o.orderId}</div>
                                <div class="order-date">
                                    <i class="fas fa-calendar"></i>
                                    <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </div>
                            </div>
                            <span class="badge badge-${o.statusBadgeClass}">${o.statusDisplay}</span>
                        </div>
                        
                        <div class="order-content">
                            <div class="order-info">
                                <h3>${o.tourName != null ? o.tourName : 'Tour'}</h3>
                                <div class="order-meta">
                                    <span><i class="fas fa-users"></i> ${o.quantity} người</span>
                                    <span><i class="fas fa-credit-card"></i> ${o.paymentStatus}</span>
                                </div>
                            </div>
                            
                            <div class="order-right">
                                <div class="order-amount">
                                    <fmt:formatNumber value="${o.totalAmount}" type="number" groupingUsed="true"/>đ
                                </div>
                                
                                <c:if test="${o.status == 'Pending'}">
                                    <form action="${pageContext.request.contextPath}/my-orders" method="post" style="display:inline;" 
                                          onsubmit="return confirm('Bạn có chắc muốn hủy đơn hàng #${o.orderId}?')">
                                        <input type="hidden" name="action" value="cancel">
                                        <input type="hidden" name="orderId" value="${o.orderId}">
                                        <button type="submit" class="btn-cancel">
                                            <i class="fas fa-times-circle"></i> Hủy đơn
                                        </button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="icon">📦</div>
                    <h3>Chưa có đơn hàng nào</h3>
                    <p>Bạn chưa đặt tour nào. Hãy khám phá các tour du lịch tuyệt vời!</p>
                    <a href="${pageContext.request.contextPath}/explore" class="btn-explore">
                        <i class="fas fa-compass"></i> Khám phá ngay
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        // Show messages
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('msg') === 'order_cancelled') {
            alert('✓ Đơn hàng đã được hủy thành công!');
            window.history.replaceState({}, '', '${pageContext.request.contextPath}/my-orders');
        } else if (urlParams.get('error')) {
            const error = urlParams.get('error');
            if (error === 'cannot_cancel') alert('✗ Không thể hủy đơn hàng này!');
            else if (error === 'cancel_failed') alert('✗ Hủy đơn hàng thất bại!');
            else if (error === 'unauthorized') alert('✗ Bạn không có quyền hủy đơn hàng này!');
            window.history.replaceState({}, '', '${pageContext.request.contextPath}/my-orders');
        }
    </script>
</body>
</html>
