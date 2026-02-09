<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<aside class="sidebar">
    <div class="sidebar-header">
        <h3>Admin Panel</h3>
        <c:choose>
            <c:when test="${sessionScope.user_plan == 'Professional' || sessionScope.user_plan == 'Elite'}">
                <span class="badge" style="background: var(--accent); color: white; border: none;">PRO HUB</span>
            </c:when>
            <c:otherwise>
                <span class="badge" style="background: #edf2f7; color: #4a5568; border: none;">FREE HUB</span>
                <a href="${pageContext.request.contextPath}/views/subscription-payment/pricing.jsp" style="display: block; font-size: 0.7rem; color: var(--accent); margin-top: 5px;">Upgrade Now</a>
            </c:otherwise>
        </c:choose>
    </div>
    <ul class="sidebar-menu">
        <li>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="${requestScope.activePage == 'dashboard' ? 'active' : ''}">
                <i class="fas fa-chart-line"></i> Dashboard
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/tours" class="${requestScope.activePage == 'tours' ? 'active' : ''}">
                <i class="fas fa-map-marked-alt"></i> Manage Tours
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/orders" class="${requestScope.activePage == 'orders' ? 'active' : ''}">
                <i class="fas fa-shopping-bag"></i> Orders
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/customers" class="${requestScope.activePage == 'users' ? 'active' : ''}">
                <i class="fas fa-users"></i> Customers
            </a>
        </li>
        <li class="menu-divider">Partners</li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/providers" class="${requestScope.activePage == 'providers' ? 'active' : ''}">
                <i class="fas fa-handshake"></i> Providers
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/providers?action=comparison" class="${requestScope.activePage == 'comparison' ? 'active' : ''}">
                <i class="fas fa-balance-scale"></i> Price Analysis
            </a>
        </li>
        <li class="menu-divider">Intelligence</li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/forecast" class="${requestScope.activePage == 'forecast' ? 'active' : ''}">
                <i class="fas fa-brain"></i> AI Forecast
            </a>
        </li>
    </ul>
</aside>

<style>
    .sidebar {
        width: 260px;
        background: #ffffff;
        height: 100vh;
        position: fixed;
        left: 0;
        top: 0;
        border-right: 1px solid #eee;
        padding-top: 20px;
        z-index: 900;
    }
    
    .sidebar-header {
        padding: 0 25px 30px 25px;
        color: var(--primary);
    }
    
    .sidebar-menu {
        list-style: none;
    }
    
    .sidebar-menu li a {
        display: flex;
        align-items: center;
        gap: 15px;
        padding: 12px 25px;
        color: var(--text-muted);
        font-weight: 500;
        transition: 0.3s;
    }
    
    .sidebar-menu li a:hover, .sidebar-menu li a.active {
        background: rgba(10, 35, 81, 0.05);
        color: var(--primary);
        border-right: 4px solid var(--primary);
    }
    
    .sidebar-menu li a i {
        width: 20px;
    }
    
    .menu-divider {
        padding: 20px 25px 10px 25px;
        font-size: 0.7rem;
        text-transform: uppercase;
        color: #b2bec3;
        font-weight: 800;
    }
</style>
