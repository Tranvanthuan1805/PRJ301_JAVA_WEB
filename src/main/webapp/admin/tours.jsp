<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Quản Lý Tour | Admin - DaNang Travel Hub</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<script src="https://cdn.tailwindcss.com"></script>
<script>tailwind.config={theme:{extend:{fontFamily:{sans:['Inter','sans-serif']}}}}</script>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Inter',sans-serif;background:#0a0f1e;color:#e2e8f0;min-height:100vh}
a{text-decoration:none;color:inherit}

/* Custom scrollbar */
::-webkit-scrollbar{width:5px;height:5px}
::-webkit-scrollbar-thumb{background:rgba(255,255,255,.1);border-radius:5px}
::-webkit-scrollbar-track{background:transparent}

/* Table row hover animation */
.tour-row{transition:all .15s ease}
.tour-row:hover{background:rgba(255,255,255,.03)!important}

/* Status badge glow */
.badge-active{animation:pulse-green 2s infinite}
@keyframes pulse-green{0%,100%{box-shadow:0 0 0 0 rgba(16,185,129,.3)}50%{box-shadow:0 0 0 4px rgba(16,185,129,0)}}

/* Card hover lift */
.stat-card{transition:all .25s ease}
.stat-card:hover{transform:translateY(-2px);box-shadow:0 8px 25px -5px rgba(0,0,0,.3)}
</style>
</head>
<body class="bg-[#0a0f1e]">

<!-- Sidebar -->
<jsp:include page="/common/_admin-sidebar.jsp"/>

<!-- Header -->
<c:set var="pageTitle" value="Quản Lý Tour" scope="request"/>
<c:set var="pageSubtitle" value="Quản lý danh sách tour du lịch Đà Nẵng" scope="request"/>
<jsp:include page="/common/_admin-header.jsp"/>

<!-- ═══════════════════════════════════════════════════════════════
     MAIN CONTENT
     ═══════════════════════════════════════════════════════════════ -->
