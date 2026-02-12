<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Billing History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .status-active { color: #198754; font-weight: bold; }
        .status-expired { color: #dc3545; }
    </style>
</head>
<body class="bg-light">

<div class="container py-5">
    <div class="text-center mb-5">
        <h1 class="fw-bold">Billing History</h1>
        <p class="text-muted">View your subscription history</p>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <c:choose>
                <c:when test="${empty history}">
                    <div class="text-center py-5">
                        <p class="text-muted">No subscription history found.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Plan</th>
                                    <th>Amount</th>
                                    <th>Start Date</th>
                                    <th>End Date</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${history}" var="sub">
                                    <tr>
                                        <td><strong>${sub.plan.planName}</strong></td>
                                        <td>
                                            <c:if test="${sub.amount == 0}">Free</c:if>
                                            <c:if test="${sub.amount > 0}">${sub.amount} VND</c:if>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${sub.startDate}" pattern="dd/MM/yyyy HH:mm" />
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${sub.endDate}" pattern="dd/MM/yyyy HH:mm" />
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${sub.status == 'Active' && sub.endDate.time > now.time}">
                                                    <span class="status-active">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-expired">Expired</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/user.jsp" class="btn btn-outline-secondary">Back to Dashboard</a>
        <a href="pricing" class="btn btn-primary ms-2">View Plans</a>
    </div>
</div>

</body>
</html>
