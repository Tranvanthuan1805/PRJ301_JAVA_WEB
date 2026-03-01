<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đang đăng nhập... | eztravel</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        *{margin:0;padding:0;box-sizing:border-box}
        body{font-family:'Inter',sans-serif;background:#0F172A;color:#fff;display:flex;align-items:center;justify-content:center;min-height:100vh}
        .loading{text-align:center}
        .spinner{width:48px;height:48px;border:3px solid rgba(255,255,255,.1);border-top-color:#3B82F6;border-radius:50%;animation:spin .8s linear infinite;margin:0 auto 20px}
        @keyframes spin{to{transform:rotate(360deg)}}
        .loading h2{font-size:1.2rem;margin-bottom:8px}
        .loading p{color:rgba(255,255,255,.5);font-size:.9rem}
        .error{background:rgba(239,68,68,.15);border:1px solid rgba(239,68,68,.3);padding:16px 24px;border-radius:12px;color:#F87171;margin-top:20px;display:none}
    </style>
</head>
<body>
    <div class="loading">
        <div class="spinner"></div>
        <h2>Đang xử lý đăng nhập...</h2>
        <p>Vui lòng đợi trong giây lát</p>
        <div class="error" id="errorBox"></div>
    </div>

    <script>
    (function() {
        // Supabase returns tokens in the URL hash after Google OAuth
        var hash = window.location.hash.substring(1);
        var params = new URLSearchParams(hash);
        var accessToken = params.get('access_token');

        if (!accessToken) {
            // Also check query params (some flows use query)
            var query = new URLSearchParams(window.location.search);
            accessToken = query.get('access_token');
        }

        if (!accessToken) {
            document.getElementById('errorBox').style.display = 'block';
            document.getElementById('errorBox').innerHTML = '❌ Không tìm thấy token. <a href="${pageContext.request.contextPath}/login.jsp" style="color:#60A5FA">Thử lại</a>';
            return;
        }

        // Send access token to server for verification and session creation
        fetch('${pageContext.request.contextPath}/auth/google-callback?access_token=' + encodeURIComponent(accessToken))
            .then(function(res) { return res.json(); })
            .then(function(data) {
                if (data.success) {
                    window.location.href = data.redirect;
                } else {
                    document.getElementById('errorBox').style.display = 'block';
                    document.getElementById('errorBox').innerHTML = '❌ ' + data.error + ' <a href="${pageContext.request.contextPath}/login.jsp" style="color:#60A5FA">Thử lại</a>';
                }
            })
            .catch(function(err) {
                document.getElementById('errorBox').style.display = 'block';
                document.getElementById('errorBox').innerHTML = '❌ Lỗi kết nối: ' + err.message + ' <a href="${pageContext.request.contextPath}/login.jsp" style="color:#60A5FA">Thử lại</a>';
            });
    })();
    </script>
</body>
</html>
