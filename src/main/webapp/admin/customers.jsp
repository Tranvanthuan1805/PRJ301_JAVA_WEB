<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Khách Hàng | Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>tailwind.config={theme:{extend:{fontFamily:{sans:['Inter','sans-serif']}}}}</script>
    <style>
    body{font-family:'Inter',sans-serif}
    .row-hover{transition:all .15s}
    .row-hover:hover{background:rgba(255,255,255,.03)!important}
    </style>
</head>
<body class="bg-[#0a0f1e] text-slate-200 min-h-screen">

<jsp:include page="/common/_admin-sidebar.jsp"/>
<c:set var="pageTitle" value="Khách Hàng" scope="request"/>
<c:set var="pageSubtitle" value="Quản lý thông tin khách hàng" scope="request"/>
<jsp:include page="/common/_admin-header.jsp"/>

<main class="lg:ml-[260px] pt-20 pb-10 px-4 lg:px-6">

    <!-- Stats -->
    <div class="grid grid-cols-3 gap-4 mb-6">
        <div class="bg-[#111827]/80 border border-white/[.06] rounded-xl p-5">
            <div class="w-10 h-10 rounded-lg bg-blue-500/10 flex items-center justify-center mb-3">
                <svg class="w-5 h-5 text-blue-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
            </div>
            <div class="text-2xl font-extrabold text-white">${totalCustomers}</div>
            <div class="text-xs text-slate-500 font-medium mt-1">Tổng khách hàng</div>
        </div>
        <div class="bg-[#111827]/80 border border-white/[.06] rounded-xl p-5">
            <div class="w-10 h-10 rounded-lg bg-emerald-500/10 flex items-center justify-center mb-3">
                <svg class="w-5 h-5 text-emerald-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
            </div>
            <div class="text-2xl font-extrabold text-white">${activeCount}</div>
            <div class="text-xs text-slate-500 font-medium mt-1">Đang hoạt động</div>
        </div>
        <div class="bg-[#111827]/80 border border-white/[.06] rounded-xl p-5">
            <div class="w-10 h-10 rounded-lg bg-violet-500/10 flex items-center justify-center mb-3">
                <svg class="w-5 h-5 text-violet-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"/></svg>
            </div>
            <div class="text-2xl font-extrabold text-white">${newThisMonth}</div>
            <div class="text-xs text-slate-500 font-medium mt-1">Mới trong tháng</div>
        </div>
    </div>

    <!-- Table Card -->
    <div class="bg-[#111827]/80 border border-white/[.06] rounded-xl overflow-hidden">
        <!-- Toolbar -->
        <div class="p-4 lg:p-5 border-b border-white/[.06] flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3">
            <h2 class="text-white font-bold text-lg">Danh Sách Khách Hàng</h2>
            <form class="flex items-center gap-2" action="${ctx}/admin/customers" method="get">
                <div class="flex items-center bg-white/[.04] border border-white/[.08] rounded-lg px-3 py-2 gap-2 focus-within:border-blue-500/40">
                    <svg class="w-4 h-4 text-slate-500" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/></svg>
                    <input type="text" name="keyword" value="${keyword}" placeholder="Tìm tên, email..." class="bg-transparent text-sm text-slate-300 placeholder-slate-600 outline-none w-40">
                </div>
                <select name="status" class="bg-white/[.04] border border-white/[.08] rounded-lg px-3 py-2 text-sm text-slate-300 outline-none cursor-pointer">
                    <option value="">Tất cả</option>
                    <option value="active" ${filterStatus == 'active' ? 'selected' : ''}>Hoạt động</option>
                    <option value="inactive" ${filterStatus == 'inactive' ? 'selected' : ''}>Tạm ngưng</option>
                    <option value="banned" ${filterStatus == 'banned' ? 'selected' : ''}>Bị khóa</option>
                </select>
                <button type="submit" class="px-4 py-2.5 bg-blue-600 hover:bg-blue-500 text-white text-sm font-semibold rounded-lg transition">Tìm</button>
            </form>
        </div>

        <!-- Table -->
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead>
                    <tr class="border-b border-white/[.06]">
                        <th class="px-5 py-3.5 text-left text-[.68rem] font-bold text-slate-500 uppercase tracking-wider">Khách hàng</th>
                        <th class="px-5 py-3.5 text-left text-[.68rem] font-bold text-slate-500 uppercase tracking-wider hidden md:table-cell">Email</th>
                        <th class="px-5 py-3.5 text-left text-[.68rem] font-bold text-slate-500 uppercase tracking-wider hidden lg:table-cell">SĐT</th>
                        <th class="px-5 py-3.5 text-center text-[.68rem] font-bold text-slate-500 uppercase tracking-wider">Vai trò</th>
                        <th class="px-5 py-3.5 text-center text-[.68rem] font-bold text-slate-500 uppercase tracking-wider">Trạng thái</th>
                        <th class="px-5 py-3.5 text-right text-[.68rem] font-bold text-slate-500 uppercase tracking-wider">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${customers}" var="c" varStatus="s">
                        <tr class="row-hover border-b border-white/[.03] ${s.index % 2 == 0 ? '' : 'bg-white/[.01]'}">
                            <td class="px-5 py-4">
                                <div class="flex items-center gap-3">
                                    <div class="w-9 h-9 rounded-lg bg-gradient-to-br from-blue-500 to-indigo-600 flex items-center justify-center text-white font-bold text-sm flex-shrink-0">${not empty c.user ? c.user.username.substring(0,1).toUpperCase() : '?'}</div>
                                    <div>
                                        <div class="text-sm font-semibold text-white">${c.fullName != null ? c.fullName : (not empty c.user ? c.user.username : 'N/A')}</div>
                                        <div class="text-[.7rem] text-slate-500">@${not empty c.user ? c.user.username : 'N/A'}</div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-5 py-4 text-sm text-slate-400 hidden md:table-cell">${c.email}</td>
                            <td class="px-5 py-4 text-sm text-slate-400 hidden lg:table-cell">${c.phone}</td>
                            <td class="px-5 py-4 text-center">
                                <span class="text-[.7rem] font-bold px-2.5 py-1 rounded-md ${not empty c.user && c.user.role.roleName == 'ADMIN' ? 'text-amber-400 bg-amber-500/10' : 'text-blue-400 bg-blue-500/10'}">${not empty c.user ? c.user.role.roleName : 'USER'}</span>
                            </td>
                            <td class="px-5 py-4 text-center">
                                <span class="inline-flex items-center gap-1 text-[.7rem] font-bold px-2.5 py-1 rounded-full ${c.active ? 'text-emerald-400 bg-emerald-500/10' : 'text-red-400 bg-red-500/10'}">
                                    <span class="w-1.5 h-1.5 rounded-full ${c.active ? 'bg-emerald-400' : 'bg-red-400'}"></span> ${c.statusText}
                                </span>
                            </td>
                            <td class="px-5 py-4">
                                <div class="flex items-center justify-end gap-1.5">
                                    <a href="${ctx}/admin/customers?action=view&id=${c.customerId}" class="w-8 h-8 flex items-center justify-center rounded-lg text-slate-500 hover:text-blue-400 hover:bg-blue-500/10 transition">
                                        <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/></svg>
                                    </a>
                                    <a href="${ctx}/admin/customers?action=edit&id=${c.customerId}" class="w-8 h-8 flex items-center justify-center rounded-lg text-slate-500 hover:text-emerald-400 hover:bg-emerald-500/10 transition">
                                        <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg>
                                    </a>
                                    <a href="${ctx}/admin/customers?action=delete&id=${c.customerId}" onclick="return confirm('Xóa khách hàng này?')" class="w-8 h-8 flex items-center justify-center rounded-lg text-slate-500 hover:text-red-400 hover:bg-red-500/10 transition">
                                        <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty customers}">
                        <tr><td colspan="6" class="text-center py-16 text-slate-500">Chưa có khách hàng nào</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <div class="p-4 border-t border-white/[.06] flex items-center justify-center gap-1.5">
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <a href="${ctx}/admin/customers?page=${i}&search=${searchQuery}"
                       class="w-8 h-8 flex items-center justify-center rounded-lg text-xs font-semibold transition ${i == currentPage ? 'bg-blue-600 text-white' : 'border border-white/[.08] text-slate-500 hover:text-white'}">${i}</a>
                </c:forEach>
            </div>
        </c:if>
    </div>
</main>
</body>
</html>
