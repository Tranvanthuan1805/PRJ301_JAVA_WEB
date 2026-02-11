<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.OrderDetailDTO" %>
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
    if (u == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    String ctx = request.getContextPath();
    List<OrderDetailDTO> orders = (List<OrderDetailDTO>) request.getAttribute("orders");
    Long pendingCount = (Long) request.getAttribute("pendingCount");
    Long confirmedCount = (Long) request.getAttribute("confirmedCount");
    Long completedCount = (Long) request.getAttribute("completedCount");
    Long cancelledCount = (Long) request.getAttribute("cancelledCount");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng của tôi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #f0f2f5; }
        .stat-card { border: none; border-radius: 16px; transition: transform 0.2s; }
        .stat-card:hover { transform: translateY(-2px); }
        .order-card { border: none; border-radius: 16px; transition: all 0.2s; }
        .order-card:hover { box-shadow: 0 8px 25px rgba(0,0,0,0.1); }
        .topbar {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white; border-radius: 16px; margin-bottom: 1.5rem;
        }
        .tour-thumb { width: 80px; height: 80px; object-fit: cover; border-radius: 12px; }
    </style>
</head>
<body>
<div class="container py-4">
    
    <!-- Top Bar -->
    <div class="topbar p-4">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <h3 class="mb-1"><i class="bi bi-bag-check me-2"></i>Đơn hàng của tôi</h3>
                <p class="mb-0 opacity-75">Xem lịch sử và trạng thái đơn đặt tour</p>
            </div>
            <div class="text-end">
                <div class="fw-semibold"><%= u.username %></div>
                <a href="<%= ctx %>/user.jsp" class="btn btn-outline-light btn-sm mt-1">
                    <i class="bi bi-arrow-left"></i> Trang chủ
                </a>
            </div>
        </div>
    </div>
    
    <!-- Alert Messages -->
    <% if (request.getParameter("msg") != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle me-2"></i>
            <% String msg = request.getParameter("msg");
               if ("order_cancelled".equals(msg)) out.print("Đã hủy đơn hàng thành công!");
               else out.print("Thao tác thành công!");
            %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>
    <% if (request.getParameter("error") != null || request.getAttribute("error") != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i>
            <% String err = request.getParameter("error");
               if ("cannot_cancel".equals(err)) out.print("Không thể hủy đơn hàng này!");
               else if ("unauthorized".equals(err)) out.print("Bạn không có quyền thực hiện thao tác này!");
               else out.print(request.getAttribute("error") != null ? request.getAttribute("error") : "Có lỗi xảy ra.");
            %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>
    
    <!-- Statistics -->
    <div class="row g-3 mb-4">
        <div class="col-6 col-md-3">
            <div class="card stat-card shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="text-warning fs-2"><i class="bi bi-clock"></i></div>
                    <div class="h4 mb-0"><%= pendingCount != null ? pendingCount : 0 %></div>
                    <div class="text-muted small">Chờ xác nhận</div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card stat-card shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="text-info fs-2"><i class="bi bi-check-circle"></i></div>
                    <div class="h4 mb-0"><%= confirmedCount != null ? confirmedCount : 0 %></div>
                    <div class="text-muted small">Đã xác nhận</div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card stat-card shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="text-success fs-2"><i class="bi bi-trophy"></i></div>
                    <div class="h4 mb-0"><%= completedCount != null ? completedCount : 0 %></div>
                    <div class="text-muted small">Hoàn thành</div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card stat-card shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="text-danger fs-2"><i class="bi bi-x-circle"></i></div>
                    <div class="h4 mb-0"><%= cancelledCount != null ? cancelledCount : 0 %></div>
                    <div class="text-muted small">Đã hủy</div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Orders List -->
    <div class="card shadow-sm" style="border: none; border-radius: 16px;">
        <div class="card-header bg-white py-3">
            <h5 class="mb-0"><i class="bi bi-list-ul me-2"></i>Lịch sử đơn hàng</h5>
        </div>
        <div class="card-body">
            <% if (orders == null || orders.isEmpty()) { %>
                <div class="text-center text-muted py-5">
                    <i class="bi bi-inbox display-4 d-block mb-3"></i>
                    <p>Bạn chưa có đơn hàng nào</p>
                    <a href="<%= ctx %>/home" class="btn btn-primary">
                        <i class="bi bi-search me-2"></i>Khám phá Tour
                    </a>
                </div>
            <% } else { 
                for (OrderDetailDTO order : orders) { %>
                <div class="card order-card shadow-sm mb-3">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <!-- Tour Image -->
                            <div class="col-auto">
                                <% if (order.getTourImage() != null && !order.getTourImage().isEmpty()) { %>
                                    <img src="<%= order.getTourImage() %>" class="tour-thumb" alt="Tour"
                                         onerror="this.src='https://via.placeholder.com/80x80?text=Tour'">
                                <% } else { %>
                                    <div class="tour-thumb bg-light d-flex align-items-center justify-content-center">
                                        <i class="bi bi-image text-muted fs-4"></i>
                                    </div>
                                <% } %>
                            </div>
                            
                            <!-- Order Info -->
                            <div class="col">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <div>
                                        <h6 class="mb-1"><%= order.getTourName() %></h6>
                                        <small class="text-muted">
                                            Mã đơn: #<%= order.getOrderId() %> | 
                                            <%= formatDate(order.getOrderDate()) %>
                                        </small>
                                    </div>
                                    <span class="badge bg-<%= order.getStatusBadgeClass() %>">
                                        <%= order.getStatusDisplayName() %>
                                    </span>
                                </div>
                                
                                <div class="row g-2 small">
                                    <div class="col-auto">
                                        <i class="bi bi-people me-1"></i><%= order.getNumberOfPeople() %> người
                                    </div>
                                    <div class="col-auto">
                                        <i class="bi bi-cash me-1"></i>
                                        <strong class="text-primary">
                                            <%= formatCurrency(order.getTotalPrice()) %> VND
                                        </strong>
                                    </div>
                                    <div class="col-auto">
                                        <% if ("Paid".equals(order.getPaymentStatus())) { %>
                                            <span class="text-success"><i class="bi bi-check-circle me-1"></i>Đã thanh toán</span>
                                        <% } else if ("Refunded".equals(order.getPaymentStatus())) { %>
                                            <span class="text-secondary"><i class="bi bi-arrow-repeat me-1"></i>Đã hoàn tiền</span>
                                        <% } else { %>
                                            <span class="text-warning"><i class="bi bi-clock me-1"></i>Chưa thanh toán</span>
                                        <% } %>
                                    </div>
                                </div>
                                
                                <% if (order.getCancelReason() != null && !order.getCancelReason().isEmpty()) { %>
                                    <div class="mt-2 small text-danger">
                                        <i class="bi bi-info-circle me-1"></i>Lý do hủy: <%= order.getCancelReason() %>
                                    </div>
                                <% } %>
                            </div>
                            
                            <!-- Actions -->
                            <div class="col-auto">
                                <% if (order.canCancel()) { %>
                                    <button type="button" class="btn btn-outline-danger btn-sm" 
                                            data-bs-toggle="modal" data-bs-target="#cancelModal<%= order.getOrderId() %>">
                                        <i class="bi bi-x-lg"></i> Hủy
                                    </button>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Cancel Modal -->
                <% if (order.canCancel()) { %>
                <div class="modal fade" id="cancelModal<%= order.getOrderId() %>" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Hủy đơn hàng #<%= order.getOrderId() %></h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <form action="<%= ctx %>/my-orders" method="post">
                                <input type="hidden" name="action" value="cancel">
                                <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                <div class="modal-body">
                                    <p>Bạn có chắc muốn hủy đơn hàng này?</p>
                                    <p class="text-muted small">Tour: <strong><%= order.getTourName() %></strong></p>
                                    <div class="mb-3">
                                        <label class="form-label">Lý do hủy:</label>
                                        <textarea name="cancelReason" class="form-control" rows="3" 
                                                  placeholder="Vui lòng cho chúng tôi biết lý do..."></textarea>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    <button type="submit" class="btn btn-danger">Xác nhận hủy</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <% } %>
                
            <% }} %>
        </div>
    </div>
    
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
