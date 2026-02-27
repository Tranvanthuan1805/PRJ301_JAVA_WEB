<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Đặt Vé | Da Nang Travel Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
    .history-page{max-width:1280px;margin:0 auto;padding:100px 30px 80px}

    /* Header */
    .page-hero{background:linear-gradient(135deg,#1B1F3B,#2D3561);border-radius:24px;padding:40px;margin-bottom:35px;position:relative;overflow:hidden;color:#fff}
    .page-hero::before{content:'';position:absolute;width:400px;height:400px;background:radial-gradient(circle,rgba(255,111,97,.12),transparent 60%);top:-200px;right:-100px;border-radius:50%}
    .page-hero h1{font-size:2rem;font-weight:800;margin-bottom:6px;position:relative;z-index:1}
    .page-hero p{color:rgba(255,255,255,.6);position:relative;z-index:1}

    /* Stats */
    .hist-stats{display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:16px;margin-bottom:30px}
    .hist-stat{background:#fff;border-radius:16px;padding:20px 24px;border:1px solid #E8EAF0;box-shadow:0 2px 8px rgba(27,31,59,.04);display:flex;align-items:center;gap:14px}
    .hist-stat .icon{width:48px;height:48px;border-radius:14px;display:flex;align-items:center;justify-content:center;font-size:1.1rem;flex-shrink:0}
    .hist-stat .icon.blue{background:rgba(0,180,216,.1);color:#00B4D8}
    .hist-stat .icon.green{background:rgba(6,214,160,.1);color:#06D6A0}
    .hist-stat .icon.orange{background:rgba(255,183,3,.1);color:#FFB703}
    .hist-stat .icon.red{background:rgba(255,111,97,.1);color:#FF6F61}
    .hist-stat .num{font-size:1.5rem;font-weight:800;color:#1B1F3B}
    .hist-stat .lab{font-size:.78rem;color:#A0A5C3}

    /* Table */
    .table-card{background:#fff;border-radius:20px;overflow:hidden;box-shadow:0 4px 20px rgba(27,31,59,.05);border:1px solid #E8EAF0}
    .table-card table{width:100%;border-collapse:collapse}
    .table-card thead th{background:#F7F8FC;padding:14px 20px;text-align:left;font-size:.75rem;text-transform:uppercase;letter-spacing:1.2px;color:#A0A5C3;font-weight:700;border-bottom:1px solid #E8EAF0}
    .table-card thead th:first-child{padding-left:28px}
    .table-card tbody td{padding:16px 20px;border-bottom:1px solid #F5F6FA;font-size:.9rem;color:#4A4E6F}
    .table-card tbody td:first-child{padding-left:28px;font-weight:700;color:#1B1F3B}
    .table-card tbody tr:last-child td{border-bottom:none}
    .table-card tbody tr{transition:.2s}
    .table-card tbody tr:hover{background:#FAFBFF}
    .tour-name{font-weight:700;color:#1B1F3B}
    .money{font-weight:800;color:#FF6F61}
    .badge{padding:5px 14px;border-radius:999px;font-size:.72rem;font-weight:700;letter-spacing:.3px;display:inline-block}
    .badge-pending{background:#FFF8E1;color:#F59E0B}
    .badge-confirmed{background:#E0F2FE;color:#0284C7}
    .badge-completed{background:#ECFDF5;color:#059669}
    .badge-cancelled{background:#FEF2F2;color:#DC2626}

    /* Empty */
    .empty-box{text-align:center;padding:80px 30px}
    .empty-box .icon{font-size:4rem;margin-bottom:16px;filter:grayscale(.2)}
    .empty-box h3{font-size:1.2rem;color:#1B1F3B;margin-bottom:8px}
    .empty-box p{color:#6B7194}
    .btn-explore{display:inline-flex;align-items:center;gap:8px;padding:12px 28px;border-radius:999px;font-weight:700;font-size:.88rem;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;margin-top:20px;box-shadow:0 4px 15px rgba(255,111,97,.3);transition:.3s}
    .btn-explore:hover{transform:translateY(-2px);box-shadow:0 8px 25px rgba(255,111,97,.4)}

    @media(max-width:768px){
        .table-card{overflow-x:auto}
        .table-card table{min-width:700px}
        .page-hero{padding:30px 20px}
    }
    </style>
</head>
<body>

<jsp:include page="/common/_header.jsp" />

<div class="history-page">
    <div class="page-hero">
        <h1><i class="fas fa-ticket-alt" style="margin-right:10px"></i> Lịch Sử Đặt Vé</h1>
        <p>Theo dõi tất cả các đơn đặt tour của bạn tại đây</p>
    </div>

    <c:choose>
        <c:when test="${not empty bookingList}">
            <div class="table-card">
                <table>
                    <thead>
                        <tr>
                            <th>Mã Vé</th>
                            <th>Tên Tour</th>
                            <th>Ngày Đặt</th>
                            <th>Số Khách</th>
                            <th>Tổng Tiền</th>
                            <th>Trạng Thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${bookingList}" var="b">
                            <tr>
                                <td>#${b.bookingId}</td>
                                <td class="tour-name">${tourDAO.getTourById(b.tourId).tourName}</td>
                                <td><fmt:formatDate value="${b.bookingDate}" pattern="dd/MM/yyyy"/></td>
                                <td><i class="fas fa-user" style="color:#A0A5C3;margin-right:4px;font-size:.75rem"></i> ${b.numberOfPeople}</td>
                                <td class="money"><fmt:formatNumber value="${b.totalPrice}" type="number" groupingUsed="true"/>đ</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${b.status == 'PENDING'}"><span class="badge badge-pending">${b.status}</span></c:when>
                                        <c:when test="${b.status == 'CONFIRMED'}"><span class="badge badge-confirmed">${b.status}</span></c:when>
                                        <c:when test="${b.status == 'COMPLETED'}"><span class="badge badge-completed">${b.status}</span></c:when>
                                        <c:when test="${b.status == 'CANCELLED'}"><span class="badge badge-cancelled">${b.status}</span></c:when>
                                        <c:otherwise><span class="badge badge-pending">${b.status}</span></c:otherwise>
                                    </c:choose>
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
                    <h3>Chưa có đơn đặt vé nào</h3>
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