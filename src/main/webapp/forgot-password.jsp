<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu — eztravel</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800;900&family=Playfair+Display:wght@700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box}
        body{font-family:'Inter',system-ui,sans-serif;min-height:100vh;background:linear-gradient(135deg,#0F172A 0%,#1E293B 50%,#0F172A 100%);display:flex;align-items:center;justify-content:center;padding:20px}

        .auth-container{display:grid;grid-template-columns:1fr 1fr;max-width:880px;width:100%;min-height:520px;background:#fff;border-radius:24px;overflow:hidden;box-shadow:0 25px 80px rgba(0,0,0,.35)}

        /* Visual Side */
        .auth-visual{background:linear-gradient(135deg,#1E293B 0%,#334155 100%);padding:48px 40px;display:flex;flex-direction:column;justify-content:center;position:relative;overflow:hidden}
        .auth-visual::before{content:'';position:absolute;top:-50%;right:-50%;width:100%;height:100%;background:radial-gradient(circle,rgba(59,130,246,.15) 0%,transparent 70%);pointer-events:none}
        .auth-visual .brand{font-family:'Playfair Display',serif;font-size:1.3rem;font-weight:900;color:#fff;margin-bottom:28px}
        .auth-visual .brand .ez{color:#60A5FA}
        .auth-visual h1{font-family:'Playfair Display',serif;font-size:clamp(1.6rem,3vw,2.2rem);font-weight:900;color:#fff;line-height:1.2;margin-bottom:16px}
        .auth-visual h1 .hl{color:#60A5FA}
        .auth-visual p{color:#94A3B8;font-size:.88rem;line-height:1.65;margin-bottom:28px;max-width:320px}
        .features{display:flex;flex-direction:column;gap:12px}
        .feat{display:flex;align-items:center;gap:10px;color:#94A3B8;font-size:.82rem;font-weight:600}
        .feat i{width:30px;height:30px;border-radius:8px;display:flex;align-items:center;justify-content:center;font-size:.72rem;flex-shrink:0}
        .feat:nth-child(1) i{background:rgba(59,130,246,.15);color:#60A5FA}
        .feat:nth-child(2) i{background:rgba(16,185,129,.15);color:#10B981}
        .feat:nth-child(3) i{background:rgba(251,191,36,.15);color:#FBBF24}

        /* Form Side */
        .auth-form{padding:48px 40px;display:flex;flex-direction:column;justify-content:center}
        .auth-form h2{font-family:'Playfair Display',serif;font-size:1.8rem;font-weight:900;color:#1E293B;margin-bottom:6px}
        .subtitle{color:#64748B;font-size:.88rem;margin-bottom:24px}
        .error-msg{background:rgba(239,68,68,.08);border:1px solid rgba(239,68,68,.2);color:#DC2626;padding:10px 14px;border-radius:10px;font-size:.82rem;font-weight:600;margin-bottom:16px;display:flex;align-items:center;gap:8px}
        .success-msg{background:rgba(16,185,129,.08);border:1px solid rgba(16,185,129,.2);color:#059669;padding:10px 14px;border-radius:10px;font-size:.82rem;font-weight:600;margin-bottom:16px;display:flex;align-items:center;gap:8px}
        .form-group{margin-bottom:16px}
        .form-group label{display:block;font-size:.82rem;font-weight:700;color:#475569;margin-bottom:6px}
        .input-wrapper{position:relative;display:flex;align-items:center}
        .input-wrapper i{position:absolute;left:14px;color:#94A3B8;font-size:.85rem}
        .input-wrapper input{width:100%;padding:12px 14px 12px 42px;border:2px solid #E2E8F0;border-radius:12px;font-size:.88rem;color:#1E293B;outline:none;transition:.3s;font-family:inherit;background:#F8FAFC}
        .input-wrapper input:focus{border-color:#3B82F6;box-shadow:0 0 0 3px rgba(59,130,246,.1);background:#fff}
        .btn-submit{width:100%;padding:12px;background:linear-gradient(135deg,#2563EB,#3B82F6);color:#fff;border:none;border-radius:12px;font-size:.88rem;font-weight:700;cursor:pointer;transition:all .3s;font-family:inherit;display:flex;align-items:center;justify-content:center;gap:8px;box-shadow:0 4px 14px rgba(37,99,235,.3);margin-top:8px}
        .btn-submit:hover{transform:translateY(-2px);box-shadow:0 6px 20px rgba(37,99,235,.4)}
        .btn-submit:active{transform:translateY(0)}
        .back-link{text-align:center;margin-top:20px;font-size:.82rem;color:#64748B}
        .back-link a{color:#3B82F6;font-weight:700;text-decoration:none;transition:.3s}
        .back-link a:hover{color:#2563EB}

        /* Step indicator */
        .steps{display:flex;align-items:center;gap:8px;margin-bottom:24px}
        .step-dot{width:32px;height:4px;border-radius:2px;background:#E2E8F0;transition:.3s}
        .step-dot.active{background:#3B82F6;width:48px}
        .step-dot.done{background:#10B981}

        /* Verified badge */
        .verified-badge{display:inline-flex;align-items:center;gap:6px;background:rgba(16,185,129,.08);border:1px solid rgba(16,185,129,.2);color:#059669;padding:8px 16px;border-radius:10px;font-size:.82rem;font-weight:700;margin-bottom:16px}
        .verified-badge i{font-size:.9rem}

        /* Password strength */
        .pw-strength{height:4px;border-radius:2px;background:#E2E8F0;margin-top:6px;overflow:hidden}
        .pw-strength-bar{height:100%;width:0;border-radius:2px;transition:all .3s}

        @media(max-width:768px){
            .auth-container{grid-template-columns:1fr;max-width:460px}
            .auth-visual{display:none}
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <!-- Visual Side -->
        <div class="auth-visual">
            <div class="brand">ez<span class="ez">travel</span></div>
            <h1>Khôi Phục<br>Tài Khoản <span class="hl">Của Bạn</span></h1>
            <p>Không thể nhớ mật khẩu? Đừng lo, chúng tôi sẽ giúp bạn lấy lại quyền truy cập nhanh chóng.</p>
            <div class="features">
                <div class="feat"><i class="fas fa-user-check"></i> Xác minh bằng username + email</div>
                <div class="feat"><i class="fas fa-lock-open"></i> Đặt lại mật khẩu an toàn</div>
                <div class="feat"><i class="fas fa-shield-alt"></i> Mã hóa SHA-256 bảo mật</div>
            </div>
        </div>

        <!-- Form Side -->
        <div class="auth-form">
            <c:choose>
                <c:when test="${step == 'reset'}">
                    <!-- Step 2: Reset Password -->
                    <div class="steps">
                        <div class="step-dot done"></div>
                        <div class="step-dot active"></div>
                    </div>
                    <h2>Đặt Lại Mật Khẩu</h2>
                    <p class="subtitle">Nhập mật khẩu mới cho tài khoản của bạn</p>

                    <c:if test="${not empty verifiedUser}">
                        <div class="verified-badge"><i class="fas fa-check-circle"></i> Đã xác minh: ${verifiedUser}</div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="error-msg"><i class="fas fa-exclamation-circle"></i> ${error}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/forgot-password" method="post" id="resetForm">
                        <input type="hidden" name="action" value="reset">

                        <div class="form-group">
                            <label for="newPassword">Mật khẩu mới</label>
                            <div class="input-wrapper">
                                <i class="fas fa-lock"></i>
                                <input type="password" id="newPassword" name="newPassword" placeholder="Tối thiểu 6 ký tự" required minlength="6">
                            </div>
                            <div class="pw-strength"><div class="pw-strength-bar" id="pwBar"></div></div>
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword">Xác nhận mật khẩu</label>
                            <div class="input-wrapper">
                                <i class="fas fa-lock"></i>
                                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required minlength="6">
                            </div>
                            <div id="matchMsg" style="font-size:.75rem;margin-top:4px;font-weight:600"></div>
                        </div>

                        <button type="submit" class="btn-submit" id="resetBtn">
                            <i class="fas fa-key"></i> ĐẶT LẠI MẬT KHẨU
                        </button>
                    </form>
                </c:when>

                <c:otherwise>
                    <!-- Step 1: Verify Identity -->
                    <div class="steps">
                        <div class="step-dot active"></div>
                        <div class="step-dot"></div>
                    </div>
                    <h2>Quên Mật Khẩu</h2>
                    <p class="subtitle">Nhập tên đăng nhập và email để xác minh tài khoản 🔐</p>

                    <c:if test="${not empty error}">
                        <div class="error-msg"><i class="fas fa-exclamation-circle"></i> ${error}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                        <input type="hidden" name="action" value="verify">

                        <div class="form-group">
                            <label for="username">Tên đăng nhập</label>
                            <div class="input-wrapper">
                                <i class="fas fa-user"></i>
                                <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập của bạn" required value="${inputUsername}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="email">Email đăng ký</label>
                            <div class="input-wrapper">
                                <i class="fas fa-envelope"></i>
                                <input type="email" id="email" name="email" placeholder="Nhập email đã đăng ký" required value="${inputEmail}">
                            </div>
                        </div>

                        <button type="submit" class="btn-submit">
                            <i class="fas fa-search"></i> XÁC MINH TÀI KHOẢN
                        </button>
                    </form>
                </c:otherwise>
            </c:choose>

            <div class="back-link">
                <a href="${pageContext.request.contextPath}/login"><i class="fas fa-arrow-left" style="margin-right:4px"></i> Quay lại Đăng nhập</a>
            </div>
        </div>
    </div>

    <script>
        // Password strength indicator
        var pwInput = document.getElementById('newPassword');
        var pwBar = document.getElementById('pwBar');
        if (pwInput && pwBar) {
            pwInput.addEventListener('input', function() {
                var val = this.value, score = 0;
                if (val.length >= 6) score++;
                if (val.length >= 8) score++;
                if (/[A-Z]/.test(val)) score++;
                if (/[0-9]/.test(val)) score++;
                if (/[^A-Za-z0-9]/.test(val)) score++;
                var pct = Math.min(score * 20, 100);
                var colors = ['#EF4444','#F97316','#FBBF24','#10B981','#059669'];
                pwBar.style.width = pct + '%';
                pwBar.style.background = colors[Math.min(score, 4)];
            });
        }

        // Confirm password match
        var cfInput = document.getElementById('confirmPassword');
        var matchMsg = document.getElementById('matchMsg');
        if (cfInput && matchMsg) {
            cfInput.addEventListener('input', function() {
                var pw = document.getElementById('newPassword').value;
                if (this.value === '') { matchMsg.textContent = ''; return; }
                if (this.value === pw) {
                    matchMsg.textContent = '✓ Mật khẩu khớp';
                    matchMsg.style.color = '#059669';
                } else {
                    matchMsg.textContent = '✗ Mật khẩu không khớp';
                    matchMsg.style.color = '#DC2626';
                }
            });
        }
    </script>
</body>
</html>
