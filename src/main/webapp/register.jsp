<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký | eztravel</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box}
        body{font-family:'Inter',system-ui,sans-serif;min-height:100vh;background:#F8FAFC;display:flex;align-items:center;justify-content:center;overflow:hidden;position:relative;-webkit-font-smoothing:antialiased}

        .bg-pattern{position:fixed;inset:0;pointer-events:none;overflow:hidden}
        .bg-pattern::before{content:'';position:absolute;width:800px;height:800px;background:radial-gradient(circle,rgba(37,99,235,.04),transparent 60%);top:-200px;left:-200px;border-radius:50%}
        .bg-pattern::after{content:'';position:absolute;width:600px;height:600px;background:radial-gradient(circle,rgba(16,185,129,.03),transparent 60%);bottom:-200px;right:-150px;border-radius:50%}

        .auth-container{width:1000px;max-width:95vw;display:flex;border-radius:24px;overflow:hidden;background:white;box-shadow:0 25px 50px -12px rgba(0,0,0,0.15),0 0 0 1px rgba(0,0,0,.03);animation:slideUp .5s ease;position:relative;z-index:10}
        @keyframes slideUp{from{opacity:0;transform:translateY(20px) scale(.99)}to{opacity:1;transform:translateY(0) scale(1)}}

        .auth-visual{width:42%;padding:50px;background:linear-gradient(135deg,#1A2B49 0%,#2A3D5F 100%);color:white;display:flex;flex-direction:column;justify-content:center;position:relative;overflow:hidden}
        .auth-visual::before{content:'';position:absolute;width:250px;height:250px;background:radial-gradient(circle,rgba(37,99,235,.2),transparent 70%);bottom:-40px;right:-40px;border-radius:50%}
        .auth-visual::after{content:'';position:absolute;width:200px;height:200px;background:radial-gradient(circle,rgba(16,185,129,.12),transparent 70%);top:-30px;left:-30px;border-radius:50%}
        .auth-visual .logo-area{margin-bottom:35px;position:relative;z-index:1}
        .auth-visual .logo-area h2{font-family:'Playfair Display',serif;font-size:1.8rem;font-weight:800}
        .auth-visual .logo-area h2 span{color:#3B82F6}
        .auth-visual h1{font-family:'Playfair Display',serif;font-size:2.2rem;margin-bottom:12px;font-weight:800;line-height:1.2;position:relative;z-index:1}
        .auth-visual h1 .hl{color:#3B82F6}
        .auth-visual>p{font-size:.92rem;opacity:.7;line-height:1.7;position:relative;z-index:1;max-width:300px}
        .steps{margin-top:35px;display:grid;gap:16px;position:relative;z-index:1}
        .step{display:flex;align-items:center;gap:12px;font-size:.85rem;color:rgba(255,255,255,.8)}
        .step .num{width:32px;height:32px;border-radius:8px;background:rgba(255,255,255,.08);border:1px solid rgba(255,255,255,.06);display:flex;align-items:center;justify-content:center;font-weight:800;flex-shrink:0;font-size:.8rem;color:#3B82F6}

        .auth-form{width:58%;padding:45px 50px;display:flex;flex-direction:column;justify-content:center}
        .auth-form h2{font-size:1.6rem;color:#1A2B49;margin-bottom:6px;font-weight:800}
        .auth-form .subtitle{color:#64748B;margin-bottom:28px;font-size:.9rem}

        .form-group{margin-bottom:16px}
        .form-group label{display:block;font-size:.78rem;font-weight:600;color:#1E293B;margin-bottom:6px}
        .form-group .input-wrapper{position:relative}
        .form-group .input-wrapper i{position:absolute;left:14px;top:50%;transform:translateY(-50%);color:#94A3B8;font-size:.82rem}
        .form-group input{width:100%;padding:12px 14px 12px 40px;border:1.5px solid #E2E8F0;border-radius:10px;font-size:.88rem;font-family:'Inter',sans-serif;transition:.3s;background:#F8FAFC;color:#1E293B}
        .form-group input:focus{outline:none;border-color:#2563EB;box-shadow:0 0 0 3px rgba(37,99,235,.08);background:white}

        .btn-register{width:100%;padding:14px;background:#2563EB;color:white;border:none;border-radius:10px;font-size:.92rem;font-weight:700;cursor:pointer;transition:.3s;font-family:'Inter',sans-serif;margin-top:6px;display:flex;align-items:center;justify-content:center;gap:8px}
        .btn-register:hover{background:#3B82F6;transform:translateY(-1px);box-shadow:0 6px 20px rgba(37,99,235,.25)}

        .error-msg{background:#FEF2F2;color:#DC2626;padding:12px 16px;border-radius:10px;margin-bottom:16px;font-size:.82rem;display:flex;align-items:center;gap:10px;border:1px solid #FECACA}
        .success-msg{background:#ECFDF5;color:#059669;padding:12px 16px;border-radius:10px;margin-bottom:16px;font-size:.82rem;display:flex;align-items:center;gap:10px;border:1px solid #A7F3D0}

        .auth-footer{margin-top:22px;text-align:center;font-size:.88rem;color:#64748B}
        .auth-footer a{color:#2563EB;font-weight:600;text-decoration:none;transition:.3s}
        .auth-footer a:hover{color:#1A2B49}

        @media(max-width:768px){
            .auth-visual{display:none}
            .auth-form{width:100%;padding:36px 24px}
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
            <h1>Tham Gia<br><span class="hl">eztravel</span></h1>
            <p>Tạo tài khoản miễn phí để khám phá và đặt tour du lịch Đà Nẵng.</p>
            <div class="steps">
                <div class="step"><div class="num">1</div> Tạo tài khoản miễn phí</div>
                <div class="step"><div class="num">2</div> Khám phá 100+ tour Đà Nẵng</div>
                <div class="step"><div class="num">3</div> Đặt tour & thanh toán QR</div>
                <div class="step"><div class="num">4</div> Tận hưởng chuyến đi!</div>
            </div>
        </div>

        <div class="auth-form">
            <h2>Đăng Ký</h2>
            <p class="subtitle">Tạo tài khoản mới để bắt đầu 🚀</p>

            <c:if test="${not empty error}">
                <div class="error-msg"><i class="fas fa-exclamation-circle"></i> ${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="success-msg"><i class="fas fa-check-circle"></i> ${success}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="form-group">
                    <label for="username">Tên đăng nhập</label>
                    <div class="input-wrapper">
                        <i class="fas fa-user"></i>
                        <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập (3-50 ký tự)" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <div class="input-wrapper">
                        <i class="fas fa-envelope"></i>
                        <input type="email" id="email" name="email" placeholder="you@example.com">
                    </div>
                </div>
                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="password" name="password" placeholder="Tối thiểu 6 ký tự" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Xác nhận mật khẩu</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu" required>
                    </div>
                </div>
                <button type="submit" class="btn-register">
                    <i class="fas fa-user-plus"></i> ĐĂNG KÝ
                </button>
            </form>
            <div class="auth-footer">
                Đã có tài khoản? <a href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a>
            </div>
        </div>
    </div>
</body>
</html>
