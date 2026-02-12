<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VietAir - Đăng ký</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .register-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            max-width: 450px;
            width: 100%;
        }
        .register-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
        }
        .register-header i {
            font-size: 3rem;
            margin-bottom: 15px;
        }
        .register-header h1 {
            font-size: 2rem;
            margin-bottom: 10px;
        }
        .register-header p {
            opacity: 0.9;
        }
        .register-body {
            padding: 40px 30px;
        }
        .form-group {
            margin-bottom: 25px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
        }
        .input-wrapper {
            position: relative;
        }
        .input-wrapper i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
        }
        .form-control {
            width: 100%;
            padding: 12px 15px 12px 45px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s;
        }
        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .error-message {
            background: #fee;
            color: #c33;
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .success-message {
            background: #efe;
            color: #3c3;
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .btn-register {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }
        .register-footer {
            text-align: center;
            margin-top: 25px;
            padding-top: 25px;
            border-top: 1px solid #e0e0e0;
        }
        .register-footer a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        .register-footer a:hover {
            text-decoration: underline;
        }
        .password-strength {
            margin-top: 8px;
            height: 4px;
            background: #e0e0e0;
            border-radius: 2px;
            overflow: hidden;
        }
        .password-strength-bar {
            height: 100%;
            width: 0%;
            transition: all 0.3s;
        }
        .strength-weak { background: #f44336; width: 33%; }
        .strength-medium { background: #ff9800; width: 66%; }
        .strength-strong { background: #4caf50; width: 100%; }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <i class="fas fa-user-plus"></i>
            <h1>Đăng ký</h1>
            <p>Tạo tài khoản VietAir mới</p>
        </div>
        
        <div class="register-body">
            <% String error = (String) request.getAttribute("error");
            if (error != null) { %>
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i>
                    <span><%= error %></span>
                </div>
            <% } %>
            
            <% String success = (String) request.getAttribute("success");
            if (success != null) { %>
                <div class="success-message">
                    <i class="fas fa-check-circle"></i>
                    <span><%= success %></span>
                </div>
            <% } %>
            
            <form action="register" method="post">
                <div class="form-group">
                    <label for="username">Tên đăng nhập</label>
                    <div class="input-wrapper">
                        <i class="fas fa-user"></i>
                        <input type="text" 
                               id="username" 
                               name="username" 
                               class="form-control" 
                               placeholder="Nhập tên đăng nhập"
                               required
                               minlength="3"
                               maxlength="50">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock"></i>
                        <input type="password" 
                               id="password" 
                               name="password" 
                               class="form-control" 
                               placeholder="Nhập mật khẩu"
                               required
                               minlength="6">
                    </div>
                    <div class="password-strength">
                        <div class="password-strength-bar" id="strengthBar"></div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">Xác nhận mật khẩu</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock"></i>
                        <input type="password" 
                               id="confirmPassword" 
                               name="confirmPassword" 
                               class="form-control" 
                               placeholder="Nhập lại mật khẩu"
                               required>
                    </div>
                </div>
                
                <button type="submit" class="btn-register">
                    <i class="fas fa-user-plus"></i>
                    Đăng ký
                </button>
            </form>
            
            <div class="register-footer">
                <p>Đã có tài khoản? <a href="login.jsp">Đăng nhập ngay</a></p>
            </div>
        </div>
    </div>
    
    <script>
        // Password strength indicator
        const password = document.getElementById('password');
        const strengthBar = document.getElementById('strengthBar');
        
        password.addEventListener('input', function() {
            const val = this.value;
            const length = val.length;
            
            strengthBar.className = 'password-strength-bar';
            
            if (length === 0) {
                strengthBar.style.width = '0%';
            } else if (length < 6) {
                strengthBar.classList.add('strength-weak');
            } else if (length < 10) {
                strengthBar.classList.add('strength-medium');
            } else {
                strengthBar.classList.add('strength-strong');
            }
        });
        
        // Confirm password validation
        const form = document.querySelector('form');
        const confirmPassword = document.getElementById('confirmPassword');
        
        form.addEventListener('submit', function(e) {
            if (password.value !== confirmPassword.value) {
                e.preventDefault();
                alert('Mật khẩu xác nhận không khớp!');
                confirmPassword.focus();
            }
        });
    </script>
</body>
</html>
