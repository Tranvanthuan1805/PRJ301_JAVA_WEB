<%@ page contentType="text/html; charset=UTF-8" %>
<!doctype html>
<html lang="vi">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>Register</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body{
      min-height:100vh;
      display:flex;
      align-items:center;
      justify-content:center;
      background: linear-gradient(135deg, #22c55e, #0ea5e9);
      font-family: Arial, sans-serif;
    }
    .card{
      width: 400px;
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
      background: linear-gradient(135deg, #34d399, #22d3ee);
      color:#fff;
      font-weight:600;
    }
    .btn-grad:hover{ filter: brightness(1.05); }
  </style>
</head>

<body>
  <div class="card p-4">
    <h4 class="mb-1">Đăng ký</h4>
    <div class="text-muted mb-3" style="font-size:14px;">Tạo tài khoản mới (role USER)</div>

    <% String err = (String) request.getAttribute("error"); %>
    <% String msg = (String) request.getAttribute("msg"); %>

    <% if (err != null) { %>
      <div class="alert alert-danger py-2"><%= err %></div>
    <% } %>
    <% if (msg != null) { %>
      <div class="alert alert-success py-2"><%= msg %></div>
    <% } %>

    <form action="register" method="post">
      <div class="mb-3">
        <label class="form-label">Username</label>
        <input class="form-control" name="username" placeholder="Nhập username">
      </div>

      <div class="mb-3">
        <label class="form-label">Password</label>
        <input class="form-control" name="password" type="password" placeholder="Nhập password">
      </div>

      <div class="mb-3">
        <label class="form-label">Confirm Password</label>
        <input class="form-control" name="confirm" type="password" placeholder="Nhập lại password">
      </div>

      <button class="btn btn-grad w-100 py-2" type="submit">Register</button>

      <div class="text-center mt-3" style="font-size:14px;">
        Đã có tài khoản? <a href="login.jsp">Đăng nhập</a>
      </div>
    </form>
  </div>
</body>
</html>
