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
</div>

</body>
</html>
