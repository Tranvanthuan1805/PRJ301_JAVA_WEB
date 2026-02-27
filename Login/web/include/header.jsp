<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- Header Include: set activeNav (home|tour|customer|booking) + pageTitle before include --%>
<c:set var="nav" value="${empty activeNav ? 'home' : activeNav}" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty pageTitle ? 'VietAir - Tour Du Lịch Đà Nẵng' : pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vietair-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<header class="header">
    <div class="container">
        <div class="nav-brand">
            <a href="${pageContext.request.contextPath}/" class="logo-container">
                <i class="fas fa-plane-departure logo-icon"></i>
                <span class="logo-text">VietAir</span>
            </a>
        </div>

        <!-- Hamburger for mobile -->
        <button class="nav-toggle" id="navToggle" aria-label="Menu">
            <span></span><span></span><span></span>
        </button>

        <nav class="nav-menu" id="navMenu">
            <a href="${pageContext.request.contextPath}/" class="nav-item ${nav == 'home' ? 'active' : ''}">
                <i class="fas fa-home"></i> Trang chủ
            </a>
            <a href="${pageContext.request.contextPath}/tour?action=list" class="nav-item ${nav == 'tour' ? 'active' : ''}">
                <i class="fas fa-compass"></i> Tours
            </a>
            <c:if test="${sessionScope.role == 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/admin/customers" class="nav-item ${nav == 'customer' ? 'active' : ''}">
                    <i class="fas fa-users"></i> Khách hàng
                </a>
            </c:if>
            <c:if test="${not empty sessionScope.username}">
                <a href="${pageContext.request.contextPath}/profile" class="nav-item ${nav == 'profile' ? 'active' : ''}">
                    <i class="fas fa-user"></i> Profile
                </a>
            </c:if>
        </nav>

        <div class="nav-actions">
            <c:choose>
                <c:when test="${not empty sessionScope.username}">
                    <span class="user-badge">${sessionScope.username}</span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
                        <i class="fas fa-sign-out-alt"></i> Đăng xuất
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn-login">
                        <i class="fas fa-sign-in-alt"></i> Đăng nhập
                    </a>
                    <a href="${pageContext.request.contextPath}/register.jsp" class="btn-register-nav">
                        <i class="fas fa-user-plus"></i> Đăng ký
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>
<main class="main-content">
