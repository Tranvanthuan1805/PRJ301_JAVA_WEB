<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lỗi - VietAir</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        
        .error-container {
            background: white;
            padding: 3rem;
            border-radius: 16px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            text-align: center;
            max-width: 500px;
            width: 100%;
        }
        
        .error-icon {
            font-size: 4rem;
            color: #ef4444;
            margin-bottom: 1.5rem;
        }
        
        .error-title {
            font-size: 2rem;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 1rem;
        }
        
        .error-message {
            font-size: 1.1rem;
            color: #6b7280;
            margin-bottom: 2rem;
            line-height: 1.6;
        }
        
        .error-details {
            background: #f3f4f6;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            text-align: left;
        }
        
        .error-details p {
            font-size: 0.9rem;
            color: #374151;
            margin-bottom: 0.5rem;
        }
        
        .error-details strong {
            color: #1f2937;
        }
        
        .btn-home {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 1rem 2rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: transform 0.2s;
        }
        
        .btn-home:hover {
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">
            <i class="fas fa-exclamation-triangle"></i>
        </div>
        <h1 class="error-title">Đã xảy ra lỗi!</h1>
        <p class="error-message">
            Xin lỗi, đã có lỗi xảy ra khi xử lý yêu cầu của bạn.
        </p>
        
        <% 
            Integer statusCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
            String message = (String) request.getAttribute("jakarta.servlet.error.message");
            Exception errorException = (Exception) request.getAttribute("jakarta.servlet.error.exception");
            String requestUri = (String) request.getAttribute("jakarta.servlet.error.request_uri");
            
            if (statusCode != null || message != null || requestUri != null) {
        %>
            <div class="error-details">
                <% if (statusCode != null) { %>
                    <p><strong>Mã lỗi:</strong> <%= statusCode %></p>
                <% } %>
                <% if (message != null && !message.isEmpty()) { %>
                    <p><strong>Thông báo:</strong> <%= message %></p>
                <% } %>
                <% if (requestUri != null) { %>
                    <p><strong>URL:</strong> <%= requestUri %></p>
                <% } %>
                <% if (errorException != null) { %>
                    <p><strong>Chi tiết:</strong> <%= errorException.getMessage() %></p>
                <% } %>
            </div>
        <% } %>
        
        <a href="<%= request.getContextPath() %>/index.jsp" class="btn-home">
            <i class="fas fa-home"></i>
            Về trang chủ
        </a>
    </div>
</body>
</html>
