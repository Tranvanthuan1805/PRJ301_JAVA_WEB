<%@ page import="model.User" %>
<%
User u = (User) session.getAttribute("user");
if (u == null || !"USER".equalsIgnoreCase(u.getRoleName())) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
  <title>User</title>
  <link rel="stylesheet" href="css/auth.css">
</head>
<body>

<div class="auth-wrapper">
  <div class="auth-left">
    <h1>User Dashboard</h1>
    <p>Book your flights</p>
  </div>

  <div class="row g-3">
    <div class="col-md-6">
      <div class="card card-soft p-3">
        <div class="fw-semibold mb-1">Thông tin tài khoản</div>
        <div class="text-muted small">Username: <b><%= u.username %></b></div>
        <div class="text-muted small">Role: <b><%= u.roleName %></b></div>
      </div>
    </div>

    <div class="col-md-6">
      <div class="card card-soft p-3">
        <div class="fw-semibold mb-1">Tính năng</div>
        <div class="text-muted small mb-3">Quản lý gói đăng ký và thanh toán.</div>
        <a href="pricing" class="btn btn-outline-success w-100 mb-2">Upgrade Plan</a>
        <a href="history" class="btn btn-outline-primary w-100">Billing History</a>
      </div>
    </div>
  </div>
</div>

</body>
</html>
