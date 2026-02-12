<%@ page contentType="text/html; charset=UTF-8" %>
<!doctype html>
<html lang="vi">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>Login</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body{
      min-height:100vh;
      display:flex;
      align-items:center;
      justify-content:center;
      background: linear-gradient(135deg, #0ea5e9, #7c3aed);
      font-family: Arial, sans-serif;
    }
    .card{
      width: 380px;
      border: none;
      border-radius: 18px;
      box-shadow: 0 20px 60px rgba(0,0,0,.25);
      animation: pop .55s ease;
    }
    @keyframes pop{
      from{ transform: translateY(14px); opacity:.0; }
      to{ transform: translateY(0); opacity:1; }
    }
    .btn-grad{
      border:0;
      border-radius: 12px;
      background: linear-gradient(135deg, #22d3ee, #a78bfa);
      color:#fff;
      font-weight:600;
    }
    .btn-grad:hover{ filter: brightness(1.05); }
  </style>
</head>

<body>
  <div class="card p-4">
    <h4 class="mb-1">Đăng nhập</h4>
    <div class="text-muted mb-3" style="font-size:14px;">Admin / User</div>

    <% String err = (String) request.getAttribute("error"); %>
    <% if (err != null) { %>
      <div class="alert alert-danger py-2"><%= err %></div>
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

      <button class="btn btn-grad w-100 py-2" type="submit">Login</button>

      <div class="text-center mt-3" style="font-size:14px;">
        Chưa có tài khoản? <a href="register.jsp">Đăng ký</a>
      </div>
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
</body>
</html>
