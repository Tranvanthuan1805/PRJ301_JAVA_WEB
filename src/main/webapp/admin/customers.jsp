<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Khách Hàng | Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .dashboard-wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: 260px; padding: 30px; background: #f8f9fa; }
        .page-title { font-size: 1.8rem; color: #0a2351; margin-bottom: 8px; }
        .page-subtitle { color: #b2bec3; margin-bottom: 25px; }

        .toolbar {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 20px; flex-wrap: wrap; gap: 15px;
        }
        .search-box {
            display: flex; gap: 10px;
        }
        .search-box input {
            padding: 10px 18px; border: 2px solid #e9ecef; border-radius: 10px;
            font-family: 'Inter', sans-serif; width: 280px; font-size: 0.9rem;
        }
        .search-box input:focus { outline: none; border-color: #4facfe; }
        .search-box button {
            padding: 10px 20px; background: #0a2351; color: white;
            border: none; border-radius: 10px; cursor: pointer; font-weight: 600;
        }

        .data-table {
            width: 100%; background: white; border-radius: 14px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04); overflow: hidden; border: 1px solid #f0f0f0;
        }
        .data-table th {
            background: #f8f9fa; padding: 14px 18px; text-align: left;
            font-size: 0.8rem; text-transform: uppercase; letter-spacing: 1px;
            color: #b2bec3; font-weight: 700; border-bottom: 1px solid #eee;
        }
        .data-table td {
            padding: 14px 18px; border-bottom: 1px solid #f5f5f5; font-size: 0.9rem; color: #2d3436;
        }
        .data-table tr:hover { background: #fafbfc; }

        .user-cell {
            display: flex; align-items: center; gap: 12px;
        }
        .user-avatar {
            width: 40px; height: 40px; border-radius: 50%;
            background: linear-gradient(135deg, #0a2351, #1a3a7a); color: white;
            display: flex; align-items: center; justify-content: center;
            font-weight: 700; font-size: 0.9rem;
        }
        .user-name { font-weight: 600; }
        .user-email { font-size: 0.8rem; color: #b2bec3; }

        .badge { padding: 4px 12px; border-radius: 20px; font-size: 0.75rem; font-weight: 700; }
        .badge-active { background: #d4edda; color: #155724; }
        .badge-inactive { background: #f8d7da; color: #721c24; }
        .badge-admin { background: #fff3cd; color: #856404; }

        .btn-sm {
            padding: 6px 12px; border-radius: 8px; font-size: 0.8rem; font-weight: 600;
            border: none; cursor: pointer; transition: 0.2s; text-decoration: none; display: inline-flex; gap: 4px; align-items: center;
        }
        .btn-edit { background: #e8f4fd; color: #2980b9; }
        .btn-edit:hover { background: #2980b9; color: white; }
        .btn-delete { background: #fdecea; color: #e74c3c; }
        .btn-delete:hover { background: #e74c3c; color: white; }

        .pagination { display: flex; justify-content: center; gap: 6px; margin-top: 25px; }
        .pagination a, .pagination span {
            padding: 8px 14px; border-radius: 8px; font-weight: 600;
            text-decoration: none; font-size: 0.85rem;
        }
        .pagination a { background: white; color: #0a2351; border: 1px solid #e9ecef; }
        .pagination a:hover { border-color: #0a2351; }
        .pagination .active { background: #0a2351; color: white; }

        .stat-cards { display: grid; grid-template-columns: repeat(3, 1fr); gap: 18px; margin-bottom: 25px; }
        .stat-card-mini {
            background: white; border-radius: 14px; padding: 22px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04); border: 1px solid #f0f0f0;
        }
        .stat-card-mini .icon { font-size: 1.5rem; margin-bottom: 10px; }
        .stat-card-mini .num { font-size: 1.8rem; font-weight: 800; color: #0a2351; }
        .stat-card-mini .label { font-size: 0.82rem; color: #b2bec3; margin-top: 3px; }

        @media (max-width: 768px) {
            .main-content { margin-left: 0; }
            .stat-cards { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="dashboard-wrapper">
        <jsp:include page="/common/_sidebar.jsp" />

        <div class="main-content">
            <h1 class="page-title"><i class="fas fa-users"></i> Quản Lý Khách Hàng</h1>
            <p class="page-subtitle">Quản lý thông tin khách hàng và người dùng hệ thống</p>

            <div class="stat-cards">
                <div class="stat-card-mini">
                    <div class="icon">👥</div>
                    <div class="num">${totalCustomers}</div>
                    <div class="label">Tổng khách hàng</div>
                </div>
                <div class="stat-card-mini">
                    <div class="icon">✅</div>
                    <div class="num">${activeCount}</div>
                    <div class="label">Đang hoạt động</div>
                </div>
                <div class="stat-card-mini">
                    <div class="icon">📈</div>
                    <div class="num">${newThisMonth}</div>
                    <div class="label">Mới trong tháng</div>
                </div>
            </div>

            <div class="toolbar">
                <form class="search-box" action="${pageContext.request.contextPath}/admin/customers" method="get">
                    <input type="text" name="keyword" value="${keyword}" placeholder="🔍 Tìm theo tên, email, SĐT...">
                    <select name="status" style="padding:10px 14px;border:2px solid #e9ecef;border-radius:10px;font-family:'Inter',sans-serif;font-size:.9rem">
                        <option value="">Tất cả trạng thái</option>
                        <option value="active" ${filterStatus == 'active' ? 'selected' : ''}>Hoạt động</option>
                        <option value="inactive" ${filterStatus == 'inactive' ? 'selected' : ''}>Tạm ngưng</option>
                        <option value="banned" ${filterStatus == 'banned' ? 'selected' : ''}>Bị khóa</option>
                    </select>
                    <button type="submit"><i class="fas fa-search"></i> Tìm</button>
                </form>
            </div>

            <c:choose>
                <c:when test="${not empty customers}">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Khách hàng</th>
                                <th>Email</th>
                                <th>Số điện thoại</th>
                                <th>Vai trò</th>
                                <th>Trạng thái</th>
                                <th>Ngày tạo</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${customers}" var="c">
                                <tr>
                                    <td>
                                        <div class="user-cell">
                                            <div class="user-avatar">${c.username.substring(0,1).toUpperCase()}</div>
                                            <div>
                                                <div class="user-name">${c.fullName != null ? c.fullName : c.username}</div>
                                                <div class="user-email">@${c.username}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>${c.email}</td>
                                    <td>${c.phone}</td>
                                    <td>
                                        <span class="badge ${c.role.roleName == 'ADMIN' ? 'badge-admin' : 'badge-active'}">${c.role.roleName}</span>
                                    </td>
                                    <td>
                                        <span class="badge ${c.active ? 'badge-active' : 'badge-inactive'}">${c.statusText}</span>
                                    </td>
                                    <td style="color: #b2bec3; font-size: 0.85rem;">
                                        <fmt:formatDate value="${c.createdAt}" pattern="dd/MM/yyyy"/>
                                    </td>
                                    <td>
                                        <div style="display: flex; gap: 6px;">
                                            <a href="${pageContext.request.contextPath}/admin/customers?action=view&id=${c.customerId}" class="btn-sm btn-edit" title="Xem">
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

                    <c:if test="${totalPages > 1}">
                        <div class="pagination">
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <span class="active">${i}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/admin/customers?page=${i}&search=${searchQuery}">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 60px; background: white; border-radius: 14px;">
                        <i class="fas fa-users" style="font-size: 3rem; color: #ddd; margin-bottom: 15px;"></i>
                        <h3 style="color: #636e72;">Chưa có khách hàng nào</h3>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
