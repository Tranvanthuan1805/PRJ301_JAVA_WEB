<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lỗi - ezTravel</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 50px; background: #f5f5f5; }
        .error-container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #dc3545; }
        .error-message { background: #f8d7da; color: #721c24; padding: 15px; border-radius: 5px; margin: 20px 0; }
        .back-link { display: inline-block; margin-top: 20px; padding: 10px 20px; background: #007bff; color: white; text-decoration: none; border-radius: 5px; }
        .back-link:hover { background: #0056b3; }
        pre { background: #f8f9fa; padding: 15px; border-radius: 5px; overflow-x: auto; }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>⚠️ Đã xảy ra lỗi</h1>
        
        <div class="error-message">
            <strong>Thông báo lỗi:</strong><br>
            <%= request.getAttribute("error") != null ? request.getAttribute("error") : "Đã xảy ra lỗi không xác định" %>
        </div>
        
        <% if (exception != null) { %>
            <h3>Chi tiết lỗi:</h3>
            <pre><%= exception.getMessage() %></pre>
            
            <h3>Stack Trace:</h3>
            <pre>
<% 
    java.io.StringWriter sw = new java.io.StringWriter();
    java.io.PrintWriter pw = new java.io.PrintWriter(sw);
    exception.printStackTrace(pw);
    out.println(sw.toString());
%>
            </pre>
        <% } %>
        
        <a href="${pageContext.request.contextPath}/" class="back-link">← Quay về trang chủ</a>
    </div>
</body>
</html>
