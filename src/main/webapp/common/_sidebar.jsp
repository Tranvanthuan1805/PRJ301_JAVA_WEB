<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <aside class="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">
                <span class="logo-icon">🏖️</span>
                <span class="logo-text">DN HUB</span>
            </div>
            <c:choose>
                <c:when test="${sessionScope.user_plan == 'Professional' || sessionScope.user_plan == 'Elite'}">
                    <span class="plan-badge pro"><i class="fas fa-crown"></i> PRO HUB</span>
                </c:when>
                <c:otherwise>
                    <span class="plan-badge free">FREE HUB</span>
                    <a href="${pageContext.request.contextPath}/pricing" class="upgrade-link"><i
                            class="fas fa-bolt"></i> Nâng Cấp</a>
                </c:otherwise>
            </c:choose>
        </div>
        <ul class="sidebar-menu">
            <li>
                <a href="${pageContext.request.contextPath}/admin/dashboard"
                    class="${requestScope.activePage == 'dashboard' ? 'active' : ''}">
                    <i class="fas fa-chart-line"></i> <span>Dashboard</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/tours"
                    class="${requestScope.activePage == 'tours' ? 'active' : ''}">
                    <i class="fas fa-map-marked-alt"></i> <span>Quản Lý Tours</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/tours?action=history"
                    class="${requestScope.activePage == 'history' ? 'active' : ''}">
                    <i class="fas fa-history"></i> <span>Lịch Sử Tour</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/tours?action=analytics"
                    class="${requestScope.activePage == 'analytics' ? 'active' : ''}">
                    <i class="fas fa-chart-pie"></i> <span>Phân Tích Tour</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/orders"
                    class="${requestScope.activePage == 'orders' ? 'active' : ''}">
                    <i class="fas fa-shopping-bag"></i> <span>Đơn Hàng</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/coupons"
                    class="${requestScope.activePage == 'coupons' ? 'active' : ''}">
                    <i class="fas fa-tags"></i> <span>Mã Giảm Giá</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/customers"
                    class="${requestScope.activePage == 'users' ? 'active' : ''}">
                    <i class="fas fa-users"></i> <span>Khách Hàng</span>
                </a>
            </li>
            <li class="menu-divider">Đối Tác</li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/providers"
                    class="${requestScope.activePage == 'providers' ? 'active' : ''}">
                    <i class="fas fa-handshake"></i> <span>Nhà Cung Cấp</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/providers?action=comparison"
                    class="${requestScope.activePage == 'comparison' ? 'active' : ''}">
                    <i class="fas fa-balance-scale"></i> <span>So Sánh Giá</span>
                </a>
            </li>
            <li class="menu-divider">Trí Tuệ AI</li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/forecast"
                    class="${requestScope.activePage == 'forecast' ? 'active' : ''}">
                    <i class="fas fa-brain"></i> <span>AI Dự Báo</span>
                </a>
            </li>
        </ul>

        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/" class="sidebar-back">
                <i class="fas fa-arrow-left"></i> <span>Về Trang Chủ</span>
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="sidebar-logout">
                <i class="fas fa-sign-out-alt"></i> <span>Đăng Xuất</span>
            </a>
        </div>
    </aside>

    <style>
        .sidebar {
            width: 260px;
            background: #fff;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            border-right: 1px solid #E8EAF0;
            z-index: 900;
            display: flex;
            flex-direction: column;
            box-shadow: 2px 0 20px rgba(27, 31, 59, .04)
        }

        .sidebar-header {
            padding: 28px 24px 24px;
            border-bottom: 1px solid #F0F1F5
        }

        .sidebar-logo {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 14px
        }

        .logo-icon {
            font-size: 1.4rem
        }

        .logo-text {
            font-size: 1.2rem;
            font-weight: 800;
            color: #1B1F3B;
            letter-spacing: -.3px
        }

        .plan-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 4px 12px;
            border-radius: 999px;
            font-size: .7rem;
            font-weight: 700;
            letter-spacing: .3px
        }

        .plan-badge.pro {
            background: linear-gradient(135deg, rgba(255, 111, 97, .1), rgba(255, 154, 139, .05));
            color: #FF6F61;
            border: 1px solid rgba(255, 111, 97, .15)
        }

        .plan-badge.pro i {
            color: #FFB703
        }

        .plan-badge.free {
            background: #F7F8FC;
            color: #6B7194;
            border: 1px solid #E8EAF0
        }

        .upgrade-link {
            display: block;
            font-size: .72rem;
            color: #FF6F61;
            font-weight: 700;
            margin-top: 8px;
            text-decoration: none;
            transition: .3s
        }

        .upgrade-link:hover {
            color: #1B1F3B
        }

        .sidebar-menu {
            list-style: none;
            flex: 1;
            padding: 12px 0;
            overflow-y: auto
        }

        .sidebar-menu li a {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 11px 24px;
            color: #6B7194;
            font-weight: 600;
            font-size: .88rem;
            transition: .3s;
            text-decoration: none;
            border-left: 3px solid transparent;
            margin: 2px 0
        }

        .sidebar-menu li a:hover,
        .sidebar-menu li a.active {
            background: linear-gradient(90deg, rgba(255, 111, 97, .06), transparent);
            color: #1B1F3B;
            border-left-color: #FF6F61
        }

        .sidebar-menu li a.active {
            font-weight: 700
        }

        .sidebar-menu li a i {
            width: 20px;
            text-align: center;
            font-size: .9rem;
            color: #A0A5C3;
            transition: .3s
        }

        .sidebar-menu li a:hover i,
        .sidebar-menu li a.active i {
            color: #FF6F61
        }

        .menu-divider {
            padding: 22px 24px 8px;
            font-size: .68rem;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            color: #A0A5C3;
            font-weight: 800
        }

        .sidebar-footer {
            padding: 16px 24px;
            border-top: 1px solid #F0F1F5
        }

        .sidebar-footer a {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 0;
            color: #6B7194;
            font-weight: 600;
            font-size: .85rem;
            text-decoration: none;
            transition: .3s
        }

        .sidebar-footer a:hover {
            color: #FF6F61
        }

        .sidebar-footer a i {
            width: 18px;
            text-align: center;
            font-size: .85rem
        }

        .sidebar-back i {
            color: #A0A5C3
        }

        .sidebar-logout i {
            color: #DC2626
        }
    </style>