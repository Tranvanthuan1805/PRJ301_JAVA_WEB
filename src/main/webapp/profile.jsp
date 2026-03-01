<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ Sơ | eztravel</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
    *{margin:0;padding:0;box-sizing:border-box}
    body{font-family:'Inter',system-ui,sans-serif;background:#0F172A;color:#E2E8F0;min-height:100vh;-webkit-font-smoothing:antialiased}
    a{text-decoration:none;color:inherit;transition:.3s}

    /* Nav */
    .nav{position:fixed;top:0;left:0;right:0;z-index:100;background:rgba(15,23,42,.95);backdrop-filter:blur(20px);border-bottom:1px solid rgba(255,255,255,.06)}
    .nav-inner{max-width:1200px;margin:0 auto;padding:0 24px;display:flex;align-items:center;justify-content:space-between;height:64px}
    .logo{font-family:'Playfair Display',serif;font-size:1.3rem;font-weight:800;color:#fff;display:flex;align-items:center;gap:8px}
    .logo .a{color:#60A5FA}
    .nav-links{display:flex;gap:8px;align-items:center}
    .nav-links a{color:rgba(255,255,255,.6);font-size:.85rem;font-weight:500;padding:8px 14px;border-radius:8px;transition:.3s}
    .nav-links a:hover{color:#fff;background:rgba(255,255,255,.06)}

    /* Container */
    .container{max-width:900px;margin:0 auto;padding:88px 24px 40px}

    /* Profile Header */
    .profile-header{background:linear-gradient(135deg,rgba(59,130,246,.15),rgba(139,92,246,.1));border:1px solid rgba(255,255,255,.06);border-radius:20px;padding:40px;display:flex;align-items:center;gap:28px;margin-bottom:28px;position:relative;overflow:hidden}
    .profile-header::before{content:'';position:absolute;top:-50%;right:-20%;width:300px;height:300px;background:radial-gradient(circle,rgba(59,130,246,.1),transparent);border-radius:50%}
    .avatar{width:90px;height:90px;border-radius:20px;background:linear-gradient(135deg,#3B82F6,#8B5CF6);display:flex;align-items:center;justify-content:center;font-size:2.2rem;font-weight:800;color:#fff;flex-shrink:0;box-shadow:0 8px 24px rgba(59,130,246,.3)}
    .profile-info{position:relative;z-index:1}
    .profile-info h1{font-size:1.6rem;font-weight:800;color:#fff;margin-bottom:4px}
    .profile-info .email{color:rgba(255,255,255,.5);font-size:.9rem;margin-bottom:10px}
    .role-badge{display:inline-flex;align-items:center;gap:6px;padding:4px 14px;border-radius:999px;font-size:.75rem;font-weight:700;text-transform:uppercase;letter-spacing:.5px}
    .role-admin{background:rgba(239,68,68,.15);color:#F87171;border:1px solid rgba(239,68,68,.2)}
    .role-provider{background:rgba(59,130,246,.15);color:#60A5FA;border:1px solid rgba(59,130,246,.2)}
    .role-customer{background:rgba(16,185,129,.15);color:#34D399;border:1px solid rgba(16,185,129,.2)}

    /* Cards */
    .card{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:28px;margin-bottom:24px}
    .card h2{font-size:1.1rem;font-weight:700;color:#fff;margin-bottom:20px;display:flex;align-items:center;gap:10px}
    .card h2 i{color:#60A5FA;font-size:.9rem}

    /* Form */
    .form-grid{display:grid;grid-template-columns:1fr 1fr;gap:20px}
    .form-group{display:flex;flex-direction:column;gap:6px}
    .form-group.full{grid-column:1/-1}
    .form-group label{font-size:.8rem;font-weight:600;color:rgba(255,255,255,.5);text-transform:uppercase;letter-spacing:.5px}
    .form-group input,.form-group select{background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.08);border-radius:10px;padding:12px 16px;color:#fff;font-size:.9rem;font-family:inherit;transition:.3s;outline:none}
    .form-group input:focus{border-color:#3B82F6;box-shadow:0 0 0 3px rgba(59,130,246,.15)}
    .form-group input:disabled{opacity:.5;cursor:not-allowed}
    .form-group input::placeholder{color:rgba(255,255,255,.25)}

    /* Buttons */
    .btn-row{display:flex;gap:12px;margin-top:8px}
    .btn-save{display:inline-flex;align-items:center;gap:8px;padding:12px 28px;border-radius:10px;background:#3B82F6;color:#fff;font-weight:700;font-size:.88rem;border:none;cursor:pointer;transition:.3s;font-family:inherit}
    .btn-save:hover{background:#2563EB;transform:translateY(-1px);box-shadow:0 4px 16px rgba(59,130,246,.3)}
    .btn-outline{display:inline-flex;align-items:center;gap:8px;padding:12px 28px;border-radius:10px;background:transparent;color:rgba(255,255,255,.7);font-weight:600;font-size:.88rem;border:1px solid rgba(255,255,255,.1);cursor:pointer;transition:.3s;font-family:inherit}
    .btn-outline:hover{border-color:rgba(255,255,255,.3);color:#fff}
    .btn-danger{background:rgba(239,68,68,.12);color:#F87171;border:1px solid rgba(239,68,68,.2)}
    .btn-danger:hover{background:rgba(239,68,68,.2)}

    /* Stats */
    .stats-row{display:grid;grid-template-columns:repeat(3,1fr);gap:16px;margin-bottom:28px}
    .stat-item{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:14px;padding:20px;text-align:center}
    .stat-item .icon{width:40px;height:40px;border-radius:10px;display:flex;align-items:center;justify-content:center;margin:0 auto 10px;font-size:.9rem}
    .stat-item .val{font-size:1.4rem;font-weight:800;color:#fff}
    .stat-item .label{font-size:.75rem;color:rgba(255,255,255,.4);margin-top:4px;font-weight:600}
    .icon-blue{background:rgba(59,130,246,.15);color:#60A5FA}
    .icon-green{background:rgba(16,185,129,.15);color:#34D399}
    .icon-orange{background:rgba(245,158,11,.15);color:#FBBF24}

    /* Alert */
    .alert{padding:12px 18px;border-radius:10px;font-size:.85rem;font-weight:600;margin-bottom:20px;display:flex;align-items:center;gap:8px}
    .alert-success{background:rgba(16,185,129,.12);border:1px solid rgba(16,185,129,.2);color:#34D399}
    .alert-error{background:rgba(239,68,68,.12);border:1px solid rgba(239,68,68,.2);color:#F87171}

    /* Account Info */
    .info-list{display:flex;flex-direction:column;gap:14px}
    .info-item{display:flex;align-items:center;gap:14px;padding:14px 18px;background:rgba(255,255,255,.03);border-radius:10px;border:1px solid rgba(255,255,255,.04)}
    .info-item i{color:#60A5FA;width:20px;text-align:center;font-size:.85rem}
    .info-item .info-label{font-size:.78rem;color:rgba(255,255,255,.4);font-weight:600}
    .info-item .info-val{font-size:.9rem;color:#fff;font-weight:500}

    @media(max-width:768px){
        .profile-header{flex-direction:column;text-align:center}
        .form-grid{grid-template-columns:1fr}
        .stats-row{grid-template-columns:1fr}
    }
    </style>
</head>
<body>

<!-- Nav -->
<nav class="nav">
    <div class="nav-inner">
        <a href="${pageContext.request.contextPath}/home" class="logo">
            <img src="${pageContext.request.contextPath}/images/logo.png" style="width:30px;height:30px;border-radius:50%">
            <span class="a">ez</span>travel
        </a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home"><i class="fas fa-home"></i> Trang Chủ</a>
            <a href="${pageContext.request.contextPath}/tour"><i class="fas fa-compass"></i> Khám Phá</a>
            <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a>
        </div>
    </div>
</nav>

<div class="container">

    <!-- Profile Header -->
    <div class="profile-header">
        <div class="avatar">${sessionScope.user.username.substring(0,1).toUpperCase()}</div>
        <div class="profile-info">
            <h1>${not empty profileUser.fullName ? profileUser.fullName : profileUser.username}</h1>
            <div class="email"><i class="fas fa-envelope" style="margin-right:6px"></i> ${profileUser.email}</div>
            <c:choose>
                <c:when test="${profileUser.role.roleName == 'ADMIN'}">
                    <span class="role-badge role-admin"><i class="fas fa-shield-alt"></i> Quản Trị Viên</span>
                </c:when>
                <c:when test="${profileUser.role.roleName == 'PROVIDER'}">
                    <span class="role-badge role-provider"><i class="fas fa-store"></i> Nhà Cung Cấp</span>
                </c:when>
                <c:otherwise>
                    <span class="role-badge role-customer"><i class="fas fa-user"></i> Khách Hàng</span>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Stats -->
    <div class="stats-row">
        <div class="stat-item">
            <div class="icon icon-blue"><i class="fas fa-calendar-check"></i></div>
            <div class="val">
                <fmt:formatDate value="${profileUser.createdAt}" pattern="dd/MM/yyyy"/>
            </div>
            <div class="label">Ngày tham gia</div>
        </div>
        <div class="stat-item">
            <div class="icon icon-green"><i class="fas fa-check-circle"></i></div>
            <div class="val">${profileUser.active ? 'Hoạt động' : 'Tạm khóa'}</div>
            <div class="label">Trạng thái</div>
        </div>
        <div class="stat-item">
            <div class="icon icon-orange"><i class="fas fa-id-badge"></i></div>
            <div class="val">#${profileUser.userId}</div>
            <div class="label">Mã tài khoản</div>
        </div>
    </div>

    <!-- Alerts -->
    <c:if test="${param.success == '1'}">
        <div class="alert alert-success"><i class="fas fa-check-circle"></i> Cập nhật thông tin thành công!</div>
    </c:if>
    <c:if test="${param.error == '1'}">
        <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> Cập nhật thất bại. Vui lòng thử lại.</div>
    </c:if>

    <!-- Edit Profile -->
    <div class="card">
        <h2><i class="fas fa-user-edit"></i> Chỉnh Sửa Thông Tin</h2>
        <form action="${pageContext.request.contextPath}/profile" method="post">
            <div class="form-grid">
                <div class="form-group">
                    <label>Tên đăng nhập</label>
                    <input type="text" value="${profileUser.username}" disabled>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" value="${profileUser.email}" disabled>
                </div>
                <div class="form-group">
                    <label>Họ và tên</label>
                    <input type="text" name="fullName" value="${profileUser.fullName}" placeholder="Nhập họ và tên">
                </div>
                <div class="form-group">
                    <label>Số điện thoại</label>
                    <input type="tel" name="phoneNumber" value="${profileUser.phoneNumber}" placeholder="0901 234 567">
                </div>
                <div class="form-group full">
                    <label>Địa chỉ</label>
                    <input type="text" name="address" value="${profileUser.address}" placeholder="Nhập địa chỉ của bạn">
                </div>
            </div>
            <div class="btn-row">
                <button type="submit" class="btn-save"><i class="fas fa-save"></i> Lưu Thay Đổi</button>
                <a href="${pageContext.request.contextPath}/home" class="btn-outline"><i class="fas fa-arrow-left"></i> Quay Lại</a>
            </div>
        </form>
    </div>

    <!-- Account Info -->
    <div class="card">
        <h2><i class="fas fa-info-circle"></i> Thông Tin Tài Khoản</h2>
        <div class="info-list">
            <div class="info-item">
                <i class="fas fa-key"></i>
                <div>
                    <div class="info-label">Vai trò</div>
                    <div class="info-val">${profileUser.role.roleName}</div>
                </div>
            </div>
            <div class="info-item">
                <i class="fas fa-clock"></i>
                <div>
                    <div class="info-label">Ngày tạo tài khoản</div>
                    <div class="info-val"><fmt:formatDate value="${profileUser.createdAt}" pattern="dd/MM/yyyy HH:mm"/></div>
                </div>
            </div>
            <div class="info-item">
                <i class="fas fa-sync"></i>
                <div>
                    <div class="info-label">Cập nhật lần cuối</div>
                    <div class="info-val"><fmt:formatDate value="${profileUser.updatedAt}" pattern="dd/MM/yyyy HH:mm"/></div>
                </div>
            </div>
        </div>
    </div>

    <!-- Danger Zone -->
    <div class="card" style="border-color:rgba(239,68,68,.15)">
        <h2 style="color:#F87171"><i class="fas fa-exclamation-triangle"></i> Vùng Nguy Hiểm</h2>
        <p style="color:rgba(255,255,255,.4);font-size:.85rem;margin-bottom:16px">Các thao tác dưới đây không thể hoàn tác.</p>
        <div class="btn-row">
            <a href="${pageContext.request.contextPath}/logout" class="btn-outline btn-danger"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a>
        </div>
    </div>
</div>

</body>
</html>
