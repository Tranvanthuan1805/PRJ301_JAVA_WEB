<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Khách Hàng | Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>tailwind.config={theme:{extend:{fontFamily:{sans:['Inter','sans-serif']}}}}</script>
    <style>
    .form-input{width:100%;padding:10px 16px;border:1px solid rgba(255,255,255,.1);border-radius:10px;font-family:'Inter',sans-serif;font-size:.9rem;transition:.3s;background:rgba(15,23,42,.8);color:#e2e8f0}
    .form-input:focus{outline:none;border-color:#3b82f6}
    .form-input:disabled{background:rgba(255,255,255,.04);color:#64748b;cursor:not-allowed}
    </style>
</head>
<body class="bg-[#0a0f1e] text-slate-200 min-h-screen font-['Inter']">
    <jsp:include page="/common/_admin-sidebar.jsp" />
    <c:set var="pageTitle" value="Chỉnh Sửa Khách Hàng" scope="request"/>
    <jsp:include page="/common/_admin-header.jsp" />
    <main class="lg:ml-[260px] pt-20 pb-10 px-4 lg:px-6">
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/admin/customers">Quản Lý Khách Hàng</a> → Chỉnh sửa #${customer.customerId}
            </div>

            <c:if test="${not empty customer}">
                <div class="form-card">
                    <h3><i class="fas fa-id-card"></i> Thông Tin Khách Hàng</h3>
                    <form action="${pageContext.request.contextPath}/admin/customers" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="customerId" value="${customer.customerId}">

                        <div class="form-row">
                            <div class="form-group">
                                <label>ID</label>
                                <input type="text" value="#${customer.customerId}" disabled>
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" value="${customer.email}" disabled>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Họ và tên</label>
                                <input type="text" name="fullName" value="${customer.fullName}" placeholder="Nhập họ tên">
                            </div>
                            <div class="form-group">
                                <label>Số điện thoại</label>
                                <input type="tel" name="phone" value="${customer.phone}" placeholder="0901 234 567">
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Địa chỉ</label>
                            <input type="text" name="address" value="${customer.address}" placeholder="Nhập địa chỉ">
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Ngày sinh</label>
                                <input type="date" name="dateOfBirth" value="<fmt:formatDate value='${customer.dateOfBirth}' pattern='yyyy-MM-dd'/>">
                            </div>
                            <div class="form-group">
                                <label>Trạng thái</label>
                                <select name="status">
                                    <option value="active" ${customer.status == 'active' ? 'selected' : ''}>✅ Hoạt động</option>
                                    <option value="inactive" ${customer.status == 'inactive' ? 'selected' : ''}>⏸️ Tạm ngưng</option>
                                    <option value="banned" ${customer.status == 'banned' ? 'selected' : ''}>🚫 Bị khóa</option>
                                </select>
                            </div>
                        </div>

                        <div class="btn-row">
                            <button type="submit" class="btn-save"><i class="fas fa-save"></i> Lưu Thay Đổi</button>
                            <a href="${pageContext.request.contextPath}/admin/customers" class="btn-cancel"><i class="fas fa-arrow-left"></i> Hủy</a>
                        </div>
                    </form>
                </div>
            </c:if>
    </main>
</body>
</html>
