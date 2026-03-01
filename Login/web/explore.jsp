<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khám Phá Tour 2026 - Da Nang Travel Hub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            color: #333;
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.5rem 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .header h1 {
            font-size: 1.8rem;
            font-weight: 600;
        }
        
        .header-nav a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            padding: 8px 16px;
            border-radius: 5px;
            transition: background 0.3s;
        }
        
        .header-nav a:hover {
            background: rgba(255,255,255,0.2);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        
        .page-title {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .page-title h2 {
            font-size: 2rem;
            color: #2d3748;
            margin-bottom: 10px;
        }
        
        .page-title p {
            color: #718096;
            font-size: 1.1rem;
        }
        
        .filter-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .filter-form {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr auto;
            gap: 15px;
            align-items: end;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
        }
        
        .form-group label {
            font-weight: 500;
            margin-bottom: 8px;
            color: #4a5568;
        }
        
        .form-group input,
        .form-group select {
            padding: 10px 15px;
            border: 1px solid #e2e8f0;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .btn {
            padding: 10px 25px;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-primary {
            background: #667eea;
            color: white;
        }
        
        .btn-primary:hover {
            background: #5568d3;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
        
        .btn-secondary {
            background: #e2e8f0;
            color: #4a5568;
        }
        
        .btn-secondary:hover {
            background: #cbd5e0;
        }
        
        .results-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 15px;
            background: white;
            border-radius: 8px;
        }
        
        .results-count {
            font-size: 1.1rem;
            color: #4a5568;
        }
        
        .results-count strong {
            color: #667eea;
        }
        
        .tour-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }
        
        .tour-card {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .tour-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        
        .tour-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        .tour-content {
            padding: 20px;
        }
        
        .tour-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 10px;
            line-height: 1.4;
        }
        
        .tour-location {
            color: #718096;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }
        
        .tour-location::before {
            content: "📍";
            margin-right: 5px;
        }
        
        .tour-desc {
            color: #4a5568;
            font-size: 0.95rem;
            line-height: 1.6;
            margin-bottom: 15px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .tour-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 1px solid #e2e8f0;
        }
        
        .tour-price {
            font-size: 1.5rem;
            font-weight: 700;
            color: #667eea;
        }
        
        .tour-price small {
            font-size: 0.8rem;
            font-weight: 400;
            color: #718096;
        }
        
        .tour-capacity {
            background: #f0fdf4;
            color: #16a34a;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.9rem;
        }
        
        .tour-capacity.full {
            background: #fef2f2;
            color: #dc2626;
        }
        
        .tour-actions {
            margin-top: 15px;
            display: flex;
            gap: 10px;
        }
        
        .btn-book {
            flex: 1;
            padding: 10px 20px;
            background: #667eea;
            color: white;
            text-decoration: none;
            text-align: center;
            border-radius: 5px;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .btn-book:hover {
            background: #5568d3;
            transform: translateY(-2px);
        }
        
        .btn-view {
            flex: 1;
            padding: 10px 20px;
            background: white;
            color: #667eea;
            text-decoration: none;
            text-align: center;
            border: 2px solid #667eea;
            border-radius: 5px;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .btn-view:hover {
            background: #f7fafc;
        }
        
        .btn-disabled {
            background: #e2e8f0;
            color: #a0aec0;
            cursor: not-allowed;
        }
        
        .btn-disabled:hover {
            background: #e2e8f0;
            transform: none;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin-top: 40px;
        }
        
        .pagination a,
        .pagination span {
            padding: 10px 15px;
            border: 1px solid #e2e8f0;
            border-radius: 5px;
            text-decoration: none;
            color: #4a5568;
            transition: all 0.3s;
        }
        
        .pagination a:hover {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }
        
        .pagination .active {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }
        
        .pagination .disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        .no-results {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 10px;
        }
        
        .no-results h3 {
            font-size: 1.5rem;
            color: #4a5568;
            margin-bottom: 10px;
        }
        
        .no-results p {
            color: #718096;
        }
        
        @media (max-width: 768px) {
            .filter-form {
                grid-template-columns: 1fr;
            }
            
            .tour-grid {
                grid-template-columns: 1fr;
            }
            
            .header-content {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1>🌴 Da Nang Travel Hub</h1>
            <nav class="header-nav">
                <a href="${pageContext.request.contextPath}/">Trang chủ</a>
                <a href="${pageContext.request.contextPath}/explore">Khám phá</a>
                <c:choose>
                    <c:when test="${not empty sessionScope.username}">
                        <a href="${pageContext.request.contextPath}/profile">👤 ${sessionScope.username}</a>
                        <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a>
                    </c:otherwise>
                </c:choose>
            </nav>
        </div>
    </div>

    <div class="container">
        <div class="page-title">
            <h2>🗺️ Khám Phá Tour 2026</h2>
            <p>Khám phá những tour du lịch tuyệt vời tại Đà Nẵng</p>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <form action="${pageContext.request.contextPath}/explore" method="get" class="filter-form">
                <div class="form-group">
                    <label for="search">🔍 Tìm kiếm tour</label>
                    <input type="text" id="search" name="search" 
                           placeholder="Nhập tên tour hoặc địa điểm..." 
                           value="${search}">
                </div>
                
                <div class="form-group">
                    <label for="available">📊 Lọc theo chỗ trống</label>
                    <select id="available" name="available">
                        <option value="">Tất cả tour</option>
                        <option value="true" ${availableOnly ? 'selected' : ''}>Còn chỗ trống</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="sort">🔄 Sắp xếp</label>
                    <select id="sort" name="sort">
                        <option value="name_asc" ${sort == 'name_asc' ? 'selected' : ''}>A → Z</option>
                        <option value="name_desc" ${sort == 'name_desc' ? 'selected' : ''}>Z → A</option>
                        <option value="price_asc" ${sort == 'price_asc' ? 'selected' : ''}>Giá thấp → cao</option>
                        <option value="price_desc" ${sort == 'price_desc' ? 'selected' : ''}>Giá cao → thấp</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                </div>
            </form>
        </div>

        <!-- Results Info -->
        <div class="results-info">
            <div class="results-count">
                Tìm thấy <strong>${totalTours}</strong> tour
            </div>
            <div>
                Trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong>
            </div>
        </div>

        <!-- Tour Grid -->
        <c:choose>
            <c:when test="${empty tours}">
                <div class="no-results">
                    <h3>😔 Không tìm thấy tour nào</h3>
                    <p>Vui lòng thử lại với từ khóa khác hoặc điều chỉnh bộ lọc</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="tour-grid">
                    <c:forEach var="tour" items="${tours}">
                        <div class="tour-card">
                            <c:choose>
                                <c:when test="${not empty tour.imageUrl}">
                                    <img src="${tour.imageUrl}" alt="${tour.tourName}" class="tour-image">
                                </c:when>
                                <c:otherwise>
                                    <div class="tour-image"></div>
                                </c:otherwise>
                            </c:choose>
                            
                            <div class="tour-content">
                                <h3 class="tour-title">${tour.tourName}</h3>
                                
                                <c:if test="${not empty tour.startLocation}">
                                    <div class="tour-location">${tour.startLocation}</div>
                                </c:if>
                                
                                <c:if test="${not empty tour.shortDesc}">
                                    <p class="tour-desc">${tour.shortDesc}</p>
                                </c:if>
                                
                                <c:if test="${empty tour.shortDesc and not empty tour.description}">
                                    <p class="tour-desc">${tour.description}</p>
                                </c:if>
                                
                                <div class="tour-footer">
                                    <div class="tour-price">
                                        <fmt:formatNumber value="${tour.price}" pattern="#,###"/>đ
                                        <small>/người</small>
                                    </div>
                                    
                                    <c:choose>
                                        <c:when test="${tour.maxPeople > 0}">
                                            <span class="tour-capacity">
                                                ✓ Còn ${tour.maxPeople} chỗ
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="tour-capacity full">
                                                ✗ Hết chỗ
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <!-- Action buttons -->
                                <div class="tour-actions">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.username}">
                                            <!-- Logged-in users can book -->
                                            <c:choose>
                                                <c:when test="${tour.maxPeople > 0}">
                                                    <a href="${pageContext.request.contextPath}/tour-detail?id=${tour.tourId}" 
                                                       class="btn-book">
                                                        🎫 Đặt tour
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="btn-book btn-disabled">
                                                        Hết chỗ
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                            <a href="${pageContext.request.contextPath}/tour-detail?id=${tour.tourId}" 
                                               class="btn-view">
                                                👁️ Chi tiết
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Guests redirected to login when clicking book -->
                                            <a href="${pageContext.request.contextPath}/login.jsp?redirect=explore" 
                                               class="btn-book">
                                                🎫 Đặt tour
                                            </a>
                                            <a href="${pageContext.request.contextPath}/tour-detail?id=${tour.tourId}" 
                                               class="btn-view">
                                                👁️ Chi tiết
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <div class="pagination">
                <c:choose>
                    <c:when test="${currentPage > 1}">
                        <a href="?page=${currentPage - 1}&search=${search}&available=${availableOnly}&sort=${sort}">
                            ← Trước
                        </a>
                    </c:when>
                    <c:otherwise>
                        <span class="disabled">← Trước</span>
                    </c:otherwise>
                </c:choose>
                
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span class="active">${i}</span>
                        </c:when>
                        <c:when test="${i == 1 || i == totalPages || (i >= currentPage - 2 && i <= currentPage + 2)}">
                            <a href="?page=${i}&search=${search}&available=${availableOnly}&sort=${sort}">${i}</a>
                        </c:when>
                        <c:when test="${i == currentPage - 3 || i == currentPage + 3}">
                            <span>...</span>
                        </c:when>
                    </c:choose>
                </c:forEach>
                
                <c:choose>
                    <c:when test="${currentPage < totalPages}">
                        <a href="?page=${currentPage + 1}&search=${search}&available=${availableOnly}&sort=${sort}">
                            Sau →
                        </a>
                    </c:when>
                    <c:otherwise>
                        <span class="disabled">Sau →</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
    </div>
</body>
</html>
