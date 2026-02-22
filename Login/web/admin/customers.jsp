<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="model.Customer" %>
<%@ page import="dao.CustomerDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
// Set encoding
response.setCharacterEncoding("UTF-8");
request.setCharacterEncoding("UTF-8");

// Check admin access
String username = (String) session.getAttribute("username");
String role = (String) session.getAttribute("role");
if (username == null || !"ADMIN".equals(role)) {
    response.sendRedirect("../login.jsp");
    return;
}

// Get data from servlet or load directly
List<Customer> customers = (List<Customer>) request.getAttribute("customers");
Integer currentPage = (Integer) request.getAttribute("currentPage");
Integer totalPages = (Integer) request.getAttribute("totalPages");
Integer totalCustomers = (Integer) request.getAttribute("totalCustomers");
String keyword = (String) request.getAttribute("keyword");
String filterStatus = (String) request.getAttribute("filterStatus");

// If no data from servlet, load directly
if (customers == null) {
    try {
        CustomerDAO customerDAO = new CustomerDAO();
        customers = customerDAO.getAllCustomers(0, 100);
        totalCustomers = customerDAO.getTotalCustomers();
        totalPages = (int) Math.ceil((double) totalCustomers / 10.0);
    } catch (Exception e) {
        e.printStackTrace();
        customers = new java.util.ArrayList<>();
    }
}

if (currentPage == null) currentPage = 1;
if (totalPages == null) totalPages = 1;
if (totalCustomers == null) totalCustomers = 0;

SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Khách Hàng - VietAir Admin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/vietair-style.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: #f5f7fa;
        }
        
        .admin-container {
            display: flex;
            min-height: 100vh;
        }
        
        /* Sidebar */
        .sidebar {
            width: 260px;
            background: white;
            border-right: 1px solid #e5e7eb;
            display: flex;
            flex-direction: column;
        }
        
        .sidebar-header {
            padding: 1.5rem;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .sidebar-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            color: var(--primary-color);
        }
        
        .sidebar-brand i {
            font-size: 24px;
        }
        
        .sidebar-brand-text h3 {
            font-size: 16px;
            font-weight: 700;
            color: #1f2937;
        }
        
        .sidebar-brand-text p {
            font-size: 12px;
            color: #6b7280;
        }
        
        .sidebar-menu {
            flex: 1;
            padding: 1rem 0;
        }
        
        .menu-section {
            margin-bottom: 1.5rem;
        }
        
        .menu-title {
            padding: 0 1.5rem;
            font-size: 11px;
            font-weight: 600;
            color: #9ca3af;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.5rem;
        }
        
        .menu-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 0.75rem 1.5rem;
            color: #6b7280;
            text-decoration: none;
            transition: all 0.2s;
        }
        
        .menu-item:hover {
            background: #f9fafb;
            color: var(--primary-color);
        }
        
        .menu-item.active {
            background: #eff6ff;
            color: var(--primary-color);
            border-right: 3px solid var(--primary-color);
            font-weight: 600;
        }
        
        .menu-item i {
            width: 20px;
            text-align: center;
        }
        
        /* Main Content */
        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        
        .top-bar {
            background: white;
            border-bottom: 1px solid #e5e7eb;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .top-bar-title h1 {
            font-size: 20px;
            font-weight: 700;
            color: #1f2937;
        }
        
        .top-bar-actions {
            display: flex;
            gap: 1rem;
            align-items: center;
        }
        
        .btn-export {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 0.5rem 1rem;
            background: white;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            color: #374151;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
        }
        
        .btn-export:hover {
            background: #f9fafb;
            border-color: #9ca3af;
        }
        
        .btn-add {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 0.5rem 1rem;
            background: var(--primary-color);
            border: none;
            border-radius: 6px;
            color: white;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
        }
        
        .btn-add:hover {
            background: var(--primary-dark);
        }
        
        .content-area {
            flex: 1;
            padding: 2rem;
            overflow-y: auto;
        }
        
        .content-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }
        
        .search-filter {
            display: flex;
            gap: 1rem;
            align-items: center;
        }
        
        .search-box {
            position: relative;
        }
        
        .search-box input {
            padding: 0.5rem 1rem 0.5rem 2.5rem;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 14px;
            width: 300px;
        }
        
        .search-box i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
        }
        
        .filter-select {
            padding: 0.5rem 1rem;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 14px;
            background: white;
        }
        
        /* Table */
        .table-container {
            background: white;
            border-radius: 8px;
            border: 1px solid #e5e7eb;
            overflow: hidden;
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
            padding: 0.75rem 1rem;
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
        
        .customer-name {
            font-weight: 600;
            color: #1f2937;
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
        
        .status-banned {
            background: #fecaca;
            color: #7f1d1d;
        }
        
        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }
        
        .btn-icon {
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
        }
        
        .btn-view {
            background: #dbeafe;
            color: #1e40af;
        }
        
        .btn-view:hover {
            background: #bfdbfe;
        }
        
        .btn-edit {
            background: #fef3c7;
            color: #92400e;
        }
        
        .btn-edit:hover {
            background: #fde68a;
        }
        
        .btn-delete {
            background: #fee2e2;
            color: #991b1b;
        }
        
        .btn-delete:hover {
            background: #fecaca;
        }
        
        .pagination {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem;
            border-top: 1px solid #e5e7eb;
        }
        
        .pagination-info {
            font-size: 14px;
            color: #6b7280;
        }
        
        .pagination-buttons {
            display: flex;
            gap: 0.5rem;
        }
        
        .page-btn {
            padding: 0.5rem 0.75rem;
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
    </style>
</head>
<body>
    <div class="admin-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <div class="sidebar-brand">
                    <i class="fas fa-plane-departure"></i>
                    <div class="sidebar-brand-text">
                        <h3>VietAir</h3>
                        <p>Admin</p>
                    </div>
                </div>
            </div>
            <nav class="sidebar-menu">
                <div class="menu-section">
                    <div class="menu-title">Quản lý chính</div>
                    <a href="<%= request.getContextPath() %>/admin.jsp" class="menu-item">
                        <i class="fas fa-chart-line"></i>
                        <span>Dashboard</span>
                    </a>
                    <a href="<%= request.getContextPath() %>/admin/customers" class="menu-item active">
                        <i class="fas fa-users"></i>
                        <span>Quản lý khách hàng</span>
                    </a>
                    <a href="<%= request.getContextPath() %>/admin/tours.jsp" class="menu-item">
                        <i class="fas fa-map-marked-alt"></i>
                        <span>Quản lý tour</span>
                    </a>
                    <a href="<%= request.getContextPath() %>/admin/history.jsp" class="menu-item">
                        <i class="fas fa-history"></i>
                        <span>Lịch sử</span>
                    </a>
                </div>
                <div class="menu-section">
                    <div class="menu-title">Hệ thống</div>
                    <a href="<%= request.getContextPath() %>/index.jsp" class="menu-item">
                        <i class="fas fa-home"></i>
                        <span>Về trang chủ</span>
                    </a>
                    <a href="<%= request.getContextPath() %>/logout" class="menu-item">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Đăng xuất</span>
                    </a>
                </div>
            </nav>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <div class="top-bar">
                <div class="top-bar-title">
                    <h1>Quản Lý Khách Hàng</h1>
                </div>
                <div class="top-bar-actions">
                    <a href="<%= request.getContextPath() %>/admin/customers?action=add" class="btn-add">
                        <i class="fas fa-plus"></i>
                        Thêm khách hàng mới
                    </a>
                </div>
            </div>
            
            <div class="content-area">
                <div class="content-header">
                    <form method="get" action="<%= request.getContextPath() %>/admin/customers" class="search-filter">
                        <div class="search-box">
                            <i class="fas fa-search"></i>
                            <input type="text" name="keyword" placeholder="Tìm kiếm theo tên, email, số điện thoại..." 
                                   value="<%= keyword != null ? keyword : "" %>">
                        </div>
                        <select name="status" class="filter-select" onchange="this.form.submit()">
                            <option value="">Tất cả trạng thái</option>
                            <option value="active" <%= "active".equals(filterStatus) ? "selected" : "" %>>Hoạt động</option>
                            <option value="inactive" <%= "inactive".equals(filterStatus) ? "selected" : "" %>>Không hoạt động</option>
                            <option value="banned" <%= "banned".equals(filterStatus) ? "selected" : "" %>>Bị cấm</option>
                        </select>
                        <select name="sortBy" class="filter-select">
                            <option value="">Mặc định</option>
                            <option value="name">Tên A-Z</option>
                            <option value="date">Ngày tạo</option>
                        </select>
                        <button type="submit" class="btn-export">
                            <i class="fas fa-search"></i>
                            Tìm kiếm
                        </button>
                    </form>
                </div>
                
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>HỌ TÊN</th>
                                <th>EMAIL</th>
                                <th>SỐ ĐIỆN THOẠI</th>
                                <th>ĐỊA CHỈ</th>
                                <th>TRẠNG THÁI</th>
                                <th>HÀNH ĐỘNG</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (customers != null && !customers.isEmpty()) {
                                for (Customer customer : customers) { 
                                    String status = customer.getStatus();
                                    String statusClass = "status-full";
                                    String statusText = "Không hoạt động";
                                    
                                    if ("active".equals(status)) {
                                        statusClass = "status-available";
                                        statusText = "Hoạt động";
                                    } else if ("banned".equals(status)) {
                                        statusClass = "status-banned";
                                        statusText = "Bị cấm";
                                    }
                            %>
                            <tr>
                                <td><%= customer.getId() %></td>
                                <td class="customer-name"><%= customer.getFullName() %></td>
                                <td><%= customer.getEmail() %></td>
                                <td><%= customer.getPhone() %></td>
                                <td><%= customer.getAddress() != null ? customer.getAddress() : "" %></td>
                                <td>
                                    <span class="status-badge <%= statusClass %>">
                                        <%= statusText %>
                                    </span>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="<%= request.getContextPath() %>/admin/customers?action=view&id=<%= customer.getId() %>" 
                                           class="btn-icon btn-view" title="Xem chi tiết">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="<%= request.getContextPath() %>/admin/customers?action=edit&id=<%= customer.getId() %>" 
                                           class="btn-icon btn-edit" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <button class="btn-icon btn-delete" title="Xóa" 
                                                onclick="if(confirm('Bạn có chắc muốn xóa khách hàng này?')) window.location.href='<%= request.getContextPath() %>/admin/customers?action=delete&id=<%= customer.getId() %>'">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <% 
                                }
                            } else { 
                            %>
                            <tr>
                                <td colspan="7" style="text-align: center; padding: 2rem; color: #9ca3af;">
                                    Không có khách hàng nào
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                    
                    <div class="pagination">
                        <div class="pagination-info">
                            Hiển thị <%= (currentPage - 1) * 10 + 1 %> - <%= Math.min(currentPage * 10, totalCustomers) %> trong tổng số <%= totalCustomers %> kết quả
                        </div>
                        <div class="pagination-buttons">
                            <% if (currentPage > 1) { %>
                                <a href="?page=<%= currentPage - 1 %><%= keyword != null ? "&keyword=" + keyword : "" %><%= filterStatus != null ? "&status=" + filterStatus : "" %>" 
                                   class="page-btn">«</a>
                            <% } %>
                            
                            <% 
                                int startPage = Math.max(1, currentPage - 2);
                                int endPage = Math.min(totalPages, currentPage + 2);
                                for (int i = startPage; i <= endPage; i++) { 
                            %>
                                <a href="?page=<%= i %><%= keyword != null ? "&keyword=" + keyword : "" %><%= filterStatus != null ? "&status=" + filterStatus : "" %>" 
                                   class="page-btn <%= i == currentPage ? "active" : "" %>"><%= i %></a>
                            <% } %>
                            
                            <% if (currentPage < totalPages) { %>
                                <a href="?page=<%= currentPage + 1 %><%= keyword != null ? "&keyword=" + keyword : "" %><%= filterStatus != null ? "&status=" + filterStatus : "" %>" 
                                   class="page-btn">»</a>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
