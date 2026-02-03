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

  <div class="auth-right">
    <h2>Hello Admin</h2>
    <p><b><%= u.getUsername() %></b></p>

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
