<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer" %>
<%@ page import="dao.CustomerDAO" %>
<%@ page import="util.DatabaseConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    // Check admin access
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    
    if (username == null || !"ADMIN".equals(role)) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    // Load customers
    List<Customer> customers = null;
    int totalCustomers = 0;
    try {
        Connection conn = DatabaseConnection.getNewConnection();
        CustomerDAO customerDAO = new CustomerDAO(conn);
        customers = customerDAO.getAllCustomers();
        totalCustomers = customers != null ? customers.size() : 0;
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
        
        .customers-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 1.5rem;
            padding: 1.5rem;
        }
        
        .customer-card {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            overflow: hidden;
            transition: all 0.2s;
        }
        
        .customer-card:hover {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
        }
        
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem;
            background: #f9fafb;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .customer-id {
            font-size: 14px;
            font-weight: 600;
            color: #6b7280;
        }
        
        .card-body {
            padding: 1.5rem;
        }
        
        .customer-name {
            font-size: 18px;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 1rem;
        }
        
        .customer-info {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }
        
        .info-row {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 14px;
            color: #6b7280;
        }
        
        .info-row i {
            width: 16px;
            color: var(--primary-color);
        }
        
        .card-footer {
            display: flex;
            justify-content: center;
            gap: 0.5rem;
            padding: 1rem;
            background: #f9fafb;
            border-top: 1px solid #e5e7eb;
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
        
        .status-active {
            background: #d1fae5;
            color: #065f46;
        }
        
        .status-inactive {
            background: #fee2e2;
            color: #991b1b;
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
                    <a href="<%= request.getContextPath() %>/tour?action=list" class="menu-item">
                        <i class="fas fa-map-marked-alt"></i>
                        <span>Quản lý tour</span>
                    </a>
                    <a href="<%= request.getContextPath() %>/history.jsp" class="menu-item">
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
                    <button class="btn-export">
                        <i class="fas fa-download"></i>
                        Xuất dữ liệu
                    </button>
                    <button class="btn-add">
                        <i class="fas fa-plus"></i>
                        Thêm mới
                    </button>
                </div>
            </div>
            
            <div class="content-area">
                <div class="content-header">
                    <form method="get" action="<%= request.getContextPath() %>/admin/customers" class="search-filter">
                        <div class="search-box">
                            <i class="fas fa-search"></i>
                            <input type="text" name="search" placeholder="Tìm kiếm theo tên, email..." value="<%= request.getAttribute("searchQuery") != null ? request.getAttribute("searchQuery") : "" %>">
                        </div>
                        <select name="status" class="filter-select" onchange="this.form.submit()">
                            <option value="">Tất cả trạng thái</option>
                            <option value="ACTIVE" <%= "ACTIVE".equals(request.getAttribute("statusFilter")) ? "selected" : "" %>>Đang hoạt động</option>
                            <option value="LOCKED" <%= "LOCKED".equals(request.getAttribute("statusFilter")) ? "selected" : "" %>>Đã khóa</option>
                        </select>
                        <select name="sortBy" class="filter-select" onchange="this.form.submit()">
                            <option value="">Sắp xếp theo</option>
                            <option value="name" <%= "name".equals(request.getAttribute("sortBy")) ? "selected" : "" %>>Tên</option>
                            <option value="email" <%= "email".equals(request.getAttribute("sortBy")) ? "selected" : "" %>>Email</option>
                            <option value="date" <%= "date".equals(request.getAttribute("sortBy")) ? "selected" : "" %>>Ngày tạo</option>
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
                                <th>TÊN KHÁCH HÀNG</th>
                                <th>EMAIL</th>
                                <th>SỐ ĐIỆN THOẠI</th>
                                <th>ĐỊA CHỈ</th>
                                <th>TRẠNG THÁI</th>
                                <th>NGÀY TẠO</th>
                                <th>HÀNH ĐỘNG</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (customers != null && !customers.isEmpty()) {
                                for (Customer customer : customers) { %>
                                    <tr>
                                        <td><%= customer.getId() %></td>
                                        <td class="customer-name"><%= customer.getFullName() %></td>
                                        <td><%= customer.getEmail() %></td>
                                        <td><%= customer.getPhone() != null ? customer.getPhone() : "-" %></td>
                                        <td><%= customer.getAddress() != null ? customer.getAddress() : "-" %></td>
                                        <td>
                                            <span class="status-badge <%= customer.getStatus().equals("ACTIVE") ? "status-active" : "status-inactive" %>">
                                                <%= customer.getStatus().equals("ACTIVE") ? "Hoạt động" : "Khóa" %>
                                            </span>
                                        </td>
                                        <td><%= customer.getCreatedAt().format(formatter) %></td>
                                        <td>
                                            <div class="action-buttons">
                                                <button class="btn-icon btn-view" title="Xem chi tiết">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                                <button class="btn-icon btn-edit" title="Chỉnh sửa">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn-icon btn-delete" title="Xóa">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                            <% }
                            } else { %>
                                <tr>
                                    <td colspan="8" style="text-align: center; padding: 2rem; color: #9ca3af;">
                                        Không có khách hàng nào
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                    
                    <div class="pagination">
                        <div class="pagination-info">
                            Hiển thị 1 - <%= Math.min(10, totalCustomers) %> trong tổng số <%= totalCustomers %> kết quả
                        </div>
                        <div class="pagination-buttons">
                            <button class="page-btn active">1</button>
                            <button class="page-btn">2</button>
                            <button class="page-btn">10</button>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
