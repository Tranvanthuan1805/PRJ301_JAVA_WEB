<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    boolean isLoggedIn = (username != null);
    boolean isAdmin = "ADMIN".equals(role);
    
    if (!isLoggedIn) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng của tôi - VietAir</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/vietair-style.css" rel="stylesheet">
    <style>
        body {
            background: #f5f7fa;
            min-height: 100vh;
        }
        
        .orders-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .page-header {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        
        .page-header h1 {
            font-size: 28px;
            color: #1f2937;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .page-header p {
            color: #6b7280;
            font-size: 15px;
        }
        
        .orders-grid {
            display: grid;
            gap: 1.5rem;
        }
        
        .order-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            transition: all 0.3s;
        }
        
        .order-card:hover {
            box-shadow: 0 4px 16px rgba(0,0,0,0.12);
            transform: translateY(-2px);
        }
        
        .order-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 1.5rem;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .order-code {
            font-size: 20px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .order-date {
            font-size: 14px;
            opacity: 0.9;
            margin-top: 4px;
        }
        
        .order-badges {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }
        
        .status-badge {
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        
        .status-pending {
            background: rgba(255, 255, 255, 0.25);
            color: white;
        }
        
        .status-confirmed {
            background: rgba(59, 130, 246, 0.2);
            color: #1e40af;
        }
        
        .status-completed {
            background: rgba(16, 185, 129, 0.2);
            color: #065f46;
        }
        
        .status-cancelled {
            background: rgba(239, 68, 68, 0.2);
            color: #991b1b;
        }
        
        .payment-unpaid {
            background: rgba(239, 68, 68, 0.2);
            color: #991b1b;
        }
        
        .payment-paid {
            background: rgba(16, 185, 129, 0.2);
            color: #065f46;
        }
        
        .order-body {
            padding: 1.5rem;
        }
        
        .order-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .info-item {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }
        
        .info-label {
            font-size: 13px;
            color: #6b7280;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .info-value {
            font-size: 15px;
            color: #1f2937;
            font-weight: 600;
        }
        
        .total-amount {
            font-size: 24px !important;
            color: #059669 !important;
        }
        
        .order-items {
            background: #f9fafb;
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
        }
        
        .order-items-title {
            font-size: 14px;
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.75rem;
        }
        
        .order-item {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .order-item:last-child {
            border-bottom: none;
        }
        
        .item-name {
            color: #1f2937;
            font-weight: 500;
        }
        
        .item-quantity {
            color: #6b7280;
            font-size: 14px;
        }
        
        .order-actions {
            display: flex;
            gap: 0.75rem;
            padding-top: 1rem;
            border-top: 1px solid #e5e7eb;
        }
        
        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            border: none;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
        
        .btn-danger {
            background: white;
            color: #dc2626;
            border: 2px solid #dc2626;
        }
        
        .btn-danger:hover {
            background: #dc2626;
            color: white;
        }
        
        .empty-state {
            background: white;
            border-radius: 12px;
            padding: 4rem 2rem;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        
        .empty-icon {
            font-size: 64px;
            color: #d1d5db;
            margin-bottom: 1.5rem;
        }
        
        .empty-state h2 {
            font-size: 24px;
            color: #374151;
            margin-bottom: 0.75rem;
        }
        
        .empty-state p {
            color: #6b7280;
            margin-bottom: 2rem;
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
                <a href="<%= request.getContextPath() %>/tour?action=list" class="nav-item">Tours</a>
                <% if (isLoggedIn) { %>
                    <a href="<%= request.getContextPath() %>/profile" class="nav-item">Profile</a>
                <% } %>
            </nav>
            <div class="nav-actions">
                <a href="<%= request.getContextPath() %>/cart" style="display: inline-flex; align-items: center; justify-content: center; width: 40px; height: 40px; background: white; border: 2px solid var(--primary-color); color: var(--primary-color); border-radius: 8px; text-decoration: none; font-weight: 600; transition: all 0.2s; margin-right: 0.5rem;" title="Giỏ hàng">
                    <i class="fas fa-shopping-cart"></i>
                </a>
                <a href="<%= request.getContextPath() %>/orders" style="display: inline-flex; align-items: center; justify-content: center; width: 40px; height: 40px; background: var(--primary-color); border: 2px solid var(--primary-color); color: white; border-radius: 8px; text-decoration: none; font-weight: 600; transition: all 0.2s; margin-right: 1rem;" title="Đơn hàng">
                    <i class="fas fa-receipt"></i>
                </a>
                <span class="user-badge"><%= username %></span>
                <a href="<%= request.getContextPath() %>/logout" class="btn-logout">
                    <i class="fas fa-sign-out-alt"></i>
                    Đăng xuất
                </a>
            </div>
        </div>
    </header>

    <div class="orders-container">
        <div class="page-header">
            <h1>
                <i class="fas fa-receipt"></i>
                Đơn hàng của tôi
            </h1>
            <p>Quản lý và theo dõi các đơn đặt tour của bạn</p>
        </div>
        
        <% 
        String successMsg = (String) session.getAttribute("success");
        String errorMsg = (String) session.getAttribute("error");
        if (successMsg != null) {
            session.removeAttribute("success");
        %>
            <div style="background: #d1fae5; border: 1px solid #6ee7b7; color: #065f46; padding: 1rem 1.5rem; border-radius: 8px; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 12px;">
                <i class="fas fa-check-circle"></i>
                <span><%= successMsg %></span>
            </div>
        <% } %>
        
        <% if (errorMsg != null) {
            session.removeAttribute("error");
        %>
            <div style="background: #fee2e2; border: 1px solid #fca5a5; color: #991b1b; padding: 1rem 1.5rem; border-radius: 8px; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 12px;">
                <i class="fas fa-exclamation-circle"></i>
                <span><%= errorMsg %></span>
            </div>
        <% } %>
        
        <% if (orders == null || orders.isEmpty()) { %>
            <div class="empty-state">
                <div class="empty-icon">
                    <i class="fas fa-inbox"></i>
                </div>
                <h2>Bạn chưa có đơn hàng nào</h2>
                <p>Hãy khám phá các tour du lịch tuyệt vời của chúng tôi!</p>
                <a href="<%= request.getContextPath() %>/tour?action=list" class="btn btn-primary">
                    <i class="fas fa-compass"></i>
                    Khám phá tours
                </a>
            </div>
        <% } else { %>
            <div class="orders-grid">
                <% for (Order order : orders) { %>
                    <div class="order-card">
                        <div class="order-header">
                            <div>
                                <div class="order-code">
                                    <i class="fas fa-ticket-alt"></i>
                                    <%= order.getOrderCode() %>
                                </div>
                                <div class="order-date">
                                    <i class="far fa-clock"></i>
                                    <%= order.getCreatedAt().format(formatter) %>
                                </div>
                            </div>
                            <div class="order-badges">
                                <span class="status-badge status-<%= order.getStatus().toLowerCase() %>">
                                    <%= order.getStatusDisplay() %>
                                </span>
                                <span class="status-badge payment-<%= order.getPaymentStatus().toLowerCase() %>">
                                    <%= order.getPaymentStatusDisplay() %>
                                </span>
                            </div>
                        </div>
                        
                        <div class="order-body">
                            <div class="order-info-grid">
                                <div class="info-item">
                                    <span class="info-label">Khách hàng</span>
                                    <span class="info-value"><%= order.getCustomerName() %></span>
                                </div>
                                
                                <div class="info-item">
                                    <span class="info-label">Số điện thoại</span>
                                    <span class="info-value"><%= order.getCustomerPhone() %></span>
                                </div>
                                
                                <div class="info-item">
                                    <span class="info-label">Email</span>
                                    <span class="info-value"><%= order.getCustomerEmail() %></span>
                                </div>
                                
                                <div class="info-item">
                                    <span class="info-label">Tổng tiền</span>
                                    <span class="info-value total-amount">
                                        <%= String.format("%,.0f", order.getTotalAmount()) %> ₫
                                    </span>
                                </div>
                            </div>
                            
                            <% if (order.getItems() != null && !order.getItems().isEmpty()) { %>
                                <div class="order-items">
                                    <div class="order-items-title">
                                        <i class="fas fa-list"></i>
                                        Danh sách tours (<%= order.getItems().size() %>)
                                    </div>
                                    <% for (var item : order.getItems()) { %>
                                        <div class="order-item">
                                            <span class="item-name"><%= item.getTourName() %></span>
                                            <span class="item-quantity">x<%= item.getQuantity() %></span>
                                        </div>
                                    <% } %>
                                </div>
                            <% } %>
                            
                            <div class="order-actions">
                                <a href="<%= request.getContextPath() %>/orders/<%= order.getOrderCode() %>" 
                                   class="btn btn-primary">
                                    <i class="fas fa-eye"></i>
                                    Xem chi tiết
                                </a>
                                
                                <% if ("PENDING".equals(order.getStatus())) { %>
                                    <form method="post" action="<%= request.getContextPath() %>/orders" 
                                          style="display: inline;"
                                          onsubmit="return confirm('Bạn có chắc muốn hủy đơn hàng này?');">
                                        <input type="hidden" name="action" value="cancel">
                                        <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                        <button type="submit" class="btn btn-danger">
                                            <i class="fas fa-times-circle"></i>
                                            Hủy đơn
                                        </button>
                                    </form>
                                <% } %>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
    </div>
</body>
</html>
