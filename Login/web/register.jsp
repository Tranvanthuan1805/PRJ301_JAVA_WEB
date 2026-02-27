<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - VietAir</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            min-height: 100vh;
            display: flex;
            background: #0f172a;
            -webkit-font-smoothing: antialiased;
        }

        .auth-page { display: flex; width: 100%; min-height: 100vh; }

        /* Left Panel */
        .auth-visual {
            flex: 1;
            background: linear-gradient(135deg, #1e40af 0%, #1e3a8a 60%, #0f172a 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 60px;
            position: relative;
            overflow: hidden;
        }

        .auth-visual::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at 30% 20%, rgba(6,182,212,0.15) 0%, transparent 50%),
                        radial-gradient(circle at 80% 80%, rgba(59,130,246,0.1) 0%, transparent 50%);
        }

        .auth-visual-content { position: relative; z-index: 1; text-align: center; color: #fff; }
        .auth-visual-content .logo-big { font-size: 3.5rem; margin-bottom: 20px; }
        .auth-visual-content h1 { font-size: 2.5rem; font-weight: 800; margin-bottom: 12px; letter-spacing: -1px; }
        .auth-visual-content p { font-size: 1.1rem; opacity: 0.8; max-width: 380px; line-height: 1.6; }

        .features-list {
            margin-top: 40px;
            text-align: left;
            position: relative;
            z-index: 1;
        }

        .feature-item {
            display: flex;
            align-items: center;
            gap: 12px;
            color: rgba(255,255,255,0.85);
            margin-bottom: 14px;
            font-size: 0.95rem;
        }

        .feature-item i {
            width: 32px;
            height: 32px;
            background: rgba(255,255,255,0.1);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #67e8f9;
            font-size: 14px;
            flex-shrink: 0;
        }

        /* Right Panel */
        .auth-form-panel {
            width: 500px;
            min-width: 440px;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 48px;
            background: #fff;
            overflow-y: auto;
        }

        .auth-form-inner {
            width: 100%;
            max-width: 380px;
            animation: slideUp 0.5s ease;
        }

        .auth-form-inner h2 { font-size: 1.6rem; font-weight: 800; color: #111827; margin-bottom: 6px; }
        .auth-form-inner .subtitle { color: #6b7280; font-size: 0.95rem; margin-bottom: 28px; }

        .back-home {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: #6b7280;
            font-size: 13px;
            text-decoration: none;
            margin-bottom: 20px;
            font-weight: 500;
            transition: color 0.2s;
        }

        .back-home:hover { color: #1e40af; }

        /* Form */
        .form-group { margin-bottom: 18px; }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            font-size: 13px;
            color: #374151;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .input-wrapper { position: relative; }

        .input-wrapper i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
            font-size: 15px;
            transition: color 0.2s;
        }

        .input-wrapper input {
            width: 100%;
            padding: 12px 14px 12px 42px;
            border: 2px solid #e5e7eb;
            border-radius: 10px;
            font-size: 15px;
            font-family: inherit;
            color: #111827;
            background: #f9fafb;
            transition: all 0.2s;
            outline: none;
        }

        .input-wrapper input:focus {
            border-color: #3b82f6;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(59,130,246,0.1);
        }

        .input-wrapper:focus-within i { color: #3b82f6; }
        .input-wrapper input::placeholder { color: #9ca3af; }

        /* Password Strength */
        .pw-strength {
            margin-top: 8px;
            height: 4px;
            background: #e5e7eb;
            border-radius: 4px;
            overflow: hidden;
        }

        .pw-strength-bar {
            height: 100%;
            width: 0%;
            border-radius: 4px;
            transition: all 0.3s;
        }

        .pw-weak { background: #ef4444; width: 33%; }
        .pw-medium { background: #f59e0b; width: 66%; }
        .pw-strong { background: #10b981; width: 100%; }

        /* Messages */
        .auth-error {
            background: #fef2f2;
            color: #991b1b;
            padding: 12px 14px;
            border-radius: 8px;
            margin-bottom: 18px;
            font-size: 14px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            border-left: 4px solid #ef4444;
        }

        .auth-success {
            background: #f0fdf4;
            color: #166534;
            padding: 12px 14px;
            border-radius: 8px;
            margin-bottom: 18px;
            font-size: 14px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            border-left: 4px solid #10b981;
        }

        /* Button */
        .btn-auth {
            width: 100%;
            padding: 13px;
            background: linear-gradient(135deg, #1e40af, #1e3a8a);
            color: #fff;
            border: none;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 700;
            font-family: inherit;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            box-shadow: 0 4px 12px rgba(30,64,175,0.25);
            margin-top: 4px;
        }

        .btn-auth:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(30,64,175,0.35); }
        .btn-auth:active { transform: translateY(0); }

        .auth-footer {
            text-align: center;
            margin-top: 24px;
            padding-top: 20px;
            border-top: 1px solid #e5e7eb;
            color: #6b7280;
            font-size: 14px;
        }

        .auth-footer a { color: #1e40af; font-weight: 600; text-decoration: none; }
        .auth-footer a:hover { text-decoration: underline; }

        @media (max-width: 900px) {
            .auth-visual { display: none; }
            .auth-form-panel { width: 100%; min-width: auto; padding: 32px 24px; }
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="auth-page">
        <!-- Left Visual Panel -->
        <div class="auth-visual">
            <div class="auth-visual-content">
                <div class="logo-big">✈️</div>
                <h1>VietAir</h1>
                <p>Tạo tài khoản để trải nghiệm dịch vụ tour du lịch tốt nhất Đà Nẵng</p>
            </div>
            <div class="features-list">
                <div class="feature-item">
                    <i class="fas fa-search"></i>
                    <span>Tìm kiếm 432+ tours theo sở thích</span>
                </div>
                <div class="feature-item">
                    <i class="fas fa-credit-card"></i>
                    <span>Đặt tour nhanh chóng, thanh toán an toàn</span>
                </div>
                <div class="feature-item">
                    <i class="fas fa-robot"></i>
                    <span>AI dự báo xu hướng du lịch 2026</span>
                </div>
                <div class="feature-item">
                    <i class="fas fa-star"></i>
                    <span>Đánh giá trung bình 4.9/5 sao</span>
                </div>
            </div>
        </div>

        <!-- Right Form Panel -->
        <div class="auth-form-panel">
            <div class="auth-form-inner">
                <a href="<%= request.getContextPath() %>/" class="back-home">
                    <i class="fas fa-arrow-left"></i> Về trang chủ
                </a>

                <h2>Đăng ký</h2>
                <p class="subtitle">Tạo tài khoản VietAir mới 🎉</p>

                <% String error = (String) request.getAttribute("error");
                   if (error != null) { %>
                    <div class="auth-error">
                        <i class="fas fa-exclamation-circle"></i> <%= error %>
                    </div>
                <% } %>

                <% String success = (String) request.getAttribute("success");
                   if (success != null) { %>
                    <div class="auth-success">
                        <i class="fas fa-check-circle"></i> <%= success %>
                    </div>
                <% } %>

                <form action="register" method="post" id="registerForm">
                    <div class="form-group">
                        <label for="username"><i class="fas fa-user"></i> Tên đăng nhập</label>
                        <div class="input-wrapper">
                            <input type="text" id="username" name="username" 
                                   placeholder="Nhập tên đăng nhập" required minlength="3" maxlength="50">
                            <i class="fas fa-user"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password"><i class="fas fa-lock"></i> Mật khẩu</label>
                        <div class="input-wrapper">
                            <input type="password" id="password" name="password" 
                                   placeholder="Nhập mật khẩu" required minlength="6">
                            <i class="fas fa-lock"></i>
                        </div>
                        <div class="pw-strength">
                            <div class="pw-strength-bar" id="strengthBar"></div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword"><i class="fas fa-shield-alt"></i> Xác nhận mật khẩu</label>
                        <div class="input-wrapper">
                            <input type="password" id="confirmPassword" name="confirmPassword" 
                                   placeholder="Nhập lại mật khẩu" required>
                            <i class="fas fa-shield-alt"></i>
                        </div>
                    </div>

                    <button type="submit" class="btn-auth">
                        <i class="fas fa-user-plus"></i> Đăng ký
                    </button>
                </form>

                <div class="auth-footer">
                    <p>Đã có tài khoản? <a href="login.jsp">Đăng nhập ngay</a></p>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Password strength
        const pw = document.getElementById('password');
        const bar = document.getElementById('strengthBar');
        
        pw.addEventListener('input', function() {
            bar.className = 'pw-strength-bar';
            if (this.value.length === 0) { bar.style.width = '0'; return; }
            if (this.value.length < 6) bar.classList.add('pw-weak');
            else if (this.value.length < 10) bar.classList.add('pw-medium');
            else bar.classList.add('pw-strong');
        });

        // Confirm password
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            if (pw.value !== document.getElementById('confirmPassword').value) {
                e.preventDefault();
                alert('Mật khẩu xác nhận không khớp!');
                document.getElementById('confirmPassword').focus();
            }
        });
    </script>
</body>
</html>
