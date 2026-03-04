<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Khám Phá Tour | eztravel</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Inter',sans-serif;background:#0F172A;color:#E2E8F0;min-height:100vh}
a{text-decoration:none;color:inherit}
.container{max-width:1280px;margin:0 auto;padding:0 24px}

/* Page */
.page-content{padding:120px 0 60px}
.page-header{margin-bottom:32px}
.page-badge{display:inline-flex;align-items:center;gap:6px;padding:5px 14px;background:rgba(37,99,235,.15);border:1px solid rgba(37,99,235,.3);border-radius:999px;font-size:.72rem;font-weight:700;color:#60A5FA;letter-spacing:1.5px;margin-bottom:12px}
.page-title{font-family:'Playfair Display',serif;font-size:2.2rem;font-weight:800;color:#fff;margin-bottom:8px}
.page-title .hl{background:linear-gradient(135deg,#3B82F6,#60A5FA);-webkit-background-clip:text;-webkit-text-fill-color:transparent}
.page-sub{color:#94A3B8;font-size:.95rem;max-width:600px}

/* Toolbar */
.toolbar{display:flex;gap:12px;flex-wrap:wrap;align-items:center;margin-bottom:28px;background:rgba(30,41,59,.6);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:16px 20px}
.toolbar-search{flex:1;min-width:260px;position:relative}
.toolbar-search input{width:100%;padding:10px 16px 10px 42px;border-radius:10px;border:1px solid rgba(255,255,255,.1);background:rgba(15,23,42,.8);color:#fff;font-size:.88rem;outline:none;transition:.3s}
.toolbar-search input:focus{border-color:#3B82F6;box-shadow:0 0 0 3px rgba(59,130,246,.15)}
.toolbar-search i{position:absolute;left:14px;top:50%;transform:translateY(-50%);color:#64748B;font-size:.85rem}
.toolbar-select{padding:10px 14px;border-radius:10px;border:1px solid rgba(255,255,255,.1);background:rgba(15,23,42,.8);color:#E2E8F0;font-size:.85rem;outline:none;cursor:pointer;min-width:150px}
.toolbar-select:focus{border-color:#3B82F6}
.toolbar-check{display:flex;align-items:center;gap:8px;padding:8px 16px;border-radius:10px;border:1px solid rgba(255,255,255,.1);background:rgba(15,23,42,.8);cursor:pointer;transition:.3s;font-size:.85rem;color:#94A3B8;user-select:none}
.toolbar-check:hover{border-color:#3B82F6;color:#fff}
.toolbar-check input{accent-color:#3B82F6;width:16px;height:16px}
.toolbar-check.active{border-color:#3B82F6;background:rgba(59,130,246,.1);color:#60A5FA}
.view-toggle{display:flex;gap:4px;margin-left:auto}
.view-btn{width:38px;height:38px;border-radius:8px;border:1px solid rgba(255,255,255,.1);background:transparent;color:#64748B;cursor:pointer;display:flex;align-items:center;justify-content:center;transition:.3s}
.view-btn.active{background:#2563EB;color:#fff;border-color:#2563EB}
.view-btn:hover{color:#fff}

/* Tour Grid */
.tours-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(290px,1fr));gap:20px}
.tours-list .tours-grid{grid-template-columns:1fr}
.tour-card{background:rgba(30,41,59,.5);border:1px solid rgba(255,255,255,.06);border-radius:16px;overflow:hidden;transition:.35s;cursor:pointer;position:relative}
.tour-card:hover{transform:translateY(-4px);border-color:rgba(59,130,246,.3);box-shadow:0 12px 40px rgba(0,0,0,.3)}
.tour-img{height:200px;background-size:cover;background-position:center;position:relative}
.tour-img::after{content:'';position:absolute;bottom:0;left:0;right:0;height:60%;background:linear-gradient(transparent,rgba(15,23,42,.8))}
.tour-badge{position:absolute;top:12px;left:12px;padding:4px 10px;border-radius:6px;font-size:.68rem;font-weight:700;z-index:2}
.badge-hot{background:rgba(239,68,68,.9);color:#fff}
.badge-new{background:rgba(16,185,129,.9);color:#fff}
.badge-full{background:rgba(100,116,139,.9);color:#fff}
.tour-cat{position:absolute;top:12px;right:12px;padding:4px 10px;border-radius:6px;font-size:.68rem;font-weight:600;background:rgba(0,0,0,.5);color:#fff;backdrop-filter:blur(4px);z-index:2}
.tour-body{padding:16px 18px 18px}
.tour-name{font-weight:700;font-size:1rem;color:#fff;margin-bottom:6px;line-height:1.4;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden}
.tour-loc{display:flex;align-items:center;gap:5px;color:#94A3B8;font-size:.78rem;margin-bottom:10px}
.tour-meta{display:flex;gap:12px;margin-bottom:12px;flex-wrap:wrap}
.tour-meta-item{display:flex;align-items:center;gap:5px;font-size:.76rem;color:#94A3B8}
.tour-meta-item i{color:#60A5FA;font-size:.7rem}
.tour-bottom{display:flex;align-items:center;justify-content:space-between;padding-top:12px;border-top:1px solid rgba(255,255,255,.06)}
.tour-price{font-weight:800;font-size:1.1rem;color:#60A5FA}
.tour-price small{font-weight:500;font-size:.72rem;color:#64748B}
.tour-btn{padding:8px 18px;border-radius:8px;font-weight:700;font-size:.8rem;border:none;cursor:pointer;transition:.3s;font-family:inherit}
.tour-btn-book{background:#2563EB;color:#fff}
.tour-btn-book:hover{background:#3B82F6;transform:translateY(-1px)}
.tour-btn-login{background:rgba(255,255,255,.08);color:#94A3B8;border:1px solid rgba(255,255,255,.1)}
.tour-btn-login:hover{background:rgba(255,255,255,.12);color:#fff}

/* List View */
.tours-list .tour-card{display:grid;grid-template-columns:280px 1fr;height:auto}
.tours-list .tour-img{height:100%;min-height:200px}
.tours-list .tour-body{display:flex;flex-direction:column;justify-content:center}
.tours-list .tour-name{font-size:1.1rem;-webkit-line-clamp:1}
.tours-list .tour-desc{color:#94A3B8;font-size:.82rem;margin-bottom:10px;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden}

/* Pagination */
.pagination{display:flex;justify-content:center;align-items:center;gap:6px;margin-top:36px}
.pg-btn{width:38px;height:38px;border-radius:8px;border:1px solid rgba(255,255,255,.1);background:transparent;color:#94A3B8;display:flex;align-items:center;justify-content:center;font-weight:600;font-size:.85rem;cursor:pointer;transition:.3s}
.pg-btn:hover{border-color:#3B82F6;color:#fff}
.pg-btn.active{background:#2563EB;border-color:#2563EB;color:#fff}
.pg-btn.disabled{opacity:.3;cursor:not-allowed;pointer-events:none}
.pg-info{color:#64748B;font-size:.82rem;margin:0 12px}

/* Stats bar */
.stats-bar{display:flex;gap:8px;align-items:center;margin-bottom:16px;flex-wrap:wrap}
.stats-chip{padding:5px 12px;border-radius:8px;font-size:.78rem;font-weight:600;background:rgba(30,41,59,.6);border:1px solid rgba(255,255,255,.08);color:#94A3B8}
.stats-chip b{color:#60A5FA}

/* Empty State */
.empty-state{text-align:center;padding:80px 20px}
.empty-icon{font-size:3rem;color:#334155;margin-bottom:16px}
.empty-title{font-size:1.3rem;font-weight:700;color:#fff;margin-bottom:8px}
.empty-desc{color:#64748B;font-size:.9rem;margin-bottom:20px}
.empty-btn{display:inline-flex;align-items:center;gap:8px;padding:10px 24px;background:#2563EB;color:#fff;border-radius:10px;font-weight:600;font-size:.88rem;transition:.3s}
.empty-btn:hover{background:#3B82F6;transform:translateY(-2px)}

/* Success toast */
.toast{position:fixed;top:100px;right:20px;padding:14px 24px;background:#10B981;color:#fff;border-radius:10px;font-weight:600;font-size:.88rem;z-index:9999;animation:slideIn .4s ease}
@keyframes slideIn{from{transform:translateX(100px);opacity:0}to{transform:translateX(0);opacity:1}}

@media(max-width:768px){
    .toolbar{flex-direction:column}
    .toolbar-search{width:100%}
    .tours-grid{grid-template-columns:1fr}
    .tours-list .tour-card{grid-template-columns:1fr}
    .page-title{font-size:1.6rem}
    .view-toggle{display:none}
}
</style>
</head>
<body>

<jsp:include page="/common/_header.jsp"/>

<main class="page-content">
<div class="container">

    <!-- Header -->
    <div class="page-header">
        <div class="page-badge"><i class="fas fa-compass"></i> KHÁM PHÁ TOUR 2026</div>
        <h1 class="page-title">Tìm Tour <span class="hl">Hoàn Hảo</span></h1>
        <p class="page-sub">Khám phá hơn ${totalTours} tour du lịch Đà Nẵng — đặt chỗ dễ dàng, trải nghiệm tuyệt vời.</p>
    </div>

    <!-- Toolbar -->
    <form id="filterForm" action="${ctx}/tour" method="get" class="toolbar">
        <div class="toolbar-search">
            <i class="fas fa-search"></i>
            <input type="text" name="search" placeholder="Tìm tour, điểm đến..." value="${searchQuery}">
        </div>

        <select name="categoryId" class="toolbar-select" onchange="this.form.submit()">
            <option value="">Tất cả danh mục</option>
            <c:forEach var="cat" items="${categories}">
                <option value="${cat.categoryId}" ${selectedCategory == cat.categoryId ? 'selected' : ''}>${cat.categoryName}</option>
            </c:forEach>
        </select>

        <select name="sortBy" class="toolbar-select" onchange="this.form.submit()">
            <option value="">Sắp xếp</option>
            <option value="name_asc" ${sortBy == 'name_asc' ? 'selected' : ''}>Tên A → Z</option>
            <option value="name_desc" ${sortBy == 'name_desc' ? 'selected' : ''}>Tên Z → A</option>
            <option value="price_asc" ${sortBy == 'price_asc' ? 'selected' : ''}>Giá thấp → cao</option>
            <option value="price_desc" ${sortBy == 'price_desc' ? 'selected' : ''}>Giá cao → thấp</option>
            <option value="newest" ${sortBy == 'newest' ? 'selected' : ''}>Mới nhất</option>
        </select>

        <label class="toolbar-check ${availableOnly ? 'active' : ''}" onclick="this.querySelector('input').click()">
            <input type="checkbox" name="available" value="true" ${availableOnly ? 'checked' : ''} onchange="this.form.submit()" style="display:none">
            <i class="fas fa-check-circle"></i> Còn chỗ
        </label>

        <div class="view-toggle">
            <button type="button" class="view-btn active" id="gridBtn" onclick="setView('grid')"><i class="fas fa-th"></i></button>
            <button type="button" class="view-btn" id="listBtn" onclick="setView('list')"><i class="fas fa-list"></i></button>
        </div>
    </form>

    <!-- Stats -->
    <div class="stats-bar">
        <div class="stats-chip">Tìm thấy <b>${totalTours}</b> tour</div>
        <c:if test="${not empty searchQuery}">
            <div class="stats-chip">Từ khóa: <b>"${searchQuery}"</b>
                <a href="${ctx}/tour" style="color:#F87171;margin-left:6px"><i class="fas fa-times"></i></a>
            </div>
        </c:if>
        <div class="stats-chip">Trang <b>${currentPage}</b>/<b>${totalPages}</b></div>
    </div>

    <!-- Tour Grid -->
    <c:choose>
        <c:when test="${not empty tours}">
            <div class="tours-grid" id="toursContainer">
                <c:forEach var="tour" items="${tours}" varStatus="s">
                    <div class="tour-card" onclick="window.location='${ctx}/tour?action=view&id=${tour.tourId}'" style="animation:fadeUp .5s ease ${s.index * 0.06}s both">
                        <div class="tour-img" style="background-image:url('${not empty tour.imageUrl ? tour.imageUrl : 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=400'}')">
                            <c:if test="${tour.maxPeople <= 5 && tour.maxPeople > 0}">
                                <span class="tour-badge badge-hot"><i class="fas fa-fire"></i> Sắp hết chỗ</span>
                            </c:if>
                            <c:if test="${tour.maxPeople <= 0}">
                                <span class="tour-badge badge-full"><i class="fas fa-ban"></i> Hết chỗ</span>
                            </c:if>
                            <c:if test="${not empty tour.category}">
                                <span class="tour-cat">${tour.category.categoryName}</span>
                            </c:if>
                        </div>
                        <div class="tour-body">
                            <h3 class="tour-name">${tour.tourName}</h3>
                            <div class="tour-loc"><i class="fas fa-map-marker-alt"></i> ${not empty tour.destination ? tour.destination : 'Đà Nẵng'}</div>
                            <c:if test="${not empty tour.shortDesc}">
                                <div class="tour-desc">${tour.shortDesc}</div>
                            </c:if>
                            <div class="tour-meta">
                                <c:if test="${not empty tour.duration}">
                                    <span class="tour-meta-item"><i class="fas fa-clock"></i> ${tour.duration}</span>
                                </c:if>
                                <c:if test="${not empty tour.transport}">
                                    <span class="tour-meta-item"><i class="fas fa-bus"></i> ${tour.transport}</span>
                                </c:if>
                                <span class="tour-meta-item"><i class="fas fa-users"></i> ${tour.maxPeople} chỗ</span>
                            </div>
                            <div class="tour-bottom">
                                <div class="tour-price">
                                    <fmt:formatNumber value="${tour.price}" pattern="#,###"/>đ
                                    <small>/người</small>
                                </div>
                                <c:choose>
                                    <c:when test="${isLoggedIn}">
                                        <a href="${ctx}/booking?tourId=${tour.tourId}" class="tour-btn tour-btn-book" onclick="event.stopPropagation()">
                                            <i class="fas fa-shopping-cart"></i> Đặt Tour
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${ctx}/login.jsp?redirect=tour&tourId=${tour.tourId}" class="tour-btn tour-btn-login" onclick="event.stopPropagation()">
                                            <i class="fas fa-sign-in-alt"></i> Đăng nhập để đặt
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <div class="empty-icon"><i class="fas fa-map-marked-alt"></i></div>
                <div class="empty-title">Không tìm thấy tour nào</div>
                <div class="empty-desc">Thử tìm kiếm với từ khóa khác hoặc xóa bộ lọc.</div>
                <a href="${ctx}/tour" class="empty-btn"><i class="fas fa-refresh"></i> Xem tất cả tour</a>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Pagination -->
    <c:if test="${totalPages > 1}">
        <div class="pagination">
            <a href="${ctx}/tour?page=${currentPage - 1}&search=${searchQuery}&sortBy=${sortBy}&categoryId=${selectedCategory}&available=${availableOnly}" 
               class="pg-btn ${currentPage <= 1 ? 'disabled' : ''}"><i class="fas fa-chevron-left"></i></a>
            
            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:if test="${i == 1 || i == totalPages || (i >= currentPage - 2 && i <= currentPage + 2)}">
                    <a href="${ctx}/tour?page=${i}&search=${searchQuery}&sortBy=${sortBy}&categoryId=${selectedCategory}&available=${availableOnly}" 
                       class="pg-btn ${i == currentPage ? 'active' : ''}">${i}</a>
                </c:if>
                <c:if test="${(i == currentPage - 3 && i > 1) || (i == currentPage + 3 && i < totalPages)}">
                    <span class="pg-info">...</span>
                </c:if>
            </c:forEach>
            
            <a href="${ctx}/tour?page=${currentPage + 1}&search=${searchQuery}&sortBy=${sortBy}&categoryId=${selectedCategory}&available=${availableOnly}" 
               class="pg-btn ${currentPage >= totalPages ? 'disabled' : ''}"><i class="fas fa-chevron-right"></i></a>
        </div>
    </c:if>

</div>
</main>

<jsp:include page="/common/_footer.jsp"/>

<!-- Success Toast -->
<c:if test="${param.success != null}">
    <div class="toast" id="toast">
        <i class="fas fa-check-circle"></i> 
        <c:choose>
            <c:when test="${param.success == 'booked'}">Đặt tour thành công!</c:when>
            <c:otherwise>Thao tác thành công!</c:otherwise>
        </c:choose>
    </div>
    <script>setTimeout(function(){document.getElementById('toast').style.display='none';},3000);</script>
</c:if>

<style>@keyframes fadeUp{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}</style>
<script>
function setView(mode) {
    var c = document.getElementById('toursContainer');
    if (!c) return;
    var gb = document.getElementById('gridBtn');
    var lb = document.getElementById('listBtn');
    if (mode === 'list') {
        c.parentElement.classList.add('tours-list');
        lb.classList.add('active'); gb.classList.remove('active');
    } else {
        c.parentElement.classList.remove('tours-list');
        gb.classList.add('active'); lb.classList.remove('active');
    }
    localStorage.setItem('tourView', mode);
}
// Restore view preference
document.addEventListener('DOMContentLoaded', function() {
    var saved = localStorage.getItem('tourView');
    if (saved) setView(saved);
});
</script>
<script src="${ctx}/js/i18n.js"></script>
</body>
</html>
