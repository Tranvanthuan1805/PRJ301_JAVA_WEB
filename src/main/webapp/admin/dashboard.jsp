<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard | Da Nang Travel Hub Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>
    <div class="dashboard-wrapper">
        <!-- Sidebar -->
        <jsp:include page="/common/_sidebar.jsp" />

        <!-- Main Content -->
        <main class="main-content">
            <header style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px;">
                <div>
                    <h1 style="color: var(--primary);">System Overview</h1>
                    <p style="color: var(--text-muted);">Welcome back, ${sessionScope.user.username}</p>
                </div>
                <div style="display: flex; gap: 15px;">
                    <button class="btn" style="background: white; border: 1px solid #ddd;"><i class="fas fa-download"></i> Export Report</button>
                    <button class="btn btn-primary">+ Create Tour</button>
                </div>
            </header>

            <!-- Stats Grid -->
            <section class="stat-grid animate-up">
                <div class="stat-card">
                    <div class="label">Total Bookings</div>
                    <div class="value">${totalBookings}</div>
                    <div style="color: #27ae60; font-size: 0.8rem; margin-top: 5px;">+12% from last month</div>
                </div>
                <div class="stat-card">
                    <div class="label">Gross Revenue</div>
                    <div class="value"><fmt:formatNumber value="${grossRevenue}" type="currency" currencySymbol="$"/></div>
                    <div style="color: #27ae60; font-size: 0.8rem; margin-top: 5px;">+8% from last month</div>
                </div>
                <div class="stat-card">
                    <div class="label">Active Tours</div>
                    <div class="value">${activeTours}</div>
                </div>
                <div class="stat-card" style="border-left: 4px solid var(--accent);">
                    <div class="label">Pending Orders</div>
                    <div class="value" style="color: var(--accent);">${pendingRequests}</div>
                </div>
            </section>

            <!-- AI Intelligence Panel -->
            <section class="card animate-up" style="margin-bottom: 40px; border-left: 4px solid var(--primary);">
                <div style="display: flex; align-items: center; gap: 15px; margin-bottom: 20px;">
                    <i class="fas fa-brain" style="font-size: 1.5rem; color: var(--primary);"></i>
                    <h3>AI Demand Forecasting</h3>
                </div>
                <div style="background: #f1f2f6; height: 300px; border-radius: 8px; display: flex; align-items: center; justify-content: center; overflow: hidden; position: relative;">
                    <!-- Placeholder for Chart.js -->
                    <p style="color: var(--text-muted); font-style: italic; z-index: 2;">AI is analyzing booking trends for the Da Nang International Fireworks Festival...</p>
                    <div style="position: absolute; bottom: 0; left: 0; width: 100%; height: 60%; background: linear-gradient(0deg, rgba(10,35,81,0.1) 0%, transparent 100%);"></div>
                </div>
                <div style="margin-top: 20px; display: flex; gap: 20px;">
                    <div style="flex: 1; padding: 15px; background: rgba(10,35,81,0.03); border-radius: 8px;">
                        <small style="color: var(--text-muted);">Confidence Score</small>
                        <div style="font-weight: 700; color: var(--success);">94.2%</div>
                    </div>
                    <div style="flex: 1; padding: 15px; background: rgba(10,35,81,0.03); border-radius: 8px;">
                        <small style="color: var(--text-muted);">Recommended Action</small>
                        <div style="font-weight: 700;">Boost "River Tours" capacity by 15%</div>
                    </div>
                </div>
            </section>

            <!-- Recent Orders Table -->
            <section class="card animate-up">
                <h3 style="margin-bottom: 20px;">Recent Activity</h3>
                <table style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr style="text-align: left; border-bottom: 2px solid #eee;">
                            <th style="padding: 15px 0;">Customer</th>
                            <th style="padding: 15px 0;">Tour</th>
                            <th style="padding: 15px 0;">Amount</th>
                            <th style="padding: 15px 0;">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr style="border-bottom: 1px solid #f9f9f9;">
                            <td style="padding: 15px 0;">Nguyen Van A</td>
                            <td style="padding: 15px 0;">Ba Na Hills Full Day</td>
                            <td style="padding: 15px 0;">$120.00</td>
                            <td style="padding: 15px 0;"><span style="background: #ecfdf5; color: #059669; padding: 4px 10px; border-radius: 20px; font-size: 0.8rem;">Confirmed</span></td>
                        </tr>
                        <tr style="border-bottom: 1px solid #f9f9f9;">
                            <td style="padding: 15px 0;">Maria Garcia</td>
                            <td style="padding: 15px 0;">Hoi An Ancient Town</td>
                            <td style="padding: 15px 0;">$85.00</td>
                            <td style="padding: 15px 0;"><span style="background: #fffbea; color: #d97706; padding: 4px 10px; border-radius: 20px; font-size: 0.8rem;">Pending</span></td>
                        </tr>
                    </tbody>
                </table>
            </section>
        </main>
    </div>
    <jsp:include page="/views/ai-chatbot/chatbot.jsp" />
</body>
</html>
