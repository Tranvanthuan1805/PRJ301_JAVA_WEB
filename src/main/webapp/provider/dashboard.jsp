<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Provider Dashboard | eztravel</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
    *{margin:0;padding:0;box-sizing:border-box}
    body{font-family:'Inter',system-ui,sans-serif;background:#0F172A;color:#E2E8F0;-webkit-font-smoothing:antialiased;min-height:100vh}

    /* Sidebar */
    .sidebar{position:fixed;left:0;top:0;width:260px;height:100vh;background:#0B1120;border-right:1px solid rgba(255,255,255,.06);padding:24px 16px;display:flex;flex-direction:column;z-index:100}
    .sidebar .logo{font-family:'Playfair Display',serif;font-size:1.4rem;font-weight:800;color:#fff;padding:0 12px 24px;border-bottom:1px solid rgba(255,255,255,.06);margin-bottom:16px}
    .sidebar .logo .a{color:#60A5FA}
    .sidebar nav{flex:1}
    .sidebar nav a{display:flex;align-items:center;gap:12px;padding:11px 16px;border-radius:10px;color:rgba(255,255,255,.5);font-size:.88rem;font-weight:500;transition:.3s;margin-bottom:2px;text-decoration:none}
    .sidebar nav a:hover{color:#fff;background:rgba(255,255,255,.06)}
    .sidebar nav a.active{color:#fff;background:rgba(59,130,246,.15);border:1px solid rgba(59,130,246,.2)}
    .sidebar nav a.active i{color:#60A5FA}
    .sidebar nav a i{width:20px;text-align:center;font-size:.85rem}
    .sidebar .user-box{padding:16px;border-top:1px solid rgba(255,255,255,.06);display:flex;align-items:center;gap:12px}
    .sidebar .user-box .avatar{width:38px;height:38px;border-radius:10px;background:linear-gradient(135deg,#3B82F6,#60A5FA);display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;font-size:.85rem}
    .sidebar .user-box .uname{font-size:.85rem;color:#fff;font-weight:600}
    .sidebar .user-box .urole{font-size:.72rem;color:rgba(255,255,255,.4)}

    /* Main */
    .main{margin-left:260px;padding:32px 40px;min-height:100vh}
    .page-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:32px}
    .page-header h1{font-size:1.8rem;font-weight:800;color:#fff}
    .page-header p{color:rgba(255,255,255,.5);font-size:.9rem;margin-top:4px}
    .header-actions{display:flex;gap:10px}
    .btn-primary{display:inline-flex;align-items:center;gap:8px;padding:10px 22px;border-radius:10px;background:#3B82F6;color:#fff;font-weight:700;font-size:.85rem;border:none;cursor:pointer;transition:.3s;font-family:inherit;text-decoration:none}
    .btn-primary:hover{background:#2563EB;transform:translateY(-1px);box-shadow:0 4px 16px rgba(59,130,246,.3)}
    .btn-outline{display:inline-flex;align-items:center;gap:8px;padding:10px 22px;border-radius:10px;background:transparent;color:rgba(255,255,255,.7);font-weight:600;font-size:.85rem;border:1px solid rgba(255,255,255,.1);cursor:pointer;transition:.3s;font-family:inherit;text-decoration:none}
    .btn-outline:hover{border-color:rgba(255,255,255,.3);color:#fff}

    /* Stats Grid */
    .stats{display:grid;grid-template-columns:repeat(4,1fr);gap:20px;margin-bottom:32px}
    .stat{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:24px;position:relative;overflow:hidden;transition:.3s}
    .stat:hover{border-color:rgba(59,130,246,.2);transform:translateY(-2px)}
    .stat .icon{width:44px;height:44px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:1rem;margin-bottom:14px}
    .stat .label{font-size:.78rem;color:rgba(255,255,255,.4);font-weight:600;text-transform:uppercase;letter-spacing:1px;margin-bottom:6px}
    .stat .value{font-size:1.8rem;font-weight:800;color:#fff;letter-spacing:-1px}
    .stat .trend{font-size:.75rem;margin-top:8px;font-weight:600}
    .trend-up{color:#10B981}
    .trend-down{color:#EF4444}
    .icon-blue{background:rgba(59,130,246,.15);color:#60A5FA}
    .icon-green{background:rgba(16,185,129,.15);color:#34D399}
    .icon-orange{background:rgba(245,158,11,.15);color:#FBBF24}
    .icon-red{background:rgba(239,68,68,.15);color:#F87171}

    /* Cards */
    .card{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:24px;margin-bottom:24px}
    .card h3{font-size:1.05rem;font-weight:700;color:#fff;margin-bottom:20px;display:flex;align-items:center;gap:10px}
    .card h3 i{color:#60A5FA;font-size:.9rem}
    .grid-2{display:grid;grid-template-columns:2fr 1fr;gap:24px}

    /* Table */
    table{width:100%;border-collapse:collapse}
    thead th{padding:12px 16px;text-align:left;font-size:.72rem;text-transform:uppercase;letter-spacing:1px;color:rgba(255,255,255,.3);font-weight:700;border-bottom:1px solid rgba(255,255,255,.06)}
    tbody td{padding:14px 16px;border-bottom:1px solid rgba(255,255,255,.04);font-size:.88rem;color:rgba(255,255,255,.7)}
    tbody tr:hover{background:rgba(255,255,255,.02)}
    .badge{padding:4px 12px;border-radius:999px;font-size:.72rem;font-weight:700}
    .badge-green{background:rgba(16,185,129,.15);color:#34D399}
    .badge-yellow{background:rgba(245,158,11,.15);color:#FBBF24}
    .badge-blue{background:rgba(59,130,246,.15);color:#60A5FA}

    /* Quick Actions */
    .quick-actions{display:flex;flex-direction:column;gap:12px}
    .quick-action{display:flex;align-items:center;gap:14px;padding:16px;border-radius:12px;background:rgba(255,255,255,.03);border:1px solid rgba(255,255,255,.06);transition:.3s;cursor:pointer;text-decoration:none;color:inherit}
    .quick-action:hover{background:rgba(59,130,246,.08);border-color:rgba(59,130,246,.15)}
    .quick-action .qa-icon{width:42px;height:42px;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:.9rem}
    .quick-action .qa-text h4{font-size:.88rem;color:#fff;font-weight:600}
    .quick-action .qa-text p{font-size:.75rem;color:rgba(255,255,255,.4);margin-top:2px}

    /* Empty State */
    .empty-state{text-align:center;padding:60px 20px;color:rgba(255,255,255,.4)}
    .empty-state i{font-size:3rem;margin-bottom:16px;opacity:.3}
    .empty-state p{font-size:.9rem}

    @media(max-width:1024px){.stats{grid-template-columns:repeat(2,1fr)}.grid-2{grid-template-columns:1fr}}
    @media(max-width:768px){.main{margin-left:0;padding:16px}.stats{grid-template-columns:1fr}.sidebar{display:none}}
    </style>
</head>
<body>

<!-- Sidebar -->
<aside class="sidebar">
    <div class="logo"><img src="${pageContext.request.contextPath}/images/logo.png" style="width:36px;height:36px;border-radius:50%;display:inline-block;vertical-align:middle;margin-right:8px"><span style="vertical-align:middle"><span class="a">ez</span>travel</span></div>
    <nav>
        <a href="${pageContext.request.contextPath}/provider/dashboard" class="active"><i class="fas fa-chart-pie"></i> Tổng Quan</a>
        <a href="${pageContext.request.contextPath}/provider/dashboard#tours-section"><i class="fas fa-map-marked-alt"></i> Tours Của Tôi</a>
        <a href="${pageContext.request.contextPath}/my-orders"><i class="fas fa-shopping-bag"></i> Đơn Đặt</a>
        <a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user-cog"></i> Hồ Sơ</a>
    </nav>
    <div class="user-box">
        <div class="avatar">${sessionScope.user.username.substring(0,1).toUpperCase()}</div>
        <div>
            <div class="uname">${sessionScope.user.username}</div>
            <div class="urole">Nhà Cung Cấp</div>
        </div>
    </div>
</aside>

<!-- Main Content -->
<main class="main">
    <header class="page-header">
        <div>
            <h1>Dashboard Nhà Cung Cấp</h1>
            <p>Xin chào, <strong>${providerName}</strong> 👋</p>
        </div>
        <div class="header-actions">
            <a href="${pageContext.request.contextPath}/provider?action=create-tour" class="btn-primary"><i class="fas fa-plus"></i> Tạo Tour Mới</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn-outline"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a>
        </div>
    </header>

    <!-- Stats -->
    <section class="stats">
        <div class="stat">
            <div class="icon icon-blue"><i class="fas fa-map-marked-alt"></i></div>
            <div class="label">Tours Hoạt Động</div>
            <div class="value">${myTours}</div>
            <div class="trend trend-up"><i class="fas fa-arrow-up"></i> Đang hoạt động</div>
        </div>
        <div class="stat">
            <div class="icon icon-green"><i class="fas fa-shopping-bag"></i></div>
            <div class="label">Tổng Đặt Chỗ</div>
            <div class="value">${myBookings}</div>
        </div>
        <div class="stat">
            <div class="icon icon-orange"><i class="fas fa-coins"></i></div>
            <div class="label">Doanh Thu</div>
            <div class="value"><fmt:formatNumber value="${myRevenue}" type="number" groupingUsed="true"/>đ</div>
        </div>
        <div class="stat">
            <div class="icon icon-red"><i class="fas fa-star"></i></div>
            <div class="label">Đánh Giá</div>
            <div class="value">4.8★</div>
            <div class="trend trend-up"><i class="fas fa-arrow-up"></i> Tốt</div>
        </div>
    </section>

    <div class="grid-2">
        <!-- My Tours List -->
        <div class="card" id="tours-section">
            <h3><i class="fas fa-map-marked-alt"></i> Quản Lý Tours</h3>
            <c:choose>
                <c:when test="${not empty tours}">
                    <table>
                        <thead>
                            <tr>
                                <th>Tour</th>
                                <th>Giá</th>
                                <th>Trạng Thái</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${tours}" var="t">
                                <tr>
                                    <td>
                                        <div style="font-weight:600;color:#fff">${t.tourName}</div>
                                        <div style="font-size:.75rem;color:rgba(255,255,255,.4)">${t.duration} • ${t.startLocation}</div>
                                    </td>
                                    <td><fmt:formatNumber value="${t.price}" type="number" groupingUsed="true"/>đ</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${t.active}"><span class="badge badge-green">Hoạt động</span></c:when>
                                            <c:otherwise><span class="badge badge-yellow">Chờ duyệt</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="text-align:right">
                                        <a href="${pageContext.request.contextPath}/tour?id=${t.tourId}" style="color:#60A5FA;text-decoration:none;font-size:.8rem"><i class="fas fa-eye"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-map-signs"></i>
                        <p>Bạn chưa có tour nào. Hãy tạo tour ngay!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Quick Actions -->
        <div class="card">
            <h3><i class="fas fa-bolt"></i> Thao Tác Nhanh</h3>
            <div class="quick-actions">
                <a href="${pageContext.request.contextPath}/provider?action=create-tour" class="quick-action">
                    <div class="qa-icon icon-blue"><i class="fas fa-plus"></i></div>
                    <div class="qa-text"><h4>Tạo Tour Mới</h4><p>Thêm tour du lịch mới</p></div>
                </a>
                <a href="${pageContext.request.contextPath}/my-orders" class="quick-action">
                    <div class="qa-icon icon-green"><i class="fas fa-list"></i></div>
                    <div class="qa-text"><h4>Xem Đơn Hàng</h4><p>Quản lý đơn đặt tour</p></div>
                </a>
                <a href="${pageContext.request.contextPath}/profile" class="quick-action">
                    <div class="qa-icon icon-red"><i class="fas fa-user-edit"></i></div>
                    <div class="qa-text"><h4>Cập Nhật Hồ Sơ</h4><p>Chỉnh sửa thông tin</p></div>
                </a>
            </div>
        </div>
    </div>
</main>

</body>
</html>
