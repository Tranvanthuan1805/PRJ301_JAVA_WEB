<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Tours | eztravel</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
    *{margin:0;padding:0;box-sizing:border-box}
    body{font-family:'Inter',system-ui,sans-serif;background:#0F172A;color:#E2E8F0;-webkit-font-smoothing:antialiased;min-height:100vh}

    /* Sidebar */
    .sidebar{position:fixed;left:0;top:0;width:260px;height:100vh;background:#0B1120;border-right:1px solid rgba(255,255,255,.06);padding:24px 16px;display:flex;flex-direction:column;z-index:100}
    .sidebar .logo{font-family:'Playfair Display',serif;font-size:1.4rem;font-weight:800;color:#fff;padding:0 12px 24px;border-bottom:1px solid rgba(255,255,255,.06);margin-bottom:16px}
    .sidebar .logo .a{color:#60A5FA}
    .sidebar .badge-admin{display:inline-block;padding:2px 8px;border-radius:6px;background:rgba(239,68,68,.15);color:#F87171;font-size:.65rem;font-weight:700;margin-left:6px;vertical-align:middle}
    .sidebar nav{flex:1}
    .sidebar nav a{display:flex;align-items:center;gap:12px;padding:11px 16px;border-radius:10px;color:rgba(255,255,255,.5);font-size:.88rem;font-weight:500;transition:.3s;margin-bottom:2px;text-decoration:none}
    .sidebar nav a:hover{color:#fff;background:rgba(255,255,255,.06)}
    .sidebar nav a.active{color:#fff;background:rgba(59,130,246,.15);border:1px solid rgba(59,130,246,.2)}
    .sidebar nav a.active i{color:#60A5FA}
    .sidebar nav a i{width:20px;text-align:center;font-size:.85rem}
    .sidebar .nav-label{font-size:.68rem;text-transform:uppercase;letter-spacing:1.5px;color:rgba(255,255,255,.2);font-weight:700;padding:16px 16px 8px;margin-top:8px}
    .sidebar .user-box{padding:16px;border-top:1px solid rgba(255,255,255,.06);display:flex;align-items:center;gap:12px}
    .sidebar .user-box .avatar{width:38px;height:38px;border-radius:10px;background:linear-gradient(135deg,#EF4444,#F87171);display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;font-size:.85rem}
    .sidebar .user-box .uname{font-size:.85rem;color:#fff;font-weight:600}
    .sidebar .user-box .urole{font-size:.72rem;color:rgba(255,255,255,.4)}

    /* Main */
    .main{margin-left:260px;padding:32px 40px;min-height:100vh}
    .page-header{margin-bottom:32px}
    .page-header h1{font-size:1.8rem;font-weight:800;color:#fff;margin-bottom:8px}
    .page-header p{color:rgba(255,255,255,.5);font-size:.9rem}

    /* Filters */
    .filters{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:24px;margin-bottom:24px}
    .filter-row{display:grid;grid-template-columns:2fr 1fr 1fr 1fr auto;gap:15px;align-items:end}
    .filter-group label{display:block;margin-bottom:8px;color:rgba(255,255,255,.6);font-size:.85rem;font-weight:600}
    .filter-group input,.filter-group select{width:100%;padding:11px 14px;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.1);border-radius:10px;color:#fff;font-size:.88rem;font-family:inherit}
    .filter-group input:focus,.filter-group select:focus{outline:none;border-color:#60A5FA;background:rgba(255,255,255,.08)}
    .filter-group select option{background:#1E293B;color:#fff}
    .btn{padding:11px 22px;border:none;border-radius:10px;font-weight:600;font-size:.85rem;cursor:pointer;transition:.3s;font-family:inherit}
    .btn-primary{background:#3B82F6;color:#fff}
    .btn-primary:hover{background:#2563EB;transform:translateY(-1px)}

    /* Table */
    .table-container{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:16px;overflow:hidden}
    table{width:100%;border-collapse:collapse}
    thead{background:rgba(255,255,255,.02)}
    th{padding:14px 16px;text-align:left;font-size:.72rem;text-transform:uppercase;letter-spacing:1px;color:rgba(255,255,255,.4);font-weight:700;border-bottom:1px solid rgba(255,255,255,.06)}
    td{padding:14px 16px;border-bottom:1px solid rgba(255,255,255,.04);font-size:.88rem;color:rgba(255,255,255,.7)}
    tbody tr:hover{background:rgba(255,255,255,.02)}
    .tour-name{font-weight:600;color:#fff}
    .badge{display:inline-block;padding:4px 12px;border-radius:999px;font-size:.72rem;font-weight:700}
    .badge-success{background:rgba(16,185,129,.15);color:#34D399}
    .badge-danger{background:rgba(239,68,68,.15);color:#F87171}
    .price{font-weight:600;color:#34D399}
    .actions{display:flex;gap:8px}
    .btn-icon{width:32px;height:32px;display:flex;align-items:center;justify-content:center;border:none;border-radius:8px;cursor:pointer;transition:.3s;font-size:.85rem}
    .btn-view{background:rgba(59,130,246,.15);color:#60A5FA}
    .btn-view:hover{background:rgba(59,130,246,.25)}
    .btn-edit{background:rgba(245,158,11,.15);color:#FBBF24}
    .btn-edit:hover{background:rgba(245,158,11,.25)}
    .btn-delete{background:rgba(239,68,68,.15);color:#F87171}
    .btn-delete:hover{background:rgba(239,68,68,.25)}

    /* Pagination */
    .pagination{display:flex;justify-content:space-between;align-items:center;padding:20px;border-top:1px solid rgba(255,255,255,.06)}
    .pagination-info{color:rgba(255,255,255,.5);font-size:.85rem}
    .pagination-buttons{display:flex;gap:6px}
    .page-btn{padding:8px 14px;border:1px solid rgba(255,255,255,.1);background:rgba(255,255,255,.04);border-radius:8px;color:rgba(255,255,255,.7);font-size:.85rem;text-decoration:none;transition:.3s}
    .page-btn:hover{background:rgba(255,255,255,.08);color:#fff}
    .page-btn.active{background:#3B82F6;color:#fff;border-color:#3B82F6}
    
    /* Modal */
    .modal{display:none;position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,.7);z-index:1000;align-items:center;justify-content:center}
    .modal.show{display:flex}
    .modal-content{background:#1E293B;border:1px solid rgba(255,255,255,.1);border-radius:16px;max-width:800px;width:90%;max-height:90vh;overflow-y:auto;position:relative}
    .modal-header{padding:24px;border-bottom:1px solid rgba(255,255,255,.06);display:flex;justify-content:space-between;align-items:center}
    .modal-header h2{font-size:1.5rem;font-weight:700;color:#fff}
    .modal-close{width:36px;height:36px;border:none;background:rgba(255,255,255,.06);border-radius:8px;color:rgba(255,255,255,.7);cursor:pointer;font-size:1.2rem;transition:.3s}
    .modal-close:hover{background:rgba(255,255,255,.1);color:#fff}
    .modal-body{padding:24px}
    .detail-grid{display:grid;grid-template-columns:1fr 1fr;gap:16px;margin-bottom:20px}
    .detail-item{background:rgba(255,255,255,.02);border:1px solid rgba(255,255,255,.06);border-radius:12px;padding:16px}
    .detail-label{font-size:.75rem;text-transform:uppercase;letter-spacing:1px;color:rgba(255,255,255,.4);margin-bottom:6px}
    .detail-value{font-size:1.1rem;font-weight:600;color:#fff}
    .detail-value.price{color:#34D399}
    .detail-desc{background:rgba(255,255,255,.02);border:1px solid rgba(255,255,255,.06);border-radius:12px;padding:16px;margin-top:16px}
    .detail-desc h3{font-size:.9rem;text-transform:uppercase;letter-spacing:1px;color:rgba(255,255,255,.4);margin-bottom:12px}
    .detail-desc p{color:rgba(255,255,255,.7);line-height:1.6}
    </style>
    <script>
    function viewTour(id) {
        fetch('${pageContext.request.contextPath}/admin/tours/view?id=' + id)
            .then(res => res.json())
            .then(tour => {
                document.getElementById('modalTourName').textContent = tour.name;
                document.getElementById('detailDestination').textContent = tour.destination;
                document.getElementById('detailStartDate').textContent = tour.startDate;
                document.getElementById('detailEndDate').textContent = tour.endDate;
                document.getElementById('detailPrice').textContent = new Intl.NumberFormat('vi-VN').format(tour.price) + ' VNĐ';
                document.getElementById('detailCapacity').textContent = tour.currentCapacity + '/' + tour.maxCapacity;
                document.getElementById('detailAvailable').textContent = (tour.maxCapacity - tour.currentCapacity) + ' chỗ';
                document.getElementById('detailStatus').textContent = tour.currentCapacity < tour.maxCapacity ? 'Còn chỗ' : 'Đã đầy';
                document.getElementById('detailStatus').style.color = tour.currentCapacity < tour.maxCapacity ? '#34D399' : '#F87171';
                document.getElementById('detailDescription').textContent = tour.description || 'Chưa có mô tả';
                
                document.getElementById('tourModal').classList.add('show');
            })
            .catch(err => alert('Không thể tải thông tin tour'));
    }
    
    function closeModal() {
        document.getElementById('tourModal').classList.remove('show');
    }
    
    function deleteTour(id, name) {
        if (confirm('Bạn có chắc muốn xóa tour "' + name + '"?\n\nHành động này không thể hoàn tác!')) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/admin/tours/delete';
            
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'id';
            input.value = id;
            
            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        }
    }
    
    // Close modal when clicking outside
    document.addEventListener('click', function(e) {
        const modal = document.getElementById('tourModal');
        if (e.target === modal) {
            closeModal();
        }
    });
    </script>
</head>
<body>

<!-- Sidebar -->
<aside class="sidebar">
    <div class="logo"><img src="${pageContext.request.contextPath}/images/logo.png" style="width:36px;height:36px;border-radius:50%;display:inline-block;vertical-align:middle;margin-right:8px"><span style="vertical-align:middle"><span class="a">ez</span>travel</span> <span class="badge-admin">ADMIN</span></div>
    <nav>
        <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-chart-pie"></i> Tổng Quan</a>
        <a href="${pageContext.request.contextPath}/admin/customers"><i class="fas fa-users"></i> Khách Hàng</a>
        <div class="nav-label">Quản lý</div>
        <a href="${pageContext.request.contextPath}/admin/tours" class="active"><i class="fas fa-plane-departure"></i> Quản lý Tours</a>
        <a href="${pageContext.request.contextPath}/admin/tour-history"><i class="fas fa-history"></i> Lịch sử</a>
        <a href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-bag"></i> Đơn Hàng</a>
        <div class="nav-label">Hệ thống</div>
        <a href="${pageContext.request.contextPath}/explore"><i class="fas fa-eye"></i> Xem Website</a>
    </nav>
    <div class="user-box">
        <div class="avatar">${sessionScope.user.username.substring(0,1).toUpperCase()}</div>
        <div>
            <div class="uname">${sessionScope.user.username}</div>
            <div class="urole">Quản Trị Viên</div>
        </div>
    </div>
</aside>

<!-- Main -->
<main class="main">
    <div class="page-header">
        <div style="display:flex;justify-content:space-between;align-items:center">
            <div>
                <h1><i class="fas fa-plane-departure"></i> Quản Lý Tours</h1>
                <p>Quản lý danh sách tour du lịch 2026</p>
            </div>
            <div style="display:flex;gap:12px">
                <button class="btn btn-secondary" onclick="window.open('${pageContext.request.contextPath}/explore', '_blank')">
                    <i class="fas fa-eye"></i> Xem giao diện người dùng
                </button>
                <button class="btn btn-primary" onclick="window.location.href='${pageContext.request.contextPath}/admin/tours/add'">
                    <i class="fas fa-plus"></i> Thêm Tour
                </button>
            </div>
        </div>
    </div>
    
    <c:if test="${param.success == 'added'}">
        <div style="padding:14px 18px;border-radius:10px;margin-bottom:24px;background:rgba(16,185,129,.15);color:#34D399;border:1px solid rgba(16,185,129,.2)">
            <i class="fas fa-check-circle"></i> Thêm tour mới thành công!
        </div>
    </c:if>
    
    <c:if test="${param.success == 'updated'}">
        <div style="padding:14px 18px;border-radius:10px;margin-bottom:24px;background:rgba(16,185,129,.15);color:#34D399;border:1px solid rgba(16,185,129,.2)">
            <i class="fas fa-check-circle"></i> Cập nhật tour thành công!
        </div>
    </c:if>
    
    <c:if test="${param.success == 'deleted'}">
        <div style="padding:14px 18px;border-radius:10px;margin-bottom:24px;background:rgba(16,185,129,.15);color:#34D399;border:1px solid rgba(16,185,129,.2)">
            <i class="fas fa-check-circle"></i> Xóa tour thành công!
        </div>
    </c:if>
    
    <c:if test="${param.error == 'notfound'}">
        <div style="padding:14px 18px;border-radius:10px;margin-bottom:24px;background:rgba(239,68,68,.15);color:#F87171;border:1px solid rgba(239,68,68,.2)">
            <i class="fas fa-exclamation-circle"></i> Không tìm thấy tour!
        </div>
    </c:if>
    
    <!-- Filters -->
    <div class="filters">
        <form method="get" action="${pageContext.request.contextPath}/admin/tours">
            <div class="filter-row">
                <div class="filter-group">
                    <label><i class="fas fa-search"></i> Tìm kiếm</label>
                    <input type="text" name="search" placeholder="Tên tour, điểm đến..." value="${searchQuery}">
                </div>
                
                <div class="filter-group">
                    <label><i class="fas fa-map-marker-alt"></i> Điểm đến</label>
                    <select name="destination">
                        <option value="all">Tất cả</option>
                        <option value="Bà Nà Hills" ${destinationFilter == 'Bà Nà Hills' ? 'selected' : ''}>Bà Nà Hills</option>
                        <option value="Ngũ Hành Sơn" ${destinationFilter == 'Ngũ Hành Sơn' ? 'selected' : ''}>Ngũ Hành Sơn</option>
                        <option value="Cù Lao Chàm" ${destinationFilter == 'Cù Lao Chàm' ? 'selected' : ''}>Cù Lao Chàm</option>
                        <option value="Sơn Trà" ${destinationFilter == 'Sơn Trà' ? 'selected' : ''}>Sơn Trà</option>
                        <option value="Huế" ${destinationFilter == 'Huế' ? 'selected' : ''}>Huế</option>
                        <option value="Núi Thần Tài" ${destinationFilter == 'Núi Thần Tài' ? 'selected' : ''}>Núi Thần Tài</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label><i class="fas fa-filter"></i> Trạng thái</label>
                    <select name="status">
                        <option value="all">Tất cả</option>
                        <option value="available" ${statusFilter == 'available' ? 'selected' : ''}>Còn chỗ</option>
                        <option value="full" ${statusFilter == 'full' ? 'selected' : ''}>Đã đầy</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label><i class="fas fa-sort"></i> Sắp xếp</label>
                    <select name="sort">
                        <option value="">Mặc định</option>
                        <option value="name" ${sortBy == 'name' ? 'selected' : ''}>Tên A-Z</option>
                        <option value="price" ${sortBy == 'price' ? 'selected' : ''}>Giá tăng dần</option>
                        <option value="price_desc" ${sortBy == 'price_desc' ? 'selected' : ''}>Giá giảm dần</option>
                        <option value="date" ${sortBy == 'date' ? 'selected' : ''}>Ngày khởi hành</option>
                        <option value="available" ${sortBy == 'available' ? 'selected' : ''}>Còn chỗ nhiều</option>
                    </select>
                </div>
                
                <button type="submit" class="btn btn-primary">Tìm kiếm</button>
            </div>
        </form>
    </div>
    
    <!-- Table -->
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
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty tours}">
                        <c:forEach var="tour" items="${tours}">
                            <tr>
                                <td>${tour.id}</td>
                                <td class="tour-name">${tour.name}</td>
                                <td>${tour.destination}</td>
                                <td><fmt:formatDate value="${tour.startDate}" pattern="dd/MM/yyyy"/></td>
                                <td class="price"><fmt:formatNumber value="${tour.price}" pattern="#,###"/> VNĐ</td>
                                <td>${tour.currentCapacity}/${tour.maxCapacity}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${tour.currentCapacity < tour.maxCapacity}">
                                            <span class="badge badge-success">Còn chỗ</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-danger">Đã đầy</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="actions">
                                        <button class="btn-icon btn-view" title="Xem" onclick="viewTour(${tour.id})"><i class="fas fa-eye"></i></button>
                                        <button class="btn-icon btn-edit" title="Sửa" onclick="window.location.href='${pageContext.request.contextPath}/admin/tours/edit?id=${tour.id}'"><i class="fas fa-edit"></i></button>
                                        <button class="btn-icon btn-delete" title="Xóa" onclick="deleteTour(${tour.id}, '${tour.name}')"><i class="fas fa-trash"></i></button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="8" style="text-align:center;padding:40px;color:rgba(255,255,255,.3)">
                                Không có tour nào
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        
        <!-- Pagination -->
        <div class="pagination">
            <div class="pagination-info">
                Hiển thị ${(currentPage - 1) * pageSize + 1} - ${currentPage * pageSize > totalTours ? totalTours : currentPage * pageSize} trong tổng số ${totalTours} tour
            </div>
            <div class="pagination-buttons">
                <c:if test="${currentPage > 1}">
                    <a href="?page=${currentPage - 1}&search=${searchQuery}&destination=${destinationFilter}&status=${statusFilter}&sort=${sortBy}" class="page-btn">‹</a>
                </c:if>
                
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <c:if test="${i == 1 || i == totalPages || (i >= currentPage - 2 && i <= currentPage + 2)}">
                        <a href="?page=${i}&search=${searchQuery}&destination=${destinationFilter}&status=${statusFilter}&sort=${sortBy}" 
                           class="page-btn ${i == currentPage ? 'active' : ''}">${i}</a>
                    </c:if>
                </c:forEach>
                
                <c:if test="${currentPage < totalPages}">
                    <a href="?page=${currentPage + 1}&search=${searchQuery}&destination=${destinationFilter}&status=${statusFilter}&sort=${sortBy}" class="page-btn">›</a>
                </c:if>
            </div>
        </div>
    </div>
</main>

<!-- Tour Detail Modal -->
<div id="tourModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2 id="modalTourName">Chi tiết tour</h2>
            <button class="modal-close" onclick="closeModal()">×</button>
        </div>
        <div class="modal-body">
            <div class="detail-grid">
                <div class="detail-item">
                    <div class="detail-label">Điểm đến</div>
                    <div class="detail-value" id="detailDestination">-</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Giá tour</div>
                    <div class="detail-value price" id="detailPrice">-</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Ngày khởi hành</div>
                    <div class="detail-value" id="detailStartDate">-</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Ngày kết thúc</div>
                    <div class="detail-value" id="detailEndDate">-</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Số người</div>
                    <div class="detail-value" id="detailCapacity">-</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Còn lại</div>
                    <div class="detail-value" id="detailAvailable">-</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Trạng thái</div>
                    <div class="detail-value" id="detailStatus">-</div>
                </div>
            </div>
            <div class="detail-desc">
                <h3>Mô tả</h3>
                <p id="detailDescription">-</p>
            </div>
        </div>
    </div>
</div>

</body>
</html>
