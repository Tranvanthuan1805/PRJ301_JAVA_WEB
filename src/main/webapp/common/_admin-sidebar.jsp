<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!-- ═══════════════════════════════════════════════════════════════════
     ADMIN SIDEBAR — DaNang Travel Hub
     Professional dark theme sidebar with collapsible sub-menus
     ═══════════════════════════════════════════════════════════════════ -->
<aside id="adminSidebar" class="fixed left-0 top-0 h-screen w-[260px] bg-[#0f1729] border-r border-white/[.06] flex flex-col z-[100] transition-transform duration-300 lg:translate-x-0 -translate-x-full">

    <!-- Logo -->
    <div class="px-6 py-5 border-b border-white/[.06]">
        <a href="${ctx}/admin/dashboard" class="flex items-center gap-3">
            <div class="w-9 h-9 rounded-xl bg-gradient-to-br from-blue-500 to-blue-600 flex items-center justify-center text-white text-sm font-bold shadow-lg shadow-blue-500/20">ez</div>
            <div>
                <span class="text-white font-bold text-[1.05rem] tracking-tight">eztravel</span>
                <span class="ml-2 px-2 py-0.5 rounded text-[.6rem] font-bold bg-red-500/15 text-red-400 uppercase tracking-wider">Admin</span>
            </div>
        </a>
    </div>

    <!-- Navigation -->
    <nav class="flex-1 overflow-y-auto py-4 px-3 space-y-1 sidebar-scroll">

        <!-- Dashboard -->
        <a href="${ctx}/admin/dashboard"
           class="nav-link ${requestScope.activePage == 'dashboard' ? 'active' : ''}">
            <svg class="w-[18px] h-[18px]" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/></svg>
            <span>Dashboard</span>
        </a>

        <!-- Tour Management -->
        <div class="nav-group">
            <button onclick="toggleMenu(this)" class="nav-link w-full ${requestScope.activePage == 'tours' || requestScope.activePage == 'tour-form' || requestScope.activePage == 'history' || requestScope.activePage == 'analytics' ? 'active' : ''}">
                <svg class="w-[18px] h-[18px]" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M3.055 11H5a2 2 0 012 2v1a2 2 0 002 2 2 2 0 012 2v2.945M8 3.935V5.5A2.5 2.5 0 0010.5 8h.5a2 2 0 012 2 2 2 0 104 0 2 2 0 012-2h1.064M15 20.488V18a2 2 0 012-2h3.064M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                <span>Quản Lý Tour</span>
                <svg class="nav-arrow w-3.5 h-3.5 ml-auto transition-transform duration-200" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5"><path d="M19 9l-7 7-7-7"/></svg>
            </button>
            <div class="nav-sub ${requestScope.activePage == 'tours' || requestScope.activePage == 'tour-form' || requestScope.activePage == 'history' || requestScope.activePage == 'analytics' ? 'open' : ''}">
                <a href="${ctx}/admin/tours" class="${requestScope.activePage == 'tours' ? 'active' : ''}">Danh Sách Tour</a>
                <a href="${ctx}/admin/tours?action=new" class="${requestScope.activePage == 'tour-form' ? 'active' : ''}">Thêm Tour Mới</a>
                <a href="${ctx}/admin/tours?action=history" class="${requestScope.activePage == 'history' ? 'active' : ''}">Lịch Sử Tour</a>
                <a href="${ctx}/admin/tours?action=analytics" class="${requestScope.activePage == 'analytics' ? 'active' : ''}">Phân Tích Tour</a>
            </div>
        </div>

        <!-- Booking -->
        <div class="nav-group">
            <button onclick="toggleMenu(this)" class="nav-link w-full ${requestScope.activePage == 'orders' ? 'active' : ''}">
                <svg class="w-[18px] h-[18px]" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/></svg>
                <span>Booking</span>
                <svg class="nav-arrow w-3.5 h-3.5 ml-auto transition-transform duration-200" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5"><path d="M19 9l-7 7-7-7"/></svg>
            </button>
            <div class="nav-sub ${requestScope.activePage == 'orders' ? 'open' : ''}">
                <a href="${ctx}/admin/orders" class="${requestScope.activePage == 'orders' ? 'active' : ''}">Tất Cả Đơn</a>
                <a href="${ctx}/admin/orders?status=pending">Chờ Xử Lý</a>
                <a href="${ctx}/admin/orders?status=confirmed">Đã Xác Nhận</a>
                <a href="${ctx}/admin/orders?status=completed">Hoàn Thành</a>
                <a href="${ctx}/admin/orders?status=cancelled">Đã Hủy</a>
            </div>
        </div>

        <!-- Customers -->
        <a href="${ctx}/admin/customers" class="nav-link ${requestScope.activePage == 'users' ? 'active' : ''}">
            <svg class="w-[18px] h-[18px]" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
            <span>Khách Hàng</span>
        </a>

        <!-- Consultations -->
        <a href="${ctx}/admin/consultations" class="nav-link ${requestScope.activePage == 'consultations' ? 'active' : ''}">
            <svg class="w-[18px] h-[18px]" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M8 10h.01M12 10h.01M16 10h.01M9 16H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-5l-5 5v-5z"/></svg>
            <span>Tư Vấn</span>
        </a>

        <div class="my-3 mx-3 border-t border-white/[.06]"></div>
        <p class="px-4 pb-1 text-[.65rem] font-semibold uppercase tracking-[1.5px] text-slate-500">Phân Tích</p>

        <!-- Analytics -->
        <a href="${ctx}/admin/analytics" class="nav-link ${requestScope.activePage == 'analytics-page' ? 'active' : ''}">
            <svg class="w-[18px] h-[18px]" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/></svg>
            <span>Doanh Thu</span>
        </a>

        <!-- Providers -->
        <a href="${ctx}/admin/providers" class="nav-link ${requestScope.activePage == 'providers' ? 'active' : ''}">
            <svg class="w-[18px] h-[18px]" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/></svg>
            <span>Đối Tác</span>
        </a>

        <div class="my-3 mx-3 border-t border-white/[.06]"></div>
        <p class="px-4 pb-1 text-[.65rem] font-semibold uppercase tracking-[1.5px] text-slate-500">Hệ Thống</p>

        <!-- View Website -->
        <a href="${ctx}/" class="nav-link" target="_blank">
            <svg class="w-[18px] h-[18px]" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/></svg>
            <span>Xem Website</span>
        </a>

        <!-- Logout -->
        <a href="${ctx}/logout" class="nav-link text-red-400/60 hover:text-red-400 hover:bg-red-500/10">
            <svg class="w-[18px] h-[18px]" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/></svg>
            <span>Đăng Xuất</span>
        </a>
    </nav>

    <!-- User Box -->
    <div class="px-5 py-4 border-t border-white/[.06]">
        <div class="flex items-center gap-3">
            <div class="w-9 h-9 rounded-lg bg-gradient-to-br from-blue-500 to-indigo-600 flex items-center justify-center text-white font-bold text-sm flex-shrink-0">
                ${not empty sessionScope.user ? sessionScope.user.username.substring(0,1).toUpperCase() : 'A'}
            </div>
            <div class="min-w-0">
                <div class="text-sm font-semibold text-white truncate">${not empty sessionScope.user ? sessionScope.user.username : 'Admin'}</div>
                <div class="text-[.7rem] text-slate-500">Quản trị viên</div>
            </div>
        </div>
    </div>
