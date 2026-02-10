<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    HttpSession s = request.getSession(false);
    User currentUser = (s == null) ? null : (User) s.getAttribute("user");
    String role = (currentUser != null) ? currentUser.roleName : "GUEST";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VietAir - Hệ thống quản lý tour du lịch hàng đầu Việt Nam</title>
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
                <a href="index.jsp" class="nav-item active">Trang chủ</a>
                <a href="tour?action=list" class="nav-item">Tours</a>
                <a href="customer?action=dashboard" class="nav-item">Khách hàng</a>
                <a href="booking?action=list" class="nav-item">Booking</a>
            </nav>
            <div class="nav-actions">
                <% if (currentUser == null) { %>
                    <a href="login.jsp" class="btn-login" style="text-decoration: none; display: flex; align-items: center; gap: 6px;">
                        <i class="fas fa-sign-in-alt"></i>
                        Đăng Nhập
                    </a>
                <% } else { %>
                    <div style="display: flex; align-items: center; gap: 15px; color: white;">
                        <span style="font-weight: 600;"><%= currentUser.username %></span>
                        <span style="background: rgba(255,255,255,0.2); padding: 4px 12px; border-radius: 20px; font-size: 13px;"><%= role %></span>
                        <a href="logout" style="color: white; text-decoration: none; padding: 8px 16px; background: rgba(255,255,255,0.15); border-radius: 6px; display: flex; align-items: center; gap: 6px;">
                            <i class="fas fa-sign-out-alt"></i> Đăng xuất
                        </a>
                    </div>
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
            </div>
            
            <div class="service-tabs">
                <button class="tab-btn active" data-tab="tour">
                    <i class="fas fa-map-marked-alt"></i>
                    <span>Tour du lịch</span>
                </button>
            </div>

            <div class="search-container">
                <div class="search-header">
                    <h3>Tìm tour du lịch trong mơ của bạn</h3>
                    <div class="search-tabs">
                        <button class="search-tab active" id="searchTab">Tìm kiếm Tour</button>
                        <button class="search-tab" id="featuredTab">Tour nổi bật</button>
                    </div>
                </div>
                
                <!-- Search Form -->
                <form class="search-form" id="searchForm" action="tour?action=list" method="get">
                    <div class="search-grid" style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 1rem; align-items: end;">
                        <div class="search-field destination-field">
                            <label style="display: flex; align-items: center; gap: 6px; margin-bottom: 8px; font-weight: 600; color: #2c3e50;">
                                <i class="fas fa-map-marker-alt" style="color: #ff6b35;"></i>
                                <span>Điểm đến</span>
                            </label>
                            <div class="input-wrapper">
                                <input type="text" name="destination" placeholder="Bạn muốn đi đâu?" list="destinations" style="width: 100%; padding: 14px 16px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 15px; transition: all 0.3s;">
                                <datalist id="destinations">
                                    <option value="Hải Châu">Hải Châu - Trung tâm Đà Nẵng</option>
                                    <option value="Thanh Khê">Thanh Khê - Khu đô thị hiện đại</option>
                                    <option value="Sơn Trà">Sơn Trà - Bán đảo Sơn Trà</option>
                                    <option value="Ngũ Hành Sơn">Ngũ Hành Sơn - Núi Ngũ Hành Sơn</option>
                                    <option value="Liên Chiểu">Liên Chiểu - Khu vực sân bay</option>
                                    <option value="Cẩm Lệ">Cẩm Lệ - Khu vực nông thôn đô thị</option>
                                    <option value="Hòa Vang">Hòa Vang - Bà Nà Hills</option>
                                    <option value="Hoàng Sa">Hoàng Sa - Quần đảo Hoàng Sa</option>
                                </datalist>
                            </div>
                        </div>
                        
                        <div class="search-field">
                            <label style="display: flex; align-items: center; gap: 6px; margin-bottom: 8px; font-weight: 600; color: #2c3e50;">
                                <i class="fas fa-calendar-alt" style="color: #ff6b35;"></i>
                                <span>Ngày khởi hành</span>
                            </label>
                            <div class="input-wrapper">
                                <input type="date" name="startDate" value="2026-02-04" style="width: 100%; padding: 14px 16px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 15px; transition: all 0.3s;">
                            </div>
                        </div>
                        
                        <div class="search-field">
                            <label style="display: flex; align-items: center; gap: 6px; margin-bottom: 8px; font-weight: 600; color: #2c3e50;">
                                <i class="fas fa-users" style="color: #ff6b35;"></i>
                                <span>Số người</span>
                            </label>
                            <div class="input-wrapper">
                                <select name="passengers" style="width: 100%; padding: 14px 16px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 15px; transition: all 0.3s; background: white; cursor: pointer;">
                                    <option value="1">1 người</option>
                                    <option value="2" selected>2 người</option>
                                    <option value="3">3 người</option>
                                    <option value="4">4 người</option>
                                    <option value="5">5 người</option>
                                    <option value="6+">6+ người</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="search-field">
                            <label style="display: block; margin-bottom: 8px; height: 24px; opacity: 0;">Tìm kiếm</label>
                            <button type="submit" class="search-btn" style="width: 100%; background: linear-gradient(135deg, #ff6b35 0%, #ff8c42 100%); color: white; padding: 14px 16px; border: none; border-radius: 8px; font-size: 16px; font-weight: 700; cursor: pointer; display: flex; flex-direction: row; align-items: center; justify-content: center; gap: 8px; height: 56px; box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3); transition: all 0.3s;">
                                <i class="fas fa-search" style="font-size: 16px;"></i>
                                <span style="line-height: 1;">Tìm kiếm</span>
                            </button>
                        </div>
                    </div>
                </form>

                <!-- Featured Tours Section -->
                <div class="featured-tours-section" id="featuredToursSection" style="display: none;">
                    <div class="featured-header">
                        <h4>🌟 Tour nổi bật được yêu thích nhất</h4>
                        <p>Những tour du lịch hot nhất với đánh giá cao từ khách hàng</p>
                    </div>
                    <div class="featured-tours-grid" id="featuredToursGrid">
                        <!-- 6 tour cards sẽ được hiển thị ở đây -->
                        <div class="featured-tour-item">
                            <div class="featured-tour-image">
                                <img src="https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=300&h=200&fit=crop" alt="Bà Nà Hills">
                                <div class="featured-badge hot">🔥 HOT</div>
                            </div>
                            <div class="featured-tour-content">
                                <h4>Tour Bà Nà Hills</h4>
                                <p class="featured-location">
                                    <i class="fas fa-map-marker-alt"></i>
                                    Hòa Vang, Đà Nẵng
                                </p>
                                <div class="featured-price">
                                    <span class="price">1.800.000 VNĐ</span>
                                    <span class="duration">3N2Đ</span>
                                </div>
                                <div class="featured-rating">
                                    <div class="stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <span class="rating-text">4.9 (234 đánh giá)</span>
                                </div>
                                <a href="tour?action=view&id=1" class="btn-book-now">
                                    <i class="fas fa-info-circle"></i> Xem chi tiết
                                </a>
                            </div>
                        </div>
                        
                        <div class="featured-tour-item">
                            <div class="featured-tour-image">
                                <img src="https://images.unsplash.com/photo-1552465011-b4e21bf6e79a?w=300&h=200&fit=crop" alt="Sơn Trà">
                                <div class="featured-badge best">⭐ BEST</div>
                            </div>
                            <div class="featured-tour-content">
                                <h4>Tour Bán đảo Sơn Trà</h4>
                                <p class="featured-location">
                                    <i class="fas fa-map-marker-alt"></i>
                                    Sơn Trà, Đà Nẵng
                                </p>
                                <div class="featured-price">
                                    <span class="price">2.200.000 VNĐ</span>
                                    <span class="duration">4N3Đ</span>
                                </div>
                                <div class="featured-rating">
                                    <div class="stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <span class="rating-text">4.8 (189 đánh giá)</span>
                                </div>
                                <a href="tour?action=view&id=2" class="btn-book-now">
                                    <i class="fas fa-info-circle"></i> Xem chi tiết
                                </a>
                            </div>
                        </div>
                        
                        <div class="featured-tour-item">
                            <div class="featured-tour-image">
                                <img src="https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&h=200&fit=crop" alt="Ngũ Hành Sơn">
                                <div class="featured-badge new">🌟 NEW</div>
                            </div>
                            <div class="featured-tour-content">
                                <h4>Tour Ngũ Hành Sơn</h4>
                                <p class="featured-location">
                                    <i class="fas fa-map-marker-alt"></i>
                                    Ngũ Hành Sơn, Đà Nẵng
                                </p>
                                <div class="featured-price">
                                    <span class="price">2.000.000 VNĐ</span>
                                    <span class="duration">3N2Đ</span>
                                </div>
                                <div class="featured-rating">
                                    <div class="stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <span class="rating-text">4.9 (156 đánh giá)</span>
                                </div>
                                <a href="tour?action=view&id=3" class="btn-book-now">
                                    <i class="fas fa-info-circle"></i> Xem chi tiết
                                </a>
                            </div>
                        </div>
                        
                        <div class="featured-tour-item">
                            <div class="featured-tour-image">
                                <img src="https://images.unsplash.com/photo-1555881400-74d7acaacd8b?w=300&h=200&fit=crop" alt="Hải Châu">
                                <div class="featured-badge vip">💎 VIP</div>
                            </div>
                            <div class="featured-tour-content">
                                <h4>Tour Trung tâm Hải Châu</h4>
                                <p class="featured-location">
                                    <i class="fas fa-map-marker-alt"></i>
                                    Hải Châu, Đà Nẵng
                                </p>
                                <div class="featured-price">
                                    <span class="price">1.800.000 VNĐ</span>
                                    <span class="duration">3N2Đ</span>
                                </div>
                                <div class="featured-rating">
                                    <div class="stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                    </div>
                                    <span class="rating-text">4.7 (142 đánh giá)</span>
                                </div>
                                <a href="tour?action=view&id=4" class="btn-book-now">
                                    <i class="fas fa-info-circle"></i> Xem chi tiết
                                </a>
                            </div>
                        </div>
                        
                        <div class="featured-tour-item">
                            <div class="featured-tour-image">
                                <img src="https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=300&h=200&fit=crop" alt="Mỹ Khê">
                                <div class="featured-badge sale">🎯 SALE</div>
                            </div>
                            <div class="featured-tour-content">
                                <h4>Tour Bãi biển Mỹ Khê</h4>
                                <p class="featured-location">
                                    <i class="fas fa-map-marker-alt"></i>
                                    Ngũ Hành Sơn, Đà Nẵng
                                </p>
                                <div class="featured-price">
                                    <span class="price">1.500.000 VNĐ</span>
                                    <span class="duration">2N1Đ</span>
                                </div>
                                <div class="featured-rating">
                                    <div class="stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <span class="rating-text">4.8 (167 đánh giá)</span>
                                </div>
                                <a href="tour?action=view&id=5" class="btn-book-now">
                                    <i class="fas fa-info-circle"></i> Xem chi tiết
                                </a>
                            </div>
                        </div>
                        
                        <div class="featured-tour-item">
                            <div class="featured-tour-image">
                                <img src="https://images.unsplash.com/photo-1528127269322-539801943592?w=300&h=200&fit=crop" alt="Chùa Linh Ứng">
                                <div class="featured-badge top">🏆 TOP</div>
                            </div>
                            <div class="featured-tour-content">
                                <h4>Tour Chùa Linh Ứng</h4>
                                <p class="featured-location">
                                    <i class="fas fa-map-marker-alt"></i>
                                    Sơn Trà, Đà Nẵng
                                </p>
                                <div class="featured-price">
                                    <span class="price">1.200.000 VNĐ</span>
                                    <span class="duration">1N</span>
                                </div>
                                <div class="featured-rating">
                                    <div class="stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <span class="rating-text">4.9 (201 đánh giá)</span>
                                </div>
                                <a href="tour?action=view&id=6" class="btn-book-now">
                                    <i class="fas fa-info-circle"></i> Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="featured-footer">
                        <a href="tour?action=list" class="btn-view-featured">
                            Xem tất cả tour nổi bật
                            <i class="fas fa-arrow-right"></i>
                        </a>
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
                        <div class="stat-pattern"></div>
                    </div>
                    <div class="stat-icon professional-icon">
                        <i class="fas fa-globe-americas"></i>
                    </div>
                    <div class="stat-content">
                        <h3 class="stat-number">15+</h3>
                        <p class="stat-label">Tour du lịch</p>
                        <span class="stat-description">Điểm đến hấp dẫn</span>
                    </div>
                </div>
                
                <div class="stat-item professional-stat">
                    <div class="stat-background">
                        <div class="stat-gradient stat-gradient-2"></div>
                        <div class="stat-pattern"></div>
                    </div>
                    <div class="stat-icon professional-icon">
                        <i class="fas fa-heart"></i>
                    </div>
                    <div class="stat-content">
                        <h3 class="stat-number">1000+</h3>
                        <p class="stat-label">Khách hàng hài lòng</p>
                        <span class="stat-description">Tin tưởng VietAir</span>
                    </div>
                </div>
                
                <div class="stat-item professional-stat">
                    <div class="stat-background">
                        <div class="stat-gradient stat-gradient-3"></div>
                        <div class="stat-pattern"></div>
                    </div>
                    <div class="stat-icon professional-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="stat-content">
                        <h3 class="stat-number">500+</h3>
                        <p class="stat-label">Tour đã thực hiện</p>
                        <span class="stat-description">Chuyến đi thành công</span>
                    </div>
                </div>
                
                <div class="stat-item professional-stat">
                    <div class="stat-background">
                        <div class="stat-gradient stat-gradient-4"></div>
                        <div class="stat-pattern"></div>
                    </div>
                    <div class="stat-icon professional-icon">
                        <i class="fas fa-star"></i>
                    </div>
                    <div class="stat-content">
                        <h3 class="stat-number">4.9/5</h3>
                        <p class="stat-label">Đánh giá từ khách hàng</p>
                        <span class="stat-description">Chất lượng xuất sắc</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Quick Actions -->
    <section class="quick-actions">
        <div class="container">
            <div class="section-header">
                <h2>Hệ thống quản lý VietAir - Đà Nẵng</h2>
                <p>Quản lý tours, khách hàng và booking trong phạm vi thành phố Đà Nẵng</p>
            </div>
            <div class="action-grid">
                <a href="tour?action=list" class="action-card tour-card">
                    <div class="card-background"></div>
                    <div class="card-overlay">
                        <div class="card-icon">
                            <i class="fas fa-globe-asia"></i>
                        </div>
                        <div class="card-content">
                            <h3>Quản lý Tours</h3>
                            <p>Khám phá và quản lý các tour du lịch trong thành phố Đà Nẵng</p>
                            <div class="card-stats">
                                <span class="stat-badge">8 quận/huyện</span>
                                <span class="stat-text">Trong thành phố Đà Nẵng</span>
                            </div>
                            <div class="card-features">
                                <span class="feature-item">🏔️ Bà Nà Hills</span>
                                <span class="feature-item">🏖️ Bãi biển Mỹ Khê</span>
                            </div>
                        </div>
                    </div>
                </a>
                
                <a href="customer?action=dashboard" class="action-card customer-card">
                    <div class="card-background"></div>
                    <div class="card-overlay">
                        <div class="card-icon">
                            <i class="fas fa-user-friends"></i>
                        </div>
                        <div class="card-content">
                            <h3>Quản lý Khách hàng</h3>
                            <p>Chăm sóc và quản lý thông tin khách hàng thân thiết tại Đà Nẵng</p>
                            <div class="card-stats">
                                <span class="stat-badge">20+ khách hàng</span>
                            </div>
                        </div>
                    </div>
                </a>
                
                <a href="booking?action=list" class="action-card booking-card">
                    <div class="card-background"></div>
                    <div class="card-overlay">
                        <div class="card-icon">
                            <i class="fas fa-ticket-alt"></i>
                        </div>
                        <div class="card-content">
                            <h3>Quản lý Booking</h3>
                            <p>Theo dõi và quản lý tất cả vé đặt tour</p>
                            <div class="card-stats">
                                <span class="stat-badge">50+ booking</span>
                            </div>
                        </div>
                    </div>
                </a>
                
                <a href="customer?action=ranking" class="action-card featured-card">
                    <div class="card-background"></div>
                    <div class="card-overlay">
                        <div class="card-icon">
                            <i class="fas fa-crown"></i>
                        </div>
                        <div class="card-content">
                            <h3>Ranking Khách hàng</h3>
                            <p>Xếp hạng và vinh danh khách hàng thân thiết</p>
                            <div class="card-stats">
                                <span class="stat-badge">Top Ranking</span>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </section>

    <!-- Popular Tours -->
    <section class="destinations">
        <div class="container">
            <div class="section-header professional-header">
                <h2>Tour nổi bật Đà Nẵng</h2>
                <p>Khám phá những điểm đến tuyệt vời trong thành phố Đà Nẵng</p>
                <div class="header-decoration">
                    <div class="decoration-line-left"></div>
                    <div class="decoration-center">✈️</div>
                    <div class="decoration-line-right"></div>
                </div>
            </div>
            <div class="destination-grid professional-tours">
                <div class="destination-card professional-tour-card" onclick="window.location.href='tour?action=view&id=1'" style="cursor: pointer;">
                    <div class="tour-card-badge">🔥 HOT</div>
                    <div class="tour-card-background">
                        <img src="https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=500&h=400&fit=crop&auto=format" alt="Bà Nà Hills" class="tour-bg-image">
                        <div class="tour-overlay"></div>
                        <div class="tour-gradient-overlay"></div>
                    </div>
                    <div class="tour-content">
                        <div class="tour-location">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Hòa Vang, Đà Nẵng</span>
                        </div>
                        <h3>Tour Bà Nà Hills</h3>
                        <p>Khám phá Bà Nà Hills với Cầu Vàng nổi tiếng và khu vui chơi Fantasy Park</p>
                        <div class="tour-details">
                            <div class="tour-price">
                                <span class="price-label">Từ</span>
                                <span class="price-amount">1.800.000</span>
                                <span class="price-currency">VNĐ</span>
                            </div>
                            <div class="tour-duration">
                                <i class="fas fa-clock"></i>
                                <span>3N2Đ</span>
                            </div>
                        </div>
                        <div class="tour-features">
                            <span class="feature-tag">🏔️ Núi</span>
                            <span class="feature-tag">🎢 Vui chơi</span>
                        </div>
                    </div>
                    <div class="tour-action">
                        <i class="fas fa-arrow-right"></i>
                    </div>
                </div>
                
                <div class="destination-card professional-tour-card" onclick="window.location.href='tour?action=view&id=2'" style="cursor: pointer;">
                    <div class="tour-card-badge">⭐ BEST</div>
                    <div class="tour-card-background">
                        <img src="https://images.unsplash.com/photo-1552465011-b4e21bf6e79a?w=500&h=400&fit=crop&auto=format" alt="Bán đảo Sơn Trà" class="tour-bg-image">
                        <div class="tour-overlay"></div>
                        <div class="tour-gradient-overlay"></div>
                    </div>
                    <div class="tour-content">
                        <div class="tour-location">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Sơn Trà, Đà Nẵng</span>
                        </div>
                        <h3>Tour Bán đảo Sơn Trà</h3>
                        <p>Khám phá bán đảo Sơn Trà với chùa Linh Ứng và bãi biển tuyệt đẹp</p>
                        <div class="tour-details">
                            <div class="tour-price">
                                <span class="price-label">Từ</span>
                                <span class="price-amount">2.200.000</span>
                                <span class="price-currency">VNĐ</span>
                            </div>
                            <div class="tour-duration">
                                <i class="fas fa-clock"></i>
                                <span>4N3Đ</span>
                            </div>
                        </div>
                        <div class="tour-features">
                            <span class="feature-tag">🏖️ Biển</span>
                            <span class="feature-tag">🙏 Chùa</span>
                        </div>
                    </div>
                    <div class="tour-action">
                        <i class="fas fa-arrow-right"></i>
                    </div>
                </div>
                
                <div class="destination-card professional-tour-card" onclick="window.location.href='tour?action=view&id=3'" style="cursor: pointer;">
                    <div class="tour-card-badge">🌟 NEW</div>
                    <div class="tour-card-background">
                        <img src="https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=500&h=400&fit=crop&auto=format" alt="Ngũ Hành Sơn" class="tour-bg-image">
                        <div class="tour-overlay"></div>
                        <div class="tour-gradient-overlay"></div>
                    </div>
                    <div class="tour-content">
                        <div class="tour-location">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Ngũ Hành Sơn, Đà Nẵng</span>
                        </div>
                        <h3>Tour Ngũ Hành Sơn</h3>
                        <p>Khám phá 5 ngọn núi đá vôi với động Huyền Không và chùa Tam Thai</p>
                        <div class="tour-details">
                            <div class="tour-price">
                                <span class="price-label">Từ</span>
                                <span class="price-amount">2.000.000</span>
                                <span class="price-currency">VNĐ</span>
                            </div>
                            <div class="tour-duration">
                                <i class="fas fa-clock"></i>
                                <span>3N2Đ</span>
                            </div>
                        </div>
                        <div class="tour-features">
                            <span class="feature-tag">🏊 Bơi lội</span>
                            <span class="feature-tag">🐠 Lặn biển</span>
                        </div>
                    </div>
                    <div class="tour-action">
                        <i class="fas fa-arrow-right"></i>
                    </div>
                </div>
                
                <div class="destination-card professional-tour-card" onclick="window.location.href='tour?action=view&id=4'" style="cursor: pointer;">
                    <div class="tour-card-badge">💎 VIP</div>
                    <div class="tour-card-background">
                        <img src="https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=500&h=400&fit=crop&auto=format" alt="Hải Châu" class="tour-bg-image">
                        <div class="tour-overlay"></div>
                        <div class="tour-gradient-overlay"></div>
                    </div>
                    <div class="tour-content">
                        <div class="tour-location">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Hải Châu, Đà Nẵng</span>
                        </div>
                        <h3>Tour Trung tâm Hải Châu</h3>
                        <p>Khám phá trung tâm thành phố với chợ Hàn, cầu Rồng và ẩm thực đường phố</p>
                        <div class="tour-details">
                            <div class="tour-price">
                                <span class="price-label">Từ</span>
                                <span class="price-amount">1.800.000</span>
                                <span class="price-currency">VNĐ</span>
                            </div>
                            <div class="tour-duration">
                                <i class="fas fa-clock"></i>
                                <span>3N2Đ</span>
                            </div>
                        </div>
                        <div class="tour-features">
                            <span class="feature-tag">🏙️ Thành phố</span>
                            <span class="feature-tag">🍜 Ẩm thực</span>
                        </div>
                    </div>
                    <div class="tour-action">
                        <i class="fas fa-arrow-right"></i>
                    </div>
                </div>
            </div>
            <div class="section-footer professional-footer">
                <a href="tour?action=list" class="btn-view-all professional-btn">
                    <span>Khám phá tất cả tour</span>
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
                    <p>Hệ thống đặt tour du lịch hàng đầu Việt Nam. Khám phá vẻ đẹp đất nước với những trải nghiệm tuyệt vời nhất.</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
                <div class="footer-section">
                    <h4>Về VietAir</h4>
                    <ul>
                        <li><a href="#">Cách đặt tour</a></li>
                        <li><a href="#">Liên hệ chúng tôi</a></li>
                        <li><a href="#">Trợ giúp</a></li>
                        <li><a href="#">Tuyển dụng</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h4>Sản phẩm</h4>
                    <ul>
                        <li><a href="tour?action=list">Tour du lịch</a></li>
                        <li><a href="booking?action=list">Đặt tour</a></li>
                        <li><a href="customer?action=list">Khách hàng</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h4>Liên hệ</h4>
                    <ul>
                        <li><i class="fas fa-phone"></i> 1900 1234</li>
                        <li><i class="fas fa-envelope"></i> support@vietair.vn</li>
                        <li><i class="fas fa-map-marker-alt"></i> Hà Nội, Việt Nam</li>
                        <li><i class="fas fa-clock"></i> 24/7 hỗ trợ</li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <div class="footer-bottom-content">
                    <p>&copy; 2026 VietAir. All rights reserved.</p>
                    <div class="footer-links">
                        <a href="#">Chính sách bảo mật</a>
                        <a href="#">Điều khoản dịch vụ</a>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <script>
        // Tab switching functionality
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
