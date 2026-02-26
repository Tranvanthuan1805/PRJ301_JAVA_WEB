<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    boolean isAdmin = "ADMIN".equals(role);
    
    if (username == null || !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${tour != null ? 'Sửa' : 'Thêm'} Tour - VietAir Admin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/vietair-style.css" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; background: #f5f7fa; }
        
        .admin-container { display: flex; min-height: 100vh; }
        
        /* Sidebar */
        .sidebar { width: 260px; background: white; border-right: 1px solid #e5e7eb; display: flex; flex-direction: column; }
        .sidebar-header { padding: 1.5rem; border-bottom: 1px solid #e5e7eb; }
        .sidebar-brand { display: flex; align-items: center; gap: 12px; color: var(--primary-color); }
        .sidebar-brand i { font-size: 24px; }
        .sidebar-brand-text h3 { font-size: 16px; font-weight: 700; color: #1f2937; }
        .sidebar-brand-text p { font-size: 12px; color: #6b7280; }
        .sidebar-menu { flex: 1; padding: 1rem 0; }
        .menu-section { margin-bottom: 1.5rem; }
        .menu-title { padding: 0 1.5rem; font-size: 11px; font-weight: 600; color: #9ca3af; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 0.5rem; }
        .menu-item { display: flex; align-items: center; gap: 12px; padding: 0.75rem 1.5rem; color: #6b7280; text-decoration: none; transition: all 0.2s; }
        .menu-item:hover { background: #f9fafb; color: var(--primary-color); }
        .menu-item.active { background: #eff6ff; color: var(--primary-color); border-right: 3px solid var(--primary-color); font-weight: 600; }
        .menu-item i { width: 20px; text-align: center; }
        
        /* Main Content */
        .main-content { flex: 1; display: flex; flex-direction: column; }
        .top-bar { background: white; border-bottom: 1px solid #e5e7eb; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .top-bar-title h1 { font-size: 20px; font-weight: 700; color: #1f2937; }
        .content-area { flex: 1; padding: 2rem; overflow-y: auto; }
        
        /* Form Card */
        .form-card { background: white; border-radius: 12px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); max-width: 800px; margin: 0 auto; }
        .form-header { padding: 1.5rem 2rem; border-bottom: 1px solid #e5e7eb; }
        .form-header h2 { font-size: 18px; font-weight: 600; color: #1f2937; display: flex; align-items: center; gap: 10px; }
        .form-header h2 i { color: var(--primary-color); }
        .form-body { padding: 2rem; }
        
        .alert { padding: 12px 16px; border-radius: 8px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px; background: #fee2e2; color: #991b1b; border: 1px solid #fecaca; }
        
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px; }
        .form-row.full { grid-template-columns: 1fr; }
        .form-group { display: flex; flex-direction: column; }
        .form-label { font-size: 14px; font-weight: 600; color: #374151; margin-bottom: 6px; }
        .required { color: #ef4444; }
        .form-control { width: 100%; padding: 10px 12px; border: 1px solid #d1d5db; border-radius: 6px; font-size: 14px; font-family: inherit; transition: all 0.2s; }
        .form-control:focus { outline: none; border-color: var(--primary-color); box-shadow: 0 0 0 3px rgba(44, 90, 160, 0.1); }
        .form-control:read-only { background: #f3f4f6; cursor: not-allowed; }
        textarea.form-control { resize: vertical; min-height: 100px; }
        
        .occupancy-badge { display: inline-block; padding: 4px 10px; background: #eff6ff; color: var(--primary-color); border-radius: 12px; font-size: 12px; font-weight: 600; margin-top: 6px; }
        
        .form-actions { display: flex; gap: 12px; justify-content: flex-end; padding-top: 20px; border-top: 1px solid #e5e7eb; margin-top: 20px; }
        .btn { padding: 10px 20px; border: none; border-radius: 6px; font-size: 14px; font-weight: 600; cursor: pointer; display: inline-flex; align-items: center; gap: 8px; transition: all 0.2s; text-decoration: none; }
        .btn-cancel { background: #f3f4f6; color: #6b7280; }
        .btn-cancel:hover { background: #e5e7eb; }
        .btn-submit { background: var(--primary-color); color: white; }
        .btn-submit:hover { background: var(--primary-dark); }
        
        @media (max-width: 768px) {
            .form-row { grid-template-columns: 1fr; }
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
                    <a href="<%= request.getContextPath() %>/admin/tours" class="menu-item active">
                        <i class="fas fa-map-marked-alt"></i>
                        <span>Quản lý tour</span>
                    </a>
                    <a href="<%= request.getContextPath() %>/admin/orders" class="menu-item">
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
            </nav>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <div class="top-bar">
                <div class="top-bar-title">
                    <h1>${tour != null ? 'Sửa' : 'Thêm'} Tour Du lịch</h1>
                </div>
            </div>
            
            <div class="content-area">
                <div class="form-card">
                    <div class="form-header">
                        <h2>
                            <i class="fas fa-${tour != null ? 'edit' : 'plus-circle'}"></i>
                            Thông tin tour
                        </h2>
                    </div>
                    
                    <div class="form-body">
                        <c:if test="${not empty error}">
                            <div class="alert">
                                <i class="fas fa-exclamation-circle"></i>
                                <span>${error}</span>
                            </div>
                        </c:if>

            <form action="<%= request.getContextPath() %>/tour" method="post">
                <input type="hidden" name="action" value="${tour != null ? 'update' : 'create'}">
                <c:if test="${tour != null}">
                    <input type="hidden" name="id" value="${tour.id}">
                    <input type="hidden" name="currentCapacity" value="${tour.currentCapacity}">
                </c:if>

                <div class="form-row full">
                    <div class="form-group">
                        <label class="form-label">
                            Tên Tour <span class="required">*</span>
                        </label>
                        <input type="text" class="form-control" name="name"
                               value="${tour != null ? tour.name : ''}"
                               placeholder="VD: Tour Đà Nẵng 3N2Đ" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">
                            Điểm đến <span class="required">*</span>
                        </label>
                        <input type="text" class="form-control" name="destination"
                               value="${tour != null ? tour.destination : ''}"
                               placeholder="VD: Đà Nẵng" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            Giá (VNĐ) <span class="required">*</span>
                        </label>
                        <input type="number" class="form-control" name="price"
                               value="${tour != null ? tour.price : ''}"
                               placeholder="VD: 2500000" min="0" step="1000" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">
                            Ngày bắt đầu <span class="required">*</span>
                        </label>
                        <input type="date" class="form-control" name="startDate"
                               value="${tour != null ? tour.startDate : ''}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            Ngày kết thúc <span class="required">*</span>
                        </label>
                        <input type="date" class="form-control" name="endDate"
                               value="${tour != null ? tour.endDate : ''}" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">
                            Sức chứa tối đa <span class="required">*</span>
                        </label>
                        <input type="number" class="form-control" name="maxCapacity"
                               value="${tour != null ? tour.maxCapacity : ''}"
                               placeholder="VD: 30" min="1" required>
                    </div>

                    <c:if test="${tour != null}">
                        <div class="form-group">
                            <label class="form-label">Đã đặt</label>
                            <input type="text" class="form-control"
                                   value="${tour.currentCapacity} người" readonly>
                            <span class="occupancy-badge">
                                <i class="fas fa-chart-pie"></i> Occupancy: ${tour.occupancyRate}%
                            </span>
                        </div>
                    </c:if>
                </div>

                <div class="form-row full">
                    <div class="form-group">
                        <label class="form-label">Mô tả</label>
                        <textarea class="form-control" name="description"
                                  placeholder="Mô tả chi tiết về tour...">${tour != null ? tour.description : ''}</textarea>
                    </div>
                </div>

                        <div class="form-actions">
                            <a href="<%= request.getContextPath() %>/admin/tours" class="btn btn-cancel">
                                <i class="fas fa-times"></i>
                                <span>Hủy</span>
                            </a>
                            <button type="submit" class="btn btn-submit">
                                <i class="fas fa-${tour != null ? 'save' : 'plus'}"></i>
                                <span>${tour != null ? 'Cập nhật' : 'Tạo mới'}</span>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>
</div>

    <script>
        // Validate dates
        document.querySelector('form').addEventListener('submit', function(e) {
            const startDate = new Date(document.querySelector('[name="startDate"]').value);
            const endDate = new Date(document.querySelector('[name="endDate"]').value);

            if (endDate < startDate) {
                e.preventDefault();
                alert('Ngày kết thúc phải sau ngày bắt đầu!');
            }
        });

        // Auto-format price input
        const priceInput = document.querySelector('[name="price"]');
        if (priceInput) {
            priceInput.addEventListener('blur', function() {
                if (this.value) {
                    this.value = Math.round(this.value / 1000) * 1000;
                }
            });
        }
    </script>
</body>
</html>
