<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>${editMode ? 'Sửa Khách Hàng' : 'Thêm Khách Hàng'} | Admin</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="https://cdn.tailwindcss.com"></script>
<script>tailwind.config={theme:{extend:{fontFamily:{sans:['Inter','sans-serif']}}}}</script>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Inter',sans-serif;background:#0a0f1e;color:#e2e8f0;min-height:100vh}
a{text-decoration:none;color:inherit}
.form-card{background:rgba(17,24,39,.7);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:32px;backdrop-filter:blur(12px)}
.form-grid{display:grid;grid-template-columns:1fr 1fr;gap:20px}
@media(max-width:768px){.form-grid{grid-template-columns:1fr}}
.form-full{grid-column:1/-1}
.form-group{display:flex;flex-direction:column;gap:6px}
.form-label{font-size:.82rem;font-weight:600;color:#94a3b8;display:flex;align-items:center;gap:4px}
.form-label .req{color:#f87171;font-weight:700}
.form-label i{font-size:.7rem;opacity:.5}
.form-input{width:100%;padding:12px 16px;border:1px solid rgba(255,255,255,.08);border-radius:10px;font-family:'Inter',sans-serif;font-size:.88rem;transition:all .3s;background:rgba(15,23,42,.6);color:#e2e8f0;outline:none}
.form-input:focus{border-color:#3b82f6;box-shadow:0 0 0 3px rgba(59,130,246,.12)}
.form-input::placeholder{color:#475569}
select.form-input{cursor:pointer;appearance:none;background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%2394a3b8' stroke-width='2'%3E%3Cpath d='M6 9l6 6 6-6'/%3E%3C/svg%3E");background-repeat:no-repeat;background-position:right 14px center}
.section-title{font-size:.78rem;font-weight:700;color:#60a5fa;text-transform:uppercase;letter-spacing:1.5px;padding:12px 0 6px;margin-top:8px;border-top:1px solid rgba(255,255,255,.05);grid-column:1/-1;display:flex;align-items:center;gap:8px}
.section-title i{font-size:.72rem}
.toggle-wrap{display:flex;align-items:center;gap:14px;padding:14px 18px;background:rgba(15,23,42,.4);border-radius:10px;border:1px solid rgba(255,255,255,.06)}
.toggle{position:relative;width:48px;height:26px;flex-shrink:0}
.toggle input{opacity:0;width:0;height:0}
.toggle-slider{position:absolute;cursor:pointer;top:0;left:0;right:0;bottom:0;background:#334155;border-radius:26px;transition:.3s}
.toggle-slider:before{content:'';position:absolute;width:20px;height:20px;left:3px;bottom:3px;background:#fff;border-radius:50%;transition:.3s}
.toggle input:checked+.toggle-slider{background:linear-gradient(135deg,#3b82f6,#2563eb)}
.toggle input:checked+.toggle-slider:before{transform:translateX(22px)}
.toggle-text{font-size:.85rem;font-weight:600}
.btn-group{display:flex;gap:12px;justify-content:flex-end;margin-top:24px;padding-top:20px;border-top:1px solid rgba(255,255,255,.06)}
.btn{display:inline-flex;align-items:center;gap:8px;padding:12px 28px;border-radius:10px;font-family:'Inter',sans-serif;font-size:.88rem;font-weight:700;cursor:pointer;transition:all .3s;border:none;text-decoration:none}
.btn-primary{background:linear-gradient(135deg,#3b82f6,#2563eb);color:#fff;box-shadow:0 4px 15px rgba(59,130,246,.3)}
.btn-primary:hover{transform:translateY(-1px);box-shadow:0 6px 20px rgba(59,130,246,.4)}
.btn-cancel{background:rgba(255,255,255,.05);color:#94a3b8;border:1px solid rgba(255,255,255,.08)}
.btn-cancel:hover{color:#e2e8f0;background:rgba(255,255,255,.08)}
.back-link{display:inline-flex;align-items:center;gap:8px;font-size:.85rem;font-weight:600;color:#60a5fa;margin-bottom:20px;padding:8px 16px;border-radius:8px;transition:.2s}
.back-link:hover{background:rgba(59,130,246,.08);color:#93c5fd}
.page-title{font-size:1.4rem;font-weight:800;color:#fff;margin-bottom:24px;display:flex;align-items:center;gap:12px}
.page-title i{color:#3b82f6;font-size:1.1rem}
.page-title .hl{background:linear-gradient(135deg,#3b82f6,#60a5fa);-webkit-background-clip:text;-webkit-text-fill-color:transparent}
</style>
</head>
<body class="bg-[#0a0f1e] text-slate-200 min-h-screen">
<jsp:include page="/common/_admin-sidebar.jsp"/>
<jsp:include page="/common/_admin-header.jsp"/>

<main class="lg:ml-[260px] pt-20 pb-10 px-4 lg:px-8" style="max-width:900px">
    <a href="${ctx}/admin/dashboard" class="back-link"><i class="fas fa-arrow-left"></i> Quay lại Dashboard</a>
    <h1 class="page-title">
        <c:choose>
            <c:when test="${editMode}"><i class="fas fa-user-pen"></i> Sửa: <span class="hl">@${editUser.username}</span></c:when>
            <c:otherwise><i class="fas fa-user-plus"></i> Thêm <span class="hl">Khách Hàng Mới</span></c:otherwise>
        </c:choose>
    </h1>
    <div class="form-card">
        <form action="${ctx}/admin/crud/customer-save" method="post">
            <c:if test="${editMode}"><input type="hidden" name="userId" value="${editUser.userId}"></c:if>
            <div class="form-grid">
                <div class="section-title"><i class="fas fa-id-card"></i> Thông Tin Tài Khoản</div>
                <c:if test="${!editMode}">
                    <div class="form-group"><label class="form-label"><i class="fas fa-user"></i> Username <span class="req">*</span></label>
                        <input type="text" name="username" class="form-input" required placeholder="username"></div>
                    <div class="form-group"><label class="form-label"><i class="fas fa-lock"></i> Mật khẩu <span class="req">*</span></label>
                        <input type="password" name="password" class="form-input" required placeholder="••••••••"></div>
                </c:if>
                <div class="form-group"><label class="form-label"><i class="fas fa-envelope"></i> Email <span class="req">*</span></label>
                    <input type="email" name="email" class="form-input" required value="${editMode ? editUser.email : ''}" placeholder="email@example.com"></div>
                <div class="form-group"><label class="form-label"><i class="fas fa-shield-halved"></i> Vai trò</label>
                    <select name="roleId" class="form-input"><c:forEach var="r" items="${roles}">
                        <option value="${r.roleId}" ${editMode && editUser.roleId == r.roleId ? 'selected' : ''}>${r.roleName}</option>
                    </c:forEach></select></div>

                <div class="section-title"><i class="fas fa-address-book"></i> Thông Tin Cá Nhân</div>
                <div class="form-group"><label class="form-label"><i class="fas fa-signature"></i> Họ Tên</label>
                    <input type="text" name="fullName" class="form-input" value="${editMode ? editUser.fullName : ''}" placeholder="Nguyễn Văn A"></div>
                <div class="form-group"><label class="form-label"><i class="fas fa-phone"></i> SĐT</label>
                    <input type="text" name="phoneNumber" class="form-input" value="${editMode ? editUser.phoneNumber : ''}" placeholder="0901234567"></div>
                <div class="form-group form-full"><label class="form-label"><i class="fas fa-map-marker-alt"></i> Địa chỉ</label>
                    <input type="text" name="address" class="form-input" value="${editMode ? editUser.address : ''}" placeholder="123 Đường ABC, TP Đà Nẵng"></div>

                <c:if test="${editMode}">
                    <div class="section-title"><i class="fas fa-toggle-on"></i> Trạng Thái</div>
                    <div class="form-group form-full"><div class="toggle-wrap">
                        <label class="toggle"><input type="checkbox" name="isActive" ${editUser.active ? 'checked' : ''}><span class="toggle-slider"></span></label>
                        <span class="toggle-text">${editUser.active ? '✅ Đang hoạt động' : '⛔ Đã vô hiệu hóa'}</span>
                    </div></div>
                </c:if>
            </div>
            <div class="btn-group">
                <a href="${ctx}/admin/dashboard" class="btn btn-cancel"><i class="fas fa-times"></i> Hủy</a>
                <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> ${editMode ? 'Cập Nhật' : 'Tạo Mới'}</button>
            </div>
        </form>
    </div>
</main>
</body>
</html>
