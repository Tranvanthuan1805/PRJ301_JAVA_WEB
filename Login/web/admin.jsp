<%@ page import="model.User" %>
<%
User u = (User) session.getAttribute("user");
if (u == null || !"ADMIN".equalsIgnoreCase(u.getRoleName())) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
  <title>Admin</title>
  <link rel="stylesheet" href="css/auth.css">
</head>
<body>

<div class="auth-wrapper">
  <div class="auth-left">
    <h1>Admin Panel</h1>
    <p>System management</p>
  </div>

  <div class="row g-3">
    <!-- Order Management - YOUR MODULE -->
    <div class="col-md-4">
      <div class="card card-soft p-3 border-primary" style="border: 2px solid #667eea !important;">
        <div class="fw-semibold mb-1 text-primary">Quản lý Đơn hàng</div>
        <div class="text-muted small mb-3">Theo dõi và quản lý đơn đặt tour</div>
        <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-primary w-100">
          Truy cập
        </a>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card card-soft p-3">
        <div class="fw-semibold mb-1">Quản lý Users</div>
        <div class="text-muted small mb-3">Xem / thêm / khóa tài khoản</div>
        <button class="btn btn-outline-primary w-100" disabled>Demo (chưa làm)</button>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card card-soft p-3">
        <div class="fw-semibold mb-1">Quản lý Roles</div>
        <div class="text-muted small mb-3">Phân quyền admin/user</div>
        <button class="btn btn-outline-primary w-100" disabled>Demo (chưa làm)</button>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card card-soft p-3">
        <div class="fw-semibold mb-1">Thống kê</div>
        <div class="text-muted small mb-3">Tổng user, user active...</div>
        <button class="btn btn-outline-primary w-100" disabled>Demo (chưa làm)</button>
      </div>
    </div>
  </div>

    <ul>
      <li>Manage Users</li>
      <li>View Reports</li>
      <li>System Settings</li>
    </ul>

    <br>
    <a href="logout">Logout</a>
  </div>
</div>

</body>
</html>
