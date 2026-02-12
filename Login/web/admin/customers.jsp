<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.User" %>
<%
    HttpSession s = request.getSession(false);
    User u = (s == null) ? null : (User) s.getAttribute("user");
    if (u == null || !"ADMIN".equalsIgnoreCase(u.roleName)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Khách hàng - VietAir Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: #f7fafc;
            color: #2d3748;
        }
        
        /* Header - VietAir Style */
        .header {
            background: linear-gradient(135deg, #2c5aa0 0%, #1e4070 100%);
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        
        .header .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 64px;
        }
        
        .logo-container {
            display: flex;
            align-items: center;
            gap: 12px;
            color: white;
            text-decoration: none;
        }
        
        .logo-icon {
            font-size: 28px;
            color: #00d4aa;
        }
        
        .logo-text {
            font-size: 24px;
            font-weight: 700;
            color: #ffffff;
        }
        
        .nav-menu {
            display: flex;
            align-items: center;
            gap: 32px;
        }
        
        .nav-item {
            color: rgba(255,255,255,0.9);
            text-decoration: none;
            padding: 12px 20px;
            border-radius: 6px;
            font-weight: 600;
            transition: all 0.2s;
        }
        
        .nav-item:hover,
        .nav-item.active {
            background: rgba(255,255,255,0.15);
            color: #ffffff;
        }
        
        .user-info {
            color: white;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .user-badge {
            background: rgba(255,255,255,0.2);
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
        
        /* Main Content */
        .main-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        /* Page Header */
        .page-header {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }
        
        .page-header h1 {
            font-size: 1.875rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .page-header h1 i {
            color: #2c5aa0;
        }
        
        .page-header p {
            color: #718096;
            font-size: 1rem;
        }
        
        /* Search and Filter Bar */
        .filter-bar {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .filter-form {
            display: flex;
            gap: 1rem;
            align-items: end;
            flex-wrap: wrap;
        }
        
        .filter-field {
            flex: 1;
            min-width: 200px;
        }
        
        .filter-field label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            font-size: 14px;
            color: #2d3748;
        }
        
        .filter-field input,
        .filter-field select {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.2s;
        }
        
        .filter-field input:focus,
        .filter-field select:focus {
            outline: none;
            border-color: #2c5aa0;
            box-shadow: 0 0 0 3px rgba(44,90,160,0.1);
        }
        
        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #2c5aa0 0%, #1e4070 100%);
            color: white;
            box-shadow: 0 2px 8px rgba(44,90,160,0.25);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(44,90,160,0.35);
        }
        
        .btn-secondary {
            background: #e2e8f0;
            color: #2d3748;
        }
        
        .btn-secondary:hover {
            background: #cbd5e0;
        }
        
        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border-left: 4px solid #2c5aa0;
        }
        
        .stat-label {
            font-size: 0.875rem;
            color: #718096;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: #2d3748;
            margin-top: 0.5rem;
        }
        
        /* Table */
        .table-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            overflow: hidden;
        }
        
        .data-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .data-table thead {
            background: linear-gradient(135deg, #2c5aa0 0%, #1e4070 100%);
            color: white;
        }
        
        .data-table th {
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
        }
        
        .data-table td {
            padding: 1rem;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .data-table tbody tr:hover {
            background: #f7fafc;
        }
        
        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }
        
        .status-active {
            background: #d4edda;
            color: #155724;
        }
        
        .status-inactive {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-banned {
            background: #f8d7da;
            color: #721c24;
        }
        
        .btn-sm {
            padding: 0.5rem 1rem;
            font-size: 13px;
        }
        
        .btn-view {
            background: #0891b2;
            color: white;
        }
        
        .btn-view:hover {
            background: #0e7490;
        }
        
        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
            margin-top: 2rem;
        }
        
        .pagination a,
        .pagination span {
            padding: 0.5rem 1rem;
            border-radius: 6px;
            text-decoration: none;
            color: #2d3748;
            font-weight: 600;
        }
        
        .pagination a {
            background: white;
            border: 1px solid #e2e8f0;
        }
        
        .pagination a:hover {
            background: #f7fafc;
            border-color: #2c5aa0;
        }
        
        .pagination .active {
            background: #2c5aa0;
            color: white;
        }
        
        /* Alert */
        .alert {
            padding: 1rem 1.25rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }
        
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }
        
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #718096;
        }
        
        .empty-state i {
            font-size: 3rem;
            color: #cbd5e0;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <a href="<%= request.getContextPath() %>/admin.jsp" class="logo-container">
                <i class="fas fa-plane-departure logo-icon"></i>
                <span class="logo-text">VietAir</span>
            </a>
            <nav class="nav-menu">
                <a href="<%= request.getContextPath() %>/" class="nav-item">Trang chủ</a>
                <a href="#" class="nav-item">Tours</a>
                <a href="<%= request.getContextPath() %>/admin/customers" class="nav-item active">Khách hàng</a>
                <a href="<%= request.getContextPath() %>/admin.jsp" class="nav-item">ADMIN</a>
            </nav>
            <div class="user-info">
                <span><%= u.username %></span>
                <span class="user-badge">ADMIN</span>
                <a href="<%= request.getContextPath() %>/logout" class="btn btn-secondary btn-sm">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Page Header -->
        <div class="page-header">
            <h1>
                <i class="fas fa-users"></i>
                Quản lý Khách hàng
            </h1>
            <p>Xem, tìm kiếm và quản lý thông tin khách hàng</p>
        </div>

        <!-- Alerts -->
        <c:if test="${not empty param.success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <c:choose>
                    <c:when test="${param.success == 'updated'}">Cập nhật thông tin thành công!</c:when>
                    <c:when test="${param.success == 'statusupdated'}">Cập nhật trạng thái thành công!</c:when>
                </c:choose>
            </div>
        </c:if>

        <c:if test="${not empty param.error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                Có lỗi xảy ra. Vui lòng thử lại!
            </div>
        </c:if>

        <!-- Stats -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-label">Tổng khách hàng</div>
                <div class="stat-value">${totalCustomers}</div>
            </div>
        </div>

        <!-- Search and Filter -->
        <div class="filter-bar">
            <form class="filter-form" method="GET" action="<%= request.getContextPath() %>/admin/customers">
                <div class="filter-field">
                    <label>Tìm kiếm</label>
                    <input type="text" name="keyword" placeholder="Tên, email, số điện thoại..." 
                           value="${keyword}">
                </div>
                <div class="filter-field">
                    <label>Trạng thái</label>
                    <select name="status">
                        <option value="">Tất cả</option>
                        <option value="active" ${filterStatus == 'active' ? 'selected' : ''}>Active</option>
                        <option value="inactive" ${filterStatus == 'inactive' ? 'selected' : ''}>Inactive</option>
                        <option value="banned" ${filterStatus == 'banned' ? 'selected' : ''}>Banned</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-search"></i> Tìm kiếm
                </button>
                <a href="<%= request.getContextPath() %>/admin/customers" class="btn btn-secondary">
                    <i class="fas fa-redo"></i> Làm mới
                </a>
            </form>
        </div>

        <!-- Customer Table -->
        <div class="table-container">
            <c:choose>
                <c:when test="${empty customers}">
                    <div class="empty-state">
                        <i class="fas fa-users"></i>
                        <h3>Không tìm thấy khách hàng</h3>
                        <p>Không có khách hàng nào phù hợp với tiêu chí tìm kiếm</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Số điện thoại</th>
                                <th>Trạng thái</th>
                                <th>Ngày tạo</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="customer" items="${customers}">
                                <tr>
                                    <td>${customer.id}</td>
                                    <td>${customer.fullName}</td>
                                    <td>${customer.email}</td>
                                    <td>${customer.phone}</td>
                                    <td>
                                        <span class="status-badge status-${customer.status}">
                                            ${customer.status}
                                        </span>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${customer.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td>
                                        <a href="<%= request.getContextPath() %>/admin/customers?action=view&id=${customer.id}" 
                                           class="btn btn-view btn-sm">
                                            <i class="fas fa-eye"></i> Xem
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="pagination">
                            <c:if test="${currentPage > 1}">
                                <a href="?page=${currentPage - 1}<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if><c:if test='${not empty filterStatus}'>&status=${filterStatus}</c:if>">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </c:if>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <span class="active">${i}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="?page=${i}<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if><c:if test='${not empty filterStatus}'>&status=${filterStatus}</c:if>">
                                            ${i}
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            
                            <c:if test="${currentPage < totalPages}">
                                <a href="?page=${currentPage + 1}<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if><c:if test='${not empty filterStatus}'>&status=${filterStatus}</c:if>">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </c:if>
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
