<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.User" %>
<%
    response.setCharacterEncoding("UTF-8");
    request.setCharacterEncoding("UTF-8");
    HttpSession s = request.getSession(false);
    User u = (s == null) ? null : (User) s.getAttribute("user");
    if (u == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
    boolean isAdmin = (u != null && u.roleName != null && "ADMIN".equalsIgnoreCase(u.roleName));
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân - VietAir</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/vietair-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Profile-specific styles */
        .profile-hero {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            padding: 48px 24px;
            text-align: center;
            color: #fff;
            position: relative;
            overflow: hidden;
        }

        .profile-hero::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at 70% 30%, rgba(6,182,212,0.1), transparent 50%);
        }

        .profile-hero h1 {
            font-size: 2rem;
            font-weight: 800;
            position: relative;
            margin-bottom: 6px;
        }

        .profile-hero p {
            opacity: 0.8;
            position: relative;
            font-size: 1rem;
        }

        .profile-avatar {
            width: 72px;
            height: 72px;
            background: rgba(255,255,255,0.15);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: #fff;
            margin: 0 auto 16px;
            border: 3px solid rgba(255,255,255,0.3);
            backdrop-filter: blur(4px);
            position: relative;
        }

        .form-actions {
            display: flex;
            gap: 12px;
            margin-top: 8px;
        }

        /* Smooth focus on inputs */
        .form-group input:focus,
        .form-group textarea:focus {
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(59,130,246,0.1);
        }

        @media (max-width: 768px) {
            .content-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="nav-brand">
                <a href="<%= request.getContextPath() %>/" class="logo-container">
                    <i class="fas fa-plane-departure logo-icon"></i>
                    <span class="logo-text">VietAir</span>
                </a>
            </div>
            <nav class="nav-menu">
                <a href="<%= request.getContextPath() %>/" class="nav-item">Trang chủ</a>
                <a href="<%= request.getContextPath() %>/tour?action=list" class="nav-item">Tours</a>
                <% if (isAdmin) { %>
                    <a href="<%= request.getContextPath() %>/admin/customers" class="nav-item">Khách hàng</a>
                <% } %>
                <a href="<%= request.getContextPath() %>/profile" class="nav-item active">Profile</a>
            </nav>
            <div class="nav-actions">
                <span class="user-badge"><%= u.username %></span>
                <a href="<%= request.getContextPath() %>/logout" class="btn-logout">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </div>
        </div>
    </header>

    <!-- Profile Hero -->
    <section class="profile-hero">
        <div class="profile-avatar">
            <i class="fas fa-user"></i>
        </div>
        <h1>${not empty customer.fullName ? customer.fullName : 'Thông tin cá nhân'}</h1>
        <p>Quản lý thông tin tài khoản VietAir của bạn</p>
    </section>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Page Header -->
        <div class="page-header fade-in-up">
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
            <div class="alert alert-success fade-in">
                <i class="fas fa-check-circle"></i>
                Cập nhật thông tin thành công!
            </div>
        </c:if>

        <c:if test="${not empty param.error}">
            <div class="alert alert-error fade-in">
                <i class="fas fa-exclamation-circle"></i>
                Có lỗi xảy ra. Vui lòng thử lại!
            </div>
        </c:if>

        <!-- Content Grid -->
        <div class="content-grid">
            <!-- Left Column — Info Display -->
            <div>
                <div class="card fade-in-up">
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
                            <span class="status-badge status-${customer.status}">${customer.status}</span>
                        </div>
                    </div>

                    <div class="info-group">
                        <div class="info-label">Ngày tạo</div>
                        <div class="info-value">
                            <fmt:formatDate value="${customer.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column — Edit Form & Activities -->
            <div>
                <!-- Edit Form -->
                <div class="card fade-in-up">
                    <div class="card-header">
                        <h2><i class="fas fa-edit"></i> Chỉnh sửa thông tin</h2>
                    </div>

                    <form method="POST" action="<%= request.getContextPath() %>/profile">
                        <div class="form-group">
                            <label><i class="fas fa-user"></i> Họ tên</label>
                            <input type="text" name="fullName" class="form-control" 
                                   value="${customer.fullName}" required>
                        </div>

                        <div class="form-group">
                            <label><i class="fas fa-phone"></i> Số điện thoại</label>
                            <input type="text" name="phone" class="form-control" 
                                   value="${customer.phone}" required>
                        </div>

                        <div class="form-group">
                            <label><i class="fas fa-map-marker-alt"></i> Địa chỉ</label>
                            <textarea name="address" class="form-control" rows="3">${customer.address}</textarea>
                        </div>

                        <div class="form-group">
                            <label><i class="fas fa-birthday-cake"></i> Ngày sinh</label>
                            <input type="date" name="dateOfBirth" class="form-control"
                                   value="<fmt:formatDate value='${customer.dateOfBirth}' pattern='yyyy-MM-dd'/>">
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Lưu thay đổi
                            </button>
                            <button type="reset" class="btn btn-secondary">
                                <i class="fas fa-undo"></i> Hoàn tác
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Activity Stats -->
                <div class="card mt-3 fade-in-up">
                    <div class="card-header">
                        <h2><i class="fas fa-chart-bar"></i> Thống kê hoạt động</h2>
                    </div>

                    <div class="stats-grid" style="grid-template-columns: repeat(3, 1fr);">
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
                <div class="card mt-3 fade-in-up">
                    <div class="card-header">
                        <h2><i class="fas fa-history"></i> Lịch sử hoạt động</h2>
                    </div>

                    <c:choose>
                        <c:when test="${empty activities}">
                            <p class="text-center text-muted" style="padding: 2rem;">
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
                                                    <fmt:formatDate value="${activity.createdAt}" pattern="dd/MM/yyyy HH:mm" />
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

    <!-- AI Chatbot -->
    <jsp:include page="/views/ai-chatbot/chatbot.jsp" />
</body>
</html>