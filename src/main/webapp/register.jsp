<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký | Da Nang Travel Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box}
        body{font-family:'Plus Jakarta Sans',system-ui,sans-serif;min-height:100vh;background:linear-gradient(135deg,#1B1F3B 0%,#2D3561 50%,#3D4580 100%);display:flex;align-items:center;justify-content:center;overflow:hidden;position:relative;-webkit-font-smoothing:antialiased}

        /* Animated orbs */
        .bg-orbs{position:fixed;inset:0;pointer-events:none;overflow:hidden}
        .orb{position:absolute;border-radius:50%;filter:blur(80px);animation:orbFloat 20s ease-in-out infinite}
        .orb-1{width:500px;height:500px;background:rgba(255,111,97,.12);bottom:-10%;right:-10%;animation-delay:0s}
        .orb-2{width:400px;height:400px;background:rgba(6,214,160,.08);top:-15%;left:-10%;animation-delay:6s}
        .orb-3{width:300px;height:300px;background:rgba(255,183,3,.06);bottom:30%;left:30%;animation-delay:3s}
        @keyframes orbFloat{0%,100%{transform:translate(0,0)}25%{transform:translate(30px,-40px)}50%{transform:translate(-20px,30px)}75%{transform:translate(40px,20px)}}

        .particles{position:fixed;inset:0;pointer-events:none;overflow:hidden}
        .particle{position:absolute;border-radius:50%;background:rgba(255,255,255,.06);animation:float linear infinite}
        @keyframes float{0%{transform:translateY(100vh) rotate(0deg);opacity:0}10%{opacity:1}90%{opacity:1}100%{transform:translateY(-100px) rotate(720deg);opacity:0}}

        .auth-container{width:980px;max-width:95vw;display:flex;border-radius:28px;overflow:hidden;background:rgba(255,255,255,.98);box-shadow:0 50px 120px rgba(0,0,0,.35),0 0 0 1px rgba(255,255,255,.1);animation:slideUp .6s ease;position:relative;z-index:10}
        @keyframes slideUp{from{opacity:0;transform:translateY(30px) scale(.98)}to{opacity:1;transform:translateY(0) scale(1)}}

        .auth-visual{width:42%;padding:50px;background:linear-gradient(135deg,#2D3561,#1B1F3B);color:white;display:flex;flex-direction:column;justify-content:center;position:relative;overflow:hidden}
        .auth-visual::before{content:'';position:absolute;width:250px;height:250px;background:radial-gradient(circle,rgba(255,111,97,.2),transparent 70%);bottom:-40px;right:-40px;border-radius:50%}
        .auth-visual::after{content:'';position:absolute;width:200px;height:200px;background:radial-gradient(circle,rgba(6,214,160,.12),transparent 70%);top:-30px;left:-30px;border-radius:50%}
        .auth-visual .icon{font-size:3.5rem;margin-bottom:25px;position:relative;z-index:1}
        .auth-visual h1{font-size:2rem;margin-bottom:12px;font-weight:800;line-height:1.2;position:relative;z-index:1}
        .auth-visual h1 .hl{color:#FF6F61}
        .auth-visual p{font-size:.95rem;opacity:.8;line-height:1.7;position:relative;z-index:1}
        .steps{margin-top:30px;display:grid;gap:18px;position:relative;z-index:1}
        .step{display:flex;align-items:center;gap:14px;font-size:.86rem;color:rgba(255,255,255,.85)}
        .step .num{width:34px;height:34px;border-radius:50%;background:rgba(255,255,255,.1);display:flex;align-items:center;justify-content:center;font-weight:800;flex-shrink:0;font-size:.82rem;border:1px solid rgba(255,255,255,.15)}

        .auth-form{width:58%;padding:45px 50px;display:flex;flex-direction:column;justify-content:center}
        .auth-form h2{font-size:1.7rem;color:#1B1F3B;margin-bottom:6px;font-weight:800}
        .auth-form .subtitle{color:#6B7194;margin-bottom:28px;font-size:.9rem}

        .form-group{margin-bottom:18px}
        .form-group label{display:block;font-size:.8rem;font-weight:700;color:#1B1F3B;margin-bottom:6px;text-transform:uppercase;letter-spacing:.5px}
        .form-group .input-wrapper{position:relative}
        .form-group .input-wrapper i{position:absolute;left:16px;top:50%;transform:translateY(-50%);color:#A0A5C3;font-size:.85rem}
        .form-group input{width:100%;padding:13px 14px 13px 44px;border:2px solid #E8EAF0;border-radius:14px;font-size:.9rem;font-family:'Plus Jakarta Sans',sans-serif;transition:.3s;background:#F7F8FC;color:#1B1F3B}
        .form-group input:focus{outline:none;border-color:#FF6F61;box-shadow:0 0 0 4px rgba(255,111,97,.1);background:white}

        .btn-register{width:100%;padding:15px;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:white;border:none;border-radius:14px;font-size:1rem;font-weight:800;cursor:pointer;transition:.3s;font-family:'Plus Jakarta Sans',sans-serif;margin-top:8px;display:flex;align-items:center;justify-content:center;gap:8px;box-shadow:0 6px 20px rgba(255,111,97,.2)}
        .btn-register:hover{transform:translateY(-2px);box-shadow:0 12px 30px rgba(255,111,97,.35)}

        .error-msg{background:linear-gradient(135deg,#FEF2F2,#FEE2E2);color:#DC2626;padding:12px 16px;border-radius:14px;margin-bottom:16px;font-size:.85rem;display:flex;align-items:center;gap:10px;border:1px solid #FECACA}
        .success-msg{background:linear-gradient(135deg,#ECFDF5,#D1FAE5);color:#059669;padding:12px 16px;border-radius:14px;margin-bottom:16px;font-size:.85rem;display:flex;align-items:center;gap:10px;border:1px solid #A7F3D0}

        .auth-footer{margin-top:25px;text-align:center;font-size:.88rem;color:#6B7194}
        .auth-footer a{color:#FF6F61;font-weight:700;text-decoration:none;transition:.3s}
        .auth-footer a:hover{color:#1B1F3B}

        @media(max-width:768px){
            .auth-visual{display:none}
            .auth-form{width:100%;padding:40px 25px}
        }
    </style>
</head>
<body>
    <div class="bg-orbs"><div class="orb orb-1"></div><div class="orb orb-2"></div><div class="orb orb-3"></div></div>
    <div class="particles" id="particles"></div>

    <div class="auth-container">
        <div class="auth-visual">
            <div class="icon">✈️</div>
            <h1>Tham Gia<br><span class="hl">Da Nang Hub</span></h1>
            <p>Tạo tài khoản miễn phí để đặt tour du lịch Đà Nẵng và trải nghiệm dịch vụ tốt nhất.</p>
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
                        <input type="email" id="email" name="email" placeholder="email@example.com">
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
