<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Register</title>
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

  <!-- LEFT -->
  <div class="auth-left">
    <h1>Join Flight Booking</h1>
    <p>Create account to book flights ✈️</p>
  </div>

  <!-- RIGHT -->
  <div class="auth-right">
    <h2>Create Account</h2>
    <p class="subtitle">Start your journey today</p>

    <% 
      String err = (String) request.getAttribute("error");
      String msg = (String) request.getAttribute("msg");
      if (err != null) { 
    %>
      <div class="error"><%= err %></div>
    <% } %>

    <% if (msg != null) { %>
      <div style="color:green; margin-bottom:12px;"><%= msg %></div>
    <% } %>

    <form action="register" method="post">
      <div class="input-group">
        <input name="username" placeholder="Username" required>
      </div>

      <div class="input-group">
        <input type="password" name="password" placeholder="Password" required>
      </div>

      <div class="input-group">
        <input type="password" name="confirm" placeholder="Confirm Password" required>
      </div>

      <button class="btn">SIGN UP</button>
    </form>

    <div class="switch">
      <a href="login.jsp">Already have an account?</a>
    </div>
  </div>

</div>

</body>
</html>
