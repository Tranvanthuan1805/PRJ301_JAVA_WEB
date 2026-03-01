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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .dashboard-wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: 260px; padding: 30px; background: #f8f9fa; }
        .page-title { font-size: 1.6rem; color: #0a2351; margin-bottom: 4px; }
        .breadcrumb { color: #b2bec3; font-size: .85rem; margin-bottom: 25px; }
        .breadcrumb a { color: #4facfe; text-decoration: none; }

        .form-card { background: white; border-radius: 14px; padding: 30px; box-shadow: 0 2px 8px rgba(0,0,0,.04); border: 1px solid #f0f0f0; max-width: 700px; }
        .form-card h3 { font-size: 1.1rem; color: #0a2351; margin-bottom: 20px; display: flex; align-items: center; gap: 8px; }
        .form-card h3 i { color: #4facfe; }

        .form-group { margin-bottom: 16px; }
        .form-group label { display: block; font-size: .82rem; font-weight: 700; color: #636e72; text-transform: uppercase; letter-spacing: .5px; margin-bottom: 6px; }
        .form-group input, .form-group select {
            width: 100%; padding: 10px 16px; border: 2px solid #e9ecef; border-radius: 10px;
            font-family: 'Inter', sans-serif; font-size: .9rem; transition: .3s;
        }
        .form-group input:focus, .form-group select:focus { outline: none; border-color: #4facfe; }
        .form-group input:disabled { background: #f1f2f6; color: #b2bec3; cursor: not-allowed; }

        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }

        .btn-row { display: flex; gap: 12px; margin-top: 24px; }
        .btn-save { padding: 12px 28px; background: #0a2351; color: white; border: none; border-radius: 10px; font-weight: 700; font-size: .9rem; cursor: pointer; }
        .btn-save:hover { background: #1a3a7a; }
        .btn-cancel { padding: 12px 28px; background: #e9ecef; color: #2d3436; border: none; border-radius: 10px; font-weight: 600; font-size: .9rem; cursor: pointer; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; }

        @media (max-width: 768px) {
            .main-content { margin-left: 0; }
            .form-row { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="dashboard-wrapper">
        <jsp:include page="/common/_sidebar.jsp" />

        <div class="main-content">
            <h1 class="page-title"><i class="fas fa-user-edit"></i> Chỉnh Sửa Khách Hàng</h1>
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
        </div>
    </div>
</body>
</html>