</aside>

<!-- Mobile Overlay -->
<div id="sidebarOverlay" class="fixed inset-0 bg-black/50 z-[99] hidden lg:hidden" onclick="closeSidebar()"></div>

<style>
/* Sidebar Navigation Styles */
.nav-link{display:flex;align-items:center;gap:11px;padding:9px 14px;border-radius:8px;color:rgba(148,163,184,.8);font-size:.855rem;font-weight:500;transition:all .2s;cursor:pointer;border:none;background:none;text-align:left;text-decoration:none;border-left:3px solid transparent;margin:1px 0}
.nav-link:hover{color:#e2e8f0;background:rgba(255,255,255,.04)}
.nav-link.active{color:#fff;background:rgba(59,130,246,.12);border-left-color:#3b82f6}
.nav-link.active svg{color:#60a5fa}

.nav-sub{max-height:0;overflow:hidden;transition:max-height .3s ease;padding-left:14px}
.nav-sub.open{max-height:300px}
.nav-sub a{display:block;padding:7px 14px 7px 32px;font-size:.8rem;color:rgba(148,163,184,.6);border-radius:6px;transition:.2s;text-decoration:none;position:relative}
.nav-sub a::before{content:'';position:absolute;left:16px;top:50%;width:4px;height:4px;border-radius:50%;background:currentColor;transform:translateY(-50%);opacity:.4}
.nav-sub a:hover,.nav-sub a.active{color:#e2e8f0;background:rgba(255,255,255,.03)}
.nav-sub a.active{color:#60a5fa}
.nav-sub a.active::before{background:#60a5fa;opacity:1}

.nav-group .nav-link.active .nav-arrow,
.nav-sub.open ~ .nav-link .nav-arrow,
button.nav-link[aria-expanded="true"] .nav-arrow{transform:rotate(180deg)}

.sidebar-scroll::-webkit-scrollbar{width:3px}
.sidebar-scroll::-webkit-scrollbar-thumb{background:rgba(255,255,255,.08);border-radius:3px}

@media(max-width:1023px){
    #adminSidebar.open{transform:translateX(0)}
    #sidebarOverlay.open{display:block}
}
</style>

<script>
function toggleMenu(btn){
    var sub=btn.nextElementSibling;
    if(!sub)return;
    var isOpen=sub.classList.contains('open');
    sub.classList.toggle('open');
    var arrow=btn.querySelector('.nav-arrow');
    if(arrow)arrow.style.transform=isOpen?'':'rotate(180deg)';
}
function openSidebar(){
    document.getElementById('adminSidebar').classList.add('open');
    document.getElementById('sidebarOverlay').classList.add('open');
    document.body.style.overflow='hidden';
}
function closeSidebar(){
    document.getElementById('adminSidebar').classList.remove('open');
    document.getElementById('sidebarOverlay').classList.remove('open');
    document.body.style.overflow='';
}
// Auto-open sub-menus that have active items
document.addEventListener('DOMContentLoaded',function(){
    document.querySelectorAll('.nav-sub.open').forEach(function(sub){
        var btn=sub.previousElementSibling;
        if(btn){var a=btn.querySelector('.nav-arrow');if(a)a.style.transform='rotate(180deg)';}
    });
});
</script>
