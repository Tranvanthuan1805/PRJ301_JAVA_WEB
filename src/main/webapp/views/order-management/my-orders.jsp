<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn Hàng Của Tôi | Da Nang Travel Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .page-header{background:linear-gradient(135deg,#1B1F3B,#2D3561);color:white;padding:80px 0 80px;position:relative;overflow:hidden;margin-top:64px}
        .page-header::before{content:'';position:absolute;width:500px;height:500px;background:radial-gradient(circle,rgba(255,111,97,.1),transparent 60%);top:-200px;right:-100px;border-radius:50%}
        .page-header h1{font-size:2rem;font-weight:800;margin-bottom:6px;position:relative;z-index:1;display:flex;align-items:center;gap:12px}
        .page-header h1 i{color:#FF6F61}
        .page-header p{opacity:.65;position:relative;z-index:1}

        .order-stats{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin:-35px 0 30px;position:relative;z-index:10}
        .order-stat{background:#fff;padding:22px 20px;border-radius:18px;text-align:center;box-shadow:0 4px 18px rgba(27,31,59,.06);border:1px solid #E8EAF0;transition:.3s}
        .order-stat:hover{transform:translateY(-3px);box-shadow:0 8px 25px rgba(27,31,59,.08)}
        .order-stat .num{font-size:1.8rem;font-weight:800;letter-spacing:-1px}
        .order-stat .label{font-size:.78rem;color:#A0A5C3;margin-top:5px;font-weight:600}

        .order-list{display:grid;gap:16px;margin-bottom:60px}
        .order-item{background:#fff;border-radius:18px;padding:24px;box-shadow:0 2px 10px rgba(27,31,59,.04);border:1px solid #E8EAF0;display:grid;grid-template-columns:auto 1fr auto;gap:24px;align-items:center;transition:.3s}
        .order-item:hover{box-shadow:0 8px 25px rgba(27,31,59,.08);transform:translateY(-2px)}
        .order-id{font-size:1.15rem;font-weight:800;color:#1B1F3B}
        .order-date{font-size:.78rem;color:#A0A5C3;margin-top:5px;display:flex;align-items:center;gap:4px}
        .order-info h3{font-size:1rem;color:#1B1F3B;margin-bottom:6px;font-weight:700}
        .order-info .amount{font-weight:800;color:#059669;font-size:1.05rem}
        .badge{padding:5px 14px;border-radius:999px;font-size:.72rem;font-weight:700;letter-spacing:.3px;display:inline-block}
        .badge-warning{background:#FFF8E1;color:#D97706}
        .badge-info{background:#E0F2FE;color:#0284C7}
        .badge-success{background:#ECFDF5;color:#059669}
        .badge-danger{background:#FEF2F2;color:#DC2626}

        .order-actions{display:flex;gap:10px;align-items:center}
        .btn-cancel{padding:9px 18px;background:rgba(220,38,38,.06);color:#DC2626;border:1px solid rgba(220,38,38,.15);border-radius:12px;font-weight:700;cursor:pointer;font-size:.8rem;transition:.3s;font-family:inherit;display:flex;align-items:center;gap:6px}
        .btn-cancel:hover{background:#DC2626;color:white;border-color:#DC2626}

        .empty-state{text-align:center;padding:80px 30px;background:#fff;border-radius:20px;border:1px solid #E8EAF0;box-shadow:0 4px 20px rgba(27,31,59,.04)}
        .empty-state .icon{font-size:4rem;margin-bottom:16px;filter:grayscale(.2)}
        .empty-state h3{font-size:1.2rem;color:#1B1F3B;margin-bottom:8px}
        .empty-state p{color:#6B7194;margin-bottom:20px}
        .btn-explore{display:inline-flex;align-items:center;gap:8px;padding:12px 28px;border-radius:999px;font-weight:700;font-size:.88rem;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;box-shadow:0 4px 15px rgba(255,111,97,.3);transition:.3s;text-decoration:none}
        .btn-explore:hover{transform:translateY(-2px);box-shadow:0 8px 25px rgba(255,111,97,.4)}

        @media(max-width:768px){
            .order-stats{grid-template-columns:repeat(2,1fr)}
            .order-item{grid-template-columns:1fr}
        }
    </style>
</head>
<body>
    <jsp:include page="/common/_header.jsp" />

    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-box"></i> Đơn Hàng Của Tôi</h1>
            <p>Quản lý và theo dõi đơn hàng du lịch</p>
        </div>
    </div>

    <div class="container">
        <div class="order-stats">
            <div class="order-stat"><div class="num" style="color:#F59E0B">${pendingCount}</div><div class="label">Chờ Xác Nhận</div></div>
            <div class="order-stat"><div class="num" style="color:#0284C7">${confirmedCount}</div><div class="label">Đã Xác Nhận</div></div>
            <div class="order-stat"><div class="num" style="color:#059669">${completedCount}</div><div class="label">Hoàn Thành</div></div>
            <div class="order-stat"><div class="num" style="color:#DC2626">${cancelledCount}</div><div class="label">Đã Hủy</div></div>
        </div>

        <c:choose>
            <c:when test="${not empty orders}">
                <div class="order-list">
                    <c:forEach items="${orders}" var="o">
                        <div class="order-item">
                            <div>
                                <div class="order-id">#${o.orderId}</div>
                                <div class="order-date"><i class="fas fa-calendar-alt"></i> <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></div>
                            </div>
                            <div class="order-info">
                                <h3>${o.tourName}</h3>
                                <span class="amount"><fmt:formatNumber value="${o.totalAmount}" type="number" groupingUsed="true"/>đ</span>
                                <c:choose>
                                    <c:when test="${o.status == 'Pending'}"><span class="badge badge-warning" style="margin-left:10px">Chờ XN</span></c:when>
                                    <c:when test="${o.status == 'Confirmed'}"><span class="badge badge-info" style="margin-left:10px">Đã XN</span></c:when>
                                    <c:when test="${o.status == 'Completed'}"><span class="badge badge-success" style="margin-left:10px">Hoàn thành</span></c:when>
                                    <c:when test="${o.status == 'Cancelled'}"><span class="badge badge-danger" style="margin-left:10px">Đã hủy</span></c:when>
                                    <c:otherwise><span class="badge badge-warning" style="margin-left:10px">${o.status}</span></c:otherwise>
                                </c:choose>
                            </div>
                            <div class="order-actions">
                                <c:if test="${o.status == 'Pending'}">
                                    <form action="${pageContext.request.contextPath}/my-orders" method="post" style="display:inline;"
                                          onsubmit="return confirm('Bạn có chắc muốn hủy đơn hàng #${o.orderId}?')">
                                        <input type="hidden" name="action" value="cancel">
                                        <input type="hidden" name="orderId" value="${o.orderId}">
                                        <button type="submit" class="btn-cancel"><i class="fas fa-times"></i> Hủy</button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="icon">📦</div>
                    <h3>Bạn chưa có đơn hàng nào</h3>
                    <p>Khám phá và đặt tour du lịch Đà Nẵng ngay!</p>
                    <a href="${pageContext.request.contextPath}/tour" class="btn-explore">
                        <i class="fas fa-compass"></i> Tìm Tour
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <jsp:include page="/common/_footer.jsp" />
</body>
</html>
