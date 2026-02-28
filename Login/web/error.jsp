<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lỗi - VietAir</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
        }
        .error-container {
            text-align: center;
            padding: 40px;
            background: rgba(255,255,255,0.1);
            border-radius: 20px;
            backdrop-filter: blur(10px);
        }
        .error-code { font-size: 80px; font-weight: 700; }
        .error-msg { font-size: 20px; margin: 15px 0; opacity: 0.9; }
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 30px;
            background: #fff;
            color: #764ba2;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 600;
            transition: transform 0.2s;
        }
        .back-btn:hover { transform: scale(1.05); }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-code">
            <%= response.getStatus() %>
        </div>
        <div class="error-msg">Trang bạn tìm kiếm không tồn tại hoặc đã bị lỗi</div>
        <a href="index.jsp" class="back-btn">← Về trang chủ</a>
    </div>
</body>
</html>
