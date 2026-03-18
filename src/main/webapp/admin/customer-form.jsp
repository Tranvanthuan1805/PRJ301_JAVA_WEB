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
body{font-family:'Inter',sans-serif;background:#080d1a;color:#e2e8f0;min-height:100vh}
a{text-decoration:none;color:inherit}

/* Sidebar */
.sidebar{position:fixed;left:0;top:0;width:270px;height:100vh;background:linear-gradient(180deg,rgba(11,17,32,.98) 0%,rgba(8,13,26,.99) 100%);border-right:1px solid rgba(255,255,255,.05);padding:24px 16px;display:flex;flex-direction:column;z-index:100;backdrop-filter:blur(24px)}
.sidebar .logo{font-size:1.4rem;font-weight:800;color:#fff;padding:0 12px 24px;border-bottom:1px solid rgba(255,255,255,.06);margin-bottom:16px;display:flex;align-items:center;gap:10px}
.sidebar .logo .a{color:#60A5FA}
.sidebar .badge-admin{display:inline-block;padding:3px 10px;border-radius:8px;background:linear-gradient(135deg,rgba(239,68,68,.2),rgba(239,68,68,.1));color:#F87171;font-size:.65rem;font-weight:700;margin-left:6px;border:1px solid rgba(239,68,68,.15)}
.sidebar nav{flex:1;overflow-y:auto;scrollbar-width:none}
.sidebar nav::-webkit-scrollbar{display:none}
.sidebar nav a{display:flex;align-items:center;gap:12px;padding:12px 16px;border-radius:12px;color:rgba(255,255,255,.45);font-size:.88rem;font-weight:500;transition:all .3s;margin-bottom:3px;border:1px solid transparent}
.sidebar nav a:hover{color:#fff;background:rgba(255,255,255,.05);border-color:rgba(255,255,255,.06);transform:translateX(4px)}
.sidebar nav a.active{color:#fff;background:linear-gradient(135deg,rgba(59,130,246,.12),rgba(139,92,246,.08));border:1px solid rgba(59,130,246,.18)}
.sidebar nav a i{width:20px;text-align:center;font-size:.88rem}
.sidebar .nav-label{font-size:.65rem;text-transform:uppercase;letter-spacing:2px;color:rgba(255,255,255,.15);font-weight:700;padding:20px 16px 8px}
.sidebar .user-box{padding:16px;border-top:1px solid rgba(255,255,255,.06);display:flex;align-items:center;gap:12px}
.sidebar .user-box .avatar{width:40px;height:40px;border-radius:12px;background:linear-gradient(135deg,#EF4444,#EC4899);display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;font-size:.88rem}
.sidebar .user-box .uname{font-size:.88rem;color:#fff;font-weight:600}
.sidebar .user-box .urole{font-size:.72rem;color:rgba(255,255,255,.35)}

.main-content{margin-left:270px;padding:32px 40px;min-height:100vh}
.form-card{background:rgba(17,24,39,.7);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:32px;backdrop-filter:blur(12px)}
.form-grid{display:grid;grid-template-columns:1fr 1fr;gap:20px}
@media(max-width:768px){.form-grid{grid-template-columns:1fr}}
.form-full{grid-column:1/-1}
.form-group{display:flex;flex-direction:column;gap:6px}
.form-label{font-size:.82rem;font-weight:600;color:#94a3b8;display:flex;align-items:center;gap:4px}
.form-label .req{color:#f87171;font-weight:700}
.form-input{width:100%;padding:12px 16px;border:1px solid rgba(255,255,255,.08);border-radius:10px;font-family:'Inter',sans-serif;font-size:.88rem;transition:all .3s;background:rgba(15,23,42,.6);color:#e2e8f0;outline:none}
.form-input:focus{border-color:#3b82f6;box-shadow:0 0 0 3px rgba(59,130,246,.12)}
.form-input::placeholder{color:#475569}
select.form-input{cursor:pointer;appearance:none;background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%2394a3b8' stroke-width='2'%3E%3Cpath d='M6 9l6 6 6-6'/%3E%3C/svg%3E");background-repeat:no-repeat;background-position:right 14px center}
.section-title{font-size:.78rem;font-weight:700;color:#60a5fa;text-transform:uppercase;letter-spacing:1.5px;padding:12px 0 6px;margin-top:8px;border-top:1px solid rgba(255,255,255,.05);grid-column:1/-1;display:flex;align-items:center;gap:8px}
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
<body>
<!-- Sidebar -->
<aside class="sidebar">
    <div class="logo">
        <img src="${ctx}/images/logo.png" style="width:36px;height:36px;border-radius:50%">
        <span><span class="a">ez</span>travel</span>
        <span class="badge-admin">ADMIN</span>
    </div>
    <nav>
        <a href="${ctx}/admin/dashboard"><i class="fas fa-chart-pie"></i> Tổng Quan</a>
        <a href="${ctx}/admin/dashboard?section=customers" class="active"><i class="fas fa-users"></i> Khách Hàng</a>
        <a href="${ctx}/admin/dashboard?section=orders"><i class="fas fa-shopping-bag"></i> Đơn Hàng</a>
        <a href="${ctx}/admin/dashboard?section=tours-mgmt"><i class="fas fa-map-marked-alt"></i> Quản Lý Tours</a>
        <a href="${ctx}/admin/dashboard?section=providers"><i class="fas fa-handshake"></i> Nhà Cung Cấp</a>
        <a href="${ctx}/admin/dashboard?section=consultations"><i class="fas fa-comments"></i> Tư Vấn</a>
        <a href="${ctx}/admin/dashboard?section=coupons"><i class="fas fa-ticket-alt"></i> Mã Giảm Giá</a>
        <div class="nav-label">AI & Phân Tích</div>
        <a href="${ctx}/admin/dashboard?section=chatbot"><i class="fas fa-robot"></i> Chatbot & Hành Vi</a>
        <a href="${ctx}/admin/dashboard?section=neural"><i class="fas fa-brain"></i> Mạng Neural</a>
        <div class="nav-label">Hệ Thống</div>
        <a href="${ctx}/home" target="_blank"><i class="fas fa-globe"></i> Xem Website</a>
        <a href="${ctx}/logout"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a>
    </nav>
    <div class="user-box">
        <div class="avatar">${sessionScope.user.username.substring(0,1).toUpperCase()}</div>
        <div>
            <div class="uname">${sessionScope.user.username}</div>
            <div class="urole">Quản Trị Viên</div>
        </div>
    </div>
</aside>

<div class="main-content">
    <a href="${ctx}/admin/dashboard" class="back-link"><i class="fas fa-arrow-left"></i> Quay lại Dashboard</a>
    <h1 style="font-size:1.4rem;font-weight:800;color:#fff;margin-bottom:16px;display:flex;align-items:center;gap:12px">
        <c:choose>
            <c:when test="${editMode}"><i class="fas fa-user-pen" style="color:#3b82f6"></i> Sửa: <span style="background:linear-gradient(135deg,#3b82f6,#60a5fa);-webkit-background-clip:text;-webkit-text-fill-color:transparent">@${editUser.username}</span></c:when>
            <c:otherwise><i class="fas fa-user-plus" style="color:#3b82f6"></i> Thêm <span style="background:linear-gradient(135deg,#3b82f6,#60a5fa);-webkit-background-clip:text;-webkit-text-fill-color:transparent">Khách Hàng Mới</span></c:otherwise>
        </c:choose>
    </h1>

    <c:if test="${not empty errorMessage}">
        <div style="padding:12px 18px;background:rgba(239,68,68,.12);border:1px solid rgba(239,68,68,.2);border-radius:10px;color:#F87171;font-size:.88rem;font-weight:600;margin-bottom:16px;display:flex;align-items:center;gap:8px">
            <i class="fas fa-exclamation-circle"></i> ${errorMessage}
        </div>
    </c:if>

    <div style="display:flex;gap:24px;align-items:flex-start;max-width:1100px">
        <!-- Form -->
        <div style="flex:1;min-width:0">
        <div class="form-card">
        <form action="${ctx}/admin/crud/customer-save" method="post" onsubmit="return validateForm(this)">
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
    </div>

        <!-- Activity Panel (chỉ hiện khi edit) -->
        <c:if test="${editMode}">
        <div style="width:320px;flex-shrink:0">
            <div class="form-card" style="padding:20px">
                <div style="font-size:.85rem;font-weight:700;color:#60a5fa;text-transform:uppercase;letter-spacing:1px;margin-bottom:16px;display:flex;align-items:center;gap:8px">
                    <i class="fas fa-history"></i> Lịch Sử Hoạt Động
                </div>
                <c:choose>
                    <c:when test="${empty activities}">
                        <div style="color:#475569;font-size:.83rem;text-align:center;padding:20px 0">Chưa có hoạt động nào</div>
                    </c:when>
                    <c:otherwise>
                        <div style="display:flex;flex-direction:column;gap:10px;max-height:500px;overflow-y:auto">
                        <c:forEach var="act" items="${activities}">
                            <div style="background:rgba(15,23,42,.5);border:1px solid rgba(255,255,255,.06);border-radius:8px;padding:10px 12px">
                                <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:4px">
                                    <span style="font-size:.75rem;font-weight:700;padding:2px 8px;border-radius:999px;background:rgba(59,130,246,.15);color:#60a5fa">${act.actionType}</span>
                                    <span style="font-size:.72rem;color:#475569"><fmt:formatDate value="${act.createdAt}" pattern="dd/MM/yyyy HH:mm"/></span>
                                </div>
                                <div style="font-size:.8rem;color:#94a3b8">${act.description}</div>
                            </div>
                        </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        </c:if>
    </div>
</div>
<script>
function validateForm(form) {
    const email = form.email.value.trim();
    const phone = form.phoneNumber ? form.phoneNumber.value.trim() : '';
    const fullName = form.fullName ? form.fullName.value.trim() : '';

    if (!email) { alert('Email không được để trống'); return false; }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) { alert('Email không hợp lệ'); return false; }
    if (fullName && fullName.length < 2) { alert('Họ tên phải từ 2 ký tự trở lên'); return false; }
    if (phone && !/^(\+84|0)[1-9][0-9]{8,9}$/.test(phone.replace(/\s/g,''))) {
        alert('Số điện thoại không hợp lệ (VD: 0901234567)'); return false;
    }
    return true;
}
</script>
</body>
</html>
