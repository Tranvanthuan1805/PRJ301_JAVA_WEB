<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Management | Da Nang Travel Hub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .status-badge { padding: 4px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; }
        .status-completed { background: #e6fffa; color: #319795; }
        .status-pending { background: #fffaf0; color: #dd6b20; }
        .status-cancelled { background: #fff5f5; color: #e53e3e; }
        .status-default { background: #f7fafc; color: #4a5568; }
    </style>
</head>
<body>
    <div class="dashboard-wrapper">
        <jsp:include page="/common/_sidebar.jsp" />

        <main class="main-content">
            <header style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px;">
                <div>
                    <h1 style="color: var(--primary);">Transaction Registry</h1>
                    <p style="color: var(--text-muted);">Monitor all incoming bookings and financial flow.</p>
                </div>
            </header>

            <section class="card animate-up">
                <table style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr style="text-align: left; border-bottom: 2px solid #eee;">
                            <th style="padding: 15px;">Order ID</th>
                            <th style="padding: 15px;">Customer</th>
                            <th style="padding: 15px;">Date</th>
                            <th style="padding: 15px;">Amount</th>
                            <th style="padding: 15px;">Status</th>
                            <th style="padding: 15px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orders}" var="o">
                            <tr style="border-bottom: 1px solid #f9f9f9;">
                                <td style="padding: 15px; font-weight: 700;">#${o.orderId}</td>
                                <td style="padding: 15px;">${o.customerName}</td>
                                <td style="padding: 15px; color: var(--text-muted);">
                                    <fmt:formatDate value="${o.orderDate}" pattern="dd MMM yyyy HH:mm"/>
                                </td>
                                <td style="padding: 15px; font-weight: 700; color: var(--primary);">
                                    $<fmt:formatNumber value="${o.totalAmount}" pattern="#,###.00"/>
                                </td>
                                <td style="padding: 15px;">
                                    <c:set var="statusType" value="default"/>
                                    <c:choose>
                                        <c:when test="${o.orderStatus == 'Completed'}"><c:set var="statusType" value="completed"/></c:when>
                                        <c:when test="${o.orderStatus == 'Pending'}"><c:set var="statusType" value="pending"/></c:when>
                                        <c:when test="${o.orderStatus == 'Cancelled'}"><c:set var="statusType" value="cancelled"/></c:when>
                                    </c:choose>
                                    <span class="status-badge status-${statusType}">
                                        ${o.orderStatus}
                                    </span>
                                </td>
                                <td style="padding: 15px;">
                                    <a href="${pageContext.request.contextPath}/admin/orders?action=view&id=${o.orderId}" class="btn" style="padding: 6px 15px; font-size: 0.8rem; border: 1px solid var(--primary); color: var(--primary);">Details</a>
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
