<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Giỏ Hàng | Travel Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>Giỏ Hàng Của Bạn</h2>
        <table class="table table-bordered mt-3">
            <thead>
                <tr>
                    <th>Tour</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Thành tiền</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${sessionScope.cart}" var="item">
                <tr>
                    <td>${item.tour.tourName}</td>
                    <td><fmt:formatNumber value="${item.tour.price}" type="currency"/></td>
                    <td>${item.quantity}</td>
                    <td><fmt:formatNumber value="${item.totalPrice}" type="currency"/></td>
                    <td>
                        <a href="cart?action=remove&id=${item.tour.tourId}" class="btn btn-danger btn-sm">Xóa</a>
                    </td>
                </tr>
                </c:forEach>
                <c:if test="${empty sessionScope.cart}">
                    <tr><td colspan="5" class="text-center">Giỏ hàng trống</td></tr>
                </c:if>
            </tbody>
        </table>
        
        <div class="text-end">
             <h4>Tổng cộng: <fmt:formatNumber value="${cartTotal}" type="currency"/></h4>
             <a href="checkout" class="btn btn-success btn-lg">Thanh Toán</a>
             <a href="home" class="btn btn-secondary btn-lg">Tiếp tục xem</a>
        </div>
    </div>
</body>
</html>
