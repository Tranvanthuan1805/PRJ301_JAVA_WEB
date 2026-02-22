<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>AI Forecasting - VietAir</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/vietair-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .forecast-container { padding: 2rem; max-width: 1200px; margin: 0 auto; }
        .dashboard-grid { display: grid; grid-template-columns: 2fr 1fr; gap: 2rem; margin-top: 2rem; }
        .chart-card, .ai-card { background: white; padding: 2rem; border-radius: 16px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        .ai-result { margin-top: 1.5rem; line-height: 1.8; color: #4a5568; font-size: 15px; border-left: 4px solid #2c5aa0; padding-left: 1.5rem; }
        .btn-analyze { background: linear-gradient(135deg, #2c5aa0, #1e4070); color: white; border: none; padding: 12px 24px; border-radius: 8px; cursor: pointer; font-weight: 600; transition: transform 0.2s; }
        .btn-analyze:hover { transform: translateY(-2px); }
        .loader { display: none; margin-left: 10px; }
    </style>
</head>
<body>
    <header class="header">
        <div class="container">
            <div class="nav-brand">
                <div class="logo-container">
                    <i class="fas fa-plane-departure logo-icon"></i>
                    <span class="logo-text">VietAir AI</span>
                </div>
            </div>
            <nav class="nav-menu">
                <a href="<%= request.getContextPath() %>/" class="nav-item">Trang chủ</a>
                <a href="<%= request.getContextPath() %>/admin/forecast" class="nav-item active">AI Forecasting</a>
            </nav>
        </div>
    </header>

    <div class="forecast-container">
        <h1><i class="fas fa-chart-line"></i> AI Trend Forecasting Analytics</h1>
        <p>Hệ thống sử dụng mạng nơ-ron từ OpenRouter AI để phân tích dữ liệu du lịch Đà Nẵng 2020-2025.</p>

        <div class="dashboard-grid">
            <div class="chart-card">
                <h3>Thống kê doanh thu theo năm</h3>
                <canvas id="revenueChart"></canvas>
            </div>

            <div class="ai-card">
                <h3>Phân tích & Dự báo AI 2026</h3>
                <button class="btn-analyze" onclick="runAIAnalysis()">
                    <i class="fas fa-brain"></i> Chạy phân tích AI
                </button>
                <div id="loader" class="loader"><i class="fas fa-spinner fa-spin"></i> Đang tính toán...</div>
                
                <div id="aiResult" class="ai-result">
                    Hãy nhấn nút trên để AI bắt đầu phân tích dữ liệu lịch sử và đưa ra dự báo cho năm 2026.
                </div>
            </div>
        </div>
    </div>

    <script>
        // Data from Servlet
        const historicalData = [
            <c:forEach var="yearData" items="${summaryData.split('\n')}">
                <c:if test="${yearData.contains(':')}">
                    { year: '<c:out value="${yearData.split(':')[0]}"/>', revenue: <c:out value="${yearData.split(':')[1].trim()}"/> },
                </c:if>
            </c:forEach>
        ];

        // Render Chart
        const ctx = document.getElementById('revenueChart').getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: historicalData.map(d => d.year),
                datasets: [{
                    label: 'Doanh thu (Triệu VNĐ)',
                    data: historicalData.map(d => d.revenue),
                    borderColor: '#2c5aa0',
                    backgroundColor: 'rgba(44, 90, 160, 0.1)',
                    borderWidth: 3,
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'top' } },
                scales: { y: { beginAtZero: true } }
            }
        });

        async function runAIAnalysis() {
            const btn = document.querySelector('.btn-analyze');
            const loader = document.getElementById('loader');
            const resultDiv = document.getElementById('aiResult');
            
            btn.disabled = true;
            loader.style.display = 'inline-block';
            resultDiv.innerHTML = "Đang kết nối với hệ thống nơ-ron AI...";

            try {
                const response = await fetch('<%= request.getContextPath() %>/admin/forecast?action=analyze', {
                    method: 'POST'
                });
                const data = await response.json();
                
                if (data.analysis) {
                    resultDiv.innerHTML = data.analysis.replace(/\n/g, '<br>');
                } else {
                    resultDiv.innerHTML = "Có lỗi xảy ra: " + (data.error || "Không rõ nguyên nhân");
                }
            } catch (error) {
                resultDiv.innerHTML = "Lỗi kết nối API.";
            } finally {
                btn.disabled = false;
                loader.style.display = 'none';
            }
        }
    </script>

    <!-- Chatbot include -->
    <jsp:include page="/views/ai-chatbot/chatbot.jsp" />
</body>
</html>
