<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Tour | eztravel</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
    *{margin:0;padding:0;box-sizing:border-box}
    body{font-family:'Inter',system-ui,sans-serif;background:#0F172A;color:#E2E8F0;-webkit-font-smoothing:antialiased;min-height:100vh}
    .sidebar{position:fixed;left:0;top:0;width:260px;height:100vh;background:#0B1120;border-right:1px solid rgba(255,255,255,.06);padding:24px 16px;display:flex;flex-direction:column;z-index:100}
    .sidebar .logo{font-family:'Playfair Display',serif;font-size:1.4rem;font-weight:800;color:#fff;padding:0 12px 24px;border-bottom:1px solid rgba(255,255,255,.06);margin-bottom:16px}
    .sidebar .logo .a{color:#60A5FA}
    .sidebar .badge-admin{display:inline-block;padding:2px 8px;border-radius:6px;background:rgba(239,68,68,.15);color:#F87171;font-size:.65rem;font-weight:700;margin-left:6px;vertical-align:middle}
    .sidebar nav{flex:1}
    .sidebar nav a{display:flex;align-items:center;gap:12px;padding:11px 16px;border-radius:10px;color:rgba(255,255,255,.5);font-size:.88rem;font-weight:500;transition:.3s;margin-bottom:2px;text-decoration:none}
    .sidebar nav a:hover{color:#fff;background:rgba(255,255,255,.06)}
    .sidebar nav a.active{color:#fff;background:rgba(59,130,246,.15);border:1px solid rgba(59,130,246,.2)}
    .sidebar nav a.active i{color:#60A5FA}
    .sidebar nav a i{width:20px;text-align:center;font-size:.85rem}
    .sidebar .nav-label{font-size:.68rem;text-transform:uppercase;letter-spacing:1.5px;color:rgba(255,255,255,.2);font-weight:700;padding:16px 16px 8px;margin-top:8px}
    .sidebar .user-box{padding:16px;border-top:1px solid rgba(255,255,255,.06);display:flex;align-items:center;gap:12px}
    .sidebar .user-box .avatar{width:38px;height:38px;border-radius:10px;background:linear-gradient(135deg,#EF4444,#F87171);display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;font-size:.85rem}
    .sidebar .user-box .uname{font-size:.85rem;color:#fff;font-weight:600}
    .sidebar .user-box .urole{font-size:.72rem;color:rgba(255,255,255,.4)}
    .main{margin-left:260px;padding:32px 40px;min-height:100vh}
    .page-header{margin-bottom:32px}
    .page-header h1{font-size:1.8rem;font-weight:800;color:#fff;margin-bottom:8px}
    .page-header p{color:rgba(255,255,255,.5);font-size:.9rem}
    .form-container{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:32px;max-width:800px}
    .form-group{margin-bottom:24px}
    .form-group label{display:block;margin-bottom:8px;color:rgba(255,255,255,.8);font-size:.88rem;font-weight:600}
    .form-group label .required{color:#F87171}
    .form-group input,.form-group select,.form-group textarea{width:100%;padding:12px 14px;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.1);border-radius:10px;color:#fff;font-size:.88rem;font-family:inherit}
    .form-group input:focus,.form-group select:focus,.form-group textarea:focus{outline:none;border-color:#60A5FA;background:rgba(255,255,255,.08)}
    .form-group select option{background:#1E293B;color:#fff}
    .form-group textarea{resize:vertical;min-height:100px}
    .form-row{display:grid;grid-template-columns:1fr 1fr;gap:20px}
    .btn{padding:12px 24px;border:none;border-radius:10px;font-weight:600;font-size:.88rem;cursor:pointer;transition:.3s;font-family:inherit}
    .btn-primary{background:#3B82F6;color:#fff}
    .btn-primary:hover{background:#2563EB;transform:translateY(-1px)}
    .btn-secondary{background:rgba(255,255,255,.06);color:rgba(255,255,255,.7);border:1px solid rgba(255,255,255,.1)}
    .btn-secondary:hover{background:rgba(255,255,255,.08);color:#fff}
    .form-actions{display:flex;gap:12px;margin-top:32px}
    .alert{padding:14px 18px;border-radius:10px;margin-bottom:24px;font-size:.88rem}
    .alert-error{background:rgba(239,68,68,.15);color:#F87171;border:1px solid rgba(239,68,68,.2)}
    .alert-success{background:rgba(16,185,129,.15);color:#34D399;border:1px solid rgba(16,185,129,.2)}
    </style>
</head>
<body>

<aside class="sidebar">
    <div class="logo"><span style="vertical-align:middle"><span class="a">ez</span>travel</span> <span class="badge-admin">ADMIN</span></div>
    <nav>
        <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-chart-pie"></i> Tổng Quan</a>
        <a href="${pageContext.request.contextPath}/admin/customers"><i class="fas fa-users"></i> Khách Hàng</a>
        <div class="nav-label">Quản lý</div>
        <a href="${pageContext.request.contextPath}/admin/tours" class="active"><i class="fas fa-plane-departure"></i> Quản lý Tours</a>
        <a href="${pageContext.request.contextPath}/admin/tour-history"><i class="fas fa-history"></i> Lịch sử</a>
        <a href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-bag"></i> Đơn Hàng</a>
        <div class="nav-label">Hệ thống</div>
        <a href="${pageContext.request.contextPath}/home" target="_blank"><i class="fas fa-globe"></i> Xem Website</a>
    </nav>
    <div class="user-box">
        <div class="avatar">${sessionScope.user.username.substring(0,1).toUpperCase()}</div>
        <div>
            <div class="uname">${sessionScope.user.username}</div>
            <div class="urole">Quản Trị Viên</div>
        </div>
    </div>
</aside>

<main class="main">
    <div class="page-header">
        <h1><i class="fas fa-edit"></i> Sửa Tour</h1>
        <p>Cập nhật thông tin tour du lịch</p>
    </div>
    
    <c:if test="${not empty error}">
        <div class="alert alert-error">
            <i class="fas fa-exclamation-circle"></i> ${error}
        </div>
    </c:if>
    
    <c:if test="${not empty tour}">
        <div class="form-container">
            <form method="post" action="${pageContext.request.contextPath}/admin/tours/edit">
                <input type="hidden" name="id" value="${tour.id}">
                
                <div class="form-group">
                    <label><i class="fas fa-tag"></i> Tên Tour <span class="required">*</span></label>
                    <input type="text" name="name" required value="${tour.name}">
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-map-marker-alt"></i> Điểm Đến <span class="required">*</span></label>
                        <select name="destination" required>
                            <option value="">-- Chọn điểm đến --</option>
                            <option value="Bà Nà Hills" ${tour.destination == 'Bà Nà Hills' ? 'selected' : ''}>Bà Nà Hills</option>
                            <option value="Ngũ Hành Sơn" ${tour.destination == 'Ngũ Hành Sơn' ? 'selected' : ''}>Ngũ Hành Sơn</option>
                            <option value="Cù Lao Chàm" ${tour.destination == 'Cù Lao Chàm' ? 'selected' : ''}>Cù Lao Chàm</option>
                            <option value="Sơn Trà" ${tour.destination == 'Sơn Trà' ? 'selected' : ''}>Sơn Trà</option>
                            <option value="Huế" ${tour.destination == 'Huế' ? 'selected' : ''}>Huế</option>
                            <option value="Núi Thần Tài" ${tour.destination == 'Núi Thần Tài' ? 'selected' : ''}>Núi Thần Tài</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-dollar-sign"></i> Giá (VNĐ) <span class="required">*</span></label>
                        <input type="number" name="price" required min="0" step="1000" value="${tour.price}">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-calendar-alt"></i> Ngày Khởi Hành <span class="required">*</span></label>
                        <input type="date" name="startDate" required value="<fmt:formatDate value='${tour.startDate}' pattern='yyyy-MM-dd'/>">
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-calendar-check"></i> Ngày Kết Thúc <span class="required">*</span></label>
                        <input type="date" name="endDate" required value="<fmt:formatDate value='${tour.endDate}' pattern='yyyy-MM-dd'/>">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-users"></i> Số Người Tối Đa <span class="required">*</span></label>
                        <input type="number" name="maxCapacity" required min="1" value="${tour.maxCapacity}">
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-user-check"></i> Số Người Đã Đặt</label>
                        <input type="number" name="currentCapacity" min="0" value="${tour.currentCapacity}">
                    </div>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-align-left"></i> Mô Tả</label>
                    <textarea name="description">${tour.description}</textarea>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Cập Nhật
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="window.location.href='${pageContext.request.contextPath}/admin/tours'">
                        <i class="fas fa-times"></i> Hủy
                    </button>
                </div>
            </form>
        </div>
    </c:if>
</main>

</body>
</html>
