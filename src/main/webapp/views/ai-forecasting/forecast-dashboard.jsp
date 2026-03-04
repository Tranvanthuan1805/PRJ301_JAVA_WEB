<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>AI Demand Forecast | Da Nang Travel Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="dashboard-wrapper">
        <jsp:include page="/common/_sidebar.jsp" />

        <main class="main-content">
            <header style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 40px;">
                <div>
                    <div style="background: var(--accent); color: white; display: inline-block; padding: 2px 10px; border-radius: 4px; font-size: 0.7rem; font-weight: 800; margin-bottom: 10px;">PRO FEATURE</div>
                    <h1 style="color: var(--primary);">AI Demand Forecasting</h1>
                    <p style="color: var(--text-muted);">Predictive insights powered by LPU™ processing for the 2026 travel season.</p>
                </div>
                <div style="display: flex; gap: 10px;">
                    <button class="btn" onclick="window.print()" style="background: white; border: 1px solid #ddd;"><i class="fas fa-file-pdf"></i> Export Forecast</button>
                    <button class="btn btn-primary"><i class="fas fa-sync"></i> Refresh Model</button>
                </div>
            </header>

            <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 30px;">
                <!-- Main Chart -->
                <section>
                    <div class="card" style="padding: 30px;">
                        <h3 style="margin-bottom: 25px;">Revenue Projections (12 Months)</h3>
                        <canvas id="revenueForecastChart" height="150"></canvas>
                    </div>

                    <div style="margin-top: 30px; display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">
                        <div class="card" style="border-left: 4px solid var(--success);">
                            <h4><i class="fas fa-arrow-up" style="color: var(--success);"></i> High Growth Segments</h4>
                            <p style="font-size: 0.9rem; margin-top: 10px; color: #666;">
                                <strong>Son Tra Snorkeling</strong> is predicted to grow by <span style="color: var(--success); font-weight: 700;">+42%</span> in Jul-Aug due to clearer water forecasts.
                            </p>
                        </div>
                        <div class="card" style="border-left: 4px solid #f6ad55;">
                            <h4><i class="fas fa-exclamation-triangle" style="color: #f6ad55;"></i> Resource Warning</h4>
                            <p style="font-size: 0.9rem; margin-top: 10px; color: #666;">
                                Transport capacity may reach <span style="color: #e53e3e; font-weight: 700;">Critical Levels</span> (98%) during the Da Nang Fireworks Festival (June).
                            </p>
                        </div>
                    </div>
                </section>

                <!-- Recommendations Sidebar -->
                <aside>
                    <div class="card" style="background: var(--primary); color: white; margin-bottom: 30px;">
                        <h3 style="margin-bottom: 15px;"><i class="fas fa-lightbulb" style="color: #f1c40f;"></i> AI Actions</h3>
                        <p style="font-size: 0.9rem; opacity: 0.9; line-height: 1.6;">
                            The engine recommends adjusting your <strong>Heritage Tour</strong> prices by <span style="font-weight: 700;">+15%</span> starting May 20th to capture early bird high-season demand.
                        </p>
                        <button class="btn" style="width: 100%; margin-top: 25px; background: rgba(255,255,255,0.1); color: white; border: 1px solid rgba(255,255,255,0.3);">Apply Pricing Suggestions</button>
                    </div>

                    <div class="card">
                        <h4 style="margin-bottom: 15px;">Seasonal Probability</h4>
                        <div style="margin-bottom: 20px;">
                            <div style="display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 8px;">
                                <span>Dry Season (Peak)</span>
                                <strong>85% Confidence</strong>
                            </div>
                            <div style="height: 6px; background: #eee; border-radius: 3px;">
                                <div style="width: 85%; height: 100%; background: var(--success); border-radius: 3px;"></div>
                            </div>
                        </div>
                        <div>
                            <div style="display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 8px;">
                                <span>Monsoon Risk</span>
                                <strong>12% Confidence</strong>
                            </div>
                            <div style="height: 6px; background: #eee; border-radius: 3px;">
                                <div style="width: 12%; height: 100%; background: #e53e3e; border-radius: 3px;"></div>
                            </div>
                        </div>
                    </div>
                </aside>
            </div>
        </main>
    </div>

    <script>
        const ctx = document.getElementById('revenueForecastChart').getContext('2d');
        const forecastData = [
            <c:forEach items="${forecastData}" var="d" varStatus="loop">
                <c:out value="${d.revenue}"/><c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];
        const labels = [
            <c:forEach items="${forecastData}" var="d" varStatus="loop">
                '<c:out value="${d.month}"/>'<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];

        new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Predicted Monthly Revenue ($)',
                    data: forecastData,
                    borderColor: '#0A2351',
                    backgroundColor: 'rgba(10, 35, 81, 0.05)',
                    borderWidth: 3,
                    fill: true,
                    tension: 0.4,
                    pointRadius: 4,
                    pointBackgroundColor: '#FF6B6B'
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: { 
                        beginAtZero: true,
                        grid: { color: '#f0f0f0' }
                    },
                    x: { grid: { display: false } }
                }
            }
        });
    </script>
</body>
</html>
