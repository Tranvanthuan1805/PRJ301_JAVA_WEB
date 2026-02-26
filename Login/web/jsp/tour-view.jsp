<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Tour" %>
<%@ page import="dao.TourDAO" %>
<%@ page import="util.DatabaseConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    boolean isLoggedIn = username != null;
    boolean isAdmin = "ADMIN".equals(role);
    
    // Get tour ID from parameter
    String idParam = request.getParameter("id");
    Tour tour = null;
    
    if (idParam != null) {
        try {
            int tourId = Integer.parseInt(idParam);
            Connection conn = DatabaseConnection.getNewConnection();
            TourDAO tourDAO = new TourDAO(conn);
            tour = tourDAO.getTourById(tourId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    if (tour == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
    
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    String startDateStr = tour.getStartDate().format(formatter);
    String endDateStr = tour.getEndDate().format(formatter);
    int capacityPercent = (tour.getCurrentCapacity() * 100) / tour.getMaxCapacity();
    boolean isAvailable = tour.getCurrentCapacity() < tour.getMaxCapacity();
    String priceFormatted = String.format("%,.0f", tour.getPrice());
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= tour.getName() %> - VietAir</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/vietair-style.css" rel="stylesheet">
    <style>
        .tour-detail-hero {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            padding: 4rem 0 3rem;
            color: white;
        }
        
        .alert {
            padding: 1rem 1.5rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 500;
        }
        
        .alert-success {
            background: #d1fae5;
            color: #065f46;
            border: 1px solid #10b981;
        }
        
        .alert-error {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #ef4444;
        }
        
        .alert i {
            font-size: 1.25rem;
        }
        
        .booking-card input::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }
        
        .booking-card input:focus {
            outline: none;
            border-color: rgba(255, 255, 255, 0.6);
            background: rgba(255, 255, 255, 0.15);
        }
        
        .tour-detail-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
        }
        
        .tour-detail-header {
            text-align: center;
            margin-bottom: 3rem;
        }
        
        .tour-detail-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: white;
        }
        
        .tour-detail-location {
            font-size: 1.2rem;
            opacity: 0.95;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }
        
        .tour-detail-content {
            background: white;
            margin-top: -2rem;
            border-radius: var(--border-radius-large);
            box-shadow: var(--shadow-lg);
            overflow: hidden;
        }
        
        .tour-info-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            padding: 2.5rem;
        }
        
        .tour-main-info {
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }
        
        .info-section {
            padding: 1.5rem;
            background: var(--bg-secondary);
            border-radius: var(--border-radius);
            border-left: 4px solid var(--primary-color);
        }
        
        .info-section h3 {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }
        
        .info-item {
            display: flex;
            align-items: flex-start;
            gap: 1rem;
        }
        
        .info-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
            border-radius: var(--border-radius-small);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            flex-shrink: 0;
        }
        
        .info-content {
            flex: 1;
        }
        
        .info-label {
            font-size: 0.85rem;
            color: var(--text-secondary);
            font-weight: 500;
            margin-bottom: 0.25rem;
        }
        
        .info-value {
            font-size: 1rem;
            font-weight: 600;
            color: var(--text-primary);
        }
        
        .tour-sidebar {
            position: sticky;
            top: 80px;
        }
        
        .booking-card {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            padding: 2rem;
            border-radius: var(--border-radius);
            color: white;
            box-shadow: var(--shadow-lg);
        }
        
        .booking-price {
            text-align: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid rgba(255,255,255,0.2);
        }
        
        .price-label {
            font-size: 0.9rem;
            opacity: 0.9;
            margin-bottom: 0.5rem;
        }
        
        .price-value {
            font-size: 2.5rem;
            font-weight: 700;
        }
        
        .price-unit {
            font-size: 1rem;
            opacity: 0.9;
        }
        
        .capacity-info {
            margin-bottom: 1.5rem;
        }
        
        .capacity-bar {
            width: 100%;
            height: 8px;
            background: rgba(255,255,255,0.2);
            border-radius: 4px;
            overflow: hidden;
            margin-bottom: 0.5rem;
        }
        
        .capacity-fill {
            height: 100%;
            background: linear-gradient(90deg, #10b981, #059669);
            border-radius: 4px;
        }
        
        .capacity-text {
            font-size: 0.9rem;
            text-align: center;
            opacity: 0.95;
        }
        
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.9rem;
            margin-bottom: 1.5rem;
            width: 100%;
            justify-content: center;
        }
        
        .status-available {
            background: rgba(16, 185, 129, 0.2);
            color: #10b981;
            border: 2px solid rgba(16, 185, 129, 0.3);
        }
        
        .status-full {
            background: rgba(239, 68, 68, 0.2);
            color: #ef4444;
            border: 2px solid rgba(239, 68, 68, 0.3);
        }
        
        .btn-book {
            width: 100%;
            padding: 1rem;
            background: white;
            color: var(--primary-color);
            border: none;
            border-radius: var(--border-radius-small);
            font-weight: 700;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            text-decoration: none;
        }
        
        .btn-book:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            color: var(--primary-color);
            text-decoration: none;
        }
        
        .btn-back {
            width: 100%;
            padding: 0.875rem;
            background: rgba(255,255,255,0.1);
            color: white;
            border: 2px solid rgba(255,255,255,0.3);
            border-radius: var(--border-radius-small);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            text-decoration: none;
            margin-top: 1rem;
        }
        
        .btn-back:hover {
            background: rgba(255,255,255,0.2);
            border-color: rgba(255,255,255,0.5);
            color: white;
            text-decoration: none;
        }
        
        @media (max-width: 768px) {
            .tour-info-grid {
                grid-template-columns: 1fr;
                padding: 1.5rem;
            }
            
            .info-grid {
                grid-template-columns: 1fr;
            }
            
            .tour-detail-title {
                font-size: 2rem;
            }
            
            .tour-sidebar {
                position: static;
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
                <% if (isAdmin) { %>
                    <a href="<%= request.getContextPath() %>/admin/tours" class="nav-item active">Tours</a>
                    <a href="<%= request.getContextPath() %>/admin/customers" class="nav-item">Khách hàng</a>
                    <a href="<%= request.getContextPath() %>/history.jsp" class="nav-item">Lịch sử</a>
                <% } else if (isLoggedIn) { %>
                    <a href="<%= request.getContextPath() %>/tour?action=list" class="nav-item active">Tours</a>
                    <a href="<%= request.getContextPath() %>/profile" class="nav-item">Profile</a>
                <% } else { %>
                    <a href="<%= request.getContextPath() %>/tour?action=list" class="nav-item active">Tours</a>
                <% } %>
            </nav>
            <div class="nav-actions">
                <% if (!isAdmin) { %>
                    <a href="<%= request.getContextPath() %>/cart" style="display: inline-flex; align-items: center; justify-content: center; width: 40px; height: 40px; background: white; border: 2px solid var(--primary-color); color: var(--primary-color); border-radius: 8px; text-decoration: none; transition: all 0.2s; margin-right: 0.5rem;" title="Giỏ hàng">
                        <i class="fas fa-shopping-cart"></i>
                    </a>
                    <a href="<%= request.getContextPath() %>/orders" style="display: inline-flex; align-items: center; justify-content: center; width: 40px; height: 40px; background: var(--primary-color); border: 2px solid var(--primary-color); color: white; border-radius: 8px; text-decoration: none; transition: all 0.2s; margin-right: 1rem;" title="Đơn hàng">
                        <i class="fas fa-receipt"></i>
                    </a>
                <% } %>
                <% if (isLoggedIn) { %>
                    <span class="user-badge"><%= isAdmin ? "ADMIN" : "USER" %></span>
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
    <div class="tour-detail-hero">
        <div class="tour-detail-container">
            <div class="tour-detail-header">
                <h1 class="tour-detail-title"><%= tour.getName() %></h1>
                <div class="tour-detail-location">
                    <i class="fas fa-map-marker-alt"></i>
                    <%= tour.getDestination() %>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="tour-detail-container" style="padding-bottom: 4rem;">
        <div class="tour-detail-content">
            <%
                String successMsg = (String) session.getAttribute("success");
                String errorMsg = (String) session.getAttribute("error");
                if (successMsg != null) {
                    session.removeAttribute("success");
            %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <%= successMsg %>
                </div>
            <%
                }
                if (errorMsg != null) {
                    session.removeAttribute("error");
            %>
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <%= errorMsg %>
                </div>
            <%
                }
            %>
            <div class="tour-info-grid">
                <!-- Main Info -->
                <div class="tour-main-info">
                    <!-- Tour Details -->
                    <div class="info-section">
                        <h3><i class="fas fa-info-circle"></i> Thông tin tour</h3>
                        <div class="info-grid">
                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-calendar-alt"></i>
                                </div>
                                <div class="info-content">
                                    <div class="info-label">Ngày khởi hành</div>
                                    <div class="info-value"><%= startDateStr %></div>
                                </div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-calendar-check"></i>
                                </div>
                                <div class="info-content">
                                    <div class="info-label">Ngày kết thúc</div>
                                    <div class="info-value"><%= endDateStr %></div>
                                </div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-users"></i>
                                </div>
                                <div class="info-content">
                                    <div class="info-label">Sức chứa tối đa</div>
                                    <div class="info-value"><%= tour.getMaxCapacity() %> người</div>
                                </div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-user-check"></i>
                                </div>
                                <div class="info-content">
                                    <div class="info-label">Đã đặt</div>
                                    <div class="info-value"><%= tour.getCurrentCapacity() %> người</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Description -->
                    <% if (tour.getDescription() != null && !tour.getDescription().trim().isEmpty()) { %>
                        <div class="info-section">
                            <h3><i class="fas fa-file-alt"></i> Mô tả chi tiết</h3>
                            <p style="line-height: 1.8; color: var(--text-secondary);"><%= tour.getDescription() %></p>
                        </div>
                    <% } %>
                </div>
                
                <!-- Sidebar -->
                <div class="tour-sidebar">
                    <div class="booking-card">
                        <div class="booking-price">
                            <div class="price-label">Giá tour</div>
                            <div class="price-value"><%= priceFormatted %>₫</div>
                            <div class="price-unit">/ người</div>
                        </div>
                        
                        <div class="capacity-info">
                            <div class="capacity-bar">
                                <div class="capacity-fill" style="width: <%= capacityPercent %>%"></div>
                            </div>
                            <div class="capacity-text">
                                Đã đặt: <%= tour.getCurrentCapacity() %>/<%= tour.getMaxCapacity() %> chỗ
                            </div>
                        </div>
                        
                        <div class="status-badge <%= isAvailable ? "status-available" : "status-full" %>">
                            <% if (isAvailable) { %>
                                <i class="fas fa-check-circle"></i> Còn chỗ trống
                            <% } else { %>
                                <i class="fas fa-times-circle"></i> Đã hết chỗ
                            <% } %>
                        </div>
                        
                        <% if (!isAvailable) { %>
                            <button class="btn-book" disabled style="opacity: 0.5; cursor: not-allowed;">
                                <i class="fas fa-times-circle"></i> Đã hết chỗ
                            </button>
                        <% } else if (isAdmin) { %>
                            <div style="text-align: center; padding: 1rem; background: rgba(255,255,255,0.1); border-radius: 8px; color: white;">
                                <i class="fas fa-user-shield" style="font-size: 2rem; margin-bottom: 0.5rem; opacity: 0.8;"></i>
                                <p style="margin: 0; font-size: 0.9rem; opacity: 0.9;">Bạn đang xem với quyền Admin</p>
                            </div>
                        <% } else if (!isLoggedIn) { %>
                            <a href="<%= request.getContextPath() %>/login.jsp" class="btn-book">
                                <i class="fas fa-sign-in-alt"></i> Đăng nhập để đặt tour
                            </a>
                        <% } else { %>
                            <!-- Buy Now - Go to Checkout -->
                            <form action="<%= request.getContextPath() %>/checkout" method="get" style="margin: 0;">
                                <input type="hidden" name="buyNowTourId" value="<%= tour.getId() %>">
                                <input type="hidden" name="buyNowQuantity" id="buyNowQuantity" value="1">
                                
                                <div style="margin-bottom: 1.5rem;">
                                    <label style="display: block; margin-bottom: 0.5rem; font-size: 0.9rem; opacity: 0.9;">
                                        Số lượng người: <span style="color: #fca5a5;">*</span>
                                    </label>
                                    <input type="number" id="numberOfPeople" min="1" max="<%= tour.getMaxCapacity() - tour.getCurrentCapacity() %>" 
                                           value="1" required
                                           onchange="document.getElementById('buyNowQuantity').value = this.value; document.getElementById('cartQuantity').value = this.value;"
                                           style="width: 100%; padding: 0.75rem; border: 2px solid rgba(255,255,255,0.3); 
                                                  border-radius: 8px; background: rgba(255,255,255,0.1); color: white; 
                                                  font-size: 1rem; font-weight: 600;">
                                </div>
                                
                                <button type="submit" class="btn-book">
                                    <i class="fas fa-ticket-alt"></i> Đặt tour ngay
                                </button>
                            </form>
                            
                            <!-- Add to Cart Button -->
                            <form action="<%= request.getContextPath() %>/cart/add" method="post" style="margin: 0; margin-top: 1rem;">
                                <input type="hidden" name="tourId" value="<%= tour.getId() %>">
                                <input type="hidden" name="quantity" id="cartQuantity" value="1">
                                <button type="submit" class="btn-book" style="background: rgba(255,255,255,0.1); color: white; border: 2px solid rgba(255,255,255,0.3);">
                                    <i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng
                                </button>
                            </form>
                        <% } %>
                        
                        <a href="<%= isAdmin ? request.getContextPath() + "/admin/tours" : request.getContextPath() + "/tour" %>" class="btn-back">
                            <i class="fas fa-arrow-left"></i> Quay lại danh sách
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
