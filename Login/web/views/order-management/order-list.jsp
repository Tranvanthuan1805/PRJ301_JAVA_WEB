<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.OrderDetailDTO" %>
<%@ page import="model.OrderStatus" %>
<%@ page import="model.User" %>
<%!
    // Helper method to format currency
    public String formatCurrency(Double amount) {
        if (amount == null) return "0";
        NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
        nf.setMaximumFractionDigits(0);
        return nf.format(amount);
    }
    
    // Helper method to format date
    public String formatDate(java.util.Date date) {
        if (date == null) return "";
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        return sdf.format(date);
    }
%>
<%
    // Auth check
    HttpSession s = request.getSession(false);
    User u = (s == null) ? null : (User) s.getAttribute("user");
    if (u == null || !"ADMIN".equalsIgnoreCase(u.roleName)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    String ctx = request.getContextPath();
    List<OrderDetailDTO> orders = (List<OrderDetailDTO>) request.getAttribute("orders");
    Long pendingCount = (Long) request.getAttribute("pendingCount");
    Long confirmedCount = (Long) request.getAttribute("confirmedCount");
    Long completedCount = (Long) request.getAttribute("completedCount");
    Long cancelledCount = (Long) request.getAttribute("cancelledCount");
    Double totalRevenue = (Double) request.getAttribute("totalRevenue");
    String selectedStatus = (String) request.getAttribute("selectedStatus");
    OrderStatus[] statuses = (OrderStatus[]) request.getAttribute("statuses");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đơn hàng - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #f0f2f5; }
        .stat-card {
            border: none;
            border-radius: 16px;
            transition: transform 0.2s;
        }
        .stat-card:hover { transform: translateY(-2px); }
        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }
        .table-card {
            border: none;
            border-radius: 16px;
            overflow: hidden;
        }
        .btn-action { padding: 0.25rem 0.5rem; font-size: 0.875rem; }
        .topbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 16px;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>
