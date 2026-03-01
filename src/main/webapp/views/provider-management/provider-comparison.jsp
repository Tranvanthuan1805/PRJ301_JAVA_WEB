<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>So sanh NCC</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); min-height: 100vh; color: #2d3748; }
        .main-wrapper { max-width: 1400px; margin: 0 auto; padding: 40px 20px; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 50px 40px; border-radius: 16px; margin-bottom: 40px; box-shadow: 0 20px 60px rgba(102, 126, 234, 0.3); }
        .header h1 { font-size: 2.5rem; font-weight: 800; margin-bottom: 10px; }
        .header p { opacity: 0.9; font-size: 1.1rem; }
        .back-link { display: inline-flex; align-items: center; gap: 8px; color: #667eea; text-decoration: none; font-weight: 600; margin-bottom: 20px; transition: all 0.3s; }
        .back-link:hover { gap: 12px; }
        .comparison-container { background: white; border-radius: 12px; overflow: auto; box-shadow: 0 4px 15px rgba(0,0,0,0.08); }
        .comparison-table { width: 100%; border-collapse: collapse; min-width: 1000px; }
        .comparison-table th { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 25px 15px; text-align: center; font-weight: 700; border-bottom: 3px solid #667eea; }
        .comparison-table th:first-child { text-align: left; background: #f7fafc; color: #2d3748; }
        .comparison-table td { padding: 20px 15px; border-bottom: 1px solid #e2e8f0; text-align: center; }
        .comparison-table tr:hover { background: #f9fafb; }
        .comparison-table td:first-child { text-align: left; font-weight: 600; color: #495057; background: #f7fafc; }
        .provider-name { font-size: 1.3rem; font-weight: 800; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }
        .provider-type { font-size: 0.85rem; color: #7f8c8d; font-weight: 600; text-transform: uppercase; margin-top: 5px; }
        .status-badge { display: inline-flex; align-items: center; gap: 6px; padding: 6px 12px; border-radius: 12px; font-size: 0.85rem; font-weight: 600; }
        .verified { background: #d4edda; color: #155724; }
        .unverified { background: #fff3cd; color: #856404; }
        .active { background: #d1ecf1; color: #0c5460; }
        .inactive { background: #f8d7da; color: #721c24; }
        .rating-badge { background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%); color: white; padding: 10px 15px; border-radius: 8px; font-weight: 700; font-size: 1.1rem; }
        .action-link { color: #667eea; text-decoration: none; font-weight: 600; transition: all 0.3s; }
        .action-link:hover { color: #764ba2; }
        .empty-state { text-align: center; padding: 60px 40px; background: white; border-radius: 12px; }
        .empty-icon { font-size: 3rem; color: #cbd5e0; margin-bottom: 15px; }
        @media (max-width: 768px) { .comparison-table { font-size: 0.9rem; } .comparison-table th, .comparison-table td { padding: 15px 10px; } }
    </style>
</head>
<body>
    <div class="main-wrapper">
        <a href="${pageContext.request.contextPath}/admin/providers" class="back-link"><i class="fas fa-arrow-left"></i> Quay lai danh sach</a>
        
        <div class="header"><h1><i class="fas fa-columns"></i> So sanh nha cung cap</h1><p>Xem chi tiet so sanh giua cac nha cung cap</p></div>
        
        <c:choose>
            <c:when test="${empty providers}">
                <div class="empty-state"><div class="empty-icon"><i class="fas fa-inbox"></i></div><h3 style="color: #7f8c8d;">Khong co du lieu de hien thi</h3></div>
            </c:when>
            <c:otherwise>
                <div class="comparison-container">
                    <table class="comparison-table">
                        <thead>
                            <tr>
                                <th>Thong tin</th>
                                <c:forEach items="${providers}" var="provider">
                                    <th><div class="provider-name">${provider.businessName}</div><div class="provider-type">${provider.providerType}</div></th>
                                </c:forEach>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><i class="fas fa-id-card"></i> ID NCC</td>
                                <c:forEach items="${providers}" var="provider">
                                    <td>#${provider.providerId}</td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <td><i class="fas fa-tag"></i> Loai</td>
                                <c:forEach items="${providers}" var="provider">
                                    <td><span style="background: #e3f2fd; color: #1976d2; padding: 6px 12px; border-radius: 12px; font-weight: 600;">${provider.providerType}</span></td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <td><i class="fas fa-plane"></i> Tong tours</td>
                                <c:forEach items="${providers}" var="provider">
                                    <td><strong>${provider.totalTours}</strong></td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <td><i class="fas fa-shield-alt"></i> Xac minh</td>
                                <c:forEach items="${providers}" var="provider">
                                    <td><span class="status-badge ${provider.verified ? 'verified' : 'unverified'}"><i class="fas fa-${provider.verified ? 'check' : 'times'}-circle"></i> ${provider.verified ? 'Da xac minh' : 'Cho duyet'}</span></td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <td><i class="fas fa-power-off"></i> Trang thai</td>
                                <c:forEach items="${providers}" var="provider">
                                    <td><span class="status-badge ${provider.active ? 'active' : 'inactive'}"><i class="fas fa-${provider.active ? 'play' : 'pause'}-circle"></i> ${provider.active ? 'Hoat dong' : 'Tam ngung'}</span></td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <td><i class="fas fa-star"></i> Danh gia</td>
                                <c:forEach items="${providers}" var="provider">
                                    <td><span class="rating-badge"><fmt:formatNumber value="${provider.rating}" pattern="#.#" /> ★</span></td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <td><i class="fas fa-dollar-sign"></i> Gia trung binh</td>
                                <c:forEach items="${providers}" var="provider">
                                    <td><strong><fmt:formatNumber value="${provider.averagePrice}" pattern="#,###" /> VND</strong></td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <td><i class="fas fa-phone"></i> Lien he</td>
                                <c:forEach items="${providers}" var="provider">
                                    <td><c:if test="${not empty provider.phone}">${provider.phone}</c:if><c:if test="${empty provider.phone}">-</c:if></td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <td><i class="fas fa-envelope"></i> Email</td>
                                <c:forEach items="${providers}" var="provider">
                                    <td><c:if test="${not empty provider.email}" style="word-break: break-all;">${provider.email}</c:if><c:if test="${empty provider.email}">-</c:if></td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <td style="background: white;"><i class="fas fa-external-link-alt"></i> Chi tiet</td>
                                <c:forEach items="${providers}" var="provider">
                                    <td style="background: white;"><a href="${pageContext.request.contextPath}/admin/providers?action=detail&id=${provider.providerId}" class="action-link"><i class="fas fa-arrow-right"></i> Chi tiet</a></td>
                                </c:forEach>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
