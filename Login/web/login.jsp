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

    <form action="login" method="post" onsubmit="return validateForm()">
      <div class="mb-3">
        <label class="form-label">Username</label>
        <input class="form-control" id="username" name="username" placeholder="Nhập username" autocomplete="off">
      </div>

      <div class="mb-3">
        <label class="form-label">Password</label>
        <input class="form-control" id="password" name="password" type="password" placeholder="Nhập password" autocomplete="off">
      </div>

      <button class="btn">LOGIN</button>
    </form>

    <script>
      function validateForm() {
        var username = document.getElementById('username').value.trim();
        var password = document.getElementById('password').value;
        
        if (username === '' || password === '') {
          alert('Vui lòng nhập đầy đủ username và password');
          return false;
        }
        
        return true;
      }
    </script>
  </div>

</div>

</body>
</html>
