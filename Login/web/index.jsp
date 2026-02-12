<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Tour" %>
<%@ page import="dao.TourDAO" %>
<%@ page import="util.DatabaseConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    boolean isLoggedIn = username != null;
    boolean isAdmin = "ADMIN".equals(role);
    
    // Load featured tours
    List<Tour> featuredTours = null;
    try {
        Connection conn = DatabaseConnection.getNewConnection();
        TourDAO tourDAO = new TourDAO(conn);
        featuredTours = tourDAO.getFeaturedTours(6);
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VietAir - Hệ thống quản lý tour du lịch Đà Nẵng</title>
    <link rel="stylesheet" href="css/vietair-style.css">
    <link rel="stylesheet" href="css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="nav-brand">
                <div class="logo-container">
                    <i class="fas fa-plane-departure logo-icon"></i>
                    <span class="logo-text">VietAir</span>
                </div>
            </div>
            <nav class="nav-menu">
                <a href="index.jsp" class="nav-item">Trang chủ</a>
                <a href="tour?action=list" class="nav-item">Tours</a>
                <% if (isAdmin) { %>
                    <a href="admin/customers" class="nav-item">Khách hàng</a>
                    <a href="history.jsp" class="nav-item">Lịch sử</a>
                <% } else if (isLoggedIn) { %>
                    <a href="profile" class="nav-item">Profile</a>
                <% } %>
            </nav>
            <div class="nav-actions">
                <% if (isLoggedIn) { %>
                    <span class="user-badge"><%= isAdmin ? "ADMIN" : "USER" %></span>
                    <a href="logout" class="btn-logout">
                        <i class="fas fa-sign-out-alt"></i>
                        Đăng xuất
                    </a>
                <% } else { %>
                    <a href="login.jsp" class="btn-login">
                        <i class="fas fa-sign-in-alt"></i>
                        Đăng Nhập
                    </a>
                    <a href="register.jsp" class="btn-register">
                        <i class="fas fa-user-plus"></i>
                        Đăng Ký
                    </a>
                <% } %>
            </div>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-background">
            <div class="hero-overlay"></div>
        </div>
        <div class="hero-content">
            <div class="hero-text">
                <h1>VietAir - Hệ thống quản lý tour du lịch</h1>
                <p>Khám phá Việt Nam với những tour du lịch chất lượng cao</p>
                <button class="hero-cta" onclick="window.location.href='tour?action=list'">
                    <i class="fas fa-compass"></i>
                    Tour du lịch
                </button>
            </div>
            
            <!-- Search Container -->
            <div class="search-container">
                <div class="search-header">
                    <h3>Tìm tour du lịch trong mơ của bạn</h3>
                    <div class="search-tabs">
                        <button class="search-tab active" id="searchTab">Tìm kiếm Tour</button>
                        <button class="search-tab" id="featuredTab">Tour nổi bật</button>
                    </div>
                </div>
                
                <!-- Search Form -->
                <form class="search-form" id="searchForm" action="tour" method="get">
                    <input type="hidden" name="action" value="search">
                    <div class="search-grid">
                        <div class="search-field">
                            <label>
                                <i class="fas fa-map-marker-alt"></i>
                                Điểm đến
                            </label>
                            <div class="input-wrapper">
                                <select name="destination" id="destination" class="form-select">
                                    <option value="">Ngũ Hành Sơn</option>
                                    <option value="Bà Nà Hills">Bà Nà Hills</option>
                                    <option value="Ngũ Hành Sơn" selected>Ngũ Hành Sơn</option>
                                    <option value="Cù Lao Chàm">Cù Lao Chàm</option>
                                    <option value="Sơn Trà">Sơn Trà</option>
                                    <option value="Huế">Huế</option>
                                    <option value="Núi Thần Tài">Núi Thần Tài</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="search-field">
                            <label>
                                <i class="fas fa-calendar-alt"></i>
                                Ngày khởi hành
                            </label>
                            <div class="input-wrapper">
                                <input type="date" name="startDate" id="startDate" class="form-input" value="2026-02-04">
                            </div>
                        </div>
                        
                        <div class="search-field">
                            <label>
                                <i class="fas fa-users"></i>
                                Số người
                            </label>
                            <div class="input-wrapper">
                                <select name="numPeople" id="numPeople" class="form-select">
                                    <option value="1">1 người</option>
                                    <option value="2" selected>2 người</option>
                                    <option value="3">3 người</option>
                                    <option value="4">4 người</option>
                                    <option value="5">5 người</option>
                                    <option value="6">6+ người</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="search-field">
                            <label style="opacity: 0;">Tìm kiếm</label>
                            <button type="submit" class="search-btn-full">
                                <i class="fas fa-search"></i>
                                <span>Tìm kiếm</span>
                            </button>
                        </div>
                    </div>
                </form>

                <!-- Featured Tours Section -->
                <div class="featured-tours-section" id="featuredToursSection" style="display: none;">
                    <div class="featured-header">
                        <h4>🌟 Tour nổi bật tháng này</h4>
                        <p>Những tour du lịch hot nhất với giá tốt nhất</p>
                    </div>
                    <div class="featured-tours-grid" id="featuredToursGrid">
                        <% if (featuredTours != null && !featuredTours.isEmpty()) { 
                            for (Tour tour : featuredTours) { %>
                                <div class="featured-tour-item" onclick="window.location.href='jsp/tour-view.jsp?id=<%= tour.getId() %>'" style="cursor: pointer;">
                                    <div class="featured-tour-image" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                                        <div class="featured-badge"><%= String.format("%,.0f", tour.getPrice()) %> VNĐ</div>
                                    </div>
                                    <div class="featured-tour-content">
                                        <h4><%= tour.getName() %></h4>
                                        <p class="featured-location">
                                            <i class="fas fa-map-marker-alt"></i>
                                            <%= tour.getDestination() %>
                                        </p>
                                        <div class="featured-tour-info">
                                            <span><i class="fas fa-calendar"></i> <%= tour.getStartDate().format(formatter) %></span>
                                            <span><i class="fas fa-users"></i> <%= tour.getCurrentCapacity() %>/<%= tour.getMaxCapacity() %></span>
                                        </div>
                                        <a href="jsp/tour-view.jsp?id=<%= tour.getId() %>" class="btn-book-now" onclick="event.stopPropagation();">
                                            <i class="fas fa-info-circle"></i> Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                        <% } 
                        } else { %>
                            <p style="text-align: center; padding: 2rem; color: #666; grid-column: 1 / -1;">Không có tours nào</p>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Quick Stats -->
    <section class="stats-section">
        <div class="container">
            <div class="stats-grid">
                <div class="stat-item professional-stat">
                    <div class="stat-background">
                        <div class="stat-gradient stat-gradient-1"></div>
                    </div>
                    <div class="stat-icon professional-icon">
                        <i class="fas fa-globe-americas"></i>
                    </div>
                    <div class="stat-content">
                        <h3 class="stat-number">432</h3>
                        <p class="stat-label">Tours lịch sử</p>
                        <span class="stat-description">Từ 2020-2025</span>
                    </div>
                </div>
                
                <div class="stat-item professional-stat">
                    <div class="stat-background">
                        <div class="stat-gradient stat-gradient-2"></div>
                    </div>
                    <div class="stat-icon professional-icon">
                        <i class="fas fa-map-marked-alt"></i>
                    </div>
                    <div class="stat-content">
                        <h3 class="stat-number">6</h3>
                        <p class="stat-label">Điểm đến</p>
                        <span class="stat-description">Khắp Đà Nẵng</span>
                    </div>
                </div>
                
                <div class="stat-item professional-stat">
                    <div class="stat-background">
                        <div class="stat-gradient stat-gradient-3"></div>
                    </div>
                    <div class="stat-icon professional-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="stat-content">
                        <h3 class="stat-number">72</h3>
                        <p class="stat-label">Tháng dữ liệu</p>
                        <span class="stat-description">6 năm hoạt động</span>
                    </div>
                </div>
                
                <div class="stat-item professional-stat">
                    <div class="stat-background">
                        <div class="stat-gradient stat-gradient-4"></div>
                    </div>
                    <div class="stat-icon professional-icon">
                        <i class="fas fa-star"></i>
                    </div>
                    <div class="stat-content">
                        <h3 class="stat-number">4.9</h3>
                        <div class="stat-rating">/5</div>
                        <p class="stat-label">Đánh giá</p>
                        <span class="stat-description">Chất lượng xuất sắc</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-brand">
                    <div class="logo-container">
                        <i class="fas fa-plane-departure logo-icon"></i>
                        <span class="logo-text">VietAir</span>
                    </div>
                    <p>Hệ thống quản lý tour du lịch Đà Nẵng với dữ liệu lịch sử từ 2020-2025</p>
                </div>
                <div class="footer-section">
                    <h4>Liên hệ</h4>
                    <ul>
                        <li><i class="fas fa-phone"></i> 1900 1234</li>
                        <li><i class="fas fa-envelope"></i> support@vietair.vn</li>
                        <li><i class="fas fa-map-marker-alt"></i> Đà Nẵng, Việt Nam</li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <div class="footer-bottom-content">
                    <p>&copy; 2026 VietAir. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <script>
        // Tab switching
        document.getElementById('searchTab').addEventListener('click', () => {
            document.getElementById('searchTab').classList.add('active');
            document.getElementById('featuredTab').classList.remove('active');
            document.getElementById('searchForm').style.display = 'block';
            document.getElementById('featuredToursSection').style.display = 'none';
        });

        document.getElementById('featuredTab').addEventListener('click', () => {
            document.getElementById('featuredTab').classList.add('active');
            document.getElementById('searchTab').classList.remove('active');
            document.getElementById('searchForm').style.display = 'none';
            document.getElementById('featuredToursSection').style.display = 'block';
        });
    </script>
</body>
</html>
