<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khám Phá Tour 2026 - ezTravel</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background: #F7F8FC; color: #1B1F3B; line-height: 1.6; }
        
        /* Container */
        .container { max-width: 1200px; margin: 0 auto; padding: 30px 20px; }
        
        /* Page Header */
        .page-header { text-align: center; margin-bottom: 40px; }
        .page-badge { display: inline-flex; align-items: center; gap: 8px; padding: 6px 16px; background: rgba(37,99,235,0.1); border-radius: 999px; font-size: 0.8rem; font-weight: 700; color: #2563EB; margin-bottom: 16px; }
        .page-title { font-size: 2.5rem; font-weight: 900; color: #1E293B; margin-bottom: 12px; }
        .page-title .hl { background: linear-gradient(135deg, #2563EB, #3B82F6); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .page-subtitle { font-size: 1.1rem; color: #64748B; }
        
        /* Filter Section */
        .filter-section { background: white; padding: 30px; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.06); margin-bottom: 30px; }
        .filter-form { display: grid; grid-template-columns: 2fr 1.5fr 1fr 1fr auto; gap: 16px; align-items: end; }
        .form-group { display: flex; flex-direction: column; }
        .form-group label { font-weight: 600; margin-bottom: 8px; color: #475569; font-size: 0.9rem; }
        .form-group input, .form-group select { padding: 12px 16px; border: 2px solid #E2E8F0; border-radius: 10px; font-size: 1rem; transition: all 0.3s; font-family: 'Inter', sans-serif; }
        .form-group input:focus, .form-group select:focus { outline: none; border-color: #2563EB; box-shadow: 0 0 0 3px rgba(37,99,235,0.1); }
        .btn { padding: 12px 28px; border: none; border-radius: 10px; font-size: 1rem; font-weight: 700; cursor: pointer; transition: all 0.3s; font-family: 'Inter', sans-serif; }
        .btn-primary { background: linear-gradient(135deg, #2563EB, #3B82F6); color: white; box-shadow: 0 4px 14px rgba(37,99,235,0.3); }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(37,99,235,0.4); }
        
        /* Results Info */
        .results-info { display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px; padding: 12px 0; }
        .results-count { font-size: 0.9rem; color: #475569; font-weight: 600; }
        .results-count strong { color: #2563EB; font-weight: 800; }
        
        /* Tour Table */
        .tour-table-wrap { background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.04); }
        .tour-table { width: 100%; border-collapse: collapse; }
        .tour-table thead { background: #3B5998; color: white; }
        .tour-table th { padding: 14px 16px; text-align: left; font-size: 0.85rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; }
        .tour-table th:first-child { padding-left: 24px; }
        .tour-table th:last-child { padding-right: 24px; text-align: center; }
        .tour-table tbody tr { border-bottom: 1px solid #E5E7EB; transition: background 0.2s; }
        .tour-table tbody tr:hover { background: #F9FAFB; }
        .tour-table tbody tr:last-child { border-bottom: none; }
        .tour-table td { padding: 16px; font-size: 0.9rem; color: #1F2937; vertical-align: middle; }
        .tour-table td:first-child { padding-left: 24px; font-weight: 600; }
        .tour-table td:last-child { padding-right: 24px; text-align: center; }
        .tour-name { color: #1E293B; font-weight: 600; }
        .tour-destination { color: #6B7280; font-size: 0.85rem; }
        .tour-date { color: #374151; white-space: nowrap; }
        .tour-price { color: #2563EB; font-weight: 700; white-space: nowrap; }
        .tour-slots { display: inline-block; padding: 4px 12px; border-radius: 4px; font-size: 0.8rem; font-weight: 600; }
        .tour-slots.available { background: #D1FAE5; color: #065F46; }
        .tour-slots.full { background: #FEE2E2; color: #991B1B; }
        .tour-status { display: inline-block; padding: 4px 12px; border-radius: 4px; font-size: 0.8rem; font-weight: 600; }
        .tour-status.open { background: #D1FAE5; color: #065F46; }
        .tour-status.closed { background: #FEE2E2; color: #991B1B; }
        .btn-action { padding: 8px 20px; border-radius: 6px; font-size: 0.85rem; font-weight: 600; text-decoration: none; display: inline-block; transition: all 0.2s; }
        .btn-book { background: #2563EB; color: white; }
        .btn-book:hover { background: #1D4ED8; }
        .btn-login { background: #2563EB; color: white; }
        .btn-login:hover { background: #1D4ED8; }
        .btn-disabled { background: #E5E7EB; color: #9CA3AF; cursor: not-allowed; }
        .btn-disabled:hover { background: #E5E7EB; }
        
        /* Pagination */
        .pagination { display: flex; justify-content: center; align-items: center; gap: 8px; margin-top: 40px; }
        .pagination a, .pagination span { padding: 10px 16px; border: 2px solid #E2E8F0; border-radius: 10px; text-decoration: none; color: #475569; font-weight: 600; transition: all 0.3s; }
        .pagination a:hover { background: #2563EB; color: white; border-color: #2563EB; transform: translateY(-2px); }
        .pagination .active { background: #2563EB; color: white; border-color: #2563EB; }
        .pagination .disabled { opacity: 0.4; cursor: not-allowed; }
        
        /* No Results */
        .no-results { text-align: center; padding: 80px 20px; background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.06); }
        .no-results h3 { font-size: 1.5rem; color: #475569; margin-bottom: 12px; }
        .no-results p { color: #64748B; }
        
        @media (max-width: 768px) {
            .filter-form { grid-template-columns: 1fr; }
            .tour-table-wrap { overflow-x: auto; }
            .tour-table { min-width: 900px; }
        }
    </style>
</head>
<body>
    <jsp:include page="/common/_header.jsp" />

    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <div class="page-badge">
                <i class="fas fa-compass"></i> KHÁM PHÁ TOUR 2026
            </div>
            <h1 class="page-title">Tìm Tour <span class="hl">Hoàn Hảo</span></h1>
            <p class="page-subtitle">Khám phá 87 tour du lịch Đà Nẵng — đặt chỗ dễ dàng, trải nghiệm tuyệt vời</p>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <form action="${pageContext.request.contextPath}/explore" method="get" class="filter-form">
                <div class="form-group">
                    <label for="search"><i class="fas fa-search"></i> Tìm kiếm tour</label>
                    <input type="text" id="search" name="search" placeholder="Nhập tên tour..." value="${search}">
                </div>
                <div class="form-group">
                    <label for="destination"><i class="fas fa-map-marker-alt"></i> Điểm đến</label>
                    <select id="destination" name="destination">
                        <option value="">Tất cả điểm đến</option>
                        <c:forEach var="dest" items="${destinations}">
                            <option value="${dest}" ${destination == dest ? 'selected' : ''}>${dest}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="available"><i class="fas fa-filter"></i> Lọc theo chỗ trống</label>
                    <select id="available" name="available">
                        <option value="">Tất cả tour</option>
                        <option value="true" ${availableOnly ? 'selected' : ''}>Còn chỗ trống</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="sort"><i class="fas fa-sort"></i> Sắp xếp</label>
                    <select id="sort" name="sort">
                        <option value="name_asc" ${sort == 'name_asc' ? 'selected' : ''}>A → Z</option>
                        <option value="name_desc" ${sort == 'name_desc' ? 'selected' : ''}>Z → A</option>
                        <option value="price_asc" ${sort == 'price_asc' ? 'selected' : ''}>Giá thấp → cao</option>
                        <option value="price_desc" ${sort == 'price_desc' ? 'selected' : ''}>Giá cao → thấp</option>
                    </select>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-search"></i> Tìm kiếm
                    </button>
                </div>
            </form>
        </div>

        <!-- Results Info -->
        <div class="results-info">
            <div class="results-count">
                Hiển thị <strong>${totalTours}</strong> tours
            </div>
            <div>
                Trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong>
            </div>
        </div>

        <!-- Tour Table -->
        <c:choose>
            <c:when test="${empty tours}">
                <div class="no-results">
                    <h3>😔 Không tìm thấy tour nào</h3>
                    <p>Vui lòng thử lại với từ khóa khác hoặc điều chỉnh bộ lọc</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="tour-table-wrap">
                    <table class="tour-table">
                        <thead>
                            <tr>
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
                            <c:forEach var="tour" items="${tours}" varStatus="status">
                                <tr>
                                    <td class="tour-name">${tour.name}</td>
                                    <td class="tour-destination">${tour.destination}</td>
                                    <td class="tour-date">
                                        <fmt:formatDate value="${tour.startDate}" pattern="dd/MM/yyyy"/>
                                    </td>
                                    <td class="tour-price">
                                        <fmt:formatNumber value="${tour.price}" pattern="#,###"/> VNĐ
                                    </td>
                                    <td>
                                        <span class="tour-slots ${tour.availableSlots > 0 ? 'available' : 'full'}">
                                            ${tour.currentCapacity}/${tour.maxCapacity}
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${tour.availableSlots > 0}">
                                                <span class="tour-status open">Còn chỗ</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="tour-status closed">Hết chỗ</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${isLoggedIn}">
                                                <c:choose>
                                                    <c:when test="${tour.availableSlots > 0}">
                                                        <a href="${pageContext.request.contextPath}/tour-detail?id=${tour.id}" class="btn-action btn-book">
                                                            Xem chi tiết
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="btn-action btn-disabled">Hết chỗ</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/login.jsp?redirect=explore&tourId=${tour.id}" class="btn-action btn-login">
                                                    Đăng nhập
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <div class="pagination">
                <c:choose>
                    <c:when test="${currentPage > 1}">
                        <a href="?page=${currentPage - 1}&search=${search}&destination=${destination}&available=${availableOnly}&sort=${sort}">
                            <i class="fas fa-chevron-left"></i> Trước
                        </a>
                    </c:when>
                    <c:otherwise>
                        <span class="disabled">
                            <i class="fas fa-chevron-left"></i> Trước
                        </span>
                    </c:otherwise>
                </c:choose>
                
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span class="active">${i}</span>
                        </c:when>
                        <c:when test="${i == 1 || i == totalPages || (i >= currentPage - 2 && i <= currentPage + 2)}">
                            <a href="?page=${i}&search=${search}&destination=${destination}&available=${availableOnly}&sort=${sort}">${i}</a>
                        </c:when>
                        <c:when test="${i == currentPage - 3 || i == currentPage + 3}">
                            <span>...</span>
                        </c:when>
                    </c:choose>
                </c:forEach>
                
                <c:choose>
                    <c:when test="${currentPage < totalPages}">
                        <a href="?page=${currentPage + 1}&search=${search}&destination=${destination}&available=${availableOnly}&sort=${sort}">
                            Sau <i class="fas fa-chevron-right"></i>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <span class="disabled">
                            Sau <i class="fas fa-chevron-right"></i>
                        </span>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
    </div>
</body>
</html>
