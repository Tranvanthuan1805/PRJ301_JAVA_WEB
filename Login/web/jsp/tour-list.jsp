<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="model.Tour" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    boolean isLoggedIn = username != null;
    boolean isAdmin = "ADMIN".equals(role);
    
    List<Tour> tours = (List<Tour>) request.getAttribute("tours");
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    Integer totalTours = (Integer) request.getAttribute("totalTours");
    
    if (currentPage == null) currentPage = 1;
    if (totalPages == null) totalPages = 1;
    if (totalTours == null) totalTours = 0;
    
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Tours - VietAir</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/vietair-style.css" rel="stylesheet">
    <style>
        .tours-hero {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            padding: 3rem 0 2rem;
            color: white;
        }
        
        .tours-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
        }
        
        .tours-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .tours-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        
        .tours-subtitle {
            font-size: 1.1rem;
            opacity: 0.95;
        }
        
        .tours-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }
        
        .tour-card {
            background: white;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--shadow-md);
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .tour-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-lg);
        }
        
        .tour-image {
            width: 100%;
            height: 220px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
        }
        
        .tour-content {
            padding: 1.5rem;
        }
        
        .tour-name {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.75rem;
        }
        
        .tour-info-row {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.5rem;
            color: var(--text-secondary);
            font-size: 0.9rem;
        }
        
        .tour-info-row i {
            color: var(--primary-color);
            width: 20px;
        }
        
        .tour-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border-color);
        }
        
        .tour-price {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
        }
        
        .tour-capacity {
            font-size: 0.85rem;
            color: var(--text-secondary);
        }
        
        .capacity-available {
            color: #10b981;
            font-weight: 600;
        }
        
        .capacity-full {
            color: #ef4444;
            font-weight: 600;
        }
        
        .no-tours {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--text-secondary);
        }
        
        .no-tours i {
            font-size: 4rem;
            color: var(--border-color);
            margin-bottom: 1rem;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
            margin: 3rem 0;
        }
        
        .pagination a,
        .pagination span {
            padding: 0.75rem 1rem;
            border: 1px solid var(--border-color);
            border-radius: 6px;
            text-decoration: none;
            color: var(--text-primary);
            font-weight: 500;
            transition: all 0.2s ease;
        }
        
        .pagination a:hover {
            background: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }
        
        .pagination .active {
            background: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }
        
        .pagination .disabled {
            opacity: 0.5;
            cursor: not-allowed;
            pointer-events: none;
        }
        
        .tours-info {
            text-align: center;
            color: var(--text-secondary);
            margin-bottom: 2rem;
            font-size: 0.95rem;
        }
        
        @media (max-width: 768px) {
            .tours-grid {
                grid-template-columns: 1fr;
            }
            
            .tours-title {
                font-size: 2rem;
            }
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
                <a href="<%= request.getContextPath() %>/index.jsp" class="nav-item">Trang chủ</a>
                <a href="<%= request.getContextPath() %>/tour?action=list" class="nav-item active">Tours</a>
                <a href="<%= isLoggedIn ? "#" : request.getContextPath() + "/login.jsp" %>" class="nav-item">Khách hàng</a>
                <a href="<%= isLoggedIn ? "#" : request.getContextPath() + "/login.jsp" %>" class="nav-item">Booking</a>
                <% if (isAdmin) { %>
                    <a href="<%= request.getContextPath() %>/history.jsp" class="nav-item">Lịch sử</a>
                <% } %>
            </nav>
            <div class="nav-actions">
                <% if (isLoggedIn) { %>
                    <% if (isAdmin) { %>
                        <span class="user-badge">ADMIN</span>
                    <% } %>
                    <a href="<%= request.getContextPath() %>/logout" class="btn-logout">
                        <i class="fas fa-sign-out-alt"></i>
                        Đăng xuất
                    </a>
                <% } else { %>
                    <a href="<%= request.getContextPath() %>/login.jsp" class="btn-login">
                        <i class="fas fa-sign-in-alt"></i>
                        Đăng Nhập
                    </a>
                    <a href="<%= request.getContextPath() %>/register.jsp" class="btn-register">
                        <i class="fas fa-user-plus"></i>
                        Đăng Ký
                    </a>
                <% } %>
            </div>
        </div>
    </header>

    <!-- Hero Section -->
    <div class="tours-hero">
        <div class="tours-container">
            <div class="tours-header">
                <h1 class="tours-title">Khám phá Đà Nẵng</h1>
                <p class="tours-subtitle">Tìm tour du lịch phù hợp với bạn</p>
                <% if (isAdmin) { %>
                    <div style="margin-top: 1.5rem;">
                        <a href="<%= request.getContextPath() %>/tour?action=add" class="btn-primary" style="background: white; color: var(--primary-color); padding: 0.75rem 1.5rem; border-radius: 8px; text-decoration: none; display: inline-flex; align-items: center; gap: 0.5rem; font-weight: 600;">
                            <i class="fas fa-plus"></i>
                            Thêm Tour Mới
                        </a>
                    </div>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="tours-container" style="padding-bottom: 4rem;">
        <!-- Tours Info -->
        <% if (totalTours > 0) { %>
            <div class="tours-info">
                Hiển thị <%= (currentPage - 1) * 12 + 1 %> - <%= Math.min(currentPage * 12, totalTours) %> trong tổng số <%= totalTours %> tours
            </div>
        <% } %>
        
        <!-- Tours Grid -->
        <% if (tours != null && !tours.isEmpty()) { %>
            <div class="tours-grid">
                <% for (Tour tour : tours) {
                    String startDateStr = tour.getStartDate().format(formatter);
                    String endDateStr = tour.getEndDate().format(formatter);
                    boolean isAvailable = tour.getCurrentCapacity() < tour.getMaxCapacity();
                    String priceFormatted = String.format("%,.0f", tour.getPrice());
                %>
                    <div class="tour-card">
                        <div class="tour-image">
                            <i class="fas fa-map-marked-alt"></i>
                        </div>
                        <div class="tour-content">
                            <h3 class="tour-name"><%= tour.getName() %></h3>
                            
                            <div class="tour-info-row">
                                <i class="fas fa-map-marker-alt"></i>
                                <span><%= tour.getDestination() %></span>
                            </div>
                            
                            <div class="tour-info-row">
                                <i class="fas fa-calendar-alt"></i>
                                <span><%= startDateStr %> - <%= endDateStr %></span>
                            </div>
                            
                            <div class="tour-info-row">
                                <i class="fas fa-users"></i>
                                <span>Sức chứa: <%= tour.getMaxCapacity() %> người</span>
                            </div>
                            
                            <div class="tour-footer">
                                <div>
                                    <div class="tour-price"><%= priceFormatted %>₫</div>
                                    <div class="tour-capacity <%= isAvailable ? "capacity-available" : "capacity-full" %>">
                                        <% if (isAvailable) { %>
                                            <i class="fas fa-check-circle"></i> Còn <%= tour.getMaxCapacity() - tour.getCurrentCapacity() %> chỗ
                                        <% } else { %>
                                            <i class="fas fa-times-circle"></i> Đã hết chỗ
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Action Buttons -->
                            <div style="margin-top: 1rem; display: flex; gap: 0.5rem;">
                                <a href="<%= request.getContextPath() %>/tour?action=view&id=<%= tour.getId() %>" 
                                   class="btn-primary" 
                                   style="flex: 1; text-align: center; padding: 0.75rem; text-decoration: none; border-radius: 6px; font-size: 0.9rem;">
                                    <i class="fas fa-eye"></i> Xem chi tiết
                                </a>
                                <% if (isAdmin) { %>
                                    <a href="<%= request.getContextPath() %>/tour?action=edit&id=<%= tour.getId() %>" 
                                       class="btn-secondary" 
                                       style="padding: 0.75rem 1rem; text-decoration: none; border-radius: 6px; background: #f59e0b; color: white;"
                                       onclick="event.stopPropagation();">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="<%= request.getContextPath() %>/tour?action=delete&id=<%= tour.getId() %>" 
                                       class="btn-danger" 
                                       style="padding: 0.75rem 1rem; text-decoration: none; border-radius: 6px; background: #ef4444; color: white;"
                                       onclick="event.stopPropagation(); return confirm('Bạn có chắc muốn xóa tour này?');">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                <% } %>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
            
            <!-- Pagination -->
            <% if (totalPages > 1) { %>
                <div class="pagination">
                    <!-- Previous Button -->
                    <% if (currentPage > 1) { %>
                        <a href="<%= request.getContextPath() %>/tour?action=list&page=<%= currentPage - 1 %>">
                            <i class="fas fa-chevron-left"></i> Trước
                        </a>
                    <% } else { %>
                        <span class="disabled">
                            <i class="fas fa-chevron-left"></i> Trước
                        </span>
                    <% } %>
                    
                    <!-- Page Numbers -->
                    <% 
                        int startPage = Math.max(1, currentPage - 2);
                        int endPage = Math.min(totalPages, currentPage + 2);
                        
                        if (startPage > 1) {
                    %>
                        <a href="<%= request.getContextPath() %>/tour?action=list&page=1">1</a>
                        <% if (startPage > 2) { %>
                            <span>...</span>
                        <% } %>
                    <% } %>
                    
                    <% for (int i = startPage; i <= endPage; i++) { %>
                        <% if (i == currentPage) { %>
                            <span class="active"><%= i %></span>
                        <% } else { %>
                            <a href="<%= request.getContextPath() %>/tour?action=list&page=<%= i %>"><%= i %></a>
                        <% } %>
                    <% } %>
                    
                    <% if (endPage < totalPages) { %>
                        <% if (endPage < totalPages - 1) { %>
                            <span>...</span>
                        <% } %>
                        <a href="<%= request.getContextPath() %>/tour?action=list&page=<%= totalPages %>"><%= totalPages %></a>
                    <% } %>
                    
                    <!-- Next Button -->
                    <% if (currentPage < totalPages) { %>
                        <a href="<%= request.getContextPath() %>/tour?action=list&page=<%= currentPage + 1 %>">
                            Sau <i class="fas fa-chevron-right"></i>
                        </a>
                    <% } else { %>
                        <span class="disabled">
                            Sau <i class="fas fa-chevron-right"></i>
                        </span>
                    <% } %>
                </div>
            <% } %>
        <% } else { %>
            <div class="no-tours">
                <i class="fas fa-search"></i>
                <h3>Không tìm thấy tour nào</h3>
                <p>Vui lòng thử lại với bộ lọc khác</p>
            </div>
        <% } %>
    </div>
</body>
</html>
