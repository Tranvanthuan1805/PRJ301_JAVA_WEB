<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<header class="navbar">
    <div class="container nav-content">
        <a href="${pageContext.request.contextPath}/home" class="brand">
            <span style="color: #ff6b6b;">DN</span> HUB
        </a>
        
        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/tours">Tours</a></li>
            <li><a href="${pageContext.request.contextPath}/about">About Da Nang</a></li>
        </ul>

        <div class="nav-actions" style="display: flex; align-items: center; gap: 20px;">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <div class="user-profile" style="display: flex; align-items: center; gap: 10px;">
                        <span style="font-size: 0.9rem;">Welcome, <strong>${sessionScope.user.username}</strong></span>
                        <c:if test="${sessionScope.user.roleName == 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-primary" style="padding: 5px 15px; font-size: 0.8rem;">Admin</a>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/logout" style="color: #ff6b6b; font-size: 0.9rem;">Logout</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" style="margin-right: 15px;">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Join Now</a>
                </c:otherwise>
            </c:choose>
            
            <a href="${pageContext.request.contextPath}/customer/cart" style="position: relative;">
                <i class="fas fa-shopping-cart"></i>
                <span id="cart-count" style="position: absolute; top: -10px; right: -10px; background: #ff6b6b; color: white; border-radius: 50%; padding: 2px 6px; font-size: 0.7rem;">
                    ${not empty sessionScope.cart_count ? sessionScope.cart_count : 0}
                </span>
            </a>
        </div>
    </div>
</header>
<!-- Font Awesome for Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
