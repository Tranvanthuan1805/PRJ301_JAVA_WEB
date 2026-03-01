<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
    :root {
        --nav-bg: rgba(255, 255, 255, 0.95);
        --nav-text: #1B1F3B;
        --nav-accent: #FF6F61;
        --nav-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    }

    .header-main {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 2000;
        background: var(--nav-bg);
        backdrop-filter: blur(10px);
        box-shadow: var(--nav-shadow);
        transition: all 0.3s ease;
        padding: 0 20px;
    }

    .header-container {
        max-width: 1200px;
        margin: 0 auto;
        height: 70px;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .header-brand {
        font-size: 1.4rem;
        font-weight: 800;
        color: var(--nav-text);
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .header-brand span {
        font-size: 1.6rem;
    }

    .header-nav {
        display: flex;
        align-items: center;
        gap: 8px;
        margin: 0;
        padding: 0;
        list-style: none;
    }

    .header-nav li a {
        color: var(--nav-text);
        text-decoration: none;
        font-weight: 600;
        font-size: 0.95rem;
        padding: 8px 16px;
        border-radius: 99px;
        transition: all 0.25s ease;
        opacity: 0.8;
    }

    .header-nav li a:hover {
        opacity: 1;
        color: var(--nav-accent);
        background: rgba(255, 111, 97, 0.05);
    }

    .header-actions {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .btn-login {
        color: var(--nav-text);
        text-decoration: none;
        font-weight: 700;
        font-size: 0.9rem;
        opacity: 0.8;
        transition: 0.3s;
    }

    .btn-login:hover {
        opacity: 1;
        color: var(--nav-accent);
    }

    .btn-register {
        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
        color: white;
        text-decoration: none;
        font-weight: 700;
        font-size: 0.9rem;
        padding: 10px 24px;
        border-radius: 99px;
        box-shadow: 0 4px 15px rgba(255, 111, 97, 0.25);
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .btn-register:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(255, 111, 97, 0.4);
    }

    .user-tag {
        display: flex;
        align-items: center;
        gap: 10px;
        text-decoration: none;
        color: var(--nav-text);
        font-weight: 700;
    }

    .avatar-circle {
        width: 38px;
        height: 38px;
        border-radius: 50%;
        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1rem;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    .logout-link {
        color: #A0A5C3;
        font-size: 1.1rem;
        transition: color 0.3s;
    }

    .logout-link:hover {
        color: var(--nav-accent);
    }

    .admin-badge {
        background: #1B1F3B;
        color: white;
        padding: 5px 12px;
        border-radius: 99px;
        font-size: 0.75rem;
        font-weight: 800;
        text-decoration: none;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    /* Padding for page content since header is fixed */
    body {
        padding-top: 70px;
    }

    @media (max-width: 992px) {
        .header-nav {
            display: none; /* Quick fix for mobile, can be expanded to hamburger later */
        }
        .header-container {
            justify-content: space-between;
        }
    }
</style>

<header class="header-main">
    <div class="header-container">
        <a href="${pageContext.request.contextPath}/" class="header-brand">
            <span>🏖️</span> DN HUB
        </a>

        <ul class="header-nav">
            <li><a href="${pageContext.request.contextPath}/">Trang Chủ</a></li>
            <li><a href="${pageContext.request.contextPath}/tour">Khám Phá</a></li>
            <li><a href="${pageContext.request.contextPath}/my-orders">Đơn Hàng</a></li>
            <li><a href="${pageContext.request.contextPath}/pricing">Gói VIP</a></li>
            <li><a href="${pageContext.request.contextPath}/providers">NCC</a></li>
        </ul>

        <div class="header-actions">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <c:if test="${sessionScope.user.role.roleName == 'ADMIN'}">
                        <a href="${pageContext.request.contextPath}/admin/orders" class="admin-badge">
                            <i class="fas fa-bolt"></i> Admin
                        </a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/profile" class="user-tag">
                        <div class="avatar-circle">
                            ${sessionScope.user.username.substring(0,1).toUpperCase()}
                        </div>
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="logout-link">
                        <i class="fas fa-sign-out-alt"></i>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn-login">Đăng Nhập</a>
                    <a href="${pageContext.request.contextPath}/providers?action=register" class="btn-register">
                        Đăng Ký <i class="fas fa-arrow-right"></i>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>
