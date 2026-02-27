<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập | Da Nang Travel Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box}
        body{font-family:'Plus Jakarta Sans',system-ui,sans-serif;min-height:100vh;background:linear-gradient(135deg,#1B1F3B 0%,#2D3561 50%,#3D4580 100%);display:flex;align-items:center;justify-content:center;overflow:hidden;position:relative;-webkit-font-smoothing:antialiased}

        /* Animated background orbs */
        .bg-orbs{position:fixed;inset:0;pointer-events:none;overflow:hidden}
        .orb{position:absolute;border-radius:50%;filter:blur(80px);animation:orbFloat 20s ease-in-out infinite}
        .orb-1{width:500px;height:500px;background:rgba(255,111,97,.12);top:-10%;left:-10%;animation-delay:0s}
        .orb-2{width:400px;height:400px;background:rgba(0,180,216,.08);bottom:-15%;right:-10%;animation-delay:8s}
        .orb-3{width:300px;height:300px;background:rgba(255,183,3,.06);top:40%;right:20%;animation-delay:4s}
        @keyframes orbFloat{0%,100%{transform:translate(0,0)}25%{transform:translate(30px,-40px)}50%{transform:translate(-20px,30px)}75%{transform:translate(40px,20px)}}

        /* Particles */
        .particles{position:fixed;inset:0;pointer-events:none;overflow:hidden}
        .particle{position:absolute;border-radius:50%;background:rgba(255,255,255,.06);animation:float linear infinite}
        @keyframes float{0%{transform:translateY(100vh) rotate(0deg);opacity:0}10%{opacity:1}90%{opacity:1}100%{transform:translateY(-100px) rotate(720deg);opacity:0}}

        .auth-container{width:980px;max-width:95vw;display:flex;border-radius:28px;overflow:hidden;background:rgba(255,255,255,.98);box-shadow:0 50px 120px rgba(0,0,0,.35),0 0 0 1px rgba(255,255,255,.1);animation:slideUp .6s ease;position:relative;z-index:10}
        @keyframes slideUp{from{opacity:0;transform:translateY(30px) scale(.98)}to{opacity:1;transform:translateY(0) scale(1)}}

        /* Visual side */
        .auth-visual{width:45%;padding:50px;background:linear-gradient(135deg,#1B1F3B,#2D3561);color:white;display:flex;flex-direction:column;justify-content:center;position:relative;overflow:hidden}
        .auth-visual::before{content:'';position:absolute;width:300px;height:300px;background:radial-gradient(circle,rgba(255,111,97,.2),transparent 70%);top:-50px;right:-50px;border-radius:50%}
        .auth-visual::after{content:'';position:absolute;width:200px;height:200px;background:radial-gradient(circle,rgba(0,180,216,.15),transparent 70%);bottom:-30px;left:-30px;border-radius:50%}
        .auth-visual .icon{font-size:4rem;margin-bottom:30px;position:relative;z-index:1}
        .auth-visual h1{font-size:2.2rem;margin-bottom:15px;line-height:1.2;font-weight:800;position:relative;z-index:1}
        .auth-visual h1 .hl{color:#FF6F61}
        .auth-visual p{font-size:1rem;opacity:.8;line-height:1.7;position:relative;z-index:1}
        .features{margin-top:35px;display:grid;gap:16px;position:relative;z-index:1}
        .feat{display:flex;align-items:center;gap:12px;font-size:.88rem;color:rgba(255,255,255,.85)}
        .feat i{width:34px;height:34px;border-radius:10px;background:rgba(255,255,255,.1);display:flex;align-items:center;justify-content:center;font-size:.82rem;flex-shrink:0;color:#FF6F61}

        /* Form side */
        .auth-form{width:55%;padding:60px;display:flex;flex-direction:column;justify-content:center}
        .auth-form h2{font-size:1.8rem;color:#1B1F3B;margin-bottom:8px;font-weight:800}
        .auth-form .subtitle{color:#6B7194;margin-bottom:35px;font-size:.95rem}

        .form-group{margin-bottom:22px}
        .form-group label{display:block;font-size:.82rem;font-weight:700;color:#1B1F3B;margin-bottom:8px;text-transform:uppercase;letter-spacing:.5px}
        .form-group .input-wrapper{position:relative}
        .form-group .input-wrapper i{position:absolute;left:16px;top:50%;transform:translateY(-50%);color:#A0A5C3;font-size:.9rem}
        .form-group input{width:100%;padding:14px 16px 14px 46px;border:2px solid #E8EAF0;border-radius:14px;font-size:.95rem;font-family:'Plus Jakarta Sans',sans-serif;transition:.3s;background:#F7F8FC;color:#1B1F3B}
        .form-group input:focus{outline:none;border-color:#FF6F61;box-shadow:0 0 0 4px rgba(255,111,97,.1);background:white}

        .btn-login{width:100%;padding:16px;background:linear-gradient(135deg,#1B1F3B,#2D3561);color:white;border:none;border-radius:14px;font-size:1rem;font-weight:800;cursor:pointer;transition:.3s;font-family:'Plus Jakarta Sans',sans-serif;margin-top:10px;display:flex;align-items:center;justify-content:center;gap:8px}
        .btn-login:hover{transform:translateY(-2px);box-shadow:0 12px 30px rgba(27,31,59,.3)}

        .error-msg{background:linear-gradient(135deg,#FEF2F2,#FEE2E2);color:#DC2626;padding:14px 18px;border-radius:14px;margin-bottom:22px;font-size:.88rem;display:flex;align-items:center;gap:10px;border:1px solid #FECACA}
        .success-msg{background:linear-gradient(135deg,#ECFDF5,#D1FAE5);color:#059669;padding:14px 18px;border-radius:14px;margin-bottom:22px;font-size:.88rem;display:flex;align-items:center;gap:10px;border:1px solid #A7F3D0}

        .auth-footer{margin-top:30px;text-align:center;font-size:.9rem;color:#6B7194}
        .auth-footer a{color:#FF6F61;font-weight:700;transition:.3s}
        .auth-footer a:hover{color:#1B1F3B}

        /* Divider */
        .divider{display:flex;align-items:center;gap:14px;margin:20px 0;color:#A0A5C3;font-size:.82rem}
        .divider::before,.divider::after{content:'';flex:1;height:1px;background:#E8EAF0}

        @media(max-width:768px){
            .auth-visual{display:none}
            .auth-form{width:100%;padding:40px 30px}
        }
    </style>
</head>
<body>
    <div class="bg-orbs">
        <div class="orb orb-1"></div>
        <div class="orb orb-2"></div>
        <div class="orb orb-3"></div>
    </div>
    <div class="particles" id="particles"></div>

    <div class="auth-container">
        <div class="auth-visual">
            <div class="icon">🏖️</div>
            <h1>Da Nang<br><span class="hl">Travel Hub</span></h1>
            <p>Nền tảng đặt tour du lịch Đà Nẵng hàng đầu với công nghệ AI dự báo doanh thu.</p>
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

    <script>
        const container = document.getElementById('particles');
        for (let i = 0; i < 25; i++) {
            const p = document.createElement('div');
            p.className = 'particle';
            const size = Math.random() * 5 + 2;
            p.style.width = size + 'px';
            p.style.height = size + 'px';
            p.style.left = Math.random() * 100 + '%';
            p.style.animationDuration = (Math.random() * 18 + 12) + 's';
            p.style.animationDelay = (Math.random() * 12) + 's';
            container.appendChild(p);
        }
    </script>
</body>
</html>
