<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User" %>
<%
    // Check if user is logged in
    HttpSession s = request.getSession(false);
    User u = (s == null) ? null : (User) s.getAttribute("user");
    boolean isLoggedIn = (u != null);
    boolean isAdmin = (u != null && u.roleName != null && "ADMIN".equalsIgnoreCase(u.roleName));
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VietAir - Hệ thống quản lý tour du lịch Đà Nẵng</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; line-height: 1.6; color: #2d3748; background: #f7fafc; }
        .container { max-width: 1200px; margin: 0 auto; padding: 0 20px; }
        
        /* Header */
        .header { background: linear-gradient(135deg, #2c5aa0 0%, #1e4070 100%); box-shadow: 0 4px 6px rgba(0,0,0,0.1); position: sticky; top: 0; z-index: 1000; }
        .header .container { display: flex; align-items: center; justify-content: center; height: 64px; position: relative; }
        .nav-brand { position: absolute; left: 20px; }
        .nav-actions { position: absolute; right: 20px; }
        .logo-container { display: flex; align-items: center; gap: 12px; color: #fff; }
        .logo-icon { font-size: 28px; color: #00d4aa; }
        .logo-text { font-size: 24px; font-weight: 700; color: #fff; }
        .nav-menu { display: flex; gap: 32px; }
        .nav-item { padding: 10px 18px; color: rgba(255,255,255,0.95); text-decoration: none; border-radius: 6px; font-weight: 500; transition: all 0.2s; }
        .nav-item:hover, .nav-item.active { background: rgba(255,255,255,0.1); color: #fff; }
        .nav-actions { display: flex; gap: 14px; align-items: center; }
        .user-badge { padding: 6px 14px; background: rgba(100,150,200,0.4); border: 1px solid rgba(255,255,255,0.3); border-radius: 4px; color: #fff; font-size: 12px; font-weight: 600; text-transform: uppercase; }
        .btn-login, .btn-register, .btn-logout { display: flex; align-items: center; gap: 6px; padding: 9px 18px; border-radius: 6px; font-weight: 600; font-size: 14px; text-decoration: none; transition: all 0.2s; }
        .btn-login, .btn-logout { background: transparent; color: #fff; border: 2px solid rgba(255,255,255,0.5); }
        .btn-login:hover, .btn-logout:hover { background: rgba(255,255,255,0.15); border-color: rgba(255,255,255,0.8); }
        .btn-register { background: #00d4aa; color: #fff; border: none; box-shadow: 0 2px 8px rgba(0,212,170,0.3); }
        .btn-register:hover { background: #00c49a; }
        
        /* Hero */
        .hero { position: relative; min-height: 80vh; display: flex; align-items: center; overflow: hidden; }
        .hero-background { position: absolute; top: 0; left: 0; right: 0; bottom: 0; background: linear-gradient(135deg, #2c5aa0 0%, #1e4070 50%, #001a33 100%); z-index: -1; }
        .hero-overlay { position: absolute; top: 0; left: 0; right: 0; bottom: 0; background: linear-gradient(45deg, rgba(0,102,204,0.1), rgba(0,212,170,0.1)); }
        .hero-content { position: relative; width: 100%; padding: 60px 0; z-index: 1; }
        .hero-text { text-align: center; margin-bottom: 40px; }
        .hero-text h1 { font-size: 3.5rem; font-weight: 800; color: #fff; margin-bottom: 16px; line-height: 1.2; }
        .hero-text p { font-size: 1.25rem; color: rgba(255,255,255,0.9); }
        
        /* Search Container */
        .search-container { background: #fff; border-radius: 14px; padding: 32px; box-shadow: 0 10px 40px rgba(0,0,0,0.2); max-width: 1000px; margin: 0 auto; }
        .search-header { text-align: center; margin-bottom: 32px; }
        .search-header h3 { font-size: 1.5rem; font-weight: 700; color: #2d3748; }
        .search-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; align-items: end; }
        .search-field { display: flex; flex-direction: column; gap: 8px; }
        .search-field label { display: flex; align-items: center; gap: 8px; font-weight: 600; font-size: 14px; color: #2d3748; }
        .search-field label i { color: #2c5aa0; }
        .form-select, .form-input { width: 100%; padding: 14px 16px; border: 2px solid #e2e8f0; border-radius: 6px; font-size: 15px; background: #fff; }
        .form-select:focus, .form-input:focus { outline: none; border-color: #2c5aa0; box-shadow: 0 0 0 3px rgba(44,90,160,0.1); }
        .search-btn-full { display: flex; align-items: center; justify-content: center; gap: 10px; padding: 14px 24px; background: #ff6b35; border: none; border-radius: 8px; color: #fff; font-weight: 700; font-size: 16px; cursor: pointer; width: 100%; transition: all 0.3s; }
        .search-btn-full:hover { background: #ff5722; transform: translateY(-2px); }
        
        /* Stats */
        .stats-section { padding: 80px 0; background: #f7fafc; }
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 32px; }
        .stat-item { display: flex; align-items: center; gap: 20px; padding: 24px; background: #fff; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); transition: all 0.3s; }
        .stat-item:hover { transform: translateY(-4px); box-shadow: 0 10px 15px rgba(0,0,0,0.1); }
        .stat-icon { width: 60px; height: 60px; display: flex; align-items: center; justify-content: center; background: linear-gradient(135deg, #2c5aa0, #4a7bc8); border-radius: 10px; color: #fff; font-size: 24px; }
        .stat-content h3 { font-size: 2rem; font-weight: 800; color: #2d3748; }
        .stat-content p { color: #718096; font-weight: 500; }
        .stat-description { font-size: 0.875rem; color: #a0aec0; font-style: italic; }
        .stat-plus, .stat-rating { display: inline; font-size: 1.5rem; color: #2c5aa0; }
        
        /* Destinations */
        .destinations { padding: 80px 0; background: #f7fafc; }
        .section-header { text-align: center; margin-bottom: 60px; }
        .section-header h2 { font-size: 2.5rem; font-weight: 700; color: #2c3e50; margin-bottom: 16px; }
        .section-header p { font-size: 1.125rem; color: #7f8c8d; }
        .destination-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 24px; margin-bottom: 40px; }
        .destination-card { background: #fff; border-radius: 10px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.1); transition: all 0.3s; cursor: pointer; }
        .destination-card:hover { transform: translateY(-8px); box-shadow: 0 10px 30px rgba(0,0,0,0.15); }
        .destination-image { position: relative; height: 200px; }
        .destination-overlay { position: absolute; top: 0; left: 0; right: 0; bottom: 0; display: flex; align-items: flex-start; justify-content: flex-end; padding: 16px; }
        .destination-badge { padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; color: #fff; }
        .destination-badge.trending { background: linear-gradient(135deg, #ff6b35, #f7931e); }
        .destination-badge.premium { background: linear-gradient(135deg, #ffc107, #fd7e14); }
        .destination-info { padding: 24px; }
        .destination-info h3 { font-size: 1.25rem; font-weight: 700; color: #2d3748; margin-bottom: 8px; }
        .destination-info p { color: #718096; margin-bottom: 16px; }
        .destination-details { display: flex; justify-content: space-between; align-items: center; }
        .tour-count { font-size: 14px; color: #a0aec0; }
        .price-from { font-size: 16px; font-weight: 700; color: #2c5aa0; }
        .section-footer { text-align: center; }
        .btn-view-all { display: inline-flex; align-items: center; gap: 12px; padding: 16px 32px; background: linear-gradient(135deg, #2c5aa0, #1e4070); color: #fff; text-decoration: none; border-radius: 10px; font-weight: 600; transition: all 0.3s; }
        .btn-view-all:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(0,102,204,0.4); }
        
        /* Footer */
        .footer { background: #2d3748; color: #fff; padding: 60px 0 20px; }
        .footer-content { display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 40px; margin-bottom: 40px; }
        .footer-brand p { color: rgba(255,255,255,0.8); line-height: 1.6; margin-bottom: 24px; }
        .social-links { display: flex; gap: 12px; }
        .social-links a { width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; background: rgba(255,255,255,0.1); border-radius: 6px; color: #fff; text-decoration: none; transition: all 0.2s; }
        .social-links a:hover { background: #2c5aa0; transform: translateY(-2px); }
        .footer-section h4 { font-size: 1.125rem; font-weight: 700; margin-bottom: 20px; }
        .footer-section ul { list-style: none; }
        .footer-section ul li { margin-bottom: 12px; }
        .footer-section ul li a { color: rgba(255,255,255,0.8); text-decoration: none; transition: all 0.2s; display: flex; align-items: center; gap: 8px; }
        .footer-section ul li a:hover { color: #00d4aa; transform: translateX(4px); }
        .footer-section ul li i { width: 16px; color: #00d4aa; }
        .footer-bottom { border-top: 1px solid rgba(255,255,255,0.1); padding-top: 20px; }
        .footer-bottom-content { display: flex; justify-content: space-between; align-items: center; }
        .footer-bottom p { color: rgba(255,255,255,0.6); font-size: 14px; }
        .footer-links { display: flex; gap: 24px; }
        .footer-links a { color: rgba(255,255,255,0.6); text-decoration: none; font-size: 14px; transition: all 0.2s; }
        .footer-links a:hover { color: #00d4aa; }
        
        @media (max-width: 768px) {
            .nav-menu { display: none; }
            .hero-text h1 { font-size: 2.5rem; }
            .search-grid { grid-template-columns: 1fr; }
            .stats-grid { grid-template-columns: 1fr; }
            .destination-grid { grid-template-columns: 1fr; }
            .footer-content { grid-template-columns: 1fr; text-align: center; }
        }
    </style>
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
                <a href="index.jsp" class="nav-item active">Trang chủ</a>
                <a href="tour?action=list" class="nav-item">Tours</a>
                <% if (isLoggedIn && isAdmin) { %>
                    <a href="admin/customers" class="nav-item">Khách hàng</a>
                    <a href="history.jsp" class="nav-item">Lịch sử</a>
                <% } else if (isLoggedIn) { %>
                    <a href="profile" class="nav-item">Profile</a>
                <% } %>
            </nav>
            <div class="nav-actions">
                <% if (isLoggedIn) { %>
                    <span class="user-badge"><%= u.username %></span>
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
                <h1>Khám phá Đà Nẵng cùng VietAir</h1>
                <p>Trải nghiệm những tour du lịch tuyệt vời với giá tốt nhất</p>
            </div>

            <!-- Search Container -->
            <div class="search-container">
                <div class="search-header">
                    <h3>Tìm tour du lịch trong mơ của bạn</h3>
                </div>

                <!-- Search Form -->
                <form class="search-form" action="tour" method="get">
                    <input type="hidden" name="action" value="search">
                    <div class="search-grid">
                        <div class="search-field">
                            <label>
                                <i class="fas fa-map-marker-alt"></i>
                                Điểm đến
                            </label>
                            <div class="input-wrapper">
                                <select name="destination" class="form-select">
                                    <option value="">Chọn điểm đến</option>
                                    <option value="Bà Nà Hills">Bà Nà Hills</option>
                                    <option value="Ngũ Hành Sơn">Ngũ Hành Sơn</option>
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
                                <input type="date" name="startDate" class="form-input">
                            </div>
                        </div>

                        <div class="search-field">
                            <label>
                                <i class="fas fa-users"></i>
                                Số người
                            </label>
                            <div class="input-wrapper">
                                <select name="numPeople" class="form-select">
                                    <option value="1">1 người</option>
                                    <option value="2" selected>2 người</option>
                                    <option value="3">3 người</option>
                                    <option value="4">4 người</option>
                                    <option value="5">5+ người</option>
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
            </div>
        </div>
    </section>

    <!-- Quick Stats -->
    <section class="stats-section">
        <div class="container">
            <div class="stats-grid">
                <div class="stat-item professional-stat">
                    <div class="stat-icon professional-icon">
                        <i class="fas fa-map-marked-alt"></i>
                    </div>
                    <div class="stat-content">
                        <h3 class="stat-number">432</h3>
                        <p class="stat-label">Tours đã tổ chức</p>
                        <span class="stat-description">Từ 2020-2025</span>
                    </div>
                </div>

                <div class="stat-item professional-stat">
                    <div class="stat-icon professional-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-content">
                        <h3 class="stat-number">15K<span class="stat-plus">+</span></h3>
                        <p class="stat-label">Khách hàng</p>
                        <span class="stat-description">Hài lòng với dịch vụ</span>
                    </div>
                </div>

                <div class="stat-item professional-stat">
                    <div class="stat-icon professional-icon">
                        <i class="fas fa-globe-americas"></i>
                    </div>
                    <div class="stat-content">
                        <h3 class="stat-number">6</h3>
                        <p class="stat-label">Điểm đến</p>
                        <span class="stat-description">Khắp Đà Nẵng</span>
                    </div>
                </div>

                <div class="stat-item professional-stat">
                    <div class="stat-icon professional-icon">
                        <i class="fas fa-star"></i>
                    </div>
                    <div class="stat-content">
                        <h3 class="stat-number">4.9<span class="stat-rating">/5</span></h3>
                        <p class="stat-label">Đánh giá</p>
                        <span class="stat-description">Chất lượng xuất sắc</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Popular Destinations -->
    <section class="destinations">
        <div class="container">
            <div class="section-header">
                <h2>Điểm đến phổ biến</h2>
                <p>Khám phá những địa điểm du lịch nổi tiếng nhất Đà Nẵng</p>
            </div>
            <div class="destination-grid">
                <div class="destination-card" onclick="window.location.href='tour?action=search&destination=Bà Nà Hills'">
                    <div class="destination-image" style="background: linear-gradient(135deg, rgba(102, 126, 234, 0.9), rgba(118, 75, 162, 0.9));">
                        <div class="destination-overlay">
                            <span class="destination-badge trending">Hot</span>
                        </div>
                    </div>
                    <div class="destination-info">
                        <h3>Bà Nà Hills</h3>
                        <p>Thiên đường trên mây với cầu Vàng nổi tiếng</p>
                        <div class="destination-details">
                            <span class="tour-count"><i class="fas fa-map-signs"></i> 50+ tours</span>
                            <span class="price-from">Từ 800K</span>
                        </div>
                    </div>
                </div>

                <div class="destination-card" onclick="window.location.href='tour?action=search&destination=Ngũ Hành Sơn'">
                    <div class="destination-image" style="background: linear-gradient(135deg, rgba(79, 172, 254, 0.9), rgba(0, 242, 254, 0.9));">
                        <div class="destination-overlay">
                            <span class="destination-badge premium">Premium</span>
                        </div>
                    </div>
                    <div class="destination-info">
                        <h3>Ngũ Hành Sơn</h3>
                        <p>Quần thể núi đá vôi với động Am Phủ huyền bí</p>
                        <div class="destination-details">
                            <span class="tour-count"><i class="fas fa-map-signs"></i> 30+ tours</span>
                            <span class="price-from">Từ 300K</span>
                        </div>
                    </div>
                </div>

                <div class="destination-card" onclick="window.location.href='tour?action=search&destination=Cù Lao Chàm'">
                    <div class="destination-image" style="background: linear-gradient(135deg, rgba(67, 233, 123, 0.9), rgba(56, 249, 215, 0.9));">
                        <div class="destination-overlay">
                            <span class="destination-badge trending">Hot</span>
                        </div>
                    </div>
                    <div class="destination-info">
                        <h3>Cù Lao Chàm</h3>
                        <p>Đảo xanh với biển trong xanh và san hô tuyệt đẹp</p>
                        <div class="destination-details">
                            <span class="tour-count"><i class="fas fa-map-signs"></i> 25+ tours</span>
                            <span class="price-from">Từ 500K</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="section-footer">
                <a href="tour?action=list" class="btn-view-all">
                    Xem tất cả tours
                    <i class="fas fa-arrow-right"></i>
                </a>
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
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
                <div class="footer-section">
                    <h4>Về chúng tôi</h4>
                    <ul>
                        <li><a href="#"><i class="fas fa-angle-right"></i> Giới thiệu</a></li>
                        <li><a href="#"><i class="fas fa-angle-right"></i> Điều khoản</a></li>
                        <li><a href="#"><i class="fas fa-angle-right"></i> Chính sách</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h4>Dịch vụ</h4>
                    <ul>
                        <li><a href="tour?action=list"><i class="fas fa-angle-right"></i> Tours</a></li>
                        <li><a href="#"><i class="fas fa-angle-right"></i> Đặt tour</a></li>
                        <li><a href="#"><i class="fas fa-angle-right"></i> Hỗ trợ</a></li>
                    </ul>
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
                    <div class="footer-links">
                        <a href="#">Privacy</a>
                        <a href="#">Terms</a>
                        <a href="#">Support</a>
                    </div>
                </div>
            </div>
        </div>
    </footer>
</body>
</html>