<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Tour" %>
<%@ page import="model.User" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    HttpSession s = request.getSession(false);
    User currentUser = (s == null) ? null : (User) s.getAttribute("user");
    String role = (currentUser != null) ? currentUser.roleName : "GUEST";
    boolean isAdmin = "ADMIN".equalsIgnoreCase(role);
    boolean isUser = "USER".equalsIgnoreCase(role);
    
    List<Tour> tours = (List<Tour>) request.getAttribute("tours");
    String searchDest = (String) request.getAttribute("searchDestination");
    Boolean availableOnly = (Boolean) request.getAttribute("availableOnly");
    
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VietAir - Tour du lịch</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
        }
        
        /* Navbar */
        .navbar {
            background: linear-gradient(135deg, #0194f3 0%, #0173c7 100%);
            padding: 1rem 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .navbar-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .logo {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: white;
            font-size: 1.5rem;
            font-weight: bold;
            text-decoration: none;
        }
        .nav-menu {
            display: flex;
            gap: 2rem;
            align-items: center;
        }
        .nav-link {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s;
            font-weight: 500;
        }
        .nav-link:hover, .nav-link.active {
            background: rgba(255,255,255,0.2);
        }
        .user-info {
            color: white;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .user-badge {
            background: rgba(255,255,255,0.2);
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.85rem;
        }
        
        /* Page Header */
        .page-header {
            background: linear-gradient(135deg, #0194f3 0%, #0173c7 100%);
            color: white;
            padding: 60px 0 40px;
        }
        .page-header-content h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2rem;
        }
        
        /* Filter Bar */
        .filter-bar {
            background: rgba(255,255,255,0.1);
            border-radius: 12px;
            padding: 20px;
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }
        .view-options {
            display: flex;
            gap: 10px;
        }
        .view-btn {
            background: rgba(255,255,255,0.2);
            color: white;
            padding: 10px 16px;
            border-radius: 6px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: background-color 0.2s;
        }
        .view-btn:hover,
        .view-btn.active {
            background: rgba(255,255,255,0.3);
            color: white;
            text-decoration: none;
        }
        
        /* Tours Section */
        .tours-section {
            padding: 40px 0;
        }
        .tours-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #ddd;
        }
        .tours-count {
            font-size: 1.1rem;
            color: #666;
        }
        
        /* Alert */
        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        /* Tours Grid */
        .tours-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
        }
        .tour-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .tour-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .tour-image {
            position: relative;
            height: 200px;
            overflow: hidden;
        }
        .tour-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .tour-status {
            position: absolute;
            top: 12px;
            right: 12px;
        }
        .tour-status span {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        .status-available {
            background: #28a745;
            color: white;
        }
        .status-limited {
            background: #ffc107;
            color: #333;
        }
        .status-full {
            background: #dc3545;
            color: white;
        }
        .tour-content {
            padding: 20px;
        }
        .tour-title a {
            color: #333;
            text-decoration: none;
            font-size: 1.3rem;
            font-weight: 600;
            line-height: 1.3;
        }
        .tour-title a:hover {
            color: #0194f3;
        }
        .tour-destination {
            color: #666;
            margin-top: 5px;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .tour-details {
            margin: 15px 0;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .tour-details > div {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #666;
            font-size: 14px;
        }
        .tour-details i {
            width: 16px;
            color: #0194f3;
        }
        .tour-description {
            color: #666;
            line-height: 1.5;
            margin: 15px 0;
        }
        .tour-footer {
            border-top: 1px solid #f0f0f0;
            padding-top: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }
        .tour-price {
            display: flex;
            align-items: baseline;
            gap: 5px;
        }
        .price-label {
            color: #666;
            font-size: 14px;
        }
        .price-amount {
            color: #0194f3;
            font-size: 1.4rem;
            font-weight: 700;
        }
        .price-unit {
            color: #666;
            font-size: 14px;
        }
        .tour-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        /* Buttons */
        .btn {
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s;
            border: none;
            cursor: pointer;
        }
        .btn-primary {
            background: #0194f3;
            color: white;
        }
        .btn-primary:hover {
            background: #0173c7;
            color: white;
            text-decoration: none;
        }
        .btn-success {
            background: #28a745;
            color: white;
        }
        .btn-success:hover {
            background: #218838;
            color: white;
            text-decoration: none;
        }
        .btn-warning {
            background: #ffc107;
            color: #333;
        }
        .btn-warning:hover {
            background: #e0a800;
            color: #333;
            text-decoration: none;
        }
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        .btn-danger:hover {
            background: #c82333;
            color: white;
            text-decoration: none;
        }
        .btn-outline {
            background: transparent;
            color: #0194f3;
            border: 1px solid #0194f3;
        }
        .btn-outline:hover {
            background: #0194f3;
            color: white;
            text-decoration: none;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        .empty-state i {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 20px;
        }
        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #333;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="navbar-container">
            <a href="index.jsp" class="logo">
                <i class="fas fa-plane-departure"></i>
                <span>VietAir</span>
            </a>
            <div class="nav-menu">
                <a href="index.jsp" class="nav-link">Trang chủ</a>
                <a href="tour?action=list" class="nav-link active">Tours</a>
                <a href="#" class="nav-link">Khách hàng</a>
                <a href="#" class="nav-link">Booking</a>
            </div>
            <div class="user-info">
                <% if (currentUser == null) { %>
                    <a href="login.jsp" class="nav-link">
                        <i class="fas fa-sign-in-alt"></i> Đăng nhập
                    </a>
                <% } else { %>
                    <span><%= currentUser.username %></span>
                    <span class="user-badge"><%= role %></span>
                    <a href="logout" class="nav-link">
                        <i class="fas fa-sign-out-alt"></i> Đăng xuất
                    </a>
                <% } %>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <div class="page-header-content">
                <h1>
                    <i class="fas fa-map-marked-alt"></i>
                    <% if (searchDest != null && !searchDest.isEmpty()) { %>
                        Tour du lịch "<%= searchDest %>"
                    <% } else if (availableOnly != null && availableOnly) { %>
                        Tour du lịch có sẵn chỗ
                    <% } else { %>
                        Tất cả Tour du lịch
                    <% } %>
                </h1>
                <p>Khám phá những điểm đến tuyệt vời với các tour du lịch chất lượng cao</p>
            </div>
            
            <div class="filter-bar">
                <div class="view-options">
                    <a href="tour?action=list" 
                       class="view-btn <%= (availableOnly == null) ? "active" : "" %>">
                        <i class="fas fa-list"></i> Tất cả
                    </a>
                    <a href="tour?action=available" 
                       class="view-btn <%= (availableOnly != null && availableOnly) ? "active" : "" %>">
                        <i class="fas fa-star"></i> Có sẵn chỗ
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Tours Section -->
    <section class="tours-section">
        <div class="container">
            <% String success = request.getParameter("success");
            if (success != null) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <% if ("created".equals(success)) { %>
                        Tour đã được tạo thành công!
                    <% } else if ("updated".equals(success)) { %>
                        Tour đã được cập nhật thành công!
                    <% } else if ("deleted".equals(success)) { %>
                        Tour đã được xóa thành công!
                    <% } %>
                </div>
            <% } %>

            <div class="tours-header">
                <div class="tours-count">
                    <span>Tìm thấy <strong><%= tours != null ? tours.size() : 0 %></strong> tour du lịch</span>
                </div>
                <% if (isAdmin) { %>
                    <div class="tours-actions">
                        <a href="tour?action=add" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Thêm tour mới
                        </a>
                    </div>
                <% } %>
            </div>

            <% if (tours == null || tours.isEmpty()) { %>
                <div class="empty-state">
                    <i class="fas fa-map-marked-alt"></i>
                    <h3>Không tìm thấy tour nào</h3>
                    <p>Hiện tại chưa có tour nào trong hệ thống.</p>
                    <a href="tour?action=list" class="btn btn-primary">
                        Xem tất cả tour
                    </a>
                </div>
            <% } else { %>
                <div class="tours-grid">
                    <% for (Tour tour : tours) { 
                        boolean isFull = tour.getCurrentCapacity() >= tour.getMaxCapacity();
                        boolean isLimited = tour.getCurrentCapacity() >= tour.getMaxCapacity() * 0.8;
                        long duration = java.time.temporal.ChronoUnit.DAYS.between(tour.getStartDate(), tour.getEndDate()) + 1;
                    %>
                        <div class="tour-card">
                            <div class="tour-image">
                                <img src="https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=250&fit=crop" 
                                     alt="<%= tour.getName() %>">
                                <div class="tour-status">
                                    <% if (isFull) { %>
                                        <span class="status-full">Hết chỗ</span>
                                    <% } else if (isLimited) { %>
                                        <span class="status-limited">Sắp hết chỗ</span>
                                    <% } else { %>
                                        <span class="status-available">Còn chỗ</span>
                                    <% } %>
                                </div>
                            </div>
                            
                            <div class="tour-content">
                                <div class="tour-header">
                                    <h3 class="tour-title">
                                        <a href="tour?action=view&id=<%= tour.getId() %>">
                                            <%= tour.getName() %>
                                        </a>
                                    </h3>
                                    <div class="tour-destination">
                                        <i class="fas fa-map-marker-alt"></i>
                                        <%= tour.getDestination() %>
                                    </div>
                                </div>
                                
                                <div class="tour-details">
                                    <div class="tour-dates">
                                        <i class="fas fa-calendar"></i>
                                        <%= tour.getStartDate().format(formatter) %> - 
                                        <%= tour.getEndDate().format(formatter) %>
                                    </div>
                                    
                                    <div class="tour-capacity">
                                        <i class="fas fa-users"></i>
                                        <%= tour.getCurrentCapacity() %>/<%= tour.getMaxCapacity() %> người
                                    </div>
                                    
                                    <div class="tour-duration">
                                        <i class="fas fa-clock"></i>
                                        <%= duration %> ngày
                                    </div>
                                </div>
                                
                                <div class="tour-description">
                                    <% String desc = tour.getDescription();
                                    if (desc != null && desc.length() > 100) { %>
                                        <%= desc.substring(0, 100) %>...
                                    <% } else { %>
                                        <%= desc != null ? desc : "" %>
                                    <% } %>
                                </div>
                                
                                <div class="tour-footer">
                                    <div class="tour-price">
                                        <span class="price-label">Từ</span>
                                        <span class="price-amount">
                                            <%= String.format("%,.0f", tour.getPrice()) %> VNĐ
                                        </span>
                                        <span class="price-unit">/người</span>
                                    </div>
                                    
                                    <div class="tour-actions">
                                        <a href="tour?action=view&id=<%= tour.getId() %>" 
                                           class="btn btn-outline">
                                            <i class="fas fa-eye"></i> Xem
                                        </a>
                                        
                                        <% if (isAdmin) { %>
                                            <a href="tour?action=edit&id=<%= tour.getId() %>" 
                                               class="btn btn-warning">
                                                <i class="fas fa-edit"></i> Sửa
                                            </a>
                                            <a href="tour?action=delete&id=<%= tour.getId() %>" 
                                               class="btn btn-danger"
                                               onclick="return confirm('Xóa tour này?')">
                                                <i class="fas fa-trash"></i> Xóa
                                            </a>
                                        <% } else if (isUser && !isFull) { %>
                                            <a href="booking?action=form&tourId=<%= tour.getId() %>" 
                                               class="btn btn-success">
                                                <i class="fas fa-calendar-plus"></i> Đặt tour
                                            </a>
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
            <% } %>
        </div>
    </section>
</body>
</html>
