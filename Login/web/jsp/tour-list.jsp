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
        body {
            background: #f5f7fa;
        }
        
        .tours-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2rem;
        }
        
        .page-header {
            text-align: center;
            margin: 2rem 0;
        }
        
        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }
        
        .page-subtitle {
            font-size: 1rem;
            color: var(--text-secondary);
        }
        
        .table-container {
            background: white;
            border-radius: 8px;
            border: 1px solid #e5e7eb;
            overflow: hidden;
            margin-bottom: 2rem;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        thead {
            background: #f9fafb;
            border-bottom: 1px solid #e5e7eb;
        }
        
        th {
            padding: 1rem;
            text-align: left;
            font-size: 12px;
            font-weight: 600;
            color: #6b7280;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        td {
            padding: 1rem;
            border-bottom: 1px solid #f3f4f6;
            font-size: 14px;
            color: #374151;
        }
        
        tbody tr:hover {
            background: #f9fafb;
        }
        
        .tour-name {
            font-weight: 600;
            color: #1f2937;
        }
        
        .price-text {
            font-weight: 600;
            color: #059669;
        }
        
        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .status-available {
            background: #d1fae5;
            color: #065f46;
        }
        
        .status-full {
            background: #fee2e2;
            color: #991b1b;
        }
        
        .btn-view-detail {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 0.5rem 1rem;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
        }
        
        .btn-view-detail:hover {
            background: var(--primary-dark);
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            gap: 0.5rem;
            margin: 2rem 0;
        }
        
        .page-btn {
            padding: 0.5rem 1rem;
            border: 1px solid #d1d5db;
            background: white;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            color: #374151;
        }
        
        .page-btn:hover {
            background: #f9fafb;
        }
        
        .page-btn.active {
            background: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }
        
        .tours-info {
            text-align: center;
            color: #6b7280;
            font-size: 14px;
            margin-bottom: 1rem;
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

    <!-- Main Content -->
    <div class="tours-container" style="padding: 3rem 0 4rem;">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">Khám phá Đà Nẵng</h1>
            <p class="page-subtitle">Tìm tour du lịch phù hợp với bạn</p>
            <% if (isAdmin) { %>
                <div style="margin-top: 1rem;">
                    <a href="<%= request.getContextPath() %>/tour?action=add" style="display: inline-flex; align-items: center; gap: 8px; padding: 0.75rem 1.5rem; background: var(--primary-color); color: white; border-radius: 8px; text-decoration: none; font-weight: 600;">
                        <i class="fas fa-plus"></i>
                        Thêm Tour Mới
                    </a>
                </div>
            <% } %>
        </div>
        
        <!-- Search and Filter (for ALL users) -->
        <div style="background: white; padding: 1.5rem; border-radius: 8px; margin-bottom: 2rem; border: 1px solid #e5e7eb;">
            <form method="get" action="<%= request.getContextPath() %>/tour" style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: end;">
                <input type="hidden" name="action" value="list">
                <div style="flex: 1; min-width: 250px;">
                    <label style="display: block; margin-bottom: 0.5rem; font-size: 14px; font-weight: 600; color: #374151;">Tìm kiếm</label>
                    <input type="text" name="search" placeholder="Tìm theo tên tour, điểm đến..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>" style="width: 100%; padding: 0.75rem; border: 1px solid #d1d5db; border-radius: 6px; font-size: 14px;">
                </div>
                <div style="min-width: 200px;">
                    <label style="display: block; margin-bottom: 0.5rem; font-size: 14px; font-weight: 600; color: #374151;">Điểm đến</label>
                    <select name="destination" style="width: 100%; padding: 0.75rem; border: 1px solid #d1d5db; border-radius: 6px; font-size: 14px; background: white;">
                        <option value="">Tất cả</option>
                        <option value="Bà Nà Hills" <%= "Bà Nà Hills".equals(request.getParameter("destination")) ? "selected" : "" %>>Bà Nà Hills</option>
                        <option value="Ngũ Hành Sơn" <%= "Ngũ Hành Sơn".equals(request.getParameter("destination")) ? "selected" : "" %>>Ngũ Hành Sơn</option>
                        <option value="Cù Lao Chàm" <%= "Cù Lao Chàm".equals(request.getParameter("destination")) ? "selected" : "" %>>Cù Lao Chàm</option>
                        <option value="Sơn Trà" <%= "Sơn Trà".equals(request.getParameter("destination")) ? "selected" : "" %>>Sơn Trà</option>
                        <option value="Huế" <%= "Huế".equals(request.getParameter("destination")) ? "selected" : "" %>>Huế</option>
                        <option value="Núi Thần Tài" <%= "Núi Thần Tài".equals(request.getParameter("destination")) ? "selected" : "" %>>Núi Thần Tài</option>
                    </select>
                </div>
                <div style="min-width: 180px;">
                    <label style="display: block; margin-bottom: 0.5rem; font-size: 14px; font-weight: 600; color: #374151;">Sắp xếp</label>
                    <select name="sortBy" style="width: 100%; padding: 0.75rem; border: 1px solid #d1d5db; border-radius: 6px; font-size: 14px; background: white;">
                        <option value="">Mặc định</option>
                        <option value="name" <%= "name".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Tên A-Z</option>
                        <option value="price_asc" <%= "price_asc".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Giá thấp đến cao</option>
                        <option value="price_desc" <%= "price_desc".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Giá cao đến thấp</option>
                        <option value="date" <%= "date".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Ngày khởi hành</option>
                        <option value="available" <%= "available".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Còn chỗ nhiều nhất</option>
                    </select>
                </div>
                <button type="submit" style="padding: 0.75rem 1.5rem; background: var(--primary-color); color: white; border: none; border-radius: 6px; font-size: 14px; font-weight: 600; cursor: pointer; display: flex; align-items: center; gap: 8px;">
                    <i class="fas fa-search"></i>
                    Tìm kiếm
                </button>
            </form>
        </div>
        
        <!-- Tours Info -->
        <% if (totalTours > 0) { %>
            <div class="tours-info">
                Hiển thị <%= (currentPage - 1) * 12 + 1 %> - <%= Math.min(currentPage * 12, totalTours) %> trong tổng số <%= totalTours %> tours
            </div>
        <% } %>
        
        <!-- Tours Table -->
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>TÊN TOUR</th>
                        <th>ĐIỂM ĐẾN</th>
                        <th>NGÀY KHỞI HÀNH</th>
                        <th>GIÁ</th>
                        <th>SỐ NGƯỜI</th>
                        <th>TRẠNG THÁI</th>
                        <th>HÀNH ĐỘNG</th>
                        <% if (isAdmin) { %>
                            <th style="width: 120px;">QUẢN LÝ</th>
                        <% } %>
                    </tr>
                </thead>
                <tbody>
                    <% if (tours != null && !tours.isEmpty()) {
                        for (Tour tour : tours) { 
                            boolean isAvailable = tour.getCurrentCapacity() < tour.getMaxCapacity();
                    %>
                            <tr>
                                <td><%= tour.getId() %></td>
                                <td class="tour-name"><%= tour.getName() %></td>
                                <td><%= tour.getDestination() %></td>
                                <td><%= tour.getStartDate().format(formatter) %></td>
                                <td class="price-text"><%= String.format("%,d", (int)tour.getPrice()) %> VNĐ</td>
                                <td><%= tour.getCurrentCapacity() %>/<%= tour.getMaxCapacity() %></td>
                                <td>
                                    <span class="status-badge <%= isAvailable ? "status-available" : "status-full" %>">
                                        <%= isAvailable ? "Còn chỗ" : "Đã đầy" %>
                                    </span>
                                </td>
                                <td>
                                    <a href="<%= request.getContextPath() %>/jsp/tour-view.jsp?id=<%= tour.getId() %>" class="btn-view-detail">
                                        <i class="fas fa-eye"></i>
                                        Xem chi tiết
                                    </a>
                                </td>
                                <% if (isAdmin) { %>
                                    <td>
                                        <div style="display: flex; gap: 0.5rem;">
                                            <a href="<%= request.getContextPath() %>/tour?action=edit&id=<%= tour.getId() %>" style="width: 32px; height: 32px; display: flex; align-items: center; justify-content: center; background: #fef3c7; color: #92400e; border-radius: 6px; text-decoration: none;" title="Sửa">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button onclick="if(confirm('Bạn có chắc muốn xóa tour này?')) window.location.href='<%= request.getContextPath() %>/tour?action=delete&id=<%= tour.getId() %>'" style="width: 32px; height: 32px; display: flex; align-items: center; justify-content: center; background: #fee2e2; color: #991b1b; border: none; border-radius: 6px; cursor: pointer;" title="Xóa">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                <% } %>
                            </tr>
                    <% }
                    } else { %>
                        <tr>
                            <td colspan="8" style="text-align: center; padding: 2rem; color: #9ca3af;">
                                Không có tour nào
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        
        <!-- Pagination -->
        <% if (totalPages > 1) { %>
            <div class="pagination">
                <% if (currentPage > 1) { %>
                    <a href="?page=<%= currentPage - 1 %>" class="page-btn">« Trước</a>
                <% } %>
                
                <% for (int i = 1; i <= totalPages; i++) { %>
                    <a href="?page=<%= i %>" class="page-btn <%= i == currentPage ? "active" : "" %>"><%= i %></a>
                <% } %>
                
                <% if (currentPage < totalPages) { %>
                    <a href="?page=<%= currentPage + 1 %>" class="page-btn">Sau »</a>
                <% } %>
            </div>
        <% } %>
    </div>
</body>
</html>
