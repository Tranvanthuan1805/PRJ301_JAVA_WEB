<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tours Du Lịch Đà Nẵng | Da Nang Travel Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .page-hero{
            background:linear-gradient(rgba(27,31,59,.82),rgba(27,31,59,.82)),
                        url('https://images.unsplash.com/photo-1559592442-7e182c3c03fb?auto=format&fit=crop&w=1600&q=80');
            background-size:cover;background-position:center;
            padding:100px 0 80px;color:white;text-align:center;position:relative;overflow:hidden;margin-top:64px
        }
        .page-hero::before{content:'';position:absolute;width:500px;height:500px;background:radial-gradient(circle,rgba(255,111,97,.08),transparent 60%);top:-200px;left:-100px;border-radius:50%}
        .page-hero h1{font-size:2.8rem;font-weight:800;margin-bottom:14px;letter-spacing:-.5px;position:relative;z-index:1}
        .page-hero h1 .hl{color:#FF6F61}
        .page-hero p{font-size:1.1rem;opacity:.75;max-width:550px;margin:0 auto 30px;line-height:1.7;position:relative;z-index:1}

        /* Filter */
        .filter-bar{background:#fff;padding:20px 28px;border-radius:18px;display:flex;gap:14px;align-items:center;flex-wrap:wrap;box-shadow:0 8px 30px rgba(27,31,59,.08);margin-top:-35px;position:relative;z-index:10;border:1px solid #E8EAF0}
        .filter-bar input,.filter-bar select{padding:13px 18px;border:2px solid #E8EAF0;border-radius:14px;font-family:'Plus Jakarta Sans',sans-serif;font-size:.9rem;transition:.3s;flex:1;min-width:180px;background:#F7F8FC;color:#1B1F3B}
        .filter-bar input:focus,.filter-bar select:focus{outline:none;border-color:#FF6F61;box-shadow:0 0 0 3px rgba(255,111,97,.08);background:#fff}
        .filter-bar .btn-search{padding:13px 28px;background:linear-gradient(135deg,#1B1F3B,#2D3561);color:white;border:none;border-radius:14px;font-weight:700;cursor:pointer;transition:.3s;font-family:'Plus Jakarta Sans',sans-serif;display:flex;align-items:center;gap:8px}
        .filter-bar .btn-search:hover{transform:translateY(-2px);box-shadow:0 8px 20px rgba(27,31,59,.25)}

        .results-info{display:flex;justify-content:space-between;align-items:center;margin:30px 0 22px;color:#6B7194;font-size:.9rem}
        .results-info strong{color:#1B1F3B}

        /* Tour Grid */
        .tour-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(340px,1fr));gap:28px;margin-bottom:50px}
        .tour-card{background:#fff;border-radius:20px;overflow:hidden;box-shadow:0 2px 12px rgba(27,31,59,.04);transition:.4s;border:1px solid #E8EAF0;display:flex;flex-direction:column}
        .tour-card:hover{transform:translateY(-10px);box-shadow:0 20px 50px rgba(27,31,59,.1)}
        .tour-card .img-wrap{position:relative;height:240px;overflow:hidden}
        .tour-card .img-wrap img{width:100%;height:100%;object-fit:cover;transition:transform .7s cubic-bezier(.4,0,.2,1)}
        .tour-card:hover .img-wrap img{transform:scale(1.1)}
        .tour-card .badge-duration{position:absolute;top:16px;left:16px;background:rgba(27,31,59,.75);backdrop-filter:blur(8px);color:white;padding:6px 14px;border-radius:999px;font-size:.75rem;font-weight:700;display:flex;align-items:center;gap:5px}
        .tour-card .badge-cat{position:absolute;top:16px;right:16px;background:rgba(255,111,97,.88);color:white;padding:6px 14px;border-radius:999px;font-size:.72rem;font-weight:700}
        .tour-card .wishlist{position:absolute;bottom:16px;right:16px;width:38px;height:38px;border-radius:50%;background:rgba(255,255,255,.85);backdrop-filter:blur(8px);display:flex;align-items:center;justify-content:center;cursor:pointer;border:none;color:#A0A5C3;font-size:.9rem;transition:.3s}
        .tour-card .wishlist:hover{background:#fff;color:#FF6F61;transform:scale(1.1)}
        .tour-card .info{padding:24px;flex:1;display:flex;flex-direction:column}
        .tour-card .info .tag{font-size:.72rem;text-transform:uppercase;letter-spacing:1.5px;color:#A0A5C3;font-weight:700;margin-bottom:8px;display:flex;align-items:center;gap:5px}
        .tour-card .info .tag i{color:#FF6F61}
        .tour-card .info h3{font-size:1.15rem;color:#1B1F3B;margin-bottom:10px;line-height:1.4;font-weight:700}
        .tour-card .info .desc{color:#6B7194;font-size:.88rem;line-height:1.6;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden;margin-bottom:20px}
        .tour-card .bottom{display:flex;justify-content:space-between;align-items:center;padding-top:20px;border-top:1px solid #E8EAF0;margin-top:auto}
        .tour-card .price-label{font-size:.72rem;color:#A0A5C3}
        .tour-card .price{font-size:1.3rem;font-weight:800;color:#1B1F3B}
        .tour-card .price span{font-size:.82rem;font-weight:500;color:#A0A5C3}
        .btn-book{padding:10px 22px;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;border:none;border-radius:999px;font-weight:700;cursor:pointer;transition:.3s;text-decoration:none;font-size:.85rem;font-family:inherit;box-shadow:0 4px 12px rgba(255,111,97,.2);display:inline-flex;align-items:center;gap:6px}
        .btn-book:hover{transform:scale(1.06);box-shadow:0 8px 20px rgba(255,111,97,.35)}

        /* Pagination */
        .pagination{display:flex;justify-content:center;gap:8px;margin:40px 0 60px}
        .pagination a,.pagination span{padding:10px 16px;border-radius:12px;font-weight:700;text-decoration:none;transition:.3s;font-size:.88rem;font-family:inherit}
        .pagination a{background:#fff;color:#1B1F3B;border:2px solid #E8EAF0}
        .pagination a:hover{border-color:#1B1F3B;background:#F7F8FC}
        .pagination .active{background:#1B1F3B;color:white;border:2px solid #1B1F3B}

        .empty-state{text-align:center;padding:80px 30px;background:#fff;border-radius:20px;border:1px solid #E8EAF0}
        .empty-state .icon{font-size:4rem;margin-bottom:16px;filter:grayscale(.2)}
        .empty-state h3{color:#1B1F3B;margin-bottom:8px}
        .empty-state p{color:#6B7194}

        @media(max-width:768px){.page-hero h1{font-size:2rem}.filter-bar{flex-direction:column}.tour-grid{grid-template-columns:1fr}}
    </style>
</head>
<body>
    <jsp:include page="/common/_header.jsp" />

    <section class="page-hero">
        <div class="container">
            <h1>Khám Phá <span class="hl">Tours</span> Đà Nẵng</h1>
            <p>Hơn 100+ tour du lịch được xác minh bởi đối tác uy tín tại Đà Nẵng</p>
        </div>
    </section>

    <section class="container">
        <form class="filter-bar" action="${pageContext.request.contextPath}/tour" method="get">
            <input type="text" name="search" value="${searchQuery}" placeholder="🔍 Tìm tour theo tên, địa điểm...">
            <select name="categoryId">
                <option value="">Tất cả danh mục</option>
                <c:forEach items="${categories}" var="cat">
                    <option value="${cat.categoryId}" ${selectedCategory == cat.categoryId ? 'selected' : ''}>${cat.categoryName}</option>
                </c:forEach>
            </select>
            <select name="sortBy">
                <option value="">Sắp xếp</option>
                <option value="name" ${sortBy == 'name' ? 'selected' : ''}>Theo tên</option>
                <option value="price_asc" ${sortBy == 'price_asc' ? 'selected' : ''}>Giá tăng dần</option>
                <option value="price_desc" ${sortBy == 'price_desc' ? 'selected' : ''}>Giá giảm dần</option>
            </select>
            <button type="submit" class="btn-search"><i class="fas fa-search"></i> Tìm</button>
        </form>

        <div class="results-info">
            <span>Tìm thấy <strong>${totalTours}</strong> tours</span>
            <span>Trang ${currentPage} / ${totalPages > 0 ? totalPages : 1}</span>
        </div>

        <c:choose>
            <c:when test="${not empty tours}">
                <div class="tour-grid">
                    <c:forEach items="${tours}" var="t">
                        <div class="tour-card">
                            <div class="img-wrap">
                                <img src="${not empty t.imageUrl ? t.imageUrl : 'https://images.unsplash.com/photo-1559592442-7e182c3c03fb?auto=format&fit=crop&w=600&q=80'}" alt="${t.tourName}">
                                <c:if test="${not empty t.duration}">
                                    <div class="badge-duration"><i class="fas fa-clock"></i> ${t.duration}</div>
                                </c:if>
                                <c:if test="${not empty t.category}">
                                    <div class="badge-cat">${t.category.categoryName}</div>
                                </c:if>
                                <button class="wishlist" type="button" onclick="toggleWish(this)"><i class="far fa-heart"></i></button>
                            </div>
                            <div class="info">
                                <div class="tag"><i class="fas fa-map-pin"></i> Đà Nẵng, Việt Nam</div>
                                <h3>${t.tourName}</h3>
                                <p class="desc">${not empty t.description ? t.description : 'Khám phá vẻ đẹp ẩn giấu của Đà Nẵng cùng hướng dẫn viên chuyên nghiệp.'}</p>
                                <div class="bottom">
                                    <div>
                                        <div class="price-label">Từ</div>
                                        <div class="price"><fmt:formatNumber value="${t.price}" type="number" groupingUsed="true"/>đ <span>/người</span></div>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/tour?action=view&id=${t.tourId}" class="btn-book">
                                        Đặt Ngay
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="${pageContext.request.contextPath}/tour?page=${currentPage - 1}&search=${searchQuery}&sortBy=${sortBy}&categoryId=${selectedCategory}">
                                <i class="fas fa-chevron-left"></i>
                            </a>
                        </c:if>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:choose>
                                <c:when test="${i == currentPage}">
                                    <span class="active">${i}</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/tour?page=${i}&search=${searchQuery}&sortBy=${sortBy}&categoryId=${selectedCategory}">${i}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <a href="${pageContext.request.contextPath}/tour?page=${currentPage + 1}&search=${searchQuery}&sortBy=${sortBy}&categoryId=${selectedCategory}">
                                <i class="fas fa-chevron-right"></i>
                            </a>
                        </c:if>
                    </div>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="icon">🔍</div>
                    <h3>Không tìm thấy tour nào</h3>
                    <p>Thử thay đổi bộ lọc hoặc quay lại sau.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </section>

    <jsp:include page="/common/_footer.jsp" />

    <script>
    function toggleWish(btn) {
        const i = btn.querySelector('i');
        i.classList.toggle('far');
        i.classList.toggle('fas');
        btn.style.color = i.classList.contains('fas') ? '#FF6F61' : '';
        btn.style.transform = 'scale(1.3)';
        setTimeout(() => btn.style.transform = '', 200);
    }
    </script>
</body>
</html>
