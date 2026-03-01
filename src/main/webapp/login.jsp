<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập | eztravel</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box}
        body{font-family:'Inter',system-ui,sans-serif;min-height:100vh;background:#F8FAFC;display:flex;align-items:center;justify-content:center;overflow:hidden;position:relative;-webkit-font-smoothing:antialiased}

        /* Subtle background pattern */
        .bg-pattern{position:fixed;inset:0;pointer-events:none;overflow:hidden}
        .bg-pattern::before{content:'';position:absolute;width:800px;height:800px;background:radial-gradient(circle,rgba(37,99,235,.04),transparent 60%);top:-200px;right:-200px;border-radius:50%}
        .bg-pattern::after{content:'';position:absolute;width:600px;height:600px;background:radial-gradient(circle,rgba(6,182,212,.03),transparent 60%);bottom:-200px;left:-150px;border-radius:50%}

        .auth-container{width:1000px;max-width:95vw;display:flex;border-radius:24px;overflow:hidden;background:white;box-shadow:0 25px 50px -12px rgba(0,0,0,0.15),0 0 0 1px rgba(0,0,0,.03);animation:slideUp .5s ease;position:relative;z-index:10}
        @keyframes slideUp{from{opacity:0;transform:translateY(20px) scale(.99)}to{opacity:1;transform:translateY(0) scale(1)}}

        /* Visual side */
        .auth-visual{width:45%;padding:50px;background:linear-gradient(135deg,#1A2B49 0%,#2A3D5F 100%);color:white;display:flex;flex-direction:column;justify-content:center;position:relative;overflow:hidden}
        .auth-visual::before{content:'';position:absolute;width:300px;height:300px;background:radial-gradient(circle,rgba(37,99,235,.2),transparent 70%);top:-50px;right:-50px;border-radius:50%}
        .auth-visual::after{content:'';position:absolute;width:200px;height:200px;background:radial-gradient(circle,rgba(6,182,212,.15),transparent 70%);bottom:-30px;left:-30px;border-radius:50%}
        .auth-visual .logo-area{margin-bottom:40px;position:relative;z-index:1}
        .auth-visual .logo-area h2{font-family:'Playfair Display',serif;font-size:2rem;font-weight:800}
        .auth-visual .logo-area h2 span{color:#3B82F6}
        .auth-visual h1{font-family:'Playfair Display',serif;font-size:2.4rem;margin-bottom:15px;line-height:1.15;font-weight:800;position:relative;z-index:1}
        .auth-visual h1 .hl{color:#3B82F6}
        .auth-visual>p{font-size:.95rem;opacity:.7;line-height:1.7;position:relative;z-index:1;max-width:320px}
        .features{margin-top:40px;display:grid;gap:14px;position:relative;z-index:1}
        .feat{display:flex;align-items:center;gap:12px;font-size:.85rem;color:rgba(255,255,255,.8)}
        .feat i{width:32px;height:32px;border-radius:8px;background:rgba(255,255,255,.08);border:1px solid rgba(255,255,255,.06);display:flex;align-items:center;justify-content:center;font-size:.78rem;flex-shrink:0;color:#3B82F6}

        /* Form side */
        .auth-form{width:55%;padding:60px;display:flex;flex-direction:column;justify-content:center}
        .auth-form h2{font-size:1.7rem;color:#1A2B49;margin-bottom:6px;font-weight:800}
        .auth-form .subtitle{color:#64748B;margin-bottom:32px;font-size:.92rem}

        .form-group{margin-bottom:20px}
        .form-group label{display:block;font-size:.8rem;font-weight:600;color:#1E293B;margin-bottom:6px}
        .form-group .input-wrapper{position:relative}
        .form-group .input-wrapper i{position:absolute;left:14px;top:50%;transform:translateY(-50%);color:#94A3B8;font-size:.85rem}
        .form-group input{width:100%;padding:13px 16px 13px 42px;border:1.5px solid #E2E8F0;border-radius:10px;font-size:.9rem;font-family:'Inter',sans-serif;transition:.3s;background:#F8FAFC;color:#1E293B}
        .form-group input:focus{outline:none;border-color:#2563EB;box-shadow:0 0 0 3px rgba(37,99,235,.08);background:white}

        .btn-login{width:100%;padding:14px;background:#2563EB;color:white;border:none;border-radius:10px;font-size:.95rem;font-weight:700;cursor:pointer;transition:.3s;font-family:'Inter',sans-serif;margin-top:8px;display:flex;align-items:center;justify-content:center;gap:8px}
        .btn-login:hover{background:#3B82F6;transform:translateY(-1px);box-shadow:0 6px 20px rgba(37,99,235,.25)}

        .error-msg{background:#FEF2F2;color:#DC2626;padding:12px 16px;border-radius:10px;margin-bottom:20px;font-size:.85rem;display:flex;align-items:center;gap:10px;border:1px solid #FECACA}
        .success-msg{background:#ECFDF5;color:#059669;padding:12px 16px;border-radius:10px;margin-bottom:20px;font-size:.85rem;display:flex;align-items:center;gap:10px;border:1px solid #A7F3D0}

        .auth-footer{margin-top:28px;text-align:center;font-size:.88rem;color:#64748B}
        .auth-footer a{color:#2563EB;font-weight:600;transition:.3s}
        .auth-footer a:hover{color:#1A2B49}

        .divider{display:flex;align-items:center;gap:14px;margin:24px 0;color:#94A3B8;font-size:.8rem}
        .divider::before,.divider::after{content:'';flex:1;height:1px;background:#E2E8F0}

        /* Social login buttons */
        .social-btns{display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-bottom:8px}
        .social-btn{display:flex;align-items:center;justify-content:center;gap:8px;padding:11px;border:1.5px solid #E2E8F0;border-radius:10px;font-size:.85rem;font-weight:600;color:#1E293B;background:white;cursor:pointer;transition:.3s;font-family:inherit}
        .social-btn:hover{border-color:#CBD5E1;background:#F8FAFC}
        .social-btn img{width:18px;height:18px}

        @media(max-width:768px){
            .auth-visual{display:none}
            .auth-form{width:100%;padding:40px 28px}
        }
    </style>
</head>
<body>
    <div class="bg-pattern"></div>

    <div class="auth-container">
        <div class="auth-visual">
            <div class="logo-area">
                <h2><span>ez</span>travel</h2>
            </div>
            <h1>Chào Mừng<br>Đến <span class="hl">Đà Nẵng</span></h1>
            <p>Khám phá các điểm đến tuyệt vời, đặt tour xác minh và tạo nên những kỷ niệm du lịch khó quên.</p>
            <div class="features">
                <div class="feat"><i class="fas fa-shield-alt"></i> Đối tác du lịch uy tín</div>
                <div class="feat"><i class="fas fa-brain"></i> AI dự báo doanh thu thông minh</div>
                <div class="feat"><i class="fas fa-bolt"></i> Đặt tour tức thì, xác nhận nhanh</div>
                <div class="feat"><i class="fas fa-qrcode"></i> Thanh toán QR SePay tiện lợi</div>
            </div>
        </div>

        <div class="auth-form">
            <h2>Đăng Nhập</h2>
            <p class="subtitle">Chào mừng bạn quay lại! 👋</p>

            <c:if test="${not empty error}">
                <div class="error-msg"><i class="fas fa-exclamation-circle"></i> ${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="success-msg"><i class="fas fa-check-circle"></i> ${success}</div>
            </c:if>

            <div class="divider" style="margin-top:0">vui lòng nhập tài khoản</div>

            <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">
                <div class="form-group">
                    <label for="username">Tên đăng nhập</label>
                    <div class="input-wrapper">
                        <i class="fas fa-user"></i>
                        <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập" required autocomplete="username">
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required autocomplete="current-password">
                    </div>
                </div>

                <button type="submit" class="btn-login">
                    <i class="fas fa-sign-in-alt"></i> ĐĂNG NHẬP
                </button>
            </form>

            <div class="auth-footer">
                Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register.jsp">Đăng ký ngay</a>
            </div>
        </div>
    </div>
</body>
</html>
