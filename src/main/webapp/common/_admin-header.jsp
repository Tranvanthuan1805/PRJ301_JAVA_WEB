<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!-- ═══ ADMIN TOP BAR ═══ -->
<header class="fixed top-0 right-0 left-0 lg:left-[260px] h-16 bg-[#0f1729]/80 backdrop-blur-xl border-b border-white/[.06] flex items-center justify-between px-4 lg:px-6 z-50">

    <!-- Left: Hamburger + Title -->
    <div class="flex items-center gap-3">
        <button onclick="openSidebar()" class="lg:hidden w-9 h-9 flex items-center justify-center rounded-lg text-slate-400 hover:text-white hover:bg-white/5 transition">
            <svg class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path d="M4 6h16M4 12h16M4 18h16"/></svg>
        </button>
        <div>
            <h1 class="text-white font-bold text-[.95rem]">${not empty pageTitle ? pageTitle : 'Dashboard'}</h1>
            <p class="text-slate-500 text-[.7rem] hidden sm:block">${not empty pageSubtitle ? pageSubtitle : 'Quản trị hệ thống du lịch'}</p>
        </div>
    </div>

    <!-- Right: Search + Notifications + Profile -->
    <div class="flex items-center gap-2">
        <!-- Search -->
        <div class="hidden md:flex items-center bg-white/[.04] border border-white/[.08] rounded-lg px-3 py-2 gap-2 w-56 focus-within:border-blue-500/40 transition">
            <svg class="w-4 h-4 text-slate-500 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/></svg>
            <input type="text" placeholder="Tìm kiếm..." class="bg-transparent text-sm text-slate-300 placeholder-slate-500 outline-none w-full">
        </div>

        <!-- Notifications -->
        <button class="relative w-9 h-9 flex items-center justify-center rounded-lg text-slate-400 hover:text-white hover:bg-white/5 transition">
            <svg class="w-[18px] h-[18px]" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/></svg>
            <span class="absolute top-1.5 right-1.5 w-2 h-2 rounded-full bg-red-500 ring-2 ring-[#0f1729]"></span>
        </button>

        <!-- Profile -->
        <div class="flex items-center gap-2.5 ml-1 pl-3 border-l border-white/[.08]">
            <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-blue-500 to-indigo-600 flex items-center justify-center text-white text-xs font-bold">
                ${not empty sessionScope.user ? sessionScope.user.username.substring(0,1).toUpperCase() : 'A'}
            </div>
            <div class="hidden sm:block">
                <div class="text-xs font-semibold text-white leading-tight">${not empty sessionScope.user ? sessionScope.user.username : 'Admin'}</div>
                <div class="text-[.65rem] text-slate-500">Admin</div>
            </div>
        </div>
    </div>
</header>
