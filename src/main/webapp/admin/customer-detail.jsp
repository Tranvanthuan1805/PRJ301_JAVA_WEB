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
    <script src="https://cdn.tailwindcss.com"></script>
    <script>tailwind.config={theme:{extend:{fontFamily:{sans:['Inter','sans-serif']}}}}</script>
</head>
<body class="bg-[#0a0f1e] text-slate-200 min-h-screen font-['Inter']">
    <jsp:include page="/common/_admin-sidebar.jsp" />
    <c:set var="pageTitle" value="Chi Tiết Khách Hàng" scope="request"/>
    <jsp:include page="/common/_admin-header.jsp" />
    <main class="lg:ml-[260px] pt-20 pb-10 px-4 lg:px-6">
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
                            <div style="background:rgba(255,255,255,.04);padding:20px;border-radius:10px;border:1px solid rgba(255,255,255,.06)">
                                <div style="font-size:1.6rem;font-weight:800;color:#fff">${totalActivities}</div>
                                <div style="font-size:.82rem;color:rgba(255,255,255,.4)">Tổng hoạt động</div>
                            </div>
                            <div style="background:rgba(255,255,255,.04);padding:20px;border-radius:10px;border:1px solid rgba(255,255,255,.06)">
                                <div style="font-size:1.6rem;font-weight:800;color:#34D399">${bookingCount}</div>
                                <div style="font-size:.82rem;color:rgba(255,255,255,.4)">Đơn đặt tour</div>
                            </div>
                            <div style="background:rgba(255,255,255,.04);padding:20px;border-radius:10px;border:1px solid rgba(255,255,255,.06)">
                                <div style="font-size:1.6rem;font-weight:800;color:#60A5FA">${searchCount}</div>
                                <div style="font-size:.82rem;color:rgba(255,255,255,.4)">Tìm kiếm</div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <a href="${pageContext.request.contextPath}/admin/customers" class="inline-flex items-center gap-2 mt-6 px-5 py-2.5 bg-white/[.04] border border-white/[.08] text-slate-400 hover:text-white hover:border-white/20 rounded-lg text-sm font-semibold transition">
                <i class="fas fa-arrow-left"></i> Quay lại danh sách
            </a>
    </main>
</body>
</html>
