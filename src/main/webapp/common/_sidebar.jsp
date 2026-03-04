<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<aside class="sidebar">
    <div class="logo"><img src="${pageContext.request.contextPath}/images/logo.png" style="width:36px;height:36px;border-radius:50%;display:inline-block;vertical-align:middle;margin-right:8px"><span style="vertical-align:middle"><span class="a">ez</span>travel</span> <span class="badge-admin">ADMIN</span></div>
    <nav>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="${requestScope.activePage == 'dashboard' ? 'active' : ''}"><i class="fas fa-chart-pie"></i> Tổng Quan</a>
        <a href="${pageContext.request.contextPath}/admin/customers" class="${requestScope.activePage == 'customers' ? 'active' : ''}"><i class="fas fa-users"></i> Khách Hàng</a>
        <div class="nav-label">Quản lý</div>
        <a href="${pageContext.request.contextPath}/admin/tours" class="${requestScope.activePage == 'tours' ? 'active' : ''}"><i class="fas fa-plane-departure"></i> Quản lý Tours</a>
        <a href="${pageContext.request.contextPath}/admin/tour-history" class="${requestScope.activePage == 'history' ? 'active' : ''}"><i class="fas fa-history"></i> Lịch sử</a>
        <a href="${pageContext.request.contextPath}/admin/orders" class="${requestScope.activePage == 'orders' ? 'active' : ''}"><i class="fas fa-shopping-bag"></i> Đơn Hàng</a>
        <div class="nav-label">Hệ thống</div>
        <a href="${pageContext.request.contextPath}/explore"><i class="fas fa-eye"></i> Xem Website</a>
    </nav>
    <div class="user-box">
        <div class="avatar">${sessionScope.user.username.substring(0,1).toUpperCase()}</div>
        <div>
            <div class="uname">${sessionScope.user.username}</div>
            <div class="urole">Quản Trị Viên</div>
        </div>
    </div>
</aside>

<style>
    .sidebar{position:fixed!important;left:0!important;top:0!important;width:260px!important;height:100vh!important;background:#0B1120!important;border-right:1px solid rgba(255,255,255,.06)!important;padding:24px 16px!important;display:flex!important;flex-direction:column!important;z-index:100!important}
    .sidebar .logo{font-family:'Playfair Display',serif!important;font-size:1.4rem!important;font-weight:800!important;color:#fff!important;padding:0 12px 24px!important;border-bottom:1px solid rgba(255,255,255,.06)!important;margin-bottom:16px!important}
    .sidebar .logo .a{color:#60A5FA!important}
    .sidebar .badge-admin{display:inline-block!important;padding:2px 8px!important;border-radius:6px!important;background:rgba(239,68,68,.15)!important;color:#F87171!important;font-size:.65rem!important;font-weight:700!important;font-family:'Inter',sans-serif!important;margin-left:6px!important;vertical-align:middle!important}
    .sidebar nav{flex:1!important}
    .sidebar nav a{display:flex!important;align-items:center!important;gap:12px!important;padding:11px 16px!important;border-radius:10px!important;color:rgba(255,255,255,.5)!important;font-size:.88rem!important;font-weight:500!important;transition:.3s!important;margin-bottom:2px!important;text-decoration:none!important}
    .sidebar nav a:hover{color:#fff!important;background:rgba(255,255,255,.06)!important}
    .sidebar nav a.active{color:#fff!important;background:rgba(59,130,246,.15)!important;border:1px solid rgba(59,130,246,.2)!important}
    .sidebar nav a.active i{color:#60A5FA!important}
    .sidebar nav a i{width:20px!important;text-align:center!important;font-size:.85rem!important}
    .sidebar .nav-label{font-size:.68rem!important;text-transform:uppercase!important;letter-spacing:1.5px!important;color:rgba(255,255,255,.2)!important;font-weight:700!important;padding:16px 16px 8px!important;margin-top:8px!important}
    .sidebar .user-box{padding:16px!important;border-top:1px solid rgba(255,255,255,.06)!important;display:flex!important;align-items:center!important;gap:12px!important}
    .sidebar .user-box .avatar{width:38px!important;height:38px!important;border-radius:10px!important;background:linear-gradient(135deg,#EF4444,#F87171)!important;display:flex!important;align-items:center!important;justify-content:center!important;color:#fff!important;font-weight:700!important;font-size:.85rem!important}
    .sidebar .user-box .uname{font-size:.85rem!important;color:#fff!important;font-weight:600!important}
    .sidebar .user-box .urole{font-size:.72rem!important;color:rgba(255,255,255,.4)!important}
</style>
