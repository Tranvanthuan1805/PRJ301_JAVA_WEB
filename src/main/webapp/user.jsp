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

  <div class="auth-right">
    <h2>Welcome</h2>
    <p><%= u.getUsername() %></p>
    <a href="logout">Logout</a>
  </div>
</div>

</body>
</html>
