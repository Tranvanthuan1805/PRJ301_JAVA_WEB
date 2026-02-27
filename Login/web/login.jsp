<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - VietAir</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            min-height: 100vh;
            display: flex;
            background: #0f172a;
            color: #1f2937;
            -webkit-font-smoothing: antialiased;
        }

        /* Split Layout */
        .auth-page { display: flex; width: 100%; min-height: 100vh; }

        /* Left — Visual Panel */
        .auth-visual {
            flex: 1;
            background: linear-gradient(135deg, #1e40af 0%, #1e3a8a 50%, #0f172a 100%);
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

        .auth-visual-content {
            position: relative;
            z-index: 1;
            text-align: center;
            color: #fff;
        }

        .auth-visual-content .logo-big {
            font-size: 3.5rem;
            margin-bottom: 20px;
            filter: drop-shadow(0 4px 12px rgba(0,0,0,0.3));
        }

        .auth-visual-content h1 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 12px;
            letter-spacing: -1px;
        }

        .auth-visual-content p {
            font-size: 1.1rem;
            opacity: 0.8;
            max-width: 380px;
            line-height: 1.6;
        }

        .visual-stats {
            display: flex;
            gap: 32px;
            margin-top: 40px;
            position: relative;
            z-index: 1;
        }

        .visual-stat {
            text-align: center;
            color: #fff;
        }

        .visual-stat strong {
            display: block;
            font-size: 1.8rem;
            font-weight: 800;
            color: #67e8f9;
        }

        .visual-stat span {
            font-size: 0.8rem;
            opacity: 0.7;
            font-weight: 500;
        }

        /* Right — Form Panel */
        .auth-form-panel {
            width: 480px;
            min-width: 420px;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 48px;
            background: #fff;
        }

        .auth-form-inner {
            width: 100%;
            max-width: 360px;
        }

        .auth-form-inner h2 {
            font-size: 1.75rem;
            font-weight: 800;
            color: #111827;
            margin-bottom: 6px;
        }

        .auth-form-inner .subtitle {
            color: #6b7280;
            font-size: 0.95rem;
            margin-bottom: 32px;
        }

        /* Form */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            font-size: 13px;
            color: #374151;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .input-wrapper {
            position: relative;
        }

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

        .input-wrapper input:focus + i,
        .input-wrapper:focus-within i {
            color: #3b82f6;
        }

        .input-wrapper input::placeholder { color: #9ca3af; }

        /* Error Alert */
        .auth-error {
            background: #fef2f2;
            color: #991b1b;
            padding: 12px 14px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            border-left: 4px solid #ef4444;
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
            margin-top: 8px;
        }

        .btn-auth:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(30,64,175,0.35);
        }

        .btn-auth:active { transform: translateY(0); }

        .auth-footer {
            text-align: center;
            margin-top: 28px;
            padding-top: 24px;
            border-top: 1px solid #e5e7eb;
            color: #6b7280;
            font-size: 14px;
        }

        .auth-footer a {
            color: #1e40af;
            font-weight: 600;
            text-decoration: none;
        }

        .auth-footer a:hover { text-decoration: underline; }

        .back-home {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: #6b7280;
            font-size: 13px;
            text-decoration: none;
            margin-bottom: 24px;
            font-weight: 500;
            transition: color 0.2s;
        }

        .back-home:hover { color: #1e40af; }

        /* Responsive */
        @media (max-width: 900px) {
            .auth-visual { display: none; }
            .auth-form-panel {
                width: 100%;
                min-width: auto;
                padding: 32px 24px;
            }
        }

        /* Animation */
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .auth-form-inner { animation: slideUp 0.5s ease; }
    </style>
</head>
<body>
    <div class="auth-page">
        <!-- Left Visual -->
        <div class="auth-visual">
            <div class="auth-visual-content">
                <div class="logo-big">✈️</div>
                <h1>VietAir</h1>
                <p>Hệ thống quản lý tour du lịch chuyên nghiệp. Khám phá Đà Nẵng cùng chúng tôi.</p>
            </div>
            <div class="visual-stats">
                <div class="visual-stat">
                    <strong>432+</strong>
                    <span>Tours</span>
                </div>
                <div class="visual-stat">
                    <strong>6</strong>
                    <span>Điểm đến</span>
                </div>
                <div class="visual-stat">
                    <strong>4.9★</strong>
                    <span>Đánh giá</span>
                </div>
            </div>
        </div>

        <!-- Right Form -->
        <div class="auth-form-panel">
            <div class="auth-form-inner">
                <a href="<%= request.getContextPath() %>/" class="back-home">
                    <i class="fas fa-arrow-left"></i> Về trang chủ
                </a>

                <h2>Đăng nhập</h2>
                <p class="subtitle">Chào mừng bạn quay trở lại ✈️</p>

                <% String err = (String) request.getAttribute("error"); %>
                <% if (err != null) { %>
                    <div class="auth-error">
                        <i class="fas fa-exclamation-circle"></i>
                        <%= err %>
                    </div>
                <% } %>

                <form action="login" method="post" onsubmit="return validateForm()">
                    <div class="form-group">
                        <label for="username">Tên đăng nhập</label>
                        <div class="input-wrapper">
                            <input id="username" name="username" type="text" 
                                   placeholder="Nhập username" autocomplete="off">
                            <i class="fas fa-user"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password">Mật khẩu</label>
                        <div class="input-wrapper">
                            <input id="password" name="password" type="password" 
                                   placeholder="Nhập password" autocomplete="off">
                            <i class="fas fa-lock"></i>
                        </div>
                    </div>

                    <button type="submit" class="btn-auth">
                        <i class="fas fa-sign-in-alt"></i>
                        Đăng nhập
                    </button>
                </form>

                <div class="auth-footer">
                    <p>Chưa có tài khoản? <a href="register.jsp">Đăng ký ngay</a></p>
                </div>
            </div>
        </div>
    </div>

    <script>
        function validateForm() {
            var u = document.getElementById('username').value.trim();
            var p = document.getElementById('password').value;
            if (u === '' || p === '') {
                alert('Vui lòng nhập đầy đủ username và password');
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
