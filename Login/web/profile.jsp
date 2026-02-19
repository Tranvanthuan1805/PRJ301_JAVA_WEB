<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ page import="model.User" %>
                <% response.setCharacterEncoding("UTF-8"); request.setCharacterEncoding("UTF-8"); HttpSession
                    s=request.getSession(false); User u=(s==null) ? null : (User) s.getAttribute("user"); if (u==null) {
                    response.sendRedirect(request.getContextPath() + "/login.jsp" ); return; } boolean isAdmin=(u !=null
                    && u.roleName !=null && "ADMIN" .equalsIgnoreCase(u.roleName)); %>
                    <!DOCTYPE html>
                    <html lang="vi">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Thông tin cá nhân - VietAir</title>
                        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
                        <style>
                            * { margin: 0; padding: 0; box-sizing: border-box; }
                            body { font-family: 'Inter', sans-serif; line-height: 1.6; color: #2d3748; background: #f7fafc; }
                            .container { max-width: 1200px; margin: 0 auto; padding: 0 20px; }
                            
                            /* Header */
                            .header { background: linear-gradient(135deg, #2c5aa0 0%, #1e4070 100%); box-shadow: 0 4px 6px rgba(0,0,0,0.1); position: sticky; top: 0; z-index: 1000; }
                            .header .container { display: flex; align-items: center; justify-content: center; height: 64px; position: relative; }
                            .nav-brand { position: absolute; left: 20px; }
                            .nav-actions { position: absolute; right: 20px; }
                            .logo-container { display: flex; align-items: center; gap: 12px; color: #fff; }
                            .logo-icon { font-size: 28px; color: #00d4aa; }
                            .logo-text { font-size: 24px; font-weight: 700; color: #fff; }
                            .nav-menu { display: flex; gap: 32px; }
                            .nav-item { padding: 10px 18px; color: rgba(255,255,255,0.95); text-decoration: none; border-radius: 6px; font-weight: 500; transition: all 0.2s; }
                            .nav-item:hover, .nav-item.active { background: rgba(255,255,255,0.1); color: #fff; }
                            .nav-actions { display: flex; gap: 14px; align-items: center; }
                            .user-badge { padding: 6px 14px; background: rgba(100,150,200,0.4); border: 1px solid rgba(255,255,255,0.3); border-radius: 4px; color: #fff; font-size: 12px; font-weight: 600; text-transform: uppercase; }
                            .btn-login, .btn-register, .btn-logout { display: flex; align-items: center; gap: 6px; padding: 9px 18px; border-radius: 6px; font-weight: 600; font-size: 14px; text-decoration: none; transition: all 0.2s; }
                            .btn-login, .btn-logout { background: transparent; color: #fff; border: 2px solid rgba(255,255,255,0.5); }
                            .btn-login:hover, .btn-logout:hover { background: rgba(255,255,255,0.15); border-color: rgba(255,255,255,0.8); }
                            .btn-register { background: #00d4aa; color: #fff; border: none; box-shadow: 0 2px 8px rgba(0,212,170,0.3); }
                            .btn-register:hover { background: #00c49a; }

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
                                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
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
                                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
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
                        </style>
                    </head>

                    <body>
                        <!-- Header -->
                        <div class="header">
                            <div class="container">
                                <div class="nav-brand">
                                    <div class="logo-container">
                                        <i class="fas fa-plane-departure logo-icon"></i>
                                        <span class="logo-text">VietAir</span>
                                    </div>
                                </div>
                                <nav class="nav-menu">
                                    <a href="<%= request.getContextPath() %>/" class="nav-item">Trang chủ</a>
                                    <a href="<%= request.getContextPath() %>/tour-list.jsp" class="nav-item">Tours</a>
                                    <a href="<%= request.getContextPath() %>/profile" class="nav-item active">Profile</a>
                                </nav>
                                <div class="nav-actions">
                                    <span class="user-badge"><%= u.username %></span>
                                    <a href="<%= request.getContextPath() %>/logout" class="btn-logout">
                                        <i class="fas fa-sign-out-alt"></i>
                                        Đăng xuất
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- Hero Section -->
                        <section class="hero" style="min-height: 200px; padding: 60px 0;">
                            <div class="hero-background">
                                <div class="hero-overlay"></div>
                            </div>
                            <div class="hero-content" style="padding: 0;">
                                <div class="hero-text" style="text-align: center;">
                                    <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem;">VietAir - Hệ thống quản lý
                                        tour du lịch</h1>
                                    <p style="font-size: 1.1rem; opacity: 0.9;">Thông tin cá nhân</p>
                                </div>
                            </div>
                        </section>

                        <!-- Main Content -->
                        <div class="main-content">
                            <!-- Page Header -->
                            <div class="page-header">
                                <h1>
                                    <i class="fas fa-user-circle"></i>
                                    Thông tin cá nhân
                                </h1>
                                <a href="<%= request.getContextPath() %>/" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Quay lại
                                </a>
                            </div>

                            <!-- Alerts -->
                            <c:if test="${not empty param.success}">
                                <div class="alert alert-success">
                                    <i class="fas fa-check-circle"></i>
                                    Cập nhật thông tin thành công!
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
                                                <fmt:formatDate value="${customer.dateOfBirth}" pattern="dd/MM/yyyy" />
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
                                                <fmt:formatDate value="${customer.createdAt}"
                                                    pattern="dd/MM/yyyy HH:mm" />
                                            </div>
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

                                        <form method="POST" action="<%= request.getContextPath() %>/profile">
                                            <div class="form-group">
                                                <label>Họ tên</label>
                                                <input type="text" name="fullName" value="${customer.fullName}"
                                                    required>
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
                                                                    <span
                                                                        class="timeline-type">${activity.actionType}</span>
                                                                    <span class="timeline-date">
                                                                        <fmt:formatDate value="${activity.createdAt}"
                                                                            pattern="dd/MM/yyyy HH:mm" />
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