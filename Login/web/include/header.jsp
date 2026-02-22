<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- request: activeNav (home|tour|customer|booking), pageTitle --%>
<c:set var="nav" value="${empty activeNav ? 'home' : activeNav}" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty pageTitle ? 'VietAir' : pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vietair-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<header class="header">
    <div class="container">
        <div class="nav-brand">
            <div class="logo-container">
                <i class="fas fa-plane-departure logo-icon"></i>
                <span class="logo-text">VietAir</span>
            </div>
        </div>
        <nav class="nav-menu">
            <a href="${pageContext.request.contextPath}/" class="nav-item ${nav == 'home' ? 'active' : ''}">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/tour?action=list" class="nav-item ${nav == 'tour' ? 'active' : ''}">Tours</a>
            <a href="${pageContext.request.contextPath}/admin/customers" class="nav-item ${nav == 'customer' ? 'active' : ''}">Khách hàng</a>
        </nav>
    </div>
</header>
<main class="main-content">
