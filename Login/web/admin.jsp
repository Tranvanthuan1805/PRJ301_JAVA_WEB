<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.User" %>
<%
    // --- Auth check ---
    HttpSession s = request.getSession(false);
    User u = (s == null) ? null : (User) s.getAttribute("user");

    if (u == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    if (!"ADMIN".equalsIgnoreCase(u.roleName)) {
        response.sendRedirect("user.jsp"); // hoặc báo 403
        return;
    }
%>
<!doctype html>
<html lang="vi">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body{ background:#f6f7fb; }
    .card-soft{ border:0; border-radius:16px; box-shadow:0 12px 30px rgba(0,0,0,.08); }
    .topbar{
      background: linear-gradient(135deg, #0ea5e9, #7c3aed);
      color:white; border-radius:16px;
    }
    .badge-role{ background: rgba(255,255,255,.2); border:1px solid rgba(255,255,255,.25); }
  </style>
</head>
<body>
<div class="container py-4">

  <div class="topbar p-4 mb-4">
    <div class="d-flex align-items-center justify-content-between flex-wrap gap-2">
      <div>
        <h3 class="mb-1">Admin Dashboard</h3>
        <div class="opacity-75">Quản trị hệ thống • phân quyền • quản lý người dùng</div>
      </div>
      <div class="text-end">
        <div class="fw-semibold"><%= u.username %></div>
        <span class="badge badge-role">ROLE: <%= u.roleName %></span>
      </div>
    </div>
  </div>

  <div class="row g-3">
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

  <div class="mt-4 d-flex justify-content-end">
    <a class="btn btn-danger" href="logout">Logout</a>
  </div>

</div>
</body>
</html>
