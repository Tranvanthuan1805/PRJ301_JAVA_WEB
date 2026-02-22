<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
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
    OrderDetailDTO order = (OrderDetailDTO) request.getAttribute("order");
    OrderStatus[] statuses = (OrderStatus[]) request.getAttribute("statuses");
    
    if (order == null) {
        response.sendRedirect(ctx + "/admin/orders");
        return;
    }
    
    OrderStatus currentStatus = order.getStatusEnum();
    boolean isCancelled = "Cancelled".equals(order.getStatus());
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Đơn hàng #<%= order.getOrderId() %> - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #f0f2f5; }
        .detail-card { border: none; border-radius: 16px; }
        .info-label { color: #6c757d; font-size: 0.875rem; }
        .info-value { font-weight: 500; }
        .topbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white; border-radius: 16px; margin-bottom: 1.5rem;
        }
        .tour-img { width: 100%; height: 200px; object-fit: cover; border-radius: 12px; }
        .status-timeline { display: flex; justify-content: space-between; position: relative; margin: 1rem 0; }
        .status-timeline::before { content: ''; position: absolute; top: 15px; left: 0; right: 0; height: 3px; background: #e9ecef; }
        .timeline-step { text-align: center; position: relative; z-index: 1; }
        .timeline-step .step-circle { width: 32px; height: 32px; border-radius: 50%; background: #e9ecef; display: flex; align-items: center; justify-content: center; margin: 0 auto 0.5rem; font-size: 0.875rem; }
        .timeline-step.active .step-circle { background: #667eea; color: white; }
        .timeline-step.completed .step-circle { background: #28a745; color: white; }
        .timeline-step.cancelled .step-circle { background: #dc3545; color: white; }
    </style>
</head>
<body>
<div class="container-fluid py-4 px-4">
    
    <!-- Top Bar -->
    <div class="topbar p-4">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <h3 class="mb-1"><i class="bi bi-receipt me-2"></i>Đơn hàng #<%= order.getOrderId() %></h3>
                <p class="mb-0 opacity-75">Chi tiết đơn đặt tour</p>
            </div>
            <div>
                <a href="<%= ctx %>/admin/orders" class="btn btn-outline-light">
                    <i class="bi bi-arrow-left"></i> Quay lại
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
               else if ("payment_confirmed".equals(msg)) out.print("Đã xác nhận thanh toán!");
               else out.print("Thao tác thành công!");
            %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>
    <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i>Có lỗi xảy ra. Vui lòng thử lại.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>
    
    <div class="row g-4">
        <!-- Left Column -->
        <div class="col-lg-8">
            
            <!-- Status Timeline -->
            <div class="card detail-card shadow-sm mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="bi bi-signpost-2 me-2"></i>Trạng thái đơn hàng</h5>
                </div>
                <div class="card-body">
                    <div class="status-timeline">
                        <% 
                        String[] timelineStatuses = {"Pending", "Confirmed", "Completed"};
                        String[] timelineLabels = {"Chờ xác nhận", "Đã xác nhận", "Hoàn thành"};
                        String[] timelineIcons = {"clock", "check", "trophy"};
                        int currentIndex = -1;
                        for (int i = 0; i < timelineStatuses.length; i++) {
                            if (timelineStatuses[i].equals(order.getStatus())) currentIndex = i;
                        }
                        for (int i = 0; i < timelineStatuses.length; i++) {
                            String stepClass = "";
                            if (isCancelled) stepClass = "cancelled";
                            else if (i < currentIndex) stepClass = "completed";
                            else if (i == currentIndex) stepClass = "active";
                        %>
                        <div class="timeline-step <%= stepClass %>">
                            <div class="step-circle"><i class="bi bi-<%= timelineIcons[i] %>"></i></div>
                            <div class="small"><%= timelineLabels[i] %></div>
                        </div>
                        <% } %>
                    </div>
                    
                    <% if (isCancelled) { %>
                        <div class="alert alert-danger mt-3 mb-0">
                            <i class="bi bi-x-circle me-2"></i><strong>Đơn hàng đã bị hủy</strong>
                            <% if (order.getCancelReason() != null && !order.getCancelReason().isEmpty()) { %>
                                <br><small>Lý do: <%= order.getCancelReason() %></small>
                            <% } %>
                        </div>
                    <% } %>
                    
                    <div class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top">
                        <div>
                            <span class="info-label">Trạng thái:</span>
                            <span class="badge bg-<%= order.getStatusBadgeClass() %> ms-2"><%= order.getStatusDisplayName() %></span>
                        </div>
                        <div>
                            <span class="info-label">Thanh toán:</span>
                            <% if ("Paid".equals(order.getPaymentStatus())) { %>
                                <span class="badge bg-success ms-2">Đã thanh toán</span>
                            <% } else if ("Refunded".equals(order.getPaymentStatus())) { %>
                                <span class="badge bg-secondary ms-2">Đã hoàn tiền</span>
                            <% } else { %>
                                <span class="badge bg-warning text-dark ms-2">Chưa thanh toán</span>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Order Details -->
            <div class="card detail-card shadow-sm mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="bi bi-info-circle me-2"></i>Thông tin đơn hàng</h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="info-label">Mã đơn hàng</div>
                            <div class="info-value">#<%= order.getOrderId() %></div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-label">Ngày đặt</div>
                            <div class="info-value"><%= formatDate(order.getOrderDate()) %></div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-label">Số người</div>
                            <div class="info-value"><%= order.getNumberOfPeople() %> người</div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-label">Tổng tiền</div>
                            <div class="info-value text-primary fs-5"><%= formatCurrency(order.getTotalPrice()) %> VND</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Customer Info -->
            <div class="card detail-card shadow-sm mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="bi bi-person me-2"></i>Thông tin khách hàng</h5>
                </div>
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="bg-primary bg-opacity-10 rounded-circle p-3 me-3">
                            <i class="bi bi-person-circle text-primary fs-3"></i>
                        </div>
                        <div>
                            <div class="fw-semibold fs-5"><%= order.getUsername() %></div>
                            <div class="text-muted">User ID: <%= order.getUserId() %></div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Tour Info -->
            <div class="card detail-card shadow-sm">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="bi bi-geo-alt me-2"></i>Thông tin Tour</h5>
                </div>
                <div class="card-body">
                    <h5 class="mb-3"><%= order.getTourName() %></h5>
                    <div class="row g-2">
                        <div class="col-6">
                            <div class="info-label">Giá/người</div>
                            <div class="info-value"><%= formatCurrency(order.getTourPrice()) %> VND</div>
                        </div>
                        <% if (order.getTourDuration() != null) { %>
                        <div class="col-6">
                            <div class="info-label">Thời gian</div>
                            <div class="info-value"><%= order.getTourDuration() %></div>
                        </div>
                        <% } %>
                        <% if (order.getTourLocation() != null) { %>
                        <div class="col-6">
                            <div class="info-label">Điểm khởi hành</div>
                            <div class="info-value"><%= order.getTourLocation() %></div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Right Column - Actions -->
        <div class="col-lg-4">
            
            <!-- Update Status -->
            <% if (!currentStatus.isFinalState()) { %>
            <div class="card detail-card shadow-sm mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="bi bi-arrow-repeat me-2"></i>Cập nhật trạng thái</h5>
                </div>
                <div class="card-body">
                    <form action="<%= ctx %>/admin/orders" method="post">
                        <input type="hidden" name="action" value="updateStatus">
                        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                        <div class="mb-3">
                            <label class="form-label">Chuyển sang:</label>
                            <select name="newStatus" class="form-select">
                                <% for (OrderStatus status : statuses) {
                                    if (currentStatus.canTransitionTo(status)) { %>
                                        <option value="<%= status.getCode() %>"><%= status.getDisplayName() %></option>
                                <% }} %>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary w-100"><i class="bi bi-check-lg me-2"></i>Cập nhật</button>
                    </form>
                </div>
            </div>
            <% } %>
            
            <!-- Confirm Payment -->
            <% if ("Unpaid".equals(order.getPaymentStatus()) && !isCancelled) { %>
            <div class="card detail-card shadow-sm mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="bi bi-credit-card me-2"></i>Xác nhận thanh toán</h5>
                </div>
                <div class="card-body">
                    <form action="<%= ctx %>/admin/orders" method="post">
                        <input type="hidden" name="action" value="confirmPayment">
                        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                        <button type="submit" class="btn btn-success w-100"><i class="bi bi-check-circle me-2"></i>Xác nhận đã thanh toán</button>
                    </form>
                </div>
            </div>
            <% } %>
            
            <!-- Cancel Order -->
            <% if (order.canCancel()) { %>
            <div class="card detail-card shadow-sm border-danger">
                <div class="card-header bg-danger bg-opacity-10">
                    <h5 class="mb-0 text-danger"><i class="bi bi-x-circle me-2"></i>Hủy đơn hàng</h5>
                </div>
                <div class="card-body">
                    <form action="<%= ctx %>/admin/orders" method="post" onsubmit="return confirm('Bạn có chắc muốn hủy đơn hàng này?');">
                        <input type="hidden" name="action" value="cancel">
                        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                        <div class="mb-3">
                            <label class="form-label">Lý do hủy:</label>
                            <textarea name="cancelReason" class="form-control" rows="3" placeholder="Nhập lý do..."></textarea>
                        </div>
                        <button type="submit" class="btn btn-danger w-100"><i class="bi bi-x-lg me-2"></i>Hủy đơn hàng</button>
                    </form>
                </div>
            </div>
            <% } %>
            
            <!-- Back Button -->
            <div class="card detail-card shadow-sm mt-4">
                <div class="card-body">
                    <a href="<%= ctx %>/admin/orders" class="btn btn-outline-secondary w-100">
                        <i class="bi bi-arrow-left me-2"></i>Quay lại danh sách
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
