<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chon NCC de so sanh</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); min-height: 100vh; color: #2d3748; }
        .main-wrapper { max-width: 1200px; margin: 0 auto; padding: 40px 20px; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 50px 40px; border-radius: 16px; margin-bottom: 40px; box-shadow: 0 20px 60px rgba(102, 126, 234, 0.3); }
        .header h1 { font-size: 2.5rem; font-weight: 800; margin-bottom: 10px; }
        .header p { opacity: 0.9; font-size: 1.1rem; }
        .counter { display: flex; align-items: center; gap: 10px; font-size: 1.2rem; font-weight: 700; }
        .selection-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 20px; margin-bottom: 40px; }
        .provider-card { background: white; border-radius: 12px; padding: 25px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); cursor: pointer; transition: all 0.3s; border: 3px solid #e2e8f0; }
        .provider-card:hover { transform: translateY(-8px); box-shadow: 0 12px 30px rgba(102,126,234,0.2); }
        .provider-card.selected { border-color: #667eea; background: #f0f4ff; }
        .card-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
        .card-name { font-size: 1.3rem; font-weight: 700; color: #2d3748; }
        .card-icons { display: flex; gap: 8px; }
        .check-icon { display: inline-flex; align-items: center; justify-content: center; width: 30px; height: 30px; background: #667eea; color: white; border-radius: 50%; opacity: 0; transition: opacity 0.3s; }
        .provider-card.selected .check-icon { opacity: 1; }
        .card-type { display: inline-block; background: #e3f2fd; color: #1976d2; padding: 6px 12px; border-radius: 12px; font-size: 0.85rem; font-weight: 600; margin-bottom: 10px; }
        .card-info { display: flex; gap: 20px; color: #7f8c8d; font-size: 0.95rem; }
        .card-info-item { display: flex; align-items: center; gap: 5px; }
        .action-buttons { display: flex; gap: 15px; justify-content: center; padding: 30px 20px; background: white; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); position: sticky; bottom: 20px; }
        .btn { padding: 14px 40px; border: none; border-radius: 8px; font-size: 1.1rem; font-weight: 700; cursor: pointer; transition: all 0.3s; text-decoration: none; display: inline-flex; align-items: center; gap: 10px; }
        .btn-primary { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; }
        .btn-primary:hover:not(:disabled) { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(102,126,234,0.3); }
        .btn-primary:disabled { opacity: 0.5; cursor: not-allowed; }
        .btn-secondary { background: #e2e8f0; color: #2d3748; }
        .btn-secondary:hover { background: #cbd5e0; }
        .selection-message { text-align: center; margin-bottom: 20px; padding: 15px 20px; background: white; border-radius: 8px; border-left: 4px solid #667eea; }
        .empty-state { text-align: center; padding: 60px 40px; background: white; border-radius: 12px; }
        .empty-icon { font-size: 3rem; color: #cbd5e0; margin-bottom: 15px; }
        @media (max-width: 768px) { .selection-grid { grid-template-columns: 1fr; } .action-buttons { flex-direction: column; } .btn { width: 100%; justify-content: center; } }
    </style>
</head>
<body>
    <div class="main-wrapper">
        <div class="header">
            <div style="display: flex; justify-content: space-between; align-items: center; gap: 20px;">
                <div>
                    <h1><i class="fas fa-hand-pointer"></i> Chon nha cung cap de so sanh</h1>
                    <p>Hay chon tu 2 den 5 nha cung cap de xem so sanh chi tiet</p>
                </div>
                <div class="counter" style="background: rgba(255,255,255,0.2); padding: 15px 25px; border-radius: 12px;"><span id="selectedCount">0</span><span>/ 5 thue</span></div>
            </div>
        </div>

        <div class="selection-message">
            <i class="fas fa-info-circle"></i> <span id="messageText">Hay chon toi thieu 2 nha cung cap</span>
        </div>

        <c:choose>
            <c:when test="${empty providers}">
                <div class="empty-state"><div class="empty-icon"><i class="fas fa-building"></i></div><h3 style="color: #7f8c8d;">Khong co nha cung cap</h3></div>
            </c:when>
            <c:otherwise>
                <form id="comparisonForm" method="get" action="${pageContext.request.contextPath}/admin/providers">
                    <input type="hidden" name="action" value="comparison">
                    <div class="selection-grid">
                        <c:forEach items="${providers}" var="provider">
                            <div class="provider-card" onclick="toggleProvider(this, ${provider.providerId}, event)">
                                <input type="hidden" class="provider-id" value="${provider.providerId}">
                                <div class="card-header">
                                    <div class="card-name">${provider.businessName}</div>
                                    <div class="card-icons">
                                        <c:if test="${provider.verified}"><i class="fas fa-check-circle" style="color: #27ae60; font-size: 1.3rem;"></i></c:if>
                                        <div class="check-icon"><i class="fas fa-check"></i></div>
                                    </div>
                                </div>
                                <span class="card-type">${provider.providerType}</span>
                                <div class="card-info">
                                    <div class="card-info-item"><i class="fas fa-star"></i> <fmt:formatNumber xmlns:fmt="http://java.sun.com/jsp/jstl/fmt" value="${provider.rating}" pattern="#.#" /></div>
                                    <div class="card-info-item"><i class="fas fa-plane"></i> ${provider.totalTours}</div>
                                    <div class="card-info-item"><i class="fas fa-${provider.active ? 'check' : 'times'}"></i> ${provider.active ? 'Hoat dong' : 'Tam ngung'}</div>
                                </div>
                                <input type="checkbox" class="provider-checkbox" name="providers" value="${provider.providerId}" style="display: none;">
                            </div>
                        </c:forEach>
                    </div>
                    <div class="action-buttons">
                        <button type="reset" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/providers'"><i class="fas fa-arrow-left"></i> Quay lai</button>
                        <button type="submit" class="btn btn-primary" id="compareBtn" disabled><i class="fas fa-columns"></i> So sanh</button>
                    </div>
                </form>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        function toggleProvider(card, providerId, event) {
            if (event.target.type === 'checkbox') return;
            const checkbox = card.querySelector('.provider-checkbox');
            const selected = document.querySelectorAll('.provider-card.selected');
            if (!card.classList.contains('selected') && selected.length >= 5) {
                alert('Toi da 5 nha cung cap!');
                return;
            }
            card.classList.toggle('selected');
            checkbox.checked = !checkbox.checked;
            updateCount();
        }
        function updateCount() {
            const selected = document.querySelectorAll('.provider-checkbox:checked').length;
            document.getElementById('selectedCount').textContent = selected;
            const btn = document.getElementById('compareBtn');
            if (selected >= 2 && selected <= 5) {
                btn.disabled = false;
                document.getElementById('messageText').innerHTML = '<i class="fas fa-check-circle" style="color: #27ae60;"></i> San sang so sanh! Click nut "So sanh"';
            } else if (selected > 0) {
                document.getElementById('messageText').innerHTML = '<i class="fas fa-info-circle"></i> Can them ' + (2 - selected) + ' nha cung cap nua';
            } else {
                btn.disabled = true;
                document.getElementById('messageText').innerHTML = '<i class="fas fa-info-circle"></i> Hay chon toi thieu 2 nha cung cap';
            }
        }
    </script>
</body>
</html>
