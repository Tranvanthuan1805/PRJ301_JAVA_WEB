<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Travel Cart | Da Nang Travel Hub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body style="background: #fdfdfd;">
    <jsp:include page="/common/_header.jsp" />

    <main class="container" style="margin-top: 60px; margin-bottom: 100px;">
        <h1 style="color: var(--primary); margin-bottom: 40px;">Shopping Cart</h1>

        <div style="display: grid; grid-template-columns: 1fr 350px; gap: 40px;">
            <!-- Cart Items -->
            <div>
                <c:choose>
                    <c:when test="${not empty sessionScope.cart_obj.items}">
                        <div style="display: grid; gap: 20px;">
                            <c:forEach items="${sessionScope.cart_obj.items}" var="item">
                                <div class="card animate-up" style="display: flex; gap: 20px; padding: 20px; align-items: center;">
                                    <img src="${item.tour.imageUrl}" style="width: 120px; height: 100px; border-radius: 8px; object-fit: cover;">
                                    <div style="flex: 1;">
                                        <h3 style="color: var(--primary); margin-bottom: 5px;">${item.tour.tourName}</h3>
                                        <p style="font-size: 0.9rem; color: var(--text-muted); margin-bottom: 10px;">
                                            <i class="far fa-calendar-alt"></i> Trip Date: <strong><fmt:formatDate value="${item.travelDate}" pattern="dd MMM yyyy" /></strong>
                                        </p>
                                        <div style="display: flex; align-items: center; gap: 20px;">
                                            <div style="display: flex; align-items: center; gap: 10px; border: 1px solid #ddd; padding: 5px 15px; border-radius: 20px;">
                                                <small>Quantity:</small>
                                                <strong>${item.quantity}</strong>
                                            </div>
                                            <div style="color: var(--success); font-weight: 700;">
                                                <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="$"/>
                                            </div>
                                        </div>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/customer/cart?action=remove&id=${item.tour.tourId}&date=${item.travelDate}" style="color: #fa5252; padding: 10px;">
                                        <i class="fas fa-trash-alt"></i>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="card" style="text-align: center; padding: 80px 0;">
                            <i class="fas fa-shopping-cart" style="font-size: 4rem; color: #eee; margin-bottom: 20px;"></i>
                            <h3>Your cart is empty</h3>
                            <p style="color: var(--text-muted); margin-bottom: 30px;">Discover the best of Da Nang and add some tours to your list!</p>
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Browse Tours</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Summary Sidebar -->
            <c:if test="${not empty sessionScope.cart_obj.items}">
                <div style="position: sticky; top: 100px; height: fit-content;">
                    <div class="card" style="background: white; border-top: 4px solid var(--primary);">
                        <h3 style="margin-bottom: 25px;">Order Summary</h3>
                        
                        <div style="display: flex; justify-content: space-between; margin-bottom: 15px;">
                            <span>Subtotal (${sessionScope.cart_obj.itemCount} items)</span>
                            <span style="font-weight: 600;">$<fmt:formatNumber value="${sessionScope.cart_obj.totalValue}" pattern="#,###.00" /></span>
                        </div>
                        <div style="display: flex; justify-content: space-between; margin-bottom: 15px;">
                            <span>Platform Fee</span>
                            <span style="color: var(--success); font-weight: 600;">FREE</span>
                        </div>
                        
                        <hr style="border: 0; border-top: 1px solid #eee; margin: 20px 0;">
                        
                        <div style="display: flex; justify-content: space-between; font-size: 1.4rem; font-weight: 800; color: var(--primary); margin-bottom: 30px;">
                            <span>Total</span>
                            <span>$<fmt:formatNumber value="${sessionScope.cart_obj.totalValue}" pattern="#,###.00" /></span>
                        </div>

                        <a href="${pageContext.request.contextPath}/customer/book?tourId=${sessionScope.cart_obj.items[0].tour.tourId}" class="btn btn-primary" style="width: 100%; display: block; text-align: center; margin-bottom: 15px;">Proceed to Checkout</a>
                        
                        <div style="background: rgba(43, 108, 176, 0.05); padding: 15px; border-radius: 8px; display: flex; gap: 10px; align-items: flex-start;">
                            <i class="fas fa-info-circle" style="color: var(--primary); margin-top: 3px;"></i>
                            <small style="color: #666;">Book with confidence. All our tours are verified by local experts.</small>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </main>

    <jsp:include page="/common/_footer.jsp" />
</body>
</html>
