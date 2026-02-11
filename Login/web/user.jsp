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
%>
<!doctype html>
<html lang="vi">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>User</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body{ background:#f6f7fb; }
    .card-soft{ border:0; border-radius:16px; box-shadow:0 12px 30px rgba(0,0,0,.08); }
    .topbar{
      background: linear-gradient(135deg, #22c55e, #0ea5e9);
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
        <h3 class="mb-1">User Page</h3>
        <div class="opacity-75">Trang người dùng • xem thông tin cá nhân</div>
      </div>
      <div class="text-end">
        <div class="fw-semibold"><%= u.username %></div>
        <span class="badge badge-role">ROLE: <%= u.roleName %></span>
      </div>
    </div>
  </div>

  <div class="row g-3">
    <div class="col-md-6">
      <div class="card card-soft p-3">
        <div class="fw-semibold mb-1">Thông tin tài khoản</div>
        <div class="text-muted small">Username: <b><%= u.username %></b></div>
        <div class="text-muted small">Role: <b><%= u.roleName %></b></div>
      </div>
    </div>

    <!-- My Orders - Link to Order Management -->
    <div class="col-md-6">
      <div class="card card-soft p-3 border-success" style="border: 2px solid #22c55e !important;">
        <div class="fw-semibold mb-1 text-success">Đơn hàng của tôi</div>
        <div class="text-muted small mb-3">Xem lịch sử và trạng thái đơn đặt tour</div>
        <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-success w-100">
          Xem đơn hàng
        </a>
      </div>
    </div>
    
    <div class="col-md-6">
      <div class="card card-soft p-3">
        <div class="fw-semibold mb-1">Tính năng khác</div>
        <div class="text-muted small mb-3">Bạn có thể thêm tính năng ở đây.</div>
        <button class="btn btn-outline-success w-100" disabled>Demo (chưa làm)</button>
      </div>
    </div>
  </div>

  <div class="mt-4 d-flex justify-content-end">
    <a class="btn btn-danger" href="logout">Logout</a>
  </div>

</div>
</body>
</html>
