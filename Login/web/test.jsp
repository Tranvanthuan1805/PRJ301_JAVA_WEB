<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    HttpSession s = request.getSession(false);
    User currentUser = (s == null) ? null : (User) s.getAttribute("user");
    String role = (currentUser != null) ? currentUser.roleName : "GUEST";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test Page</title>
</head>
<body>
    <h1>Test Page</h1>
    <p>Current User: <%= currentUser != null ? currentUser.username : "Guest" %></p>
    <p>Role: <%= role %></p>
    <a href="index.jsp">Go to Index</a>
</body>
</html>
