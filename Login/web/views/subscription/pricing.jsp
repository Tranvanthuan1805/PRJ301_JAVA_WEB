<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Upgrade Plan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .pricing-card {
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            padding: 20px;
            transition: transform 0.3s;
        }
        .pricing-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .price-tag {
            font-size: 2rem;
            font-weight: bold;
            color: #0d6efd;
        }
        .current-plan {
            border: 2px solid #198754;
            background-color: #f8fff9;
        }
    </style>
</head>
<body class="bg-light">

<div class="container py-5">
    <div class="text-center mb-5">
        <h1 class="fw-bold">Choose Your Plan</h1>
        <p class="text-muted">Unlock advanced AI features and grow your business.</p>
    </div>

    <div class="row justify-content-center">
        <c:forEach items="${plans}" var="p">
            <div class="col-md-4 mb-4">
                <!-- Logic: Current plan is the highest priced active one, or Explorer if none -->
                <c:set var="isCurrent" value="${(currentSub == null && p.price == 0) || (currentSub != null && currentSub.plan.planId == p.planId)}" />
                <!-- Logic: Can only upgrade to higher priced plans -->
                <c:set var="canUpgrade" value="${currentSub == null || currentSub.plan.price < p.price}" />
                
                <div class="pricing-card h-100 bg-white ${isCurrent ? 'current-plan' : ''}">
                    <h3 class="fw-bold">${p.planName}</h3>
                    <div class="price-tag my-3">
                        <c:if test="${p.price == 0}">Free</c:if>
                        <c:if test="${p.price > 0}">${p.price} VND</c:if>
                        <span class="fs-6 text-muted fw-normal">/ ${p.durationDays} days</span>
                    </div>
                    <p class="text-muted">${p.description}</p>
                    <hr>
                    <ul class="list-unstyled mb-4">
                        <c:forTokens items="${p.features}" delims="," var="feature">
                            <li class="mb-2">✔ ${feature}</li>
                        </c:forTokens>
                    </ul>
                    
                    <div class="mt-auto">
                        <c:choose>
                            <c:when test="${isCurrent}">
                                <button class="btn btn-success w-100" disabled>Current Plan</button>
                            </c:when>
                            <c:when test="${!canUpgrade}">
                                <button class="btn btn-secondary w-100" disabled>Owned</button>
                            </c:when>
                            <c:otherwise>
                                <a href="payment?planId=${p.planId}" class="btn btn-primary w-100">Upgrade</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    
    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/user.jsp" class="text-decoration-none">Back to Dashboard</a>
    </div>
</div>

</body>
</html>
