<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Vé Của Tôi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <nav class="navbar navbar-dark bg-primary mb-4">
        <div class="container">
            <a class="navbar-brand" href="home">TRAVEL BOOKING</a>
            <a class="btn btn-light btn-sm" href="home">← Về trang chủ</a>
        </div>
    </nav>

    <div class="container">
        <h3 class="mb-3 text-center text-primary fw-bold">Lịch Sử Đặt Vé</h3>
        
        <div class="card shadow border-0">
            <div class="card-body p-0">
                <table class="table table-hover mb-0 text-center align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>Mã Vé</th>
                            <th class="text-start">Tên Tour</th>
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
                                <td class="text-start fw-bold text-primary">
                                    ${tourDAO.getTourById(b.tourId).tourName}
                                </td>
                                <td><fmt:formatDate value="${b.bookingDate}" pattern="dd/MM/yyyy"/></td>
                                <td>${b.numberOfPeople}</td>
                                <td class="text-danger fw-bold">
                                    <fmt:formatNumber value="${b.totalPrice}" type="currency" currencySymbol="₫"/>
                                </td>
                                <td>
                                    <span class="badge bg-warning text-dark">${b.status}</span>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty bookingList}">
                            <tr><td colspan="6" class="py-4 text-muted">Bạn chưa có đơn đặt vé nào.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>