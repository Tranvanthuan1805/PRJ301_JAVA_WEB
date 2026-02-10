<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Tour" %>
<%@ page import="model.User" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%
    HttpSession s = request.getSession(false);
    User currentUser = (s == null) ? null : (User) s.getAttribute("user");
    String role = (currentUser != null) ? currentUser.roleName : "GUEST";
    boolean isAdmin = "ADMIN".equalsIgnoreCase(role);
    boolean isUser = "USER".equalsIgnoreCase(role);
    
    Tour tour = (Tour) request.getAttribute("tour");
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    long duration = ChronoUnit.DAYS.between(tour.getStartDate(), tour.getEndDate()) + 1;
    double occupancyRate = (tour.getCurrentCapacity() * 100.0) / tour.getMaxCapacity();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VietAir - <%= tour.getName() %></title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/vietair-style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: #f8f9fa;
            color: #333;
            line-height: 1.6;
        }
        
        .header {
            background: linear-gradient(135deg, #0194f3 0%, #0173c7 100%);
            padding: 1rem 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .header-content {
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
        .nav {
            display: flex;
            gap: 2rem;
        }
        .nav a {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s;
            font-weight: 500;
        }
        .nav a:hover {
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
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 3rem 2rem;
        }
        
        .tour-hero {
            background: white;
            border-radius: 16px;
            padding: 3rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .tour-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: #0194f3;
            margin-bottom: 1rem;
        }
        .tour-subtitle {
            font-size: 1.2rem;
            color: #666;
            margin-bottom: 2rem;
        }
        
        .tour-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }
        
        .tour-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
        }
        .detail-card {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 12px;
            border-left: 4px solid #0194f3;
        }
        .detail-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            background: #0194f3;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
            margin-bottom: 1rem;
        }
        .detail-label {
            font-weight: 600;
            color: #666;
            font-size: 0.9rem;
            text-transform: uppercase;
            margin-bottom: 0.5rem;
        }
        .detail-value {
            font-size: 1.1rem;
            font-weight: 600;
            color: #333;
        }
        
        .price-card {
            background: linear-gradient(135deg, #0194f3, #0173c7);
            color: white;
            padding: 2rem;
            border-radius: 16px;
            text-align: center;
        }
        .price-label {
            font-size: 1rem;
            opacity: 0.9;
            margin-bottom: 1rem;
            text-transform: uppercase;
        }
        .price-amount {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        .price-per {
            font-size: 1rem;
            opacity: 0.8;
        }
        .capacity-indicator {
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(255,255,255,0.2);
        }
        .capacity-bar {
            width: 100%;
            height: 8px;
            background: rgba(255,255,255,0.3);
            border-radius: 4px;
            overflow: hidden;
            margin-bottom: 0.5rem;
        }
        .capacity-fill {
            height: 100%;
            background: white;
            border-radius: 4px;
            transition: width 0.3s ease;
        }
        .capacity-text {
            font-size: 0.9rem;
            opacity: 0.9;
        }
        
        .status-section {
            margin: 2rem 0;
        }
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.8rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
        }
        .status-available {
            background: #28a745;
            color: white;
        }
        .status-full {
            background: #dc3545;
            color: white;
        }
        
        .description-card {
            background: white;
            padding: 2rem;
            border-radius: 16px;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .description-card h3 {
            font-size: 1.5rem;
            font-weight: 600;
            color: #0194f3;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .description-card p {
            font-size: 1.1rem;
            line-height: 1.8;
            color: #666;
        }
        
        .actions {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            justify-content: center;
        }
        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background: #28a745;
            color: white;
        }
        .btn-primary:hover {
            background: #218838;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(40,167,69,0.3);
            color: white;
            text-decoration: none;
        }
        .btn-warning {
            background: #ffc107;
            color: #333;
        }
        .btn-warning:hover {
            background: #e0a800;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255,193,7,0.3);
            color: #333;
            text-decoration: none;
        }
        .btn-secondary {
            background: white;
            color: #0194f3;
            border: 2px solid #0194f3;
        }
        .btn-secondary:hover {
            background: #0194f3;
            color: white;
            transform: translateY(-2px);
            text-decoration: none;
        }
        
        @media (max-width: 1024px) {
            .tour-grid { grid-template-columns: 1fr; }
            .tour-title { font-size: 2rem; }
        }
        
        @media (max-width: 768px) {
            .container { padding: 2rem 1rem; }
            .tour-hero { padding: 2rem; }
            .tour-title { font-size: 1.8rem; }
            .price-amount { font-size: 2rem; }
            .actions { flex-direction: column; }
            .nav { display: none; }
            .tour-details { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <a href="<%= request.getContextPath() %>/index.jsp" class="logo">
                <i class="fas fa-plane-departure"></i> VietAir
            </a>
            <nav class="nav">
                <a href="<%= request.getContextPath() %>/index.jsp"><i class="fas fa-home"></i> Trang chủ</a>
                <a href="<%= request.getContextPath() %>/tour?action=list"><i class="fas fa-map-marked-alt"></i> Tours</a>
            </nav>
            <div class="user-info">
                <% if (currentUser == null) { %>
                    <a href="<%= request.getContextPath() %>/login.jsp" style="color: white; text-decoration: none;">
                        <i class="fas fa-sign-in-alt"></i> Đăng nhập
                    </a>
                <% } else { %>
                    <span><%= currentUser.username %></span>
                    <span class="user-badge"><%= role %></span>
                    <a href="<%= request.getContextPath() %>/logout" style="color: white; text-decoration: none;">
                        <i class="fas fa-sign-out-alt"></i> Đăng xuất
                    </a>
                <% } %>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="tour-hero">
            <h1 class="tour-title"><%= tour.getName() %></h1>
            <p class="tour-subtitle">Khám phá vẻ đẹp <%= tour.getDestination() %> cùng VietAir</p>
            
            <div class="tour-grid">
                <div class="tour-details">
                    <div class="detail-card">
                        <div class="detail-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <div class="detail-label">Điểm đến</div>
                        <div class="detail-value"><%= tour.getDestination() %></div>
                    </div>
                    
                    <div class="detail-card">
                        <div class="detail-icon">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                        <div class="detail-label">Thời gian</div>
                        <div class="detail-value">
                            <%= tour.getStartDate().format(formatter) %> - <%= tour.getEndDate().format(formatter) %>
                        </div>
                    </div>
                    
                    <div class="detail-card">
                        <div class="detail-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="detail-label">Thời lượng</div>
                        <div class="detail-value"><%= duration %> ngày</div>
                    </div>
                    
                    <div class="detail-card">
                        <div class="detail-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="detail-label">Sức chứa</div>
                        <div class="detail-value"><%= tour.getMaxCapacity() %> người</div>
                    </div>
                </div>
                
                <div class="price-card">
                    <div class="price-label">Giá tour</div>
                    <div class="price-amount">
                        <%= String.format("%,.0f", tour.getPrice()) %>₫
                    </div>
                    <div class="price-per">/ người</div>
                    
                    <div class="capacity-indicator">
                        <div class="capacity-bar">
                            <div class="capacity-fill" style="width: <%= occupancyRate %>%"></div>
                        </div>
                        <div class="capacity-text">
                            Đã đặt: <%= tour.getCurrentCapacity() %>/<%= tour.getMaxCapacity() %> chỗ
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="status-section">
                <div class="status-badge <%= tour.isAvailable() ? "status-available" : "status-full" %>">
                    <% if (tour.isAvailable()) { %>
                        <i class="fas fa-check-circle"></i> Còn chỗ trống
                    <% } else { %>
                        <i class="fas fa-times-circle"></i> Đã hết chỗ
                    <% } %>
                </div>
            </div>
        </div>

        <% if (tour.getDescription() != null && !tour.getDescription().isEmpty()) { %>
            <div class="description-card">
                <h3><i class="fas fa-info-circle"></i> Mô tả chi tiết tour</h3>
                <p><%= tour.getDescription() %></p>
            </div>
        <% } %>

        <div class="actions">
            <% if (tour.isAvailable() && isUser) { %>
                <a href="<%= request.getContextPath() %>/booking?action=form&tourId=<%= tour.getId() %>" class="btn btn-primary">
                    <i class="fas fa-ticket-alt"></i> Đặt tour ngay
                </a>
            <% } %>
            <% if (isAdmin) { %>
                <a href="<%= request.getContextPath() %>/tour?action=edit&id=<%= tour.getId() %>" class="btn btn-warning">
                    <i class="fas fa-edit"></i> Chỉnh sửa
                </a>
            <% } %>
            <a href="<%= request.getContextPath() %>/tour?action=list" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Quay lại danh sách
            </a>
        </div>
    </div>
</body>
</html>
