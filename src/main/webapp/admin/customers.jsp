<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Khách Hàng | Admin</title>
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
    .btn-outline{display:inline-flex;align-items:center;gap:8px;padding:10px 22px;border-radius:10px;background:transparent;color:rgba(255,255,255,.7);font-weight:600;font-size:.85rem;border:1px solid rgba(255,255,255,.1);cursor:pointer;transition:.3s;font-family:inherit;text-decoration:none}
    .btn-outline:hover{border-color:rgba(255,255,255,.3);color:#fff}

    /* Stats */
    .stats{display:grid;grid-template-columns:repeat(3,1fr);gap:20px;margin-bottom:32px}
    .stat{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:24px;position:relative;overflow:hidden;transition:.3s}
    .stat:hover{border-color:rgba(59,130,246,.2);transform:translateY(-2px)}
    .stat .icon{width:44px;height:44px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:1rem;margin-bottom:14px}
    .stat .label{font-size:.78rem;color:rgba(255,255,255,.4);font-weight:600;text-transform:uppercase;letter-spacing:1px;margin-bottom:6px}
    .stat .value{font-size:1.8rem;font-weight:800;color:#fff;letter-spacing:-1px}
    .icon-blue{background:rgba(59,130,246,.15);color:#60A5FA}
    .icon-green{background:rgba(16,185,129,.15);color:#34D399}
    .icon-orange{background:rgba(245,158,11,.15);color:#FBBF24}

    /* Search */
    .search-bar{display:flex;gap:12px;margin-bottom:24px;flex-wrap:wrap}
    .search-bar input,.search-bar select{padding:12px 18px;background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:10px;color:#fff;font-family:inherit;font-size:.88rem}
    .search-bar input{flex:1;min-width:250px}
    .search-bar input::placeholder{color:rgba(255,255,255,.3)}
    .search-bar input:focus,.search-bar select:focus{outline:none;border-color:rgba(59,130,246,.3);background:rgba(255,255,255,.06)}
    .search-bar select{min-width:180px}
    .search-bar select option{background:#1a1f3a;color:#fff}
    .btn-search{padding:12px 24px;background:#3B82F6;color:#fff;border:none;border-radius:10px;font-weight:600;cursor:pointer;transition:.3s;font-family:inherit;display:inline-flex;align-items:center;gap:8px}
    .btn-search:hover{background:#2563EB;transform:translateY(-1px)}

    /* Table */
    .card{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:24px;margin-bottom:24px}
    table{width:100%;border-collapse:collapse}
    thead th{padding:12px 16px;text-align:left;font-size:.72rem;text-transform:uppercase;letter-spacing:1px;color:rgba(255,255,255,.3);font-weight:700;border-bottom:1px solid rgba(255,255,255,.06)}
    tbody td{padding:14px 16px;border-bottom:1px solid rgba(255,255,255,.04);font-size:.88rem;color:rgba(255,255,255,.7)}
    tbody tr:hover{background:rgba(255,255,255,.02)}

    .user-cell{display:flex;align-items:center;gap:12px}
    .user-avatar{width:40px;height:40px;border-radius:10px;background:linear-gradient(135deg,#3B82F6,#60A5FA);display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;font-size:.9rem}
    .user-name{font-weight:600;color:#fff}
    .user-email{font-size:.8rem;color:rgba(255,255,255,.4);margin-top:2px}

    .badge{padding:4px 12px;border-radius:999px;font-size:.72rem;font-weight:700}
    .badge-active{background:rgba(16,185,129,.15);color:#34D399}
    .badge-inactive{background:rgba(239,68,68,.15);color:#F87171}
    .badge-admin{background:rgba(245,158,11,.15);color:#FBBF24}

    .btn-sm{padding:8px 14px;border-radius:8px;font-size:.82rem;font-weight:600;border:none;cursor:pointer;transition:.3s;text-decoration:none;display:inline-flex;align-items:center;gap:6px}
    .btn-view{background:rgba(59,130,246,.2);color:#60A5FA;border:1px solid rgba(59,130,246,.3)}
    .btn-view:hover{background:#3B82F6;color:#fff}
    .btn-edit{background:rgba(16,185,129,.2);color:#34D399;border:1px solid rgba(16,185,129,.3)}
    .btn-edit:hover{background:#10B981;color:#fff}
    .btn-delete{background:rgba(239,68,68,.2);color:#F87171;border:1px solid rgba(239,68,68,.3)}
    .btn-delete:hover{background:#EF4444;color:#fff}

    .empty{text-align:center;padding:60px 20px;color:rgba(255,255,255,.3)}
    .empty i{font-size:3rem;margin-bottom:15px;opacity:.5}

    @media(max-width:1200px){.stats{grid-template-columns:repeat(2,1fr)}}
    @media(max-width:768px){.main{margin-left:0;padding:16px}.stats{grid-template-columns:1fr}.sidebar{display:none}}
    </style>
</head>
<body>

<!-- Sidebar -->
<aside class="sidebar">
    <div class="logo"><img src="${pageContext.request.contextPath}/images/logo.png" style="width:36px;height:36px;border-radius:50%;display:inline-block;vertical-align:middle;margin-right:8px"><span style="vertical-align:middle"><span class="a">ez</span>travel</span> <span class="badge-admin">ADMIN</span></div>
    <nav>
        <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-chart-pie"></i> Tổng Quan</a>
        <a href="${pageContext.request.contextPath}/admin/customers" class="active"><i class="fas fa-users"></i> Khách Hàng</a>
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
            <h1><i class="fas fa-users" style="color:#60A5FA;margin-right:12px"></i>Quản Lý Khách Hàng</h1>
            <p>Quản lý thông tin khách hàng và người dùng hệ thống</p>
        </div>
        <div class="header-actions">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-outline"><i class="fas fa-arrow-left"></i> Quay lại</a>
        </div>
    </header>

    <!-- Stats -->
    <section class="stats">
        <div class="stat">
            <div class="icon icon-blue"><i class="fas fa-users"></i></div>
            <div class="label">Tổng Khách Hàng</div>
            <div class="value">${totalCustomers}</div>
        </div>
        <div class="stat">
            <div class="icon icon-green"><i class="fas fa-check-circle"></i></div>
            <div class="label">Đang Hoạt Động</div>
            <div class="value" style="color:#34D399">${activeCount}</div>
        </div>
        <div class="stat">
            <div class="icon icon-orange"><i class="fas fa-user-plus"></i></div>
            <div class="label">Mới Trong Tháng</div>
            <div class="value" style="color:#FBBF24">${newThisMonth}</div>
        </div>
    </section>

    <!-- Search -->
    <form class="search-bar" action="${pageContext.request.contextPath}/admin/customers" method="get">
        <input type="text" name="keyword" value="${keyword}" placeholder="🔍 Tìm theo tên, email, SĐT...">
        <select name="status">
            <option value="">Tất cả trạng thái</option>
            <option value="active" ${filterStatus == 'active' ? 'selected' : ''}>Hoạt động</option>
            <option value="inactive" ${filterStatus == 'inactive' ? 'selected' : ''}>Tạm ngưng</option>
        </select>
        <button type="submit" class="btn-search"><i class="fas fa-search"></i> Tìm kiếm</button>
    </form>

    <!-- Table -->
    <div class="card">
        <c:choose>
            <c:when test="${not empty customers}">
                <table>
                    <thead>
                        <tr>
                            <th>Khách hàng</th>
                            <th>Email</th>
                            <th>Số điện thoại</th>
                            <th>Vai trò</th>
                            <th>Trạng thái</th>
                            <th>Ngày tạo</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${customers}" var="c">
                            <tr>
                                <td>
                                    <div class="user-cell">
                                        <div class="user-avatar">${c.user.username.substring(0,1).toUpperCase()}</div>
                                        <div>
                                            <div class="user-name">${c.fullName != null ? c.fullName : c.user.username}</div>
                                            <div class="user-email">@${c.user.username}</div>
                                        </div>
                                    </div>
                                </td>
                                <td>${c.email}</td>
                                <td>${c.phone != null ? c.phone : '-'}</td>
                                <td>
                                    <span class="badge ${c.user.role.roleName == 'ADMIN' ? 'badge-admin' : 'badge-active'}">${c.user.role.roleName}</span>
                                </td>
                                <td>
                                    <span class="badge ${c.status == 'active' ? 'badge-active' : 'badge-inactive'}">${c.statusText}</span>
                                </td>
                                <td style="color:rgba(255,255,255,.5);font-size:.85rem">
                                    <fmt:formatDate value="${c.user.createdAt}" pattern="dd/MM/yyyy"/>
                                </td>
                                <td>
                                    <div style="display:flex;gap:6px">
                                        <a href="${pageContext.request.contextPath}/admin/customers?action=view&id=${c.customerId}" class="btn-sm btn-view" title="Xem">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/customers?action=edit&id=${c.customerId}" class="btn-sm btn-edit" title="Sửa">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/customers?action=delete&id=${c.customerId}" class="btn-sm btn-delete" title="Xóa" onclick="return confirm('Bạn có chắc muốn xóa khách hàng này?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="empty">
                    <i class="fas fa-users"></i>
                    <p>Chưa có khách hàng nào</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

</body>
</html>
