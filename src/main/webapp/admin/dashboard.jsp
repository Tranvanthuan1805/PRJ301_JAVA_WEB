<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | eztravel</title>
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
    .sidebar .badge-admin{display:inline-block;padding:2px 8px;border-radius:6px;background:rgba(239,68,68,.15);color:#F87171;font-size:.65rem;font-weight:700;font-family:'Inter',sans-serif;margin-left:6px;vertical-align:middle}
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

    /* Main */
    .main{margin-left:260px;padding:32px 40px;min-height:100vh}
    .page-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:32px}
    .page-header h1{font-size:1.8rem;font-weight:800;color:#fff}
    .page-header p{color:rgba(255,255,255,.5);font-size:.9rem;margin-top:4px}
    .header-actions{display:flex;gap:10px}
    .btn-primary{display:inline-flex;align-items:center;gap:8px;padding:10px 22px;border-radius:10px;background:#3B82F6;color:#fff;font-weight:700;font-size:.85rem;border:none;cursor:pointer;transition:.3s;font-family:inherit;text-decoration:none}
    .btn-primary:hover{background:#2563EB;transform:translateY(-1px);box-shadow:0 4px 16px rgba(59,130,246,.3)}
    .btn-danger{background:linear-gradient(135deg,#EF4444,#F87171)}
    .btn-outline{display:inline-flex;align-items:center;gap:8px;padding:10px 22px;border-radius:10px;background:transparent;color:rgba(255,255,255,.7);font-weight:600;font-size:.85rem;border:1px solid rgba(255,255,255,.1);cursor:pointer;transition:.3s;font-family:inherit;text-decoration:none}
    .btn-outline:hover{border-color:rgba(255,255,255,.3);color:#fff}

    /* Stats */
    .stats{display:grid;grid-template-columns:repeat(4,1fr);gap:20px;margin-bottom:32px}
    .stat{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:24px;position:relative;overflow:hidden;transition:.3s}
    .stat:hover{border-color:rgba(59,130,246,.2);transform:translateY(-2px)}
    .stat .icon{width:44px;height:44px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:1rem;margin-bottom:14px}
    .stat .label{font-size:.78rem;color:rgba(255,255,255,.4);font-weight:600;text-transform:uppercase;letter-spacing:1px;margin-bottom:6px}
    .stat .value{font-size:1.8rem;font-weight:800;color:#fff;letter-spacing:-1px}
    .stat .trend{font-size:.75rem;margin-top:8px;font-weight:600}
    .trend-up{color:#10B981}
    .icon-blue{background:rgba(59,130,246,.15);color:#60A5FA}
    .icon-green{background:rgba(16,185,129,.15);color:#34D399}
    .icon-orange{background:rgba(245,158,11,.15);color:#FBBF24}
    .icon-red{background:rgba(239,68,68,.15);color:#F87171}

    /* Cards */
    .card{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:24px;margin-bottom:24px}
    .card h3{font-size:1.05rem;font-weight:700;color:#fff;margin-bottom:20px;display:flex;align-items:center;gap:10px}
    .card h3 i{color:#60A5FA;font-size:.9rem}
    .grid-2{display:grid;grid-template-columns:1.5fr 1fr;gap:24px}

    /* Table */
    table{width:100%;border-collapse:collapse}
    thead th{padding:12px 16px;text-align:left;font-size:.72rem;text-transform:uppercase;letter-spacing:1px;color:rgba(255,255,255,.3);font-weight:700;border-bottom:1px solid rgba(255,255,255,.06)}
    tbody td{padding:14px 16px;border-bottom:1px solid rgba(255,255,255,.04);font-size:.88rem;color:rgba(255,255,255,.7)}
    tbody tr:hover{background:rgba(255,255,255,.02)}
    .badge{padding:4px 12px;border-radius:999px;font-size:.72rem;font-weight:700}
    .badge-green{background:rgba(16,185,129,.15);color:#34D399}
    .badge-yellow{background:rgba(245,158,11,.15);color:#FBBF24}
    .badge-red{background:rgba(239,68,68,.15);color:#F87171}

    /* AI Panel */
    .ai-panel{border-left:3px solid #3B82F6}
    .ai-header{display:flex;align-items:center;gap:14px;margin-bottom:20px}
    .ai-icon{width:44px;height:44px;border-radius:12px;background:linear-gradient(135deg,#1E293B,#334155);display:flex;align-items:center;justify-content:center;color:#60A5FA;font-size:1.1rem}
    .ai-chart{background:rgba(255,255,255,.02);height:200px;border-radius:12px;display:flex;align-items:center;justify-content:center;border:1px solid rgba(255,255,255,.04)}
    .ai-chart p{color:rgba(255,255,255,.3);font-size:.85rem;text-align:center;padding:20px}
    .ai-metrics{display:grid;grid-template-columns:1fr 1fr;gap:12px;margin-top:16px}
    .ai-metric{padding:16px;background:rgba(255,255,255,.03);border-radius:10px;border:1px solid rgba(255,255,255,.05)}
    .ai-metric small{font-size:.7rem;color:rgba(255,255,255,.3);text-transform:uppercase;letter-spacing:.5px;font-weight:700}
    .ai-metric .val{font-weight:800;color:#fff;margin-top:4px;font-size:.9rem}
    .ai-metric .val.success{color:#34D399}

    @media(max-width:1200px){.stats{grid-template-columns:repeat(2,1fr)}.grid-2{grid-template-columns:1fr}}
    @media(max-width:768px){.main{margin-left:0;padding:16px}.stats{grid-template-columns:1fr}.sidebar{display:none}}
    </style>
</head>
<body>

<!-- Sidebar -->
<aside class="sidebar">
    <div class="logo"><img src="${pageContext.request.contextPath}/images/logo.png" style="width:36px;height:36px;border-radius:50%;display:inline-block;vertical-align:middle;margin-right:8px"><span style="vertical-align:middle"><span class="a">ez</span>travel</span> <span class="badge-admin">ADMIN</span></div>
    <nav>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="active"><i class="fas fa-chart-pie"></i> Tổng Quan</a>
        <a href="${pageContext.request.contextPath}/admin/customers"><i class="fas fa-users"></i> Khách Hàng</a>
        <div class="nav-label">Quản lý</div>
        <a href="${pageContext.request.contextPath}/admin/tours"><i class="fas fa-plane-departure"></i> Quản lý Tours</a>
        <a href="${pageContext.request.contextPath}/admin/tour-history"><i class="fas fa-history"></i> Lịch sử</a>
        <a href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-bag"></i> Đơn Hàng</a>
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

<!-- Main -->
<main class="main">
    <header class="page-header">
        <div>
            <h1>🏠 Tổng Quan Hệ Thống</h1>
            <p>Xin chào, <strong>${sessionScope.user.username}</strong> 👋 — Hôm nay hệ thống hoạt động bình thường.</p>
        </div>
        <div class="header-actions">
            <button class="btn-outline"><i class="fas fa-download"></i> Xuất Báo Cáo</button>
            <a href="${pageContext.request.contextPath}/logout" class="btn-outline"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a>
        </div>
    </header>

    <!-- Stats -->
    <section class="stats">
        <div class="stat">
            <div class="icon icon-blue"><i class="fas fa-users"></i></div>
            <div class="label">Tổng Người Dùng</div>
            <div class="value">${totalUsers}</div>
        </div>
        <div class="stat">
            <div class="icon icon-green"><i class="fas fa-map-marked-alt"></i></div>
            <div class="label">Tours Hoạt Động</div>
            <div class="value">${activeTours}</div>
        </div>
        <div class="stat">
            <div class="icon icon-orange"><i class="fas fa-shopping-bag"></i></div>
            <div class="label">Tổng Đơn Hàng</div>
            <div class="value">${totalBookings}</div>
        </div>
        <div class="stat">
            <div class="icon icon-red"><i class="fas fa-clock"></i></div>
            <div class="label">Đơn Chờ Xử Lý</div>
            <div class="value" style="color:#F87171">${pendingRequests}</div>
        </div>
    </section>

    <div class="grid-2">
        <!-- Revenue + AI -->
        <div>
            <div class="card">
                <h3><i class="fas fa-coins"></i> Doanh Thu Tổng</h3>
                <div style="font-size:2.4rem;font-weight:800;color:#34D399;letter-spacing:-1px;margin-bottom:8px">
                    <fmt:formatNumber value="${grossRevenue}" type="number" groupingUsed="true"/>đ
                </div>
                <div class="trend-up" style="font-size:.85rem"><i class="fas fa-arrow-up"></i> Từ đơn hàng hoàn thành</div>
            </div>

            <div class="card ai-panel">
                <div class="ai-header">
                    <div class="ai-icon"><i class="fas fa-brain"></i></div>
                    <h3 style="margin-bottom:0">AI Dự Báo Nhu Cầu</h3>
                </div>
                <div class="ai-chart">
                    <p><i class="fas fa-chart-area" style="font-size:2rem;display:block;margin-bottom:12px;opacity:.3"></i>AI đang phân tích xu hướng đặt tour cho Lễ hội Pháo hoa Quốc tế Đà Nẵng...</p>
                </div>
                <div class="ai-metrics">
                    <div class="ai-metric"><small>Độ Tin Cậy</small><div class="val success">94.2%</div></div>
                    <div class="ai-metric"><small>Khuyến Nghị</small><div class="val">Tăng 15% công suất Tour Sông Hàn</div></div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="card">
            <h3><i class="fas fa-bolt"></i> Quản Trị Nhanh</h3>
            <div style="display:flex;flex-direction:column;gap:12px">
                <a href="${pageContext.request.contextPath}/admin/customers" style="display:flex;align-items:center;gap:14px;padding:16px;border-radius:12px;background:rgba(255,255,255,.03);border:1px solid rgba(255,255,255,.06);transition:.3s;text-decoration:none;color:inherit;cursor:pointer" onmouseover="this.style.background='rgba(255,255,255,.08)';this.style.borderColor='rgba(59,130,246,.3)';this.style.transform='translateY(-2px)'" onmouseout="this.style.background='rgba(255,255,255,.03)';this.style.borderColor='rgba(255,255,255,.06)';this.style.transform='translateY(0)'">
                    <div class="icon-blue" style="width:42px;height:42px;border-radius:10px;display:flex;align-items:center;justify-content:center"><i class="fas fa-users"></i></div>
                    <div><div style="font-size:.88rem;color:#fff;font-weight:600">Quản Lý Khách Hàng</div><div style="font-size:.75rem;color:rgba(255,255,255,.4);margin-top:2px">Xem danh sách khách hàng</div></div>
                </a>
                <a href="${pageContext.request.contextPath}/admin/orders" style="display:flex;align-items:center;gap:14px;padding:16px;border-radius:12px;background:rgba(255,255,255,.03);border:1px solid rgba(255,255,255,.06);transition:.3s;text-decoration:none;color:inherit;cursor:pointer" onmouseover="this.style.background='rgba(255,255,255,.08)';this.style.borderColor='rgba(245,158,11,.3)';this.style.transform='translateY(-2px)'" onmouseout="this.style.background='rgba(255,255,255,.03)';this.style.borderColor='rgba(255,255,255,.06)';this.style.transform='translateY(0)'">
                    <div class="icon-orange" style="width:42px;height:42px;border-radius:10px;display:flex;align-items:center;justify-content:center"><i class="fas fa-shopping-bag"></i></div>
                    <div><div style="font-size:.88rem;color:#fff;font-weight:600">Quản Lý Đơn Hàng</div><div style="font-size:.75rem;color:rgba(255,255,255,.4);margin-top:2px">Duyệt và xử lý đơn</div></div>
                </a>
                <a href="${pageContext.request.contextPath}/admin/tours" style="display:flex;align-items:center;gap:14px;padding:16px;border-radius:12px;background:rgba(255,255,255,.03);border:1px solid rgba(255,255,255,.06);transition:.3s;text-decoration:none;color:inherit;cursor:pointer" onmouseover="this.style.background='rgba(255,255,255,.08)';this.style.borderColor='rgba(16,185,129,.3)';this.style.transform='translateY(-2px)'" onmouseout="this.style.background='rgba(255,255,255,.03)';this.style.borderColor='rgba(255,255,255,.06)';this.style.transform='translateY(0)'">
                    <div class="icon-green" style="width:42px;height:42px;border-radius:10px;display:flex;align-items:center;justify-content:center"><i class="fas fa-map"></i></div>
                    <div><div style="font-size:.88rem;color:#fff;font-weight:600">Quản Lý Tours</div><div style="font-size:.75rem;color:rgba(255,255,255,.4);margin-top:2px">Tạo, sửa, xóa tour</div></div>
                </a>
                <a href="${pageContext.request.contextPath}/dbtest" style="display:flex;align-items:center;gap:14px;padding:16px;border-radius:12px;background:rgba(255,255,255,.03);border:1px solid rgba(255,255,255,.06);transition:.3s;text-decoration:none;color:inherit;cursor:pointer" onmouseover="this.style.background='rgba(255,255,255,.08)';this.style.borderColor='rgba(239,68,68,.3)';this.style.transform='translateY(-2px)'" onmouseout="this.style.background='rgba(255,255,255,.03)';this.style.borderColor='rgba(255,255,255,.06)';this.style.transform='translateY(0)'">
                    <div class="icon-red" style="width:42px;height:42px;border-radius:10px;display:flex;align-items:center;justify-content:center"><i class="fas fa-database"></i></div>
                    <div><div style="font-size:.88rem;color:#fff;font-weight:600">Kiểm Tra Database</div><div style="font-size:.75rem;color:rgba(255,255,255,.4);margin-top:2px">Test kết nối hệ thống</div></div>
                </a>
            </div>
        </div>
    </div>
</main>

</body>
</html>
