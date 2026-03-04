<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Profile | Da Nang Travel Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>
    <div class="dashboard-wrapper">
        <jsp:include page="/common/_sidebar.jsp" />

        <main class="main-content">
            <header style="margin-bottom: 40px;">
                <a href="${pageContext.request.contextPath}/admin/customers" style="color: var(--text-muted); font-size: 0.9rem; text-decoration: none; margin-bottom: 10px; display: inline-block;">
                    <i class="fas fa-arrow-left"></i> Back to Customers
                </a>
                <h1 style="color: var(--primary);">Customer Profile</h1>
            </header>

            <div style="display: grid; grid-template-columns: 350px 1fr; gap: 30px;">
                <!-- Profile Card -->
                <aside>
                    <div class="card" style="text-align: center; padding: 40px 20px;">
                        <img src="${not empty customer.avatarUrl ? customer.avatarUrl : 'https://ui-avatars.com/api/?size=150&name=' + customer.fullName}" style="width: 120px; height: 120px; border-radius: 50%; border: 4px solid #f8f9fa; margin-bottom: 20px;">
                        <h2 style="margin-bottom: 5px;">${customer.fullName}</h2>
                        <p style="color: var(--text-muted); margin-bottom: 25px;">${customer.email}</p>
                        
                        <div style="display: flex; gap: 10px; justify-content: center; margin-bottom: 30px;">
                            <span style="background: var(--primary); color: white; padding: 4px 15px; border-radius: 20px; font-size: 0.8rem;">Loyalty Tier: Silver</span>
                        </div>

                        <hr style="border: 0; border-top: 1px solid #eee; margin-bottom: 30px;">

                        <div style="text-align: left; font-size: 0.9rem;">
                            <div style="margin-bottom: 15px;">
                                <small style="color: var(--text-muted); display: block; text-transform: uppercase;">Phone Number</small>
                                <strong>${customer.phoneNumber}</strong>
                            </div>
                            <div style="margin-bottom: 15px;">
                                <small style="color: var(--text-muted); display: block; text-transform: uppercase;">Customer Since</small>
                                <strong><fmt:formatDate value="${customer.createdAt}" pattern="dd MMMM yyyy"/></strong>
                            </div>
                            <div style="margin-bottom: 15px;">
                                <small style="color: var(--text-muted); display: block; text-transform: uppercase;">Last Active</small>
                                <strong><fmt:formatDate value="${customer.lastBookingDate}" pattern="dd MMM yyyy HH:mm"/></strong>
                            </div>
                        </div>

                        <button class="btn" style="width: 100%; margin-top: 20px; border: 1px solid #fa5252; color: #fa5252; background: white;">Restrict Account</button>
                    </div>
                </aside>

                <!-- Activity Details -->
                <section>
                    <div class="stat-grid" style="grid-template-columns: 1fr 1fr 1fr; margin-bottom: 30px;">
                        <div class="stat-card">
                            <div class="label">Total Bookings</div>
                            <div class="value">${customer.totalOrders}</div>
                        </div>
                        <div class="stat-card">
                            <div class="label">Lifetime Spent</div>
                            <div class="value" style="color: var(--success);">$<fmt:formatNumber value="${customer.totalSpent}" pattern="#,###.00"/></div>
                        </div>
                        <div class="stat-card">
                            <div class="label">Booking Frequency</div>
                            <div class="value">0.4/mo</div>
                        </div>
                    </div>

                    <div class="card" style="margin-bottom: 30px; border-left: 4px solid var(--accent);">
                        <h3><i class="fas fa-brain" style="color: var(--accent); margin-right: 10px;"></i> AI Behavior Insights</h3>
                        <p style="margin-top: 15px; color: var(--text-main);">
                            Based on search history, this guest prefers <strong>Culture & Heritage</strong> tours in Hoi An. 
                            Predicted next booking window: <strong>March 15-20, 2026</strong>.
                        </p>
                        <div style="margin-top: 20px; display: flex; gap: 10px;">
                            <span style="background: #fff3f3; color: #ff6b6b; padding: 4px 12px; border-radius: 4px; font-size: 0.8rem;">#HoiAnLover</span>
                            <span style="background: #f1f0ff; color: #5c7cfa; padding: 4px 12px; border-radius: 4px; font-size: 0.8rem;">#WeekendTraveler</span>
                        </div>
                    </div>

                    <div class="card">
                        <h3 style="margin-bottom: 20px;">Booking History</h3>
                        <div style="text-align: center; padding: 40px; background: #fafafa; border-radius: 8px;">
                            <p style="color: var(--text-muted); font-style: italic;">Detailed order history will appear here once linked with the Order Management module.</p>
                        </div>
                    </div>
                </section>
            </div>
        </main>
    </div>
</body>
</html>
