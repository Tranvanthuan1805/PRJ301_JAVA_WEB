<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiet NCC - ${provider.businessName}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); min-height: 100vh; color: #2d3748; }
        .main-wrapper { max-width: 1200px; margin: 0 auto; padding: 40px 20px; }
        .back-link { display: inline-flex; align-items: center; gap: 8px; color: #667eea; text-decoration: none; font-weight: 600; margin-bottom: 30px; transition: all 0.3s; }
        .back-link:hover { gap: 12px; }
        .provider-header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 50px 40px; border-radius: 16px; margin-bottom: 40px; position: relative; overflow: hidden; box-shadow: 0 20px 60px rgba(102, 126, 234, 0.3); }
        .provider-header::before { content: ''; position: absolute; top: -200px; right: -200px; width: 500px; height: 500px; background: rgba(255,255,255,0.08); border-radius: 50%; }
        .header-content { position: relative; z-index: 1; display: flex; justify-content: space-between; align-items: flex-start; gap: 30px; }
        .header-info h1 { font-size: 3rem; font-weight: 800; margin-bottom: 10px; }
        .header-badges { display: flex; gap: 12px; flex-wrap: wrap; margin-top: 15px; }
        .header-badges span { background: rgba(255,255,255,0.2); padding: 8px 16px; border-radius: 20px; font-size: 0.95rem; font-weight: 600; }
        .rating-display { text-align: right; }
        .rating-number { font-size: 3.5rem; font-weight: 800; display: flex; align-items: center; gap: 10px; }
        .rating-number i { color: #fbbf24; }
        .stats-row { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 40px; }
        .stat-box { background: white; border-radius: 12px; padding: 25px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); }
        .stat-box h3 { color: #718096; font-size: 0.9rem; font-weight: 600; text-transform: uppercase; margin-bottom: 10px; }
        .stat-box .value { font-size: 2.5rem; font-weight: 800; color: #2d3748; }
        .card { background: white; border-radius: 12px; padding: 30px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); margin-bottom: 30px; }
        .card h2 { font-size: 1.5rem; font-weight: 700; color: #2d3748; margin-bottom: 25px; display: flex; align-items: center; gap: 10px; }
        .card h2 i { color: #667eea; }
        .price-history-table { width: 100%; border-collapse: collapse; }
        .price-history-table th { background: #f7fafc; padding: 15px; text-align: left; font-weight: 600; color: #495057; border-bottom: 2px solid #e2e8f0; }
        .price-history-table td { padding: 15px; border-bottom: 1px solid #e2e8f0; }
        .price-history-table tr:hover { background: #f9fafb; }
        .price-up { color: #e74c3c; font-weight: 600; }
        .price-down { color: #27ae60; font-weight: 600; }
        .chart-container { position: relative; height: 300px; margin: 20px 0; }
        .empty-state { text-align: center; padding: 60px 20px; }
        .empty-icon { font-size: 3rem; color: #cbd5e0; margin-bottom: 15px; }
        @media (max-width: 768px) { .header-content { flex-direction: column; } .rating-display { text-align: left; margin-top: 20px; } }
    </style>
</head>
<body>
    <div class="main-wrapper">
        <a href="${pageContext.request.contextPath}/admin/providers" class="back-link"><i class="fas fa-arrow-left"></i> Quay lai danh sach</a>
        
        <div class="provider-header">
            <div class="header-content">
                <div class="header-info">
                    <h1>${provider.businessName} <c:if test="${provider.verified}"><i class="fas fa-check-circle" style="font-size: 2rem;"></i></c:if></h1>
                    <p style="opacity: 0.9; font-size: 1.1rem;"><i class="fas fa-tag"></i> ${provider.providerType} | <i class="fas fa-id-card"></i> ID: #${provider.providerId}</p>
                    <div class="header-badges">
                        <span><i class="fas fa-check-circle"></i> <c:choose><c:when test="${provider.verified}"> Xac minh</c:when><c:otherwise>Cho duyet</c:otherwise></c:choose></span>
                        <span><i class="fas fa-${provider.active ? 'play-circle' : 'pause-circle'}"></i> ${provider.active ? 'Hoat dong' : 'Tam ngung'}</span>
                    </div>
                </div>
                <div class="rating-display">
                    <div class="rating-number"><fmt:formatNumber value="${provider.rating}" pattern="#.#" /> <i class="fas fa-star"></i></div>
                    <p style="opacity: 0.9; margin-top: 5px;">Danh gia</p>
                </div>
            </div>
        </div>

        <div class="stats-row">
            <div class="stat-box">
                <h3><i class="fas fa-plane"></i> Tong tours</h3>
                <div class="value">${provider.totalTours}</div>
            </div>
            <div class="stat-box">
                <h3><i class="fas fa-clock"></i> Trang thai</h3>
                <div class="value" style="font-size: 1.5rem; color: ${provider.active ? '#27ae60' : '#e74c3c'};">${provider.active ? 'Hoat dong' : 'Tam ngung'}</div>
            </div>
            <div class="stat-box">
                <h3><i class="fas fa-shield-alt"></i> Xac minh</h3>
                <div class="value" style="font-size: 1.5rem; color: ${provider.verified ? '#27ae60' : '#f39c12'};">${provider.verified ? 'Da xac minh' : 'Cho duyet'}</div>
            </div>
        </div>

        <div class="card">
            <h2><i class="fas fa-chart-line"></i> Lich su gia dich vu</h2>
            <c:choose>
                <c:when test="${empty priceHistory}">
                    <div class="empty-state"><div class="empty-icon"><i class="fas fa-chart-line"></i></div><h3 style="color: #7f8c8d;">Chua co lich su gia</h3></div>
                </c:when>
                <c:otherwise>
                    <div class="chart-container"><canvas id="priceChart"></canvas></div>
                    <div style="margin-top: 30px; overflow-x: auto;">
                        <table class="price-history-table">
                            <thead>
                                <tr>
                                    <th>Dich vu</th>
                                    <th>Loai</th>
                                    <th>Gia cu</th>
                                    <th>Gia moi</th>
                                    <th>Thay doi</th>
                                    <th>Ngay cap nhat</th>
                                    <th>Ghi chu</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${priceHistory}" var="ph">
                                    <tr>
                                        <td><strong>${ph.serviceName}</strong></td>
                                        <td><span style="background: #e3f2fd; color: #1976d2; padding: 4px 10px; border-radius: 12px; font-weight: 600;">${ph.serviceType}</span></td>
                                        <td><c:if test="${ph.oldPrice != null}"><fmt:formatNumber value="${ph.oldPrice}" pattern="#,###" /> VND</c:if></td>
                                        <td><strong><fmt:formatNumber value="${ph.newPrice}" pattern="#,###" /> VND</strong></td>
                                        <td><c:if test="${ph.oldPrice != null}"><c:set var="change" value="${ph.priceChangePercent}" /><span class="${change >= 0 ? 'price-up' : 'price-down'}"><i class="fas fa-arrow-${change >= 0 ? 'up' : 'down'}"></i> <fmt:formatNumber value="${change}" pattern="#.##" />%</span></c:if></td>
                                        <td><fmt:formatDate value="${ph.changeDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                        <td style="color: #7f8c8d;">${ph.note != null ? ph.note : '-'}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <script>
        <c:if test="${not empty priceHistory}">
        const ctx = document.getElementById('priceChart').getContext('2d');
        new Chart(ctx, { type: 'line', data: { labels: [<c:forEach items="${priceHistory}" var="ph" varStatus="s">'<fmt:formatDate value="${ph.changeDate}" pattern="dd/MM" />'${!s.last ? ',' : ''}</c:forEach>], datasets: [{ label: 'Gia dich vu (VND)', data: [<c:forEach items="${priceHistory}" var="ph" varStatus="s">${ph.newPrice}${!s.last ? ',' : ''}</c:forEach>], borderColor: '#667eea', backgroundColor: 'rgba(102, 126, 234, 0.1)', tension: 0.4, fill: true }] }, options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: true, position: 'top' } }, scales: { y: { ticks: { callback: v => v.toLocaleString() + ' VND' } } } } });
        </c:if>
    </script>
</body>
</html>