<div class="container-fluid py-4 px-4">
    
    <!-- Top Bar -->
    <div class="topbar p-4">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <h3 class="mb-1"><i class="bi bi-receipt me-2"></i>Quản lý Đơn hàng</h3>
                <p class="mb-0 opacity-75">Theo dõi và quản lý tất cả đơn đặt tour</p>
            </div>
            <div class="text-end">
                <div class="fw-semibold"><%= u.username %></div>
                <span class="badge bg-light text-dark">ADMIN</span>
                <a href="<%= ctx %>/admin.jsp" class="btn btn-outline-light btn-sm ms-2">
                    <i class="bi bi-arrow-left"></i> Dashboard
                </a>
            </div>
        </div>
    </div>
    
    <!-- Alert Messages -->
    <% if (request.getParameter("msg") != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle me-2"></i>
            <% String msg = request.getParameter("msg");
               if ("status_updated".equals(msg)) out.print("Cập nhật trạng thái thành công!");
               else if ("order_cancelled".equals(msg)) out.print("Đã hủy đơn hàng thành công!");
               else if ("payment_confirmed".equals(msg)) out.print("Đã xác nhận thanh toán!");
               else out.print("Thao tác thành công!");
            %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>
    <% if (request.getParameter("error") != null || request.getAttribute("error") != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i>
            <%= request.getAttribute("error") != null ? request.getAttribute("error") : "Có lỗi xảy ra. Vui lòng thử lại." %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>
    
    <!-- Statistics Cards -->
    <div class="row g-3 mb-4">
        <div class="col-md-3 col-sm-6">
            <div class="card stat-card shadow-sm h-100">
                <div class="card-body d-flex align-items-center">
                    <div class="stat-icon bg-warning bg-opacity-10 text-warning me-3">
                        <i class="bi bi-clock"></i>
                    </div>
                    <div>
                        <div class="text-muted small">Chờ xác nhận</div>
                        <div class="h4 mb-0"><%= pendingCount != null ? pendingCount : 0 %></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card stat-card shadow-sm h-100">
                <div class="card-body d-flex align-items-center">
                    <div class="stat-icon bg-info bg-opacity-10 text-info me-3">
                        <i class="bi bi-check-circle"></i>
                    </div>
                    <div>
                        <div class="text-muted small">Đã xác nhận</div>
                        <div class="h4 mb-0"><%= confirmedCount != null ? confirmedCount : 0 %></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card stat-card shadow-sm h-100">
                <div class="card-body d-flex align-items-center">
                    <div class="stat-icon bg-success bg-opacity-10 text-success me-3">
                        <i class="bi bi-trophy"></i>
                    </div>
                    <div>
                        <div class="text-muted small">Hoàn thành</div>
                        <div class="h4 mb-0"><%= completedCount != null ? completedCount : 0 %></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card stat-card shadow-sm h-100">
                <div class="card-body d-flex align-items-center">
                    <div class="stat-icon bg-primary bg-opacity-10 text-primary me-3">
                        <i class="bi bi-currency-dollar"></i>
                    </div>
                    <div>
                        <div class="text-muted small">Doanh thu</div>
                        <div class="h5 mb-0"><%= formatCurrency(totalRevenue) %> VND</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Filter & Orders Table -->
    <div class="card table-card shadow-sm">
        <div class="card-header bg-white py-3">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                <h5 class="mb-0"><i class="bi bi-list-ul me-2"></i>Danh sách đơn hàng</h5>
                
                <!-- Filter Form -->
                <form action="<%= ctx %>/admin/orders" method="get" class="d-flex gap-2">
                    <input type="hidden" name="action" value="filter">
                    <select name="status" class="form-select form-select-sm" style="width: auto;">
                        <option value="all" <%= (selectedStatus == null || "all".equals(selectedStatus)) ? "selected" : "" %>>Tất cả trạng thái</option>
                        <% if (statuses != null) { for (OrderStatus status : statuses) { %>
                            <option value="<%= status.getCode() %>" <%= status.getCode().equals(selectedStatus) ? "selected" : "" %>>
                                <%= status.getDisplayName() %>
                            </option>
                        <% }} %>
                    </select>
                    <button type="submit" class="btn btn-primary btn-sm">
                        <i class="bi bi-funnel"></i> Lọc
                    </button>
                </form>
            </div>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Mã đơn</th>
                            <th>Khách hàng</th>
                            <th>Tour</th>
                            <th>Ngày đặt</th>
                            <th class="text-center">Số người</th>
                            <th class="text-end">Tổng tiền</th>
                            <th class="text-center">Trạng thái</th>
                            <th class="text-center">Thanh toán</th>
                            <th class="text-center">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (orders == null || orders.isEmpty()) { %>
                            <tr>
                                <td colspan="9" class="text-center text-muted py-4">
                                    <i class="bi bi-inbox display-6 d-block mb-2"></i>
                                    Không có đơn hàng nào
                                </td>
                            </tr>
                        <% } else { for (OrderDetailDTO order : orders) { %>
                            <tr>
                                <td><strong>#<%= order.getOrderId() %></strong></td>
                                <td>
                                    <i class="bi bi-person-circle me-1"></i>
                                    <%= order.getUsername() %>
                                </td>
                                <td>
                                    <div class="text-truncate" style="max-width: 200px;" title="<%= order.getTourName() %>">
                                        <%= order.getTourName() %>
                                    </div>
                                </td>
                                <td>
                                    <%= formatDate(order.getOrderDate()) %>
                                </td>
                                <td class="text-center">
                                    <span class="badge bg-secondary"><%= order.getNumberOfPeople() %></span>
                                </td>
                                <td class="text-end fw-semibold">
                                    <%= formatCurrency(order.getTotalPrice()) %> VND
                                </td>
                                <td class="text-center">
                                    <span class="badge bg-<%= order.getStatusBadgeClass() %>">
                                        <%= order.getStatusDisplayName() %>
                                    </span>
                                </td>
                                <td class="text-center">
                                    <% if ("Paid".equals(order.getPaymentStatus())) { %>
                                        <span class="badge bg-success"><i class="bi bi-check"></i> Đã TT</span>
                                    <% } else if ("Refunded".equals(order.getPaymentStatus())) { %>
                                        <span class="badge bg-secondary">Hoàn tiền</span>
                                    <% } else { %>
                                        <span class="badge bg-warning text-dark">Chưa TT</span>
                                    <% } %>
                                </td>
                                <td class="text-center">
                                    <a href="<%= ctx %>/admin/orders?action=view&id=<%= order.getOrderId() %>" 
                                       class="btn btn-outline-primary btn-action" title="Xem chi tiết">
                                        <i class="bi bi-eye"></i>
                                    </a>
                                </td>
                            </tr>
                        <% }} %>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="card-footer bg-white text-muted small">
            Tổng: <%= orders != null ? orders.size() : 0 %> đơn hàng
            <% if (cancelledCount != null && cancelledCount > 0) { %>
                | <span class="text-danger"><%= cancelledCount %> đã hủy</span>
            <% } %>
        </div>
    </div>
    
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
