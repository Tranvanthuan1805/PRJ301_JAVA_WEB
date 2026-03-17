<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>So sánh Tour | eztravel</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .compare-page { padding: 120px 0 60px; min-height: 100vh; background: #f8fafc; }
        .compare-header { margin-bottom: 40px; }
        .compare-header h1 { font-size: 2rem; color: #1B1F3B; font-weight: 800; }
        .compare-header h1 i { background: linear-gradient(135deg, #FF6F61, #FF9A8B); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }

        /* Tour Picker */
        .tour-picker { background: white; border-radius: 20px; padding: 28px; box-shadow: 0 4px 20px rgba(27,31,59,.06); margin-bottom: 36px; }
        .tour-picker h3 { font-size: 1rem; font-weight: 700; margin-bottom: 16px; color: #1B1F3B; }
        .picker-grid { display: flex; gap: 12px; flex-wrap: wrap; }
        .picker-item { display: flex; align-items: center; gap: 10px; padding: 10px 16px; background: #f1f5f9; border-radius: 12px; cursor: pointer; transition: all .3s; border: 2px solid transparent; user-select: none; }
        .picker-item:hover { border-color: #FF6F61; background: #fff5f4; }
        .picker-item.selected { border-color: #FF6F61; background: linear-gradient(135deg, rgba(255,111,97,.08), rgba(255,154,139,.06)); }
        .picker-item img { width: 40px; height: 40px; border-radius: 10px; object-fit: cover; }
        .picker-item .info h4 { font-size: .82rem; font-weight: 700; color: #1B1F3B; }
        .picker-item .info span { font-size: .72rem; color: #FF6F61; font-weight: 700; }
        .picker-item .check { width: 22px; height: 22px; border-radius: 50%; border: 2px solid #d1d5db; display: flex; align-items: center; justify-content: center; font-size: .7rem; color: white; transition: all .3s; }
        .picker-item.selected .check { background: #FF6F61; border-color: #FF6F61; }

        .compare-btn { margin-top: 20px; background: linear-gradient(135deg, #FF6F61, #FF9A8B); color: white; padding: 14px 36px; border: none; border-radius: 14px; font-weight: 700; font-size: .92rem; cursor: pointer; transition: all .3s; display: inline-flex; align-items: center; gap: 8px; }
        .compare-btn:hover { transform: translateY(-3px); box-shadow: 0 10px 30px rgba(255,111,97,.3); }
        .compare-btn:disabled { opacity: .5; cursor: not-allowed; transform: none; }

        /* Category Filter */
        .category-filter { display: flex; gap: 8px; margin-bottom: 16px; flex-wrap: wrap; }
        .cat-tag { padding: 7px 16px; border-radius: 20px; font-size: .78rem; font-weight: 600; background: #f1f5f9; color: #64748b; cursor: pointer; transition: all .3s; border: none; }
        .cat-tag:hover, .cat-tag.active { background: #1B1F3B; color: white; }

        /* Comparison Table */
        .compare-table-wrap { background: white; border-radius: 20px; overflow: hidden; box-shadow: 0 4px 20px rgba(27,31,59,.06); }
        .compare-table { width: 100%; border-collapse: collapse; }
        .compare-table th { background: #1B1F3B; color: white; padding: 18px 20px; text-align: left; font-weight: 700; font-size: .85rem; }
        .compare-table td { padding: 16px 20px; border-bottom: 1px solid #f1f5f9; font-size: .88rem; }
        .compare-table tr:hover td { background: #fafbff; }
        .compare-table .feature-label { font-weight: 700; color: #1B1F3B; background: #f8fafc; width: 180px; }
        .compare-table .price-cell { font-size: 1.15rem; font-weight: 800; color: #FF6F61; }
        .compare-table .best-price { background: linear-gradient(135deg, rgba(16,185,129,.08), rgba(16,185,129,.04)); }
        .compare-table .best-price .price-cell { color: #10B981; }
        .compare-table .tour-header { text-align: center; }
        .compare-table .tour-header img { width: 120px; height: 80px; border-radius: 12px; object-fit: cover; margin: 0 auto 10px; display: block; }
        .compare-table .tour-header h4 { font-size: .9rem; font-weight: 700; color: #1B1F3B; }

        .rating-stars { color: #f59e0b; font-size: .85rem; }
        .tag { padding: 4px 10px; border-radius: 6px; font-size: .72rem; font-weight: 700; display: inline-block; }
        .tag-green { background: rgba(16,185,129,.1); color: #10B981; }
        .tag-blue { background: rgba(37,99,235,.1); color: #2563EB; }
        .tag-orange { background: rgba(245,158,11,.1); color: #F59E0B; }

        /* Price Summary */
        .price-summary { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-bottom: 30px; }
        .price-stat { background: white; border-radius: 16px; padding: 22px; text-align: center; box-shadow: 0 4px 16px rgba(27,31,59,.05); }
        .price-stat .label { font-size: .78rem; color: #94a3b8; font-weight: 600; }
        .price-stat .value { font-size: 1.4rem; font-weight: 800; margin-top: 6px; }
        .price-stat.min .value { color: #10B981; }
        .price-stat.max .value { color: #EF4444; }
        .price-stat.avg .value { color: #2563EB; }

        @media(max-width:768px) {
            .compare-page { padding: 90px 0 40px; }
            .price-summary { grid-template-columns: 1fr; }
            .compare-table-wrap { overflow-x: auto; }
            .compare-table { min-width: 650px; }
        }
    </style>
</head>
<body>
    <jsp:include page="/common/_header.jsp" />

    <section class="compare-page">
        <div class="container">
            <div class="compare-header">
                <h1><i class="fas fa-balance-scale"></i> So sánh Tour du lịch</h1>
                <p style="color:#64748b;margin-top:8px">Chọn tối đa 4 tour để so sánh giá cả và dịch vụ</p>
            </div>

            <!-- Tour Picker -->
            <div class="tour-picker">
                <h3><i class="fas fa-plus-circle" style="color:#FF6F61;margin-right:6px"></i> Chọn tour để so sánh</h3>

                <div class="category-filter">
                    <button class="cat-tag ${empty selectedCategory ? 'active' : ''}" onclick="filterCategory('')">Tất cả</button>
                    <c:forEach items="${categories}" var="cat">
                        <button class="cat-tag ${selectedCategory == cat ? 'active' : ''}" onclick="filterCategory('${cat}')">${cat}</button>
                    </c:forEach>
                </div>

                <form id="compareForm" method="get" action="${pageContext.request.contextPath}/tour-compare">
                    <div class="picker-grid">
                        <c:forEach items="${not empty filteredTours ? filteredTours : allTours}" var="tour">
                            <label class="picker-item" data-id="${tour.tourId}">
                                <img src="${tour.imageUrl != null ? tour.imageUrl : 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=100'}" alt="">
                                <div class="info">
                                    <h4>${tour.tourName}</h4>
                                    <span><fmt:formatNumber value="${tour.price}" pattern="#,##0"/>đ</span>
                                </div>
                                <div class="check"><i class="fas fa-check"></i></div>
                                <input type="checkbox" name="tourCheck" value="${tour.tourId}" style="display:none"
                                    onchange="updateCompare(this)">
                            </label>
                        </c:forEach>
                    </div>
                    <input type="hidden" name="ids" id="compareIds">
                    <button type="submit" class="compare-btn" id="compareBtn" disabled>
                        <i class="fas fa-balance-scale"></i> So sánh (<span id="selectedCount">0</span>/4)
                    </button>
                </form>
            </div>

            <!-- Price Summary -->
            <c:if test="${not empty compareTours}">
                <div class="price-summary">
                    <div class="price-stat min">
                        <div class="label"><i class="fas fa-arrow-down"></i> Giá thấp nhất</div>
                        <div class="value"><fmt:formatNumber value="${minPrice}" pattern="#,##0"/>đ</div>
                    </div>
                    <div class="price-stat avg">
                        <div class="label"><i class="fas fa-chart-line"></i> Giá trung bình</div>
                        <div class="value"><fmt:formatNumber value="${avgPrice}" pattern="#,##0"/>đ</div>
                    </div>
                    <div class="price-stat max">
                        <div class="label"><i class="fas fa-arrow-up"></i> Giá cao nhất</div>
                        <div class="value"><fmt:formatNumber value="${maxPrice}" pattern="#,##0"/>đ</div>
                    </div>
                </div>

                <!-- Comparison Table -->
                <div class="compare-table-wrap">
                    <table class="compare-table">
                        <thead>
                            <tr>
                                <th>Tiêu chí</th>
                                <c:forEach items="${compareTours}" var="t">
                                    <th class="tour-header">
                                        <img src="${t.imageUrl != null ? t.imageUrl : 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=200'}" alt="">
                                        <h4>${t.tourName}</h4>
                                    </th>
                                </c:forEach>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="feature-label"><i class="fas fa-tag" style="color:#FF6F61;margin-right:6px"></i> Giá</td>
                                <c:forEach items="${compareTours}" var="t">
                                    <td class="${t.price == minPrice ? 'best-price' : ''}">
                                        <span class="price-cell"><fmt:formatNumber value="${t.price}" pattern="#,##0"/>đ</span>
                                        <c:if test="${t.price == minPrice}"><br><span class="tag tag-green">Tốt nhất</span></c:if>
                                    </td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <td class="feature-label"><i class="fas fa-clock" style="color:#2563EB;margin-right:6px"></i> Thời gian</td>
                                <c:forEach items="${compareTours}" var="t">
                                    <td>${t.duration != null ? t.duration : 'N/A'}</td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <td class="feature-label"><i class="fas fa-users" style="color:#10B981;margin-right:6px"></i> Số chỗ trống</td>
                                <c:forEach items="${compareTours}" var="t">
                                    <td>
                                        <c:choose>
                                            <c:when test="${t.availableSlots > 10}"><span class="tag tag-green">${t.availableSlots} chỗ</span></c:when>
                                            <c:when test="${t.availableSlots > 0}"><span class="tag tag-orange">${t.availableSlots} chỗ</span></c:when>
                                            <c:otherwise><span class="tag" style="background:rgba(239,68,68,.1);color:#EF4444">Hết chỗ</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <td class="feature-label"><i class="fas fa-folder" style="color:#8B5CF6;margin-right:6px"></i> Danh mục</td>
                                <c:forEach items="${compareTours}" var="t">
                                    <td><span class="tag tag-blue">${t.category != null ? t.category.categoryName : 'N/A'}</span></td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <td class="feature-label"><i class="fas fa-map-marker-alt" style="color:#EF4444;margin-right:6px"></i> Địa điểm</td>
                                <c:forEach items="${compareTours}" var="t">
                                    <td>${t.location != null ? t.location : 'Đà Nẵng'}</td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <td class="feature-label"><i class="fas fa-info-circle" style="color:#06B6D4;margin-right:6px"></i> Mô tả</td>
                                <c:forEach items="${compareTours}" var="t">
                                    <td style="font-size:.82rem;color:#64748b;max-width:250px">
                                        ${t.description != null && t.description.length() > 100 ? t.description.substring(0,100).concat('...') : t.description}
                                    </td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <td class="feature-label"><i class="fas fa-shopping-cart" style="color:#FF6F61;margin-right:6px"></i> Hành động</td>
                                <c:forEach items="${compareTours}" var="t">
                                    <td>
                                        <a href="${pageContext.request.contextPath}/booking?id=${t.tourId}" 
                                           style="background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:white;padding:10px 20px;border-radius:10px;font-weight:700;font-size:.82rem;text-decoration:none;display:inline-flex;align-items:center;gap:6px;transition:all .3s">
                                            <i class="fas fa-bolt"></i> Đặt tour
                                        </a>
                                    </td>
                                </c:forEach>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </section>

    <jsp:include page="/common/_footer.jsp" />

    <script>
        const MAX_COMPARE = 4;
        let selectedIds = [];

        // Initialize from URL
        const urlIds = new URLSearchParams(window.location.search).get('ids');
        if (urlIds) {
            urlIds.split(',').forEach(id => {
                const el = document.querySelector('.picker-item[data-id="'+id+'"]');
                if (el) {
                    el.classList.add('selected');
                    el.querySelector('input').checked = true;
                    selectedIds.push(id);
                }
            });
        }

        document.querySelectorAll('.picker-item').forEach(item => {
            item.addEventListener('click', function(e) {
                if (e.target.tagName === 'INPUT') return;
                const cb = this.querySelector('input');
                cb.checked = !cb.checked;
                updateCompare(cb);
            });
        });

        function updateCompare(cb) {
            const id = cb.value;
            const parent = cb.closest('.picker-item');

            if (cb.checked) {
                if (selectedIds.length >= MAX_COMPARE) {
                    cb.checked = false;
                    alert('Tối đa ' + MAX_COMPARE + ' tour để so sánh');
                    return;
                }
                selectedIds.push(id);
                parent.classList.add('selected');
            } else {
                selectedIds = selectedIds.filter(i => i !== id);
                parent.classList.remove('selected');
            }

            document.getElementById('compareIds').value = selectedIds.join(',');
            document.getElementById('selectedCount').textContent = selectedIds.length;
            document.getElementById('compareBtn').disabled = selectedIds.length < 2;
        }

        function filterCategory(cat) {
            window.location.href = '${pageContext.request.contextPath}/tour-compare' + (cat ? '?category=' + encodeURIComponent(cat) : '');
        }
    </script>
</body>
</html>
