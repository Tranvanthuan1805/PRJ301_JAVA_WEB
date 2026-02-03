<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Login</title>
  <link rel="stylesheet" href="css/auth.css">
</head>
<body>
    <div class="top-nav">
  <div class="logo">✈ AirBooking</div>
  <span>Home</span>
  <span>Flights</span>
  <span>Booking</span>
  <span>Support</span>
  <span>Login</span>
</div>

<div class="auth-wrapper">

  <div class="auth-left">
    <h1>Flight Booking</h1>
    <p>Login to manage your flights and tickets</p>
  </div>

  <div class="auth-right">
    <h2>Login</h2>
    <p class="subtitle">Welcome back ✈️</p>

    <% String err = (String) request.getAttribute("error"); %>
    <% if (err != null) { %>
      <div class="error"><%= err %></div>
    <% } %>

    <form action="login" method="post">
      <div class="input-group">
        <input name="username" placeholder="Username" required>
      </div>

      <div class="input-group">
        <input type="password" name="password" placeholder="Password" required>
      </div>

      <button class="btn">LOGIN</button>
    </form>

    <div class="social">
      <img src="images/google.png">
      <img src="images/facebook.png">
      <img src="images/github.png">
    </div>

    <div class="switch">
      <a href="register.jsp">Create new account</a>
    </div>
  </div>

</div>

</body>
</html>
