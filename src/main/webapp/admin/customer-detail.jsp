<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Khách Hàng | Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
    *{margin:0;padding:0;box-sizing:border-box}
    body{font-family:'Inter',system-ui,sans-serif;background:#0F172A;color:#E2E8F0;-webkit-font-smoothing:antialiased;min-height:100vh}

    /* Main */
    .main{margin-left:260px;padding:32px 40px;min-height:100vh}
    .page-header{margin-bottom:32px}
    .page-header h1{font-size:1.8rem;font-weight:800;color:#fff;display:flex;align-items:center;gap:12px}
    .page-header h1 i{color:#60A5FA}
    .breadcrumb{color:rgba(255,255,255,.5);font-size:.9rem;margin-top:8px}
    .breadcrumb a{color:#60A5FA;text-decoration:none;transition:.3s}
    .breadcrumb a:hover{color:#93C5FD}

    /* Alert */
    .alert{padding:14px 20px;border-radius:12px;font-size:.88rem;font-weight:600;margin-bottom:24px;display:flex;align-items:center;gap:10px}
    .alert-success{background:rgba(16,185,129,.15);color:#34D399;border:1px solid rgba(16,185,129,.2)}
    .alert-error{background:rgba(239,68,68,.15);color:#F87171;border:1px solid rgba(239,68,68,.2)}

    /* Cards */
    .detail-grid{display:grid;grid-template-columns:1fr 1fr;gap:24px;margin-bottom:24px}
    .detail-card{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:28px}
    .detail-card.full{grid-column:1/-1}
    .detail-card h3{font-size:1.1rem;font-weight:700;color:#fff;margin-bottom:20px;display:flex;align-items:center;gap:10px}
    .detail-card h3 i{color:#60A5FA;font-size:.95rem}

    /* Info Rows */
    .info-row{display:flex;justify-content:space-between;align-items:center;padding:14px 0;border-bottom:1px solid rgba(255,255,255,.04)}
    .info-row:last-child{border-bottom:none}
    .info-label{color:rgba(255,255,255,.4);font-size:.82rem;font-weight:600;text-transform:uppercase;letter-spacing:.5px}
    .info-value{color:#fff;font-weight:600;font-size:.9rem}

    /* Badge */
    .badge{padding:5px 14px;border-radius:999px;font-size:.75rem;font-weight:700}
    .badge-success{background:rgba(16,185,129,.15);color:#34D399}
    .badge-warning{background:rgba(245,158,11,.15);color:#FBBF24}
    .badge-danger{background:rgba(239,68,68,.15);color:#F87171}

    /* Status Form */
    .status-form{display:flex;gap:12px;align-items:center;margin-top:20px;padding-top:20px;border-top:1px solid rgba(255,255,255,.06)}
    .status-form select{padding:10px 16px;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.08);border-radius:10px;color:#fff;font-size:.88rem;font-family:inherit;cursor:pointer;outline:none;transition:.3s}
    .status-form select:focus{border-color:#3B82F6;box-shadow:0 0 0 3px rgba(59,130,246,.15)}
    .status-form select option{background:#1a1f3a;color:#fff}
    .status-form button{display:inline-flex;align-items:center;gap:8px;padding:10px 22px;background:#3B82F6;color:#fff;border:none;border-radius:10px;font-weight:700;font-size:.85rem;cursor:pointer;transition:.3s;font-family:inherit}
    .status-form button:hover{background:#2563EB;transform:translateY(-1px);box-shadow:0 4px 16px rgba(59,130,246,.3)}

    /* Custom Select */
    .custom-select-wrapper{position:relative}
    .custom-select{appearance:none;-webkit-appearance:none;-moz-appearance:none;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.08);border-radius:10px;padding:12px 40px 12px 16px;color:#fff;font-size:.9rem;font-family:inherit;transition:.3s;outline:none;cursor:pointer;width:100%}
    .custom-select:hover{border-color:rgba(255,255,255,.15);background:rgba(255,255,255,.08)}
    .custom-select:focus{border-color:#3B82F6;box-shadow:0 0 0 3px rgba(59,130,246,.15);background:rgba(255,255,255,.08)}
    .custom-select option{background:#1E293B;color:#fff;padding:12px;font-size:.9rem}
    .custom-select option[value="active"]{color:#34D399}
    .custom-select option[value="inactive"]{color:#FBBF24}
    .custom-select option[value="banned"]{color:#F87171}
    .custom-select option:hover{background:#334155}
    .select-arrow{position:absolute;right:14px;top:50%;transform:translateY(-50%);color:rgba(255,255,255,.4);font-size:.75rem;pointer-events:none;transition:.3s}
    .custom-select:focus + .select-arrow{color:#60A5FA}

    /* Stats */
    .stats-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:20px}
    .stat-box{background:rgba(255,255,255,.03);border:1px solid rgba(255,255,255,.05);padding:24px;border-radius:12px;text-align:center}
    .stat-value{font-size:2rem;font-weight:800;color:#fff;letter-spacing:-1px;margin-bottom:6px}
    .stat-label{font-size:.8rem;color:rgba(255,255,255,.4);text-transform:uppercase;letter-spacing:.5px;font-weight:600}
    .stat-box:nth-child(1) .stat-value{color:#60A5FA}
    .stat-box:nth-child(2) .stat-value{color:#34D399}
    .stat-box:nth-child(3) .stat-value{color:#FBBF24}

    /* Button */
    .btn-back{display:inline-flex;align-items:center;gap:8px;padding:12px 24px;background:transparent;color:rgba(255,255,255,.7);border:1px solid rgba(255,255,255,.1);border-radius:10px;font-weight:600;font-size:.88rem;text-decoration:none;transition:.3s}
    .btn-back:hover{border-color:rgba(255,255,255,.3);color:#fff}

    @media(max-width:768px){.main{margin-left:0;padding:16px}.detail-grid{grid-template-columns:1fr}.stats-grid{grid-template-columns:1fr}}
    </style>
</head>
<body>
    <jsp:include page="/common/_sidebar.jsp" />

    <main class="main">
        <div class="page-header">
            <h1><i class="fas fa-user-circle"></i> Chi Tiết Khách Hàng</h1>
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/admin/customers">Quản Lý Khách Hàng</a> → #${customer.customerId}
            </div>
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
                        <div class="custom-select-wrapper" style="flex:1">
                            <select name="status" class="custom-select">
                                <option value="active" ${customer.status == 'active' ? 'selected' : ''}>Hoạt động</option>
                                <option value="inactive" ${customer.status == 'inactive' ? 'selected' : ''}>Tạm ngưng</option>
                                <option value="banned" ${customer.status == 'banned' ? 'selected' : ''}>Bị khóa</option>
                            </select>
                            <i class="fas fa-chevron-down select-arrow"></i>
                        </div>
                        <button type="submit"><i class="fas fa-save"></i> Cập nhật</button>
                    </form>
                </div>

                <!-- Activity Stats -->
                <div class="detail-card full">
                    <h3><i class="fas fa-chart-bar"></i> Hoạt Động</h3>
                    <div class="stats-grid">
                        <div class="stat-box">
                            <div class="stat-value">${totalActivities}</div>
                            <div class="stat-label">Tổng hoạt động</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-value">${bookingCount}</div>
                            <div class="stat-label">Đơn đặt tour</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-value">${searchCount}</div>
                            <div class="stat-label">Tìm kiếm</div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <a href="${pageContext.request.contextPath}/admin/customers" class="btn-back">
            <i class="fas fa-arrow-left"></i> Quay lại danh sách
        </a>
    </main>
</body>
</html>
