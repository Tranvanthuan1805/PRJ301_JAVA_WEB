<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Test Provider Access</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                max-width: 900px;
                margin: 50px auto;
                padding: 20px;
                background: #f5f5f5;
            }

            .test-card {
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }

            h1 {
                color: #2563EB;
                margin-bottom: 10px;
            }

            .info-box {
                background: #EFF6FF;
                border-left: 4px solid #2563EB;
                padding: 15px;
                margin: 15px 0;
                border-radius: 5px;
            }

            .success {
                background: #DCFCE7;
                border-left-color: #16A34A;
                color: #166534;
            }

            .test-link {
                display: inline-block;
                background: #2563EB;
                color: white;
                padding: 12px 24px;
                text-decoration: none;
                border-radius: 6px;
                margin: 10px 10px 10px 0;
                transition: all 0.3s;
            }

            .test-link:hover {
                background: #1D4ED8;
                transform: translateY(-2px);
            }

            .code {
                background: #1E293B;
                color: #E2E8F0;
                padding: 15px;
                border-radius: 5px;
                font-family: 'Courier New', monospace;
                overflow-x: auto;
                margin: 10px 0;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin: 15px 0;
            }

            th,
            td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #E5E7EB;
            }

            th {
                background: #F3F4F6;
                font-weight: 600;
                color: #374151;
            }
        </style>
    </head>

    <body>
        <div class="test-card">
            <h1>🧪 Test Provider Access</h1>
            <p>Trang này giúp bạn kiểm tra xem tính năng NCC có hoạt động đúng không</p>

            <div class="info-box success">
                <strong>✅ Trang này đã load thành công!</strong><br>
                Điều này có nghĩa là server đang chạy và JSP engine hoạt động bình thường.
            </div>
        </div>

        <div class="test-card">
            <h2>📊 Thông tin Request</h2>
            <table>
                <tr>
                    <th>Thuộc tính</th>
                    <th>Giá trị</th>
                </tr>
                <tr>
                    <td>Context Path</td>
                    <td><code><%= request.getContextPath() %></code></td>
                </tr>
                <tr>
                    <td>Servlet Path</td>
                    <td><code><%= request.getServletPath() %></code></td>
                </tr>
                <tr>
                    <td>Request URI</td>
                    <td><code><%= request.getRequestURI() %></code></td>
                </tr>
                <tr>
                    <td>Request URL</td>
                    <td><code><%= request.getRequestURL() %></code></td>
                </tr>
                <tr>
                    <td>Server Name</td>
                    <td><code><%= request.getServerName() %></code></td>
                </tr>
                <tr>
                    <td>Server Port</td>
                    <td><code><%= request.getServerPort() %></code></td>
                </tr>
                <tr>
                    <td>Session ID</td>
                    <td><code><%= session.getId() %></code></td>
                </tr>
                <tr>
                    <td>User Logged In</td>
                    <td><code><%= session.getAttribute("user") != null ? "Yes" : "No" %></code></td>
                </tr>
            </table>
        </div>

        <div class="test-card">
            <h2>🔗 Test Links</h2>
            <p>Click vào các link dưới đây để test tính năng NCC:</p>

            <a href="<%= request.getContextPath() %>/admin/providers" class="test-link">
                📋 Danh sách NCC
            </a>

            <a href="<%= request.getContextPath() %>/admin/providers?action=comparison" class="test-link">
                ⚖️ So sánh NCC
            </a>

            <a href="<%= request.getContextPath() %>/admin/providers?type=Hotel" class="test-link">
                🏨 Khách sạn
            </a>

            <a href="<%= request.getContextPath() %>/admin/providers?type=TourOperator" class="test-link">
                🗺️ Công ty Tour
            </a>

            <a href="<%= request.getContextPath() %>/admin/providers?type=Transport" class="test-link">
                🚌 Vận chuyển
            </a>

            <div class="info-box" style="margin-top: 20px;">
                <strong>📝 Kết quả mong đợi:</strong><br>
                - Nếu click vào các link trên mà KHÔNG bị redirect đến trang login → ✅ Thành công!<br>
                - Nếu bị redirect đến login → ❌ Cần kiểm tra lại AuthFilter
            </div>
        </div>

        <div class="test-card">
            <h2>🔍 URL Patterns</h2>
            <p>Các URL pattern được sử dụng:</p>
            <div class="code">
                # Danh sách NCC
                <%= request.getContextPath() %>/admin/providers

                    # Chi tiết NCC (ID = 1)
                    <%= request.getContextPath() %>/admin/providers?action=detail&id=1

                        # So sánh NCC
                        <%= request.getContextPath() %>/admin/providers?action=comparison

                            # Tìm kiếm NCC
                            <%= request.getContextPath() %>/admin/providers?action=search&keyword=vinpearl

                                # Lọc theo loại
                                <%= request.getContextPath() %>/admin/providers?type=Hotel
                                    <%= request.getContextPath() %>/admin/providers?type=TourOperator
                                        <%= request.getContextPath() %>/admin/providers?type=Transport
            </div>
        </div>

        <div class="test-card">
            <h2>🏠 Navigation</h2>
            <a href="<%= request.getContextPath() %>/" class="test-link">← Về Trang Chủ</a>
            <a href="<%= request.getContextPath() %>/login.jsp" class="test-link">🔐 Đăng Nhập</a>
        </div>
    </body>

    </html>