<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Khách Hàng | Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .dashboard-wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: 260px; padding: 30px; background: #f8f9fa; }
        .page-title { font-size: 1.6rem; color: #0a2351; margin-bottom: 4px; }
        .breadcrumb { color: #b2bec3; font-size: .85rem; margin-bottom: 25px; }
        .breadcrumb a { color: #4facfe; text-decoration: none; }

        .detail-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .detail-card { background: white; border-radius: 14px; padding: 24px; box-shadow: 0 2px 8px rgba(0,0,0,.04); border: 1px solid #f0f0f0; }
        .detail-card.full { grid-column: 1 / -1; }
        .detail-card h3 { font-size: 1rem; color: #0a2351; margin-bottom: 18px; display: flex; align-items: center; gap: 8px; }
        .detail-card h3 i { color: #4facfe; }

        .info-row { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid #f5f5f5; }
        .info-row:last-child { border-bottom: none; }
        .info-label { color: #b2bec3; font-size: .85rem; font-weight: 600; }
        .info-value { color: #2d3436; font-weight: 600; }

        .badge { padding: 4px 12px; border-radius: 20px; font-size: .75rem; font-weight: 700; }
        .badge-success { background: #d4edda; color: #155724; }
        .badge-warning { background: #fff3cd; color: #856404; }
        .badge-danger { background: #f8d7da; color: #721c24; }

        .status-form { display: flex; gap: 10px; align-items: center; margin-top: 16px; }
        .status-form select { padding: 8px 14px; border: 2px solid #e9ecef; border-radius: 8px; font-size: .88rem; }
        .status-form button { padding: 8px 18px; background: #0a2351; color: white; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; }

        .btn-back { display: inline-flex; align-items: center; gap: 6px; padding: 10px 20px; background: #e9ecef; color: #2d3436; border-radius: 10px; font-weight: 600; text-decoration: none; margin-top: 20px; }
        .btn-back:hover { background: #ddd; }

        .alert { padding: 12px 18px; border-radius: 10px; font-size: .88rem; font-weight: 600; margin-bottom: 16px; }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }

        @media (max-width: 768px) {
            .main-content { margin-left: 0; }
            .detail-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="dashboard-wrapper">
        <jsp:include page="/common/_sidebar.jsp" />

        <div class="main-content">
            <h1 class="page-title"><i class="fas fa-user-circle"></i> Chi Tiết Khách Hàng</h1>
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/admin/customers">Quản Lý Khách Hàng</a> → #${customer.customerId}
            </div>

            <c:if test="${param.success != null}">
                <div class="alert alert-success"><i class="fas fa-check-circle"></i> Thao tác thành công!</div>
            </c:if>
            <c:if test="${param.error != null}">
                <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> Có lỗi xảy ra!</div>
            </c:if>

            <c:if test="${not empty customer}">
                <div class="detail-grid">
                    <!-- Basic Info -->
                    <div class="detail-card">
                        <h3><i class="fas fa-id-card"></i> Thông Tin Cá Nhân</h3>
                        <div class="info-row">
                            <span class="info-label">ID</span>
                            <span class="info-value">#${customer.customerId}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Họ tên</span>
                            <span class="info-value">${not empty customer.fullName ? customer.fullName : 'Chưa cập nhật'}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Email</span>
                            <span class="info-value">${customer.email}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Số điện thoại</span>
                            <span class="info-value">${not empty customer.phone ? customer.phone : 'Chưa cập nhật'}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Địa chỉ</span>
                            <span class="info-value">${not empty customer.address ? customer.address : 'Chưa cập nhật'}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Ngày sinh</span>
                            <span class="info-value">
                                <c:choose>
                                    <c:when test="${not empty customer.dateOfBirth}">
                                        <fmt:formatDate value="${customer.dateOfBirth}" pattern="dd/MM/yyyy"/>
                                    </c:when>
                                    <c:otherwise>Chưa cập nhật</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>

                    <!-- Account & Status -->
                    <div class="detail-card">
                        <h3><i class="fas fa-shield-alt"></i> Tài Khoản & Trạng Thái</h3>
                        <div class="info-row">
                            <span class="info-label">Username</span>
                            <span class="info-value">@${customer.user.username}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Vai trò</span>
                            <span class="info-value">${customer.user.role.roleName}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Trạng thái</span>
                            <span class="badge ${customer.statusBadgeClass}">${customer.statusText}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Ngày đăng ký</span>
                            <span class="info-value"><fmt:formatDate value="${customer.user.createdAt}" pattern="dd/MM/yyyy HH:mm"/></span>
                        </div>

                        <!-- Update Status Form -->
                        <form class="status-form" action="${pageContext.request.contextPath}/admin/customers" method="post">
                            <input type="hidden" name="action" value="updateStatus">
                            <input type="hidden" name="customerId" value="${customer.customerId}">
                            <select name="status">
                                <option value="active" ${customer.status == 'active' ? 'selected' : ''}>✅ Hoạt động</option>
                                <option value="inactive" ${customer.status == 'inactive' ? 'selected' : ''}>⏸️ Tạm ngưng</option>
                                <option value="banned" ${customer.status == 'banned' ? 'selected' : ''}>🚫 Bị khóa</option>
                            </select>
                            <button type="submit"><i class="fas fa-save"></i> Cập nhật</button>
                        </form>
                    </div>

                    <!-- Activity Stats -->
                    <div class="detail-card full">
                        <h3><i class="fas fa-chart-bar"></i> Hoạt Động</h3>
                        <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:16px;text-align:center">
                            <div style="background:#f8f9fa;padding:20px;border-radius:10px">
                                <div style="font-size:1.6rem;font-weight:800;color:#0a2351">${totalActivities}</div>
                                <div style="font-size:.82rem;color:#b2bec3">Tổng hoạt động</div>
                            </div>
                            <div style="background:#f8f9fa;padding:20px;border-radius:10px">
                                <div style="font-size:1.6rem;font-weight:800;color:#27ae60">${bookingCount}</div>
                                <div style="font-size:.82rem;color:#b2bec3">Đơn đặt tour</div>
                            </div>
                            <div style="background:#f8f9fa;padding:20px;border-radius:10px">
                                <div style="font-size:1.6rem;font-weight:800;color:#4facfe">${searchCount}</div>
                                <div style="font-size:.82rem;color:#b2bec3">Tìm kiếm</div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <a href="${pageContext.request.contextPath}/admin/customers" class="btn-back">
                <i class="fas fa-arrow-left"></i> Quay lại danh sách
            </a>
        </div>
    </div>
</body>
</html>
