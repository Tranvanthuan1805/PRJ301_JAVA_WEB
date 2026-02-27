<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">

<header class="navbar" id="mainNav">
    <div class="container">
        <div class="nav-content">
            <a href="${pageContext.request.contextPath}/" class="brand">
                <span class="accent">🏖️</span> DN HUB
            </a>

            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/">Trang Chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/tour">Khám Phá</a></li>
                <li><a href="${pageContext.request.contextPath}/my-orders">Đơn Hàng</a></li>
                <li><a href="${pageContext.request.contextPath}/pricing">Gói VIP</a></li>
            </ul>

            <div class="nav-actions">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="user-profile">
                            <c:if test="${sessionScope.user.role.roleName == 'ADMIN'}">
                                <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-primary" style="padding: 7px 16px; font-size: 0.78rem;">
                                    <i class="fas fa-bolt"></i> Admin
                                </a>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/profile" style="display:flex;align-items:center;gap:6px;">
                                <span style="width:32px;height:32px;border-radius:50%;background:var(--accent-gradient);display:flex;align-items:center;justify-content:center;font-weight:800;font-size:0.8rem;color:white;">
                                    ${sessionScope.user.username.substring(0,1).toUpperCase()}
                                </span>
                            </a>
                            <a href="${pageContext.request.contextPath}/logout" style="font-size:0.85rem;">
                                <i class="fas fa-sign-out-alt"></i>
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn-ghost" style="color: rgba(255,255,255,0.8);">Đăng Nhập</a>
                        <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-primary" style="padding: 8px 20px; font-size: 0.82rem;">
                            Đăng Ký <i class="fas fa-arrow-right"></i>
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</header>

<script>
    // Navbar scroll effect
    window.addEventListener('scroll', function() {
        const nav = document.getElementById('mainNav');
        if (window.scrollY > 60) {
            nav.classList.add('scrolled');
        } else {
            nav.classList.remove('scrolled');
        }
    });
</script>
