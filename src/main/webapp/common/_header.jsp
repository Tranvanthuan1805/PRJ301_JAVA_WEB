<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
/* ═══ TOP BAR ═══ */
.top-bar{background:#1E293B;color:#94A3B8;font-size:.78rem;height:36px;display:flex;align-items:center;position:fixed;top:0;left:0;right:0;z-index:2001;padding:0 20px}
.top-bar-inner{max-width:1200px;margin:0 auto;width:100%;display:flex;align-items:center;justify-content:space-between}
.top-bar-left{display:flex;align-items:center;gap:18px}
.top-bar-left a,.top-bar-left span{color:#94A3B8;text-decoration:none;display:flex;align-items:center;gap:5px;transition:.3s}
.top-bar-left a:hover{color:#fff}
.top-bar-left i{color:#60A5FA;font-size:.72rem}
.top-bar-right{display:flex;align-items:center;gap:14px}
.top-bar-social{display:flex;gap:10px}
.top-bar-social a{color:#64748B;font-size:.8rem;transition:.3s}
.top-bar-social a:hover{color:#60A5FA}

/* ═══ LANGUAGE SELECTOR ═══ */
.lang-selector{position:relative}
.lang-current{display:flex;align-items:center;gap:5px;padding:3px 10px;border-radius:4px;cursor:pointer;color:#94A3B8;font-size:.78rem;font-weight:600;border:1px solid rgba(255,255,255,.1);transition:.3s}
.lang-current:hover{border-color:#60A5FA;color:#fff}
.lang-current img{width:16px;height:12px;border-radius:2px}
.lang-dropdown{position:absolute;top:100%;right:0;background:#1E293B;border:1px solid rgba(255,255,255,.1);border-radius:6px;min-width:150px;display:none;z-index:9999;margin-top:4px;box-shadow:0 8px 24px rgba(0,0,0,.3)}
.lang-selector:hover .lang-dropdown{display:block}
.lang-option{display:flex;align-items:center;gap:8px;padding:8px 12px;cursor:pointer;color:#94A3B8;font-size:.78rem;transition:.2s}
.lang-option:hover{background:rgba(59,130,246,.1);color:#fff}
.lang-option.active{color:#60A5FA;font-weight:700}
.lang-option img{width:18px;height:13px;border-radius:2px}

/* ═══ NAVIGATION ═══ */
.hdr-nav{position:fixed;top:36px;left:0;right:0;z-index:2000;background:rgba(255,255,255,.97);backdrop-filter:blur(12px);box-shadow:0 4px 24px rgba(0,0,0,.06);padding:0 20px;transition:all .3s ease}
.hdr-nav-inner{max-width:1200px;margin:0 auto;height:64px;display:flex;align-items:center;justify-content:space-between}
.logo{font-family:'Playfair Display',serif;font-size:1.3rem;font-weight:800;color:#1E293B;text-decoration:none;display:flex;align-items:center;gap:8px}
.logo img{height:36px;width:auto}
.logo .ez{color:#2563EB}

.nav-links{display:flex;align-items:center;gap:4px;list-style:none;margin:0;padding:0}
.nav-links li a{color:#475569;text-decoration:none;font-weight:600;font-size:.88rem;padding:8px 16px;border-radius:99px;transition:all .25s}
.nav-links li a:hover,.nav-links li a.active{color:#2563EB;background:rgba(37,99,235,.06)}

.hdr-actions{display:flex;align-items:center;gap:12px}
.btn-hdr-login{color:#475569;font-weight:700;font-size:.88rem;text-decoration:none;transition:.3s}
.btn-hdr-login:hover{color:#2563EB}
.btn-hdr-register{background:linear-gradient(135deg,#2563EB,#3B82F6);color:#fff;text-decoration:none;font-weight:700;font-size:.88rem;padding:9px 22px;border-radius:99px;box-shadow:0 4px 14px rgba(37,99,235,.3);transition:all .3s;display:flex;align-items:center;gap:6px}
.btn-hdr-register:hover{transform:translateY(-2px);box-shadow:0 6px 20px rgba(37,99,235,.4)}

.user-tag{display:flex;align-items:center;gap:10px;text-decoration:none;color:#1E293B;font-weight:700}
.avatar-circle{width:36px;height:36px;border-radius:50%;background:linear-gradient(135deg,#2563EB,#60A5FA);color:#fff;display:flex;align-items:center;justify-content:center;font-size:.9rem;font-weight:700;box-shadow:0 3px 10px rgba(37,99,235,.2)}
.logout-link{color:#94A3B8;font-size:1rem;transition:.3s}
.logout-link:hover{color:#EF4444}
.admin-badge{background:#1E293B;color:#fff;padding:5px 12px;border-radius:99px;font-size:.72rem;font-weight:800;text-decoration:none;letter-spacing:.5px}
.cart-link{position:relative;color:#475569;font-size:1.1rem;transition:.3s;text-decoration:none}
.cart-link:hover{color:#2563EB}
.cart-badge{position:absolute;top:-6px;right:-8px;background:#EF4444;color:#fff;font-size:.6rem;font-weight:800;min-width:16px;height:16px;border-radius:50%;display:flex;align-items:center;justify-content:center;border:2px solid #fff}

body{padding-top:100px}

@media(max-width:992px){
    .top-bar-left span:nth-child(n+3){display:none}
    .nav-links{display:none}
    .hdr-nav-inner{justify-content:space-between}
}
@media(max-width:576px){.top-bar{display:none}body{padding-top:64px}.hdr-nav{top:0}}
</style>

<!-- ═══ TOP BAR ═══ -->
<div class="top-bar">
    <div class="top-bar-inner">
        <div class="top-bar-left">
            <a href="tel:0335111783"><i class="fas fa-phone-alt"></i> <span data-i18n="topbar.phone">0335 111 783</span></a>
            <span><i class="fas fa-clock"></i> <span data-i18n="topbar.hours">T2-CN: 8:00 - 22:00</span></span>
            <a href="mailto:contact@eztravel.vn"><i class="fas fa-envelope"></i> contact@eztravel.vn</a>
        </div>
        <div class="top-bar-right">
            <div class="top-bar-social">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-youtube"></i></a>
                <a href="#"><i class="fab fa-tiktok"></i></a>
            </div>
            <!-- Language Selector -->
            <div class="lang-selector" id="langSelector">
                <div class="lang-current" id="langCurrent">
                    <img src="https://flagcdn.com/w20/vn.png" alt="VN" id="langFlag">
                    <span id="langLabel">VI</span>
                    <i class="fas fa-chevron-down" style="font-size:.55rem"></i>
                </div>
                <div class="lang-dropdown" id="langDropdown">
                    <div class="lang-option active" data-lang="vi">
                        <img src="https://flagcdn.com/w20/vn.png" alt="VN"> Tiếng Việt
                    </div>
                    <div class="lang-option" data-lang="en">
                        <img src="https://flagcdn.com/w20/gb.png" alt="EN"> English
                    </div>
                    <div class="lang-option" data-lang="ko">
                        <img src="https://flagcdn.com/w20/kr.png" alt="KO"> 한국어
                    </div>
                    <div class="lang-option" data-lang="ja">
                        <img src="https://flagcdn.com/w20/jp.png" alt="JA"> 日本語
                    </div>
                    <div class="lang-option" data-lang="zh">
                        <img src="https://flagcdn.com/w20/cn.png" alt="ZH"> 中文
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ═══ NAVIGATION ═══ -->
<nav class="hdr-nav">
    <div class="hdr-nav-inner">
        <a href="${pageContext.request.contextPath}/" class="logo">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="eztravel" onerror="this.style.display='none'">
            <span><span class="ez">ez</span>travel</span>
        </a>

        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/" data-i18n="nav.home">Trang Chủ</a></li>
            <li><a href="${pageContext.request.contextPath}/tour" data-i18n="nav.explore">Khám Phá</a></li>
            <li><a href="${pageContext.request.contextPath}/my-orders" data-i18n="nav.orders">Đơn Hàng</a></li>
            <li><a href="${pageContext.request.contextPath}/history" data-i18n="nav.history">Lịch Sử</a></li>
            <li><a href="${pageContext.request.contextPath}/provider">Nhà Cung Cấp</a></li>
        </ul>

        <div class="hdr-actions">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <c:if test="${sessionScope.user.role.roleName == 'ADMIN'}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="admin-badge">
                            <i class="fas fa-bolt"></i> Admin
                        </a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/cart" class="cart-link" title="Giỏ hàng">
                        <i class="fas fa-shopping-cart"></i>
                        <c:if test="${not empty sessionScope.cart}">
                            <span class="cart-badge">${sessionScope.cart.size()}</span>
                        </c:if>
                    </a>
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
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn-hdr-login" data-i18n="nav.login">Đăng Nhập</a>
                    <a href="${pageContext.request.contextPath}/register.jsp" class="btn-hdr-register">
                        <span data-i18n="nav.register">Đăng Ký</span> <i class="fas fa-arrow-right"></i>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<script src="${pageContext.request.contextPath}/js/i18n.js"></script>