<main class="lg:ml-[260px] pt-20 pb-10 px-4 lg:px-6 min-h-screen">

    <!-- ═══ STATS CARDS ═══ -->
    <div class="grid grid-cols-2 lg:grid-cols-4 gap-4 mb-6">

        <!-- Total Tours -->
        <div class="stat-card bg-[#111827]/80 border border-white/[.06] rounded-xl p-5">
            <div class="flex items-center justify-between mb-3">
                <div class="w-10 h-10 rounded-lg bg-blue-500/10 flex items-center justify-center">
                    <svg class="w-5 h-5 text-blue-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M3.055 11H5a2 2 0 012 2v1a2 2 0 002 2 2 2 0 012 2v2.945M8 3.935V5.5A2.5 2.5 0 0010.5 8h.5a2 2 0 012 2 2 2 0 104 0 2 2 0 012-2h1.064M15 20.488V18a2 2 0 012-2h3.064M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                </div>
                <span class="text-[.65rem] font-bold text-emerald-400 bg-emerald-500/10 px-2 py-1 rounded-md">+12%</span>
            </div>
            <div class="text-2xl font-extrabold text-white">${not empty totalTours ? totalTours : '0'}</div>
            <div class="text-[.75rem] text-slate-500 font-medium mt-0.5">Tổng số tour</div>
        </div>

        <!-- Active Tours -->
        <div class="stat-card bg-[#111827]/80 border border-white/[.06] rounded-xl p-5">
            <div class="flex items-center justify-between mb-3">
                <div class="w-10 h-10 rounded-lg bg-emerald-500/10 flex items-center justify-center">
                    <svg class="w-5 h-5 text-emerald-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                </div>
            </div>
            <div class="text-2xl font-extrabold text-white">${not empty activeTours ? activeTours : '0'}</div>
            <div class="text-[.75rem] text-slate-500 font-medium mt-0.5">Đang hoạt động</div>
        </div>

        <!-- Inactive Tours -->
        <div class="stat-card bg-[#111827]/80 border border-white/[.06] rounded-xl p-5">
            <div class="flex items-center justify-between mb-3">
                <div class="w-10 h-10 rounded-lg bg-amber-500/10 flex items-center justify-center">
                    <svg class="w-5 h-5 text-amber-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/></svg>
                </div>
            </div>
            <div class="text-2xl font-extrabold text-white">${not empty inactiveTours ? inactiveTours : '0'}</div>
            <div class="text-[.75rem] text-slate-500 font-medium mt-0.5">Đã tạm dừng</div>
        </div>

        <!-- Average Price -->
        <div class="stat-card bg-[#111827]/80 border border-white/[.06] rounded-xl p-5">
            <div class="flex items-center justify-between mb-3">
                <div class="w-10 h-10 rounded-lg bg-violet-500/10 flex items-center justify-center">
                    <svg class="w-5 h-5 text-violet-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                </div>
            </div>
            <div class="text-2xl font-extrabold text-white"><fmt:formatNumber value="${not empty avgPrice ? avgPrice : 0}" pattern="#,###"/>đ</div>
            <div class="text-[.75rem] text-slate-500 font-medium mt-0.5">Giá trung bình</div>
        </div>
    </div>

    <!-- ═══ TABLE HEADER: Title + Actions ═══ -->
    <div class="bg-[#111827]/80 border border-white/[.06] rounded-xl overflow-hidden">

        <!-- Toolbar -->
        <div class="p-4 lg:p-5 border-b border-white/[.06] flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3">
            <div>
                <h2 class="text-white font-bold text-lg flex items-center gap-2">
                    <svg class="w-5 h-5 text-blue-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M4 6h16M4 10h16M4 14h16M4 18h16"/></svg>
                    Danh Sách Tour
                </h2>
                <p class="text-xs text-slate-500 mt-0.5">Tổng cộng <span class="text-blue-400 font-semibold">${not empty totalTours ? totalTours : 0}</span> tour</p>
            </div>
            <div class="flex items-center gap-2 flex-wrap">
                <!-- Search -->
                <form action="${ctx}/admin/tours" method="get" class="flex items-center bg-white/[.04] border border-white/[.08] rounded-lg px-3 py-2 gap-2 focus-within:border-blue-500/40">
                    <svg class="w-4 h-4 text-slate-500" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/></svg>
                    <input type="text" name="search" placeholder="Tìm tour..." value="${search}" class="bg-transparent text-sm text-slate-300 placeholder-slate-600 outline-none w-32 lg:w-44">
                </form>
                <!-- Add Tour Button -->
                <a href="${ctx}/admin/tours?action=new" class="flex items-center gap-2 px-4 py-2.5 bg-blue-600 hover:bg-blue-500 text-white text-sm font-semibold rounded-lg transition shadow-lg shadow-blue-600/20">
                    <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5"><path d="M12 4v16m8-8H4"/></svg>
                    <span class="hidden sm:inline">Thêm Tour</span>
                </a>
            </div>
        </div>

        <!-- Table -->
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead>
                    <tr class="border-b border-white/[.06]">
                        <th class="px-5 py-3.5 text-left text-[.68rem] font-bold text-slate-500 uppercase tracking-wider">Tour</th>
                        <th class="px-5 py-3.5 text-left text-[.68rem] font-bold text-slate-500 uppercase tracking-wider hidden md:table-cell">Danh mục</th>
                        <th class="px-5 py-3.5 text-left text-[.68rem] font-bold text-slate-500 uppercase tracking-wider">Giá</th>
                        <th class="px-5 py-3.5 text-center text-[.68rem] font-bold text-slate-500 uppercase tracking-wider hidden lg:table-cell">Chỗ</th>
                        <th class="px-5 py-3.5 text-center text-[.68rem] font-bold text-slate-500 uppercase tracking-wider">Trạng thái</th>
                        <th class="px-5 py-3.5 text-right text-[.68rem] font-bold text-slate-500 uppercase tracking-wider">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="tour" items="${tours}" varStatus="s">
                        <tr class="tour-row border-b border-white/[.03] ${s.index % 2 == 0 ? '' : 'bg-white/[.01]'}">
                            <!-- Tour Info -->
                            <td class="px-5 py-4">
                                <div class="flex items-center gap-3.5">
                                    <img src="${not empty tour.imageUrl ? tour.imageUrl : 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=80&h=56&fit=crop'}"
                                         alt="${tour.tourName}" class="w-14 h-10 rounded-lg object-cover flex-shrink-0 ring-1 ring-white/10">
                                    <div class="min-w-0">
                                        <div class="text-sm font-semibold text-white truncate max-w-[200px] lg:max-w-[280px]">${tour.tourName}</div>
                                        <div class="text-[.72rem] text-slate-500 mt-0.5 flex items-center gap-1">
                                            <svg class="w-3 h-3" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/><path d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
                                            ${not empty tour.destination ? tour.destination : 'Đà Nẵng'}
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <!-- Category -->
                            <td class="px-5 py-4 hidden md:table-cell">
                                <span class="text-xs font-medium text-slate-400 bg-white/[.04] px-2.5 py-1 rounded-md">${not empty tour.category ? tour.category.categoryName : 'Tour'}</span>
                            </td>
                            <!-- Price -->
                            <td class="px-5 py-4">
                                <span class="text-sm font-bold text-blue-400"><fmt:formatNumber value="${tour.price}" pattern="#,###"/>đ</span>
                            </td>
                            <!-- Capacity -->
                            <td class="px-5 py-4 text-center hidden lg:table-cell">
                                <span class="text-sm text-slate-400">${tour.maxPeople}</span>
                            </td>
                            <!-- Status -->
                            <td class="px-5 py-4 text-center">
                                <c:choose>
                                    <c:when test="${tour.active}">
                                        <span class="badge-active inline-flex items-center gap-1 text-[.7rem] font-bold text-emerald-400 bg-emerald-500/10 px-2.5 py-1 rounded-full">
                                            <span class="w-1.5 h-1.5 rounded-full bg-emerald-400"></span> Active
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline-flex items-center gap-1 text-[.7rem] font-bold text-slate-500 bg-white/[.04] px-2.5 py-1 rounded-full">
                                            <span class="w-1.5 h-1.5 rounded-full bg-slate-500"></span> Inactive
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <!-- Actions -->
                            <td class="px-5 py-4">
                                <div class="flex items-center justify-end gap-1.5">
                                    <a href="${ctx}/admin/tours?action=edit&id=${tour.tourId}" title="Sửa"
                                       class="w-8 h-8 flex items-center justify-center rounded-lg text-slate-500 hover:text-blue-400 hover:bg-blue-500/10 transition">
                                        <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg>
                                    </a>
                                    <a href="${ctx}/admin/tours?action=view&id=${tour.tourId}" title="Xem"
                                       class="w-8 h-8 flex items-center justify-center rounded-lg text-slate-500 hover:text-emerald-400 hover:bg-emerald-500/10 transition">
                                        <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/></svg>
                                    </a>
                                    <a href="${ctx}/admin/tours?action=delete&id=${tour.tourId}" title="Xóa"
                                       onclick="return confirm('Bạn có chắc muốn xóa tour này?')"
                                       class="w-8 h-8 flex items-center justify-center rounded-lg text-slate-500 hover:text-red-400 hover:bg-red-500/10 transition">
                                        <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>

                    <!-- Empty State -->
                    <c:if test="${empty tours}">
                        <tr>
                            <td colspan="6" class="text-center py-16">
                                <div class="flex flex-col items-center">
                                    <div class="w-16 h-16 rounded-2xl bg-white/[.03] flex items-center justify-center mb-4">
                                        <svg class="w-8 h-8 text-slate-600" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path d="M3.055 11H5a2 2 0 012 2v1a2 2 0 002 2 2 2 0 012 2v2.945M8 3.935V5.5A2.5 2.5 0 0010.5 8h.5a2 2 0 012 2 2 2 0 104 0 2 2 0 012-2h1.064M15 20.488V18a2 2 0 012-2h3.064M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                                    </div>
                                    <p class="text-slate-500 font-medium">Chưa có tour nào</p>
                                    <a href="${ctx}/admin/tours?action=new" class="mt-3 text-blue-400 text-sm font-semibold hover:text-blue-300">+ Thêm tour đầu tiên</a>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <div class="p-4 border-t border-white/[.06] flex items-center justify-between">
                <p class="text-xs text-slate-500">Trang <span class="text-white font-semibold">${currentPage}</span> / ${totalPages}</p>
                <div class="flex items-center gap-1.5">
                    <a href="${ctx}/admin/tours?page=${currentPage-1}&search=${search}"
                       class="w-8 h-8 flex items-center justify-center rounded-lg border border-white/[.08] text-slate-500 ${currentPage <= 1 ? 'opacity-30 pointer-events-none' : 'hover:border-blue-500/40 hover:text-white'} transition">
                        <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path d="M15 19l-7-7 7-7"/></svg>
                    </a>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="${ctx}/admin/tours?page=${i}&search=${search}"
                           class="w-8 h-8 flex items-center justify-center rounded-lg text-xs font-semibold transition ${i == currentPage ? 'bg-blue-600 text-white' : 'border border-white/[.08] text-slate-500 hover:border-blue-500/40 hover:text-white'}">${i}</a>
                    </c:forEach>
                    <a href="${ctx}/admin/tours?page=${currentPage+1}&search=${search}"
                       class="w-8 h-8 flex items-center justify-center rounded-lg border border-white/[.08] text-slate-500 ${currentPage >= totalPages ? 'opacity-30 pointer-events-none' : 'hover:border-blue-500/40 hover:text-white'} transition">
                        <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path d="M9 5l7 7-7 7"/></svg>
                    </a>
                </div>
            </div>
        </c:if>
    </div>

</main>

</body>
</html>
