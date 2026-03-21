<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!-- Admin Sidebar - Dark Theme (matching dashboard.jsp) -->
        <aside class="sidebar" id="sidebar">
            <div class="logo">
                <img src="${pageContext.request.contextPath}/images/logo.png"
                    style="width:36px;height:36px;border-radius:50%;display:inline-block;vertical-align:middle;margin-right:8px"
                    onerror="this.style.display='none'">
                <span style="vertical-align:middle"><span class="a">ez</span>travel</span>
                <span class="badge-admin">ADMIN</span>
            </div>
            <nav>
                <a href="${pageContext.request.contextPath}/admin/dashboard"
                    class="${requestScope.activePage == 'dashboard' ? 'active' : ''}"><i class="fas fa-th-large"></i>
                    Dashboard</a>

                <!-- Tour Management -->
                <div class="nav-group">
                    <a href="javascript:void(0)"
                        class="nav-parent ${requestScope.activePage == 'tours' || requestScope.activePage == 'history' || requestScope.activePage == 'analytics' || requestScope.activePage == 'tour-form' ? 'open' : ''}"
                        onclick="toggleSubMenu(this)">
                        <i class="fas fa-plane"></i> Quản Lý Tour
                        <i class="fas fa-chevron-down nav-arrow"></i>
                    </a>
                    <div
                        class="nav-sub ${requestScope.activePage == 'tours' || requestScope.activePage == 'history' || requestScope.activePage == 'analytics' || requestScope.activePage == 'tour-form' ? 'open' : ''}">
                        <a href="${pageContext.request.contextPath}/admin/tours"
                            class="${requestScope.activePage == 'tours' ? 'active' : ''}"><i class="fas fa-list"></i>
                            Danh Sách Tour</a>
                        <a href="${pageContext.request.contextPath}/admin/tours?action=new"
                            class="${requestScope.activePage == 'tour-form' ? 'active' : ''}"><i
                                class="fas fa-plus-circle"></i> Thêm Tour Mới</a>
                        <a href="${pageContext.request.contextPath}/admin/tours?action=history"
                            class="${requestScope.activePage == 'history' ? 'active' : ''}"><i
                                class="fas fa-history"></i> Lịch Sử Tour</a>
                        <a href="${pageContext.request.contextPath}/admin/tours?action=analytics"
                            class="${requestScope.activePage == 'analytics' ? 'active' : ''}"><i
                                class="fas fa-chart-pie"></i> Phân Tích Tour</a>
                    </div>
                </div>

                <!-- Booking -->
                <div class="nav-group">
                    <a href="javascript:void(0)" class="nav-parent ${requestScope.activePage == 'orders' ? 'open' : ''}"
                        onclick="toggleSubMenu(this)">
                        <i class="fas fa-calendar-check"></i> Booking
                        <i class="fas fa-chevron-down nav-arrow"></i>
                    </a>
                    <div class="nav-sub ${requestScope.activePage == 'orders' ? 'open' : ''}">
                        <a href="${pageContext.request.contextPath}/admin/orders"
                            class="${requestScope.activePage == 'orders' ? 'active' : ''}"><i
                                class="fas fa-shopping-bag"></i> Tất Cả Đơn</a>
                        <a href="${pageContext.request.contextPath}/admin/orders?status=pending"><i
                                class="fas fa-clock"></i> Chờ Xử Lý</a>
                        <a href="${pageContext.request.contextPath}/admin/orders?status=completed"><i
                                class="fas fa-check-circle"></i> Hoàn Thành</a>
                    </div>
                </div>

                <a href="${pageContext.request.contextPath}/admin/customers"
                    class="${requestScope.activePage == 'users' ? 'active' : ''}"><i class="fas fa-users"></i> Khách
                    Hàng</a>

                <div class="nav-label">Đối Tác</div>
                <a href="${pageContext.request.contextPath}/admin/providers"
                    class="${requestScope.activePage == 'providers' ? 'active' : ''}">
                    <i class="fas fa-handshake"></i> Nhà Cung Cấp
                    <span id="provider-pending-badge"
                        style="display:none;background:#FBBF24;color:#000;font-size:.65rem;font-weight:800;padding:2px 7px;border-radius:20px;margin-left:auto;min-width:20px;text-align:center"></span>
                </a>

                <div class="nav-label">AI & Analytics</div>
                <a href="${pageContext.request.contextPath}/admin/forecast"
                    class="${requestScope.activePage == 'forecast' ? 'active' : ''}"><i class="fas fa-brain"></i> AI Dự
                    Báo</a>

                <div class="nav-label">Hệ Thống</div>
                <a href="${pageContext.request.contextPath}/home"><i class="fas fa-globe"></i> Xem Website</a>
            </nav>
            <div class="user-box">
                <div class="avatar">${not empty sessionScope.user ?
                    sessionScope.user.username.substring(0,1).toUpperCase() : 'A'}</div>
                <div>
                    <div class="uname">${not empty sessionScope.user ? sessionScope.user.username : 'Admin'}</div>
                    <div class="urole">Quản Trị Viên</div>
                </div>
            </div>
        </aside>

        <style>
            .sidebar {
                position: fixed;
                left: 0;
                top: 0;
                width: 260px;
                height: 100vh;
                background: #0B1120;
                border-right: 1px solid rgba(255, 255, 255, .06);
                padding: 24px 16px;
                display: flex;
                flex-direction: column;
                z-index: 100
            }

            .sidebar .logo {
                font-size: 1.4rem;
                font-weight: 800;
                color: #fff;
                padding: 0 12px 24px;
                border-bottom: 1px solid rgba(255, 255, 255, .06);
                margin-bottom: 16px
            }

            .sidebar .logo .a {
                color: #60A5FA
            }

            .sidebar .badge-admin {
                display: inline-block;
                padding: 2px 8px;
                border-radius: 6px;
                background: rgba(239, 68, 68, .15);
                color: #F87171;
                font-size: .65rem;
                font-weight: 700;
                margin-left: 6px;
                vertical-align: middle
            }

            .sidebar nav {
                flex: 1;
                overflow-y: auto
            }

            .sidebar nav a {
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 11px 16px;
                border-radius: 10px;
                color: rgba(255, 255, 255, .5);
                font-size: .88rem;
                font-weight: 500;
                transition: .3s;
                margin-bottom: 2px;
                text-decoration: none
            }

            .sidebar nav a:hover {
                color: #fff;
                background: rgba(255, 255, 255, .06)
            }

            .sidebar nav a.active {
                color: #fff;
                background: rgba(59, 130, 246, .15);
                border: 1px solid rgba(59, 130, 246, .2)
            }

            .sidebar nav a.active i {
                color: #60A5FA
            }

            .sidebar nav a i {
                width: 20px;
                text-align: center;
                font-size: .85rem
            }

            .sidebar .nav-label {
                font-size: .68rem;
                text-transform: uppercase;
                letter-spacing: 1.5px;
                color: rgba(255, 255, 255, .2);
                font-weight: 700;
                padding: 16px 16px 8px;
                margin-top: 8px
            }

            .sidebar .user-box {
                padding: 16px;
                border-top: 1px solid rgba(255, 255, 255, .06);
                display: flex;
                align-items: center;
                gap: 12px
            }

            .sidebar .user-box .avatar {
                width: 38px;
                height: 38px;
                border-radius: 10px;
                background: linear-gradient(135deg, #EF4444, #F87171);
                display: flex;
                align-items: center;
                justify-content: center;
                color: #fff;
                font-weight: 700;
                font-size: .85rem
            }

            .sidebar .user-box .uname {
                font-size: .85rem;
                color: #fff;
                font-weight: 600
            }

            .sidebar .user-box .urole {
                font-size: .72rem;
                color: rgba(255, 255, 255, .4)
            }

            .nav-group {
                position: relative
            }

            .nav-parent {
                display: flex !important;
                align-items: center !important
            }

            .nav-arrow {
                margin-left: auto !important;
                font-size: .6rem !important;
                transition: transform .3s !important;
                width: auto !important
            }

            .nav-parent.open .nav-arrow {
                transform: rotate(180deg)
            }

            .nav-sub {
                max-height: 0;
                overflow: hidden;
                transition: max-height .3s ease;
                padding-left: 12px
            }

            .nav-sub a {
                font-size: .82rem !important;
                padding: 8px 16px !important;
                opacity: .7
            }

            .nav-sub a:hover,
            .nav-sub a.active {
                opacity: 1
            }

            .nav-sub.open {
                max-height: 220px
            }

            @media(max-width:768px) {
                .sidebar {
                    display: none
                }
            }
        </style>

        <script>
            function toggleSubMenu(el) {
                el.classList.toggle('open');
                var sub = el.nextElementSibling;
                if (sub) sub.classList.toggle('open');
            }
        </script>