<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Management | Da Nang Travel Hub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>
    <div class="dashboard-wrapper">
        <jsp:include page="/common/_sidebar.jsp" />

        <main class="main-content">
            <header style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px;">
                <div>
                    <h1 style="color: var(--primary);">Customer Insights</h1>
                    <p style="color: var(--text-muted);">Monitor user engagement and lifetime value.</p>
                </div>
                <div style="display: flex; gap: 15px;">
                    <button class="btn" style="background: white; border: 1px solid #ddd;"><i class="fas fa-file-export"></i> Export CRM</button>
                </div>
            </header>

            <!-- Customer Table -->
            <section class="card animate-up">
                <table style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr style="text-align: left; border-bottom: 2px solid #eee;">
                            <th style="padding: 15px;">Customer</th>
                            <th style="padding: 15px;">Contact</th>
                            <th style="padding: 15px;">Total Orders</th>
                            <th style="padding: 15px;">Lifetime Spend</th>
                            <th style="padding: 15px;">Status</th>
                            <th style="padding: 15px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${customers}" var="c">
                            <tr style="border-bottom: 1px solid #f9f9f9;">
                                <td style="padding: 15px;">
                                    <div style="display: flex; align-items: center; gap: 12px;">
                                        <img src="${not empty c.avatarUrl ? c.avatarUrl : 'https://ui-avatars.com/api/?name=' + c.fullName}" style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover;">
                                        <div>
                                            <div style="font-weight: 700;">${c.fullName}</div>
                                            <small style="color: var(--text-muted);">Joined <fmt:formatDate value="${c.createdAt}" pattern="MMM yyyy"/></small>
                                        </div>
                                    </div>
                                </td>
                                <td style="padding: 15px;">
                                    <div style="font-size: 0.9rem;">${c.email}</div>
                                    <div style="font-size: 0.8rem; color: var(--text-muted);">${c.phoneNumber}</div>
                                </td>
                                <td style="padding: 15px; text-align: center;">
                                    <span style="font-weight: 700; background: #f1f2f6; padding: 4px 12px; border-radius: 20px;">${c.totalOrders}</span>
                                </td>
                                <td style="padding: 15px; font-weight: 700; color: var(--success);">
                                    $<fmt:formatNumber value="${c.totalSpent}" pattern="#,###.00"/>
                                </td>
                                <td style="padding: 15px;">
                                    <span style="background: ${c.active ? '#ecfdf5' : '#fff5f5'}; color: ${c.active ? '#059669' : '#fa5252'}; padding: 4px 10px; border-radius: 20px; font-size: 0.8rem;">
                                        ${c.active ? 'Active' : 'Banned'}
                                    </span>
                                </td>
                                <td style="padding: 15px;">
                                    <a href="${pageContext.request.contextPath}/admin/customers?action=view&id=${c.userId}" class="btn" style="padding: 6px 15px; font-size: 0.8rem; border: 1px solid var(--primary); color: var(--primary);">View Profile</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </section>
        </main>
    </div>
</body>
</html>
