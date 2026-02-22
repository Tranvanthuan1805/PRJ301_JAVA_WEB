<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pricing Plans | Da Nang Travel Hub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body style="background: #fdfdfd;">
    <jsp:include page="/common/_header.jsp" />

    <c:if test="${not empty error_message}">
        <div style="max-width: 800px; margin: 30px auto -30px auto; background: #fff5f5; border: 1px solid #feb2b2; color: #c53030; padding: 15px 25px; border-radius: 8px; display: flex; align-items: center; gap: 15px;">
            <i class="fas fa-lock"></i>
            <div>
                <strong>${error_title}</strong>: ${error_message}
            </div>
        </div>
    </c:if>

    <main class="container" style="margin-top: 80px; margin-bottom: 100px; text-align: center;">
        <h1 style="color: var(--primary); font-size: 2.5rem; margin-bottom: 15px;">Unlock the Power of Da Nang AI</h1>
        <p style="color: var(--text-muted); font-size: 1.1rem; max-width: 600px; margin: 0 auto 60px auto;">
            Choose a plan that fits your business. From local guest houses to international airlines.
        </p>

        <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px; max-width: 1100px; margin: 0 auto;">
            <!-- Free Plan -->
            <div class="card animate-up" style="padding: 40px; border-top: 4px solid #ddd;">
                <h3 style="margin-bottom: 10px;">Explorer</h3>
                <div style="font-size: 2rem; font-weight: 800; margin-bottom: 20px;">$0 <small style="font-size: 0.9rem; color: #999;">/mo</small></div>
                <ul style="list-style: none; text-align: left; padding: 0; margin-bottom: 40px; color: #666;">
                    <li style="margin-bottom: 15px;"><i class="fas fa-check" style="color: var(--success); margin-right: 10px;"></i> List up to 3 tours</li>
                    <li style="margin-bottom: 15px;"><i class="fas fa-check" style="color: var(--success); margin-right: 10px;"></i> Basic Booking Dashboard</li>
                    <li style="margin-bottom: 15px; opacity: 0.5;"><i class="fas fa-times" style="color: #fa5252; margin-right: 10px;"></i> AI Demand Forecasting</li>
                    <li style="margin-bottom: 15px; opacity: 0.5;"><i class="fas fa-times" style="color: #fa5252; margin-right: 10px;"></i> Priority Search Result</li>
                </ul>
                <a href="${pageContext.request.contextPath}/payment?plan=Explorer&price=0" class="btn" style="width: 100%; border: 1px solid #ddd; background: white;">Current Plan</a>
            </div>

            <!-- Pro Plan -->
            <div class="card animate-up" style="padding: 40px; border-top: 4px solid var(--accent); transform: scale(1.05); box-shadow: 0 20px 40px rgba(0,0,0,0.1); position: relative;">
                <div style="position: absolute; top: -15px; left: 50%; transform: translateX(-50%); background: var(--accent); color: white; padding: 5px 20px; border-radius: 20px; font-size: 0.8rem; font-weight: 700;">MOST POPULAR</div>
                <h3 style="margin-bottom: 10px; color: var(--primary);">Professional</h3>
                <div style="font-size: 2rem; font-weight: 800; margin-bottom: 20px; color: var(--primary);">$49 <small style="font-size: 0.9rem; color: #999;">/mo</small></div>
                <ul style="list-style: none; text-align: left; padding: 0; margin-bottom: 40px; color: #666;">
                    <li style="margin-bottom: 15px;"><i class="fas fa-check" style="color: var(--success); margin-right: 10px;"></i> Unlimited Tour Listings</li>
                    <li style="margin-bottom: 15px;"><i class="fas fa-check" style="color: var(--success); margin-right: 10px;"></i> <strong>AI Demand Forecasting</strong></li>
                    <li style="margin-bottom: 15px;"><i class="fas fa-check" style="color: var(--success); margin-right: 10px;"></i> Advanced Analytics</li>
                    <li style="margin-bottom: 15px;"><i class="fas fa-check" style="color: var(--success); margin-right: 10px;"></i> Verified Partner Badge</li>
                </ul>
                <a href="${pageContext.request.contextPath}/payment?plan=Professional&price=49" class="btn btn-primary" style="width: 100%; background: var(--accent);">Upgrade to Pro</a>
            </div>

            <!-- Enterprise Plan -->
            <div class="card animate-up" style="padding: 40px; border-top: 4px solid var(--primary);">
                <h3 style="margin-bottom: 10px;">Elite</h3>
                <div style="font-size: 2rem; font-weight: 800; margin-bottom: 20px;">$199 <small style="font-size: 0.9rem; color: #999;">/mo</small></div>
                <ul style="list-style: none; text-align: left; padding: 0; margin-bottom: 40px; color: #666;">
                    <li style="margin-bottom: 15px;"><i class="fas fa-check" style="color: var(--success); margin-right: 10px;"></i> All Pro Features</li>
                    <li style="margin-bottom: 15px;"><i class="fas fa-check" style="color: var(--success); margin-right: 10px;"></i> AI Dynamic Pricing API</li>
                    <li style="margin-bottom: 15px;"><i class="fas fa-check" style="color: var(--success); margin-right: 10px;"></i> Dedicated Account Manager</li>
                    <li style="margin-bottom: 15px;"><i class="fas fa-check" style="color: var(--success); margin-right: 10px;"></i> Top-tier Search Placement</li>
                </ul>
                <a href="${pageContext.request.contextPath}/payment?plan=Elite&price=199" class="btn" style="width: 100%; border: 1px solid var(--primary); color: var(--primary); background: white;">Contact Sales</a>
            </div>
        </div>
    </main>

    <jsp:include page="/common/_footer.jsp" />
</body>
</html>
