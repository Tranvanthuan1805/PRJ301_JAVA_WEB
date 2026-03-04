<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Thanh Toán | Da Nang Travel Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .page-header { background: #0a2351; color: white; padding: 50px 0; }
        .page-header h1 { font-size: 2rem; }
        .page-header p { opacity: 0.8; }

        .history-list { max-width: 800px; margin: 30px auto 60px; padding: 0 20px; }
        .history-item {
            background: white; border-radius: 14px; padding: 25px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04); border: 1px solid #f0f0f0;
            margin-bottom: 15px; display: flex; justify-content: space-between;
            align-items: center; transition: 0.3s;
        }
        .history-item:hover { box-shadow: 0 8px 20px rgba(0,0,0,0.08); }

        .history-info h3 { font-size: 1.05rem; color: #0a2351; margin-bottom: 6px; }
        .history-meta { font-size: 0.82rem; color: #b2bec3; }
        .history-meta span { margin-right: 15px; }

        .history-amount { font-size: 1.3rem; font-weight: 800; color: #2e7d32; }
        .badge { padding: 5px 14px; border-radius: 20px; font-size: 0.75rem; font-weight: 700; }
        .badge-active { background: #d4edda; color: #155724; }
        .badge-expired { background: #f8d7da; color: #721c24; }

        .empty-state {
            text-align: center; padding: 80px; background: white; border-radius: 14px;
        }
        .empty-state i { font-size: 3rem; color: #ddd; margin-bottom: 15px; }
    </style>
</head>
<body>
    <jsp:include page="/common/_header.jsp" />

    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-receipt"></i> Lịch Sử Thanh Toán</h1>
            <p>Xem lại các giao dịch thanh toán gói dịch vụ</p>
        </div>
    </div>

    <div class="history-list">
        <c:choose>
            <c:when test="${not empty history}">
                <c:forEach items="${history}" var="h">
                    <div class="history-item">
                        <div class="history-info">
                            <h3>${h.plan.planName}</h3>
                            <div class="history-meta">
                                <span><i class="fas fa-calendar"></i> <fmt:formatDate value="${h.startDate}" pattern="dd/MM/yyyy"/> - <fmt:formatDate value="${h.endDate}" pattern="dd/MM/yyyy"/></span>
                                <span class="badge ${h.endDate.after(now) ? 'badge-active' : 'badge-expired'}">${h.endDate.after(now) ? 'Đang dùng' : 'Hết hạn'}</span>
                            </div>
                        </div>
                        <div class="history-amount">
                            <fmt:formatNumber value="${h.plan.price}" type="number" groupingUsed="true"/>đ
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-receipt"></i>
                    <h3 style="color: #636e72;">Chưa có lịch sử thanh toán</h3>
                    <p style="color: #b2bec3; margin-bottom: 15px;">Nâng cấp gói để mở khóa tính năng</p>
                    <a href="${pageContext.request.contextPath}/pricing" class="btn btn-primary">Xem Gói Dịch Vụ</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <jsp:include page="/common/_footer.jsp" />
</body>
</html>
