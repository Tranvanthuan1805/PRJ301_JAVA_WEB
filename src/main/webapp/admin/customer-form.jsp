<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Khách Hàng | Admin</title>
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

    /* Form Card */
    .form-card{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:32px;max-width:800px}
    .form-card h3{font-size:1.1rem;font-weight:700;color:#fff;margin-bottom:24px;display:flex;align-items:center;gap:10px}
    .form-card h3 i{color:#60A5FA;font-size:.9rem}

    /* Form */
    .form-row{display:grid;grid-template-columns:1fr 1fr;gap:20px;margin-bottom:20px}
    .form-group{display:flex;flex-direction:column;gap:8px}
    .form-group label{font-size:.78rem;font-weight:600;color:rgba(255,255,255,.5);text-transform:uppercase;letter-spacing:.5px}
    .form-group input,.form-group select{background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.08);border-radius:10px;padding:12px 16px;color:#fff;font-size:.9rem;font-family:inherit;transition:.3s;outline:none}
    .form-group input:focus,.form-group select:focus{border-color:#3B82F6;box-shadow:0 0 0 3px rgba(59,130,246,.15)}
    .form-group input:disabled{opacity:.5;cursor:not-allowed;background:rgba(255,255,255,.03)}
    .form-group input::placeholder{color:rgba(255,255,255,.25)}
    .form-group select{cursor:pointer}
    .form-group select option{background:#1a1f3a;color:#fff}

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

    /* Buttons */
    .btn-row{display:flex;gap:12px;margin-top:28px}
    .btn-save{display:inline-flex;align-items:center;gap:8px;padding:12px 28px;border-radius:10px;background:#3B82F6;color:#fff;font-weight:700;font-size:.88rem;border:none;cursor:pointer;transition:.3s;font-family:inherit}
    .btn-save:hover{background:#2563EB;transform:translateY(-1px);box-shadow:0 4px 16px rgba(59,130,246,.3)}
    .btn-cancel{display:inline-flex;align-items:center;gap:8px;padding:12px 28px;border-radius:10px;background:transparent;color:rgba(255,255,255,.7);font-weight:600;font-size:.88rem;border:1px solid rgba(255,255,255,.1);cursor:pointer;transition:.3s;font-family:inherit;text-decoration:none}
    .btn-cancel:hover{border-color:rgba(255,255,255,.3);color:#fff}

    @media(max-width:768px){.main{margin-left:0;padding:16px}.form-row{grid-template-columns:1fr}}
    </style>
</head>
<body>
    <jsp:include page="/common/_sidebar.jsp" />

    <main class="main">
        <div class="page-header">
            <h1><i class="fas fa-user-edit"></i> Chỉnh Sửa Khách Hàng</h1>
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/admin/customers">Quản Lý Khách Hàng</a> → 
                <c:choose>
                    <c:when test="${not empty customer}">Chỉnh sửa #${customer.customerId}</c:when>
                    <c:otherwise>Không tìm thấy</c:otherwise>
                </c:choose>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty customer}">
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
                                <input type="email" name="email" value="${customer.email}" placeholder="Nhập email" required>
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
                                <div class="custom-select-wrapper">
                                    <select name="status" class="custom-select">
                                        <option value="active" ${customer.status == 'active' ? 'selected' : ''} data-icon="check-circle">Hoạt động</option>
                                        <option value="inactive" ${customer.status == 'inactive' ? 'selected' : ''} data-icon="pause-circle">Tạm ngưng</option>
                                        <option value="banned" ${customer.status == 'banned' ? 'selected' : ''} data-icon="ban">Bị khóa</option>
                                    </select>
                                    <i class="fas fa-chevron-down select-arrow"></i>
                                </div>
                            </div>
                        </div>

                        <div class="btn-row">
                            <button type="submit" class="btn-save"><i class="fas fa-save"></i> Lưu Thay Đổi</button>
                            <a href="${pageContext.request.contextPath}/admin/customers" class="btn-cancel"><i class="fas fa-arrow-left"></i> Hủy</a>
                        </div>
                    </form>
                </div>
            </c:when>
            <c:otherwise>
                <div class="form-card">
                    <div style="text-align:center;padding:40px;color:rgba(255,255,255,.4)">
                        <i class="fas fa-exclamation-circle" style="font-size:3rem;margin-bottom:16px;opacity:.5"></i>
                        <p>Không tìm thấy thông tin khách hàng</p>
                        <a href="${pageContext.request.contextPath}/admin/customers" class="btn-cancel" style="margin-top:20px;display:inline-flex">
                            <i class="fas fa-arrow-left"></i> Quay lại danh sách
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </main>
    </body>
</html>
