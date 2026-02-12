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
    <title>Chi tiết Khách hàng - VietAir Admin</title>
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
        }
        
        .nav-menu {
            display: flex;
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
        
        .main-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .page-header {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .page-header h1 {
            font-size: 1.875rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .page-header h1 i {
            color: #2c5aa0;
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
        }
        
        .btn-secondary {
            background: #e2e8f0;
            color: #2d3748;
        }
        
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        
        .btn-success {
            background: #28a745;
            color: white;
        }
        
        .btn-sm {
            padding: 0.5rem 1rem;
            font-size: 13px;
        }
        
        .content-grid {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 2rem;
        }
        
        .card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #e2e8f0;
        }
        
        .card-header h2 {
            font-size: 1.25rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .info-group {
            margin-bottom: 1.5rem;
        }
        
        .info-label {
            font-size: 0.875rem;
            color: #718096;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        
        .info-value {
            font-size: 1rem;
            color: #2d3748;
            font-weight: 500;
        }
        
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 12px;
            font-size: 14px;
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
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .stat-box {
            background: #f7fafc;
            padding: 1rem;
            border-radius: 8px;
            text-align: center;
        }
        
        .stat-box .stat-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: #2c5aa0;
        }
        
        .stat-box .stat-label {
            font-size: 0.875rem;
            color: #718096;
            margin-top: 0.25rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            font-size: 14px;
        }
        
        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
        }
        
        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #2c5aa0;
        }
        
        .timeline {
            position: relative;
            padding-left: 2rem;
        }
        
        .timeline::before {
            content: '';
            position: absolute;
            left: 0.5rem;
            top: 0;
            bottom: 0;
            width: 2px;
            background: #e2e8f0;
        }
        
        .timeline-item {
            position: relative;
            margin-bottom: 1.5rem;
        }
        
        .timeline-item::before {
            content: '';
            position: absolute;
            left: -1.5rem;
            top: 0.25rem;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: #2c5aa0;
            border: 2px solid white;
            box-shadow: 0 0 0 2px #2c5aa0;
        }
        
        .timeline-content {
            background: #f7fafc;
            padding: 1rem;
            border-radius: 8px;
        }
        
        .timeline-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }
        
        .timeline-type {
            font-weight: 600;
            color: #2c5aa0;
        }
        
        .timeline-date {
            font-size: 0.875rem;
            color: #718096;
        }
        
        .timeline-desc {
            color: #2d3748;
            font-size: 0.875rem;
        }
        
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
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
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
                <i class="fas fa-user"></i>
                Chi tiết Khách hàng
            </h1>
            <a href="<%= request.getContextPath() %>/admin/customers" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Quay lại
            </a>
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

        <!-- Content Grid -->
        <div class="content-grid">
            <!-- Left Column - Customer Info -->
            <div>
                <div class="card">
                    <div class="card-header">
                        <h2><i class="fas fa-user-circle"></i> Thông tin cơ bản</h2>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">ID</div>
                        <div class="info-value">#${customer.id}</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Họ tên</div>
                        <div class="info-value">${customer.fullName}</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Email</div>
                        <div class="info-value">${customer.email}</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Số điện thoại</div>
                        <div class="info-value">${customer.phone}</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Địa chỉ</div>
                        <div class="info-value">${customer.address}</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Ngày sinh</div>
                        <div class="info-value">
                            <fmt:formatDate value="${customer.dateOfBirth}" pattern="dd/MM/yyyy"/>
                        </div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Trạng thái</div>
                        <div class="info-value">
                            <span class="status-badge status-${customer.status}">
                                ${customer.status}
                            </span>
                        </div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Ngày tạo</div>
                        <div class="info-value">
                            <fmt:formatDate value="${customer.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                        </div>
                    </div>
                    
                    <!-- Status Actions -->
                    <div class="action-buttons">
                        <c:choose>
                            <c:when test="${customer.status == 'active'}">
                                <form method="POST" action="<%= request.getContextPath() %>/admin/customers" style="display:inline;">
                                    <input type="hidden" name="action" value="updateStatus">
                                    <input type="hidden" name="customerId" value="${customer.id}">
                                    <input type="hidden" name="status" value="banned">
                                    <button type="submit" class="btn btn-danger btn-sm" 
                                            onclick="return confirm('Bạn có chắc muốn khóa tài khoản này?')">
                                        <i class="fas fa-lock"></i> Khóa tài khoản
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <form method="POST" action="<%= request.getContextPath() %>/admin/customers" style="display:inline;">
                                    <input type="hidden" name="action" value="updateStatus">
                                    <input type="hidden" name="customerId" value="${customer.id}">
                                    <input type="hidden" name="status" value="active">
                                    <button type="submit" class="btn btn-success btn-sm">
                                        <i class="fas fa-unlock"></i> Mở khóa
                                    </button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Right Column - Edit Form & Activities -->
            <div>
                <!-- Edit Form -->
                <div class="card">
                    <div class="card-header">
                        <h2><i class="fas fa-edit"></i> Chỉnh sửa thông tin</h2>
                    </div>
                    
                    <form method="POST" action="<%= request.getContextPath() %>/admin/customers">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="customerId" value="${customer.id}">
                        
                        <div class="form-group">
                            <label>Họ tên</label>
                            <input type="text" name="fullName" value="${customer.fullName}" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" value="${customer.email}" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Số điện thoại</label>
                            <input type="text" name="phone" value="${customer.phone}" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Địa chỉ</label>
                            <textarea name="address" rows="3">${customer.address}</textarea>
                        </div>
                        
                        <div class="form-group">
                            <label>Ngày sinh</label>
                            <input type="date" name="dateOfBirth" 
                                   value="<fmt:formatDate value='${customer.dateOfBirth}' pattern='yyyy-MM-dd'/>">
                        </div>
                        
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Lưu thay đổi
                        </button>
                    </form>
                </div>

                <!-- Activity Stats -->
                <div class="card" style="margin-top: 2rem;">
                    <div class="card-header">
                        <h2><i class="fas fa-chart-bar"></i> Thống kê hoạt động</h2>
                    </div>
                    
                    <div class="stats-grid">
                        <div class="stat-box">
                            <div class="stat-value">${totalActivities}</div>
                            <div class="stat-label">Tổng hoạt động</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-value">${bookingCount}</div>
                            <div class="stat-label">Đặt tour</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-value">${searchCount}</div>
                            <div class="stat-label">Tìm kiếm</div>
                        </div>
                    </div>
                </div>

                <!-- Activity Timeline -->
                <div class="card" style="margin-top: 2rem;">
                    <div class="card-header">
                        <h2><i class="fas fa-history"></i> Lịch sử hoạt động</h2>
                    </div>
                    
                    <c:choose>
                        <c:when test="${empty activities}">
                            <p style="text-align:center; color:#718096; padding:2rem;">
                                Chưa có hoạt động nào
                            </p>
                        </c:when>
                        <c:otherwise>
                            <div class="timeline">
                                <c:forEach var="activity" items="${activities}">
                                    <div class="timeline-item">
                                        <div class="timeline-content">
                                            <div class="timeline-header">
                                                <span class="timeline-type">${activity.actionType}</span>
                                                <span class="timeline-date">
                                                    <fmt:formatDate value="${activity.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                                </span>
                                            </div>
                                            <div class="timeline-desc">${activity.description}</div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
