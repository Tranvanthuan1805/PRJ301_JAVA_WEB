<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    
    if (!"ADMIN".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    String searchKeyword = (String) request.getAttribute("searchKeyword");
    String success = request.getParameter("success");
    String error = request.getParameter("error");
    
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Đơn hàng - VietAir Admin</title>
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
        
        /* Sidebar - COPY EXACT từ tours.jsp */
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
        
        /* Content Area */
        .content-area {
            flex: 1;
            padding: 2rem;
            overflow-y: auto;
        }
        
        .content-header {
            margin-bottom: 1.5rem;
        }
        
        .search-filter {
            display: flex;
            gap: 1rem;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .search-box {
            flex: 1;
            min-width: 300px;
            position: relative;
        }
        
        .search-box i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
        }
        
        .search-box input {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 2.5rem;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 14px;
        }
        
        .search-box input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }
        
        .filter-select {
            padding: 0.75rem 1rem;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 14px;
            color: #374151;
            background: white;
            cursor: pointer;
        }
        
        .filter-select:focus {
            outline: none;
            border-color: var(--primary-color);
        }
        
        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .alert-success {
            background: #d1fae5;
            color: #065f46;
            border: 1px solid #6ee7b7;
        }
        
        .alert-error {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fca5a5;
        }
        
        /* Table */
        .table-container {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        thead {
            background: #f9fafb;
        }
        
        th {
            padding: 1rem;
            text-align: left;
            font-size: 11px;
            font-weight: 600;
            color: #6b7280;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid #e5e7eb;
        }
        
        td {
            padding: 1rem;
            font-size: 14px;
            color: #374151;
            border-bottom: 1px solid #f3f4f6;
        }
        
        tbody tr:hover {
            background: #f9fafb;
        }
        
        tbody tr:last-child td {
            border-bottom: none;
        }
        
        /* Status Badges */
        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .status-pending {
            background: #fef3c7;
            color: #92400e;
        }
        
        .status-confirmed {
            background: #dbeafe;
            color: #1e40af;
        }
        
        .status-completed {
            background: #d1fae5;
            color: #065f46;
        }
        
        .status-cancelled {
            background: #fee2e2;
            color: #991b1b;
        }
        
        .payment-unpaid {
            background: #fee2e2;
            color: #991b1b;
        }
        
        .payment-paid {
            background: #d1fae5;
            color: #065f46;
        }
        
        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }
        
        .btn-icon {
            width: 32px;
            height: 32px;
            display: inline-flex !important;
            align-items: center;
            justify-content: center;
            border-radius: 6px;
            border: 1px solid #d1d5db;
            background: white;
            color: #6b7280;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
        }
        
        .btn-icon:hover {
            background: #f9fafb;
        }
        
        .btn-view:hover {
            border-color: #3b82f6;
            color: #3b82f6;
            background: #eff6ff;
        }
        
        .btn-edit:hover {
            border-color: #10b981;
            color: #10b981;
            background: #d1fae5;
        }
        
        .btn-delete {
            display: inline-flex !important;
        }
        
        .btn-delete:hover {
            border-color: #ef4444;
            color: #ef4444;
            background: #fee2e2;
        }
        
        /* Pagination */
        .pagination {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 1.5rem;
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
            border-radius: 6px;
            background: white;
            color: #374151;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.2s;
        }
        
        .page-btn:hover {
            background: #f9fafb;
            border-color: #9ca3af;
        }
        
        .page-btn.active {
            background: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }
        
        .price-text {
            font-weight: 600;
            color: #059669;
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
                        <p>Admin Panel</p>
                    </div>
                </div>
            </div>
            
            <div class="sidebar-menu">
                <div class="menu-section">
                    <div class="menu-title">Quản lý</div>
                    <a href="<%= request.getContextPath() %>/admin/dashboard" class="menu-item">
                        <i class="fas fa-chart-line"></i>
                        <span>Dashboard</span>
                    </a>
                    <a href="<%= request.getContextPath() %>/admin/customers" class="menu-item">
                        <i class="fas fa-users"></i>
                        <span>Quản lý khách hàng</span>
                    </a>
                    <a href="<%= request.getContextPath() %>/admin/tours" class="menu-item">
                        <i class="fas fa-map-marked-alt"></i>
                        <span>Quản lý tour</span>
                    </a>
                    <a href="<%= request.getContextPath() %>/admin/orders" class="menu-item active">
                        <i class="fas fa-ticket-alt"></i>
                        <span>Quản lý đơn hàng</span>
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
            </div>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="top-bar">
                <div class="top-bar-title">
                    <h1>Quản Lý Đơn hàng</h1>
                </div>
            </div>

            <div class="content-area">
                <% if (success != null) { %>
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        <span>
                            <% if ("updated".equals(success)) { %>
                                Cập nhật trạng thái thành công!
                            <% } else if ("deleted".equals(success)) { %>
                                Xóa đơn hàng thành công!
                            <% } %>
                        </span>
                    </div>
                <% } %>
                
                <% if (error != null) { %>
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>
                            <% if ("invalid".equals(error)) { %>
                                Thông tin không hợp lệ!
                            <% } else if ("failed".equals(error)) { %>
                                Cập nhật thất bại!
                            <% } %>
                        </span>
                    </div>
                <% } %>

                <!-- Search & Filter -->
                <div class="content-header">
                    <form method="get" action="<%= request.getContextPath() %>/admin/orders" class="search-filter">
                        <div class="search-box">
                            <i class="fas fa-search"></i>
                            <input type="text" name="search" 
                                   placeholder="Tìm kiếm theo mã đơn hàng, tên khách hàng..." 
                                   value="<%= searchKeyword != null ? searchKeyword : "" %>">
                        </div>
                        <select name="status" class="filter-select" onchange="this.form.submit()">
                            <option value="all">Tất cả trạng thái</option>
                            <option value="PENDING" <%= "PENDING".equals(request.getAttribute("statusFilter")) ? "selected" : "" %>>Chờ xử lý</option>
                            <option value="CONFIRMED" <%= "CONFIRMED".equals(request.getAttribute("statusFilter")) ? "selected" : "" %>>Đã xác nhận</option>
                            <option value="COMPLETED" <%= "COMPLETED".equals(request.getAttribute("statusFilter")) ? "selected" : "" %>>Hoàn thành</option>
                            <option value="CANCELLED" <%= "CANCELLED".equals(request.getAttribute("statusFilter")) ? "selected" : "" %>>Đã hủy</option>
                        </select>
                        <select name="payment" class="filter-select" onchange="this.form.submit()">
                            <option value="all">Tất cả thanh toán</option>
                            <option value="UNPAID" <%= "UNPAID".equals(request.getAttribute("paymentFilter")) ? "selected" : "" %>>Chưa thanh toán</option>
                            <option value="PAID" <%= "PAID".equals(request.getAttribute("paymentFilter")) ? "selected" : "" %>>Đã thanh toán</option>
                        </select>
                        <select name="sortBy" class="filter-select" onchange="this.form.submit()">
                            <option value="">Mặc định</option>
                            <option value="date_desc" <%= "date_desc".equals(request.getAttribute("sortBy")) ? "selected" : "" %>>Mới nhất</option>
                            <option value="date_asc" <%= "date_asc".equals(request.getAttribute("sortBy")) ? "selected" : "" %>>Cũ nhất</option>
                            <option value="amount_desc" <%= "amount_desc".equals(request.getAttribute("sortBy")) ? "selected" : "" %>>Giá cao đến thấp</option>
                            <option value="amount_asc" <%= "amount_asc".equals(request.getAttribute("sortBy")) ? "selected" : "" %>>Giá thấp đến cao</option>
                        </select>
                        <button type="submit" class="btn-export">
                            <i class="fas fa-search"></i>
                            Tìm kiếm
                        </button>
                    </form>
                </div>

                <!-- Orders Table -->
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>MÃ ĐƠN</th>
                                <th>KHÁCH HÀNG</th>
                                <th>EMAIL</th>
                                <th>SĐT</th>
                                <th>TỔNG TIỀN</th>
                                <th>TRẠNG THÁI</th>
                                <th>THANH TOÁN</th>
                                <th>NGÀY ĐẶT</th>
                                <th>HÀNH ĐỘNG</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (orders != null && !orders.isEmpty()) {
                                for (Order order : orders) { %>
                                    <tr>
                                        <td><strong><%= order.getOrderCode() %></strong></td>
                                        <td><%= order.getCustomerName() %></td>
                                        <td><%= order.getCustomerEmail() %></td>
                                        <td><%= order.getCustomerPhone() %></td>
                                        <td class="price-text"><%= String.format("%,.0f", order.getTotalAmount()) %> VNĐ</td>
                                        <td>
                                            <span class="status-badge status-<%= order.getStatus().toLowerCase() %>">
                                                <%= order.getStatusDisplay() %>
                                            </span>
                                        </td>
                                        <td>
                                            <span class="status-badge payment-<%= order.getPaymentStatus().toLowerCase() %>">
                                                <%= order.getPaymentStatusDisplay() %>
                                            </span>
                                        </td>
                                        <td><%= order.getCreatedAt().format(formatter) %></td>
                                        <td>
                                            <div class="action-buttons">
                                                <a href="<%= request.getContextPath() %>/admin/orders?action=edit&id=<%= order.getId() %>" class="btn-icon btn-edit" title="Chỉnh sửa đơn hàng">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="javascript:void(0)" class="btn-icon btn-delete" title="Xóa đơn hàng" 
                                                   data-order-code="<%= order.getOrderCode() %>" 
                                                   data-order-id="<%= order.getId() %>"
                                                   onclick="confirmDelete(this.getAttribute('data-order-code'), this.getAttribute('data-order-id'))">
                                                    <i class="fas fa-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                <% }
                            } else { %>
                                <tr>
                                    <td colspan="9" style="text-align: center; padding: 2rem; color: #9ca3af;">
                                        Không có đơn hàng nào
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                    
                    <% if (orders != null && !orders.isEmpty()) { %>
                        <div class="pagination">
                            <div class="pagination-info">
                                Tổng số: <strong><%= orders.size() %></strong> đơn hàng
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
        </main>
    </div>

    <script>
        function confirmDelete(orderCode, orderId) {
            if (confirm('Bạn có chắc muốn xóa đơn hàng ' + orderCode + '?')) {
                deleteOrder(orderId);
            }
        }
        
        function deleteOrder(orderId) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '<%= request.getContextPath() %>/admin/orders';
            
            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'delete';
            form.appendChild(actionInput);
            
            const orderIdInput = document.createElement('input');
            orderIdInput.type = 'hidden';
            orderIdInput.name = 'orderId';
            orderIdInput.value = orderId;
            form.appendChild(orderIdInput);
            
            document.body.appendChild(form);
            form.submit();
        }
    </script>
</body>
</html>
