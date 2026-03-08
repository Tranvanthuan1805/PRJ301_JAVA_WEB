<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách yêu thích | eztravel</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .wishlist-page { padding: 120px 0 60px; min-height: 100vh; background: #f8fafc; }
        .wishlist-header { display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 40px; }
        .wishlist-header h1 { font-size: 2rem; color: #1B1F3B; }
        .wishlist-header h1 i { color: #FF6F61; margin-right: 10px; }
        .wishlist-header .count-badge { background: linear-gradient(135deg, #FF6F61, #FF9A8B); color: white; padding: 6px 16px; border-radius: 20px; font-size: .85rem; font-weight: 700; }

        .wishlist-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 28px; }

        .wishlist-card { background: white; border-radius: 20px; overflow: hidden; box-shadow: 0 4px 20px rgba(27,31,59,.06); transition: all .4s cubic-bezier(.175,.885,.32,1.275); position: relative; }
        .wishlist-card:hover { transform: translateY(-8px); box-shadow: 0 16px 48px rgba(27,31,59,.12); }
        .wishlist-card .card-img { height: 200px; position: relative; overflow: hidden; }
        .wishlist-card .card-img img { width: 100%; height: 100%; object-fit: cover; transition: transform .6s; }
        .wishlist-card:hover .card-img img { transform: scale(1.08); }
        .wishlist-card .remove-btn { position: absolute; top: 14px; right: 14px; width: 40px; height: 40px; border-radius: 50%; background: rgba(255,255,255,.95); backdrop-filter: blur(10px); border: none; cursor: pointer; display: flex; align-items: center; justify-content: center; color: #FF6F61; font-size: 1.1rem; transition: all .3s; z-index: 2; }
        .wishlist-card .remove-btn:hover { background: #FF6F61; color: white; transform: scale(1.1); }
        .wishlist-card .card-body { padding: 22px; }
        .wishlist-card .card-body h3 { font-size: 1.1rem; font-weight: 700; color: #1B1F3B; margin-bottom: 8px; }
        .wishlist-card .price { font-size: 1.25rem; font-weight: 800; background: linear-gradient(135deg, #FF6F61, #FF9A8B); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .wishlist-card .card-actions { display: flex; gap: 10px; margin-top: 16px; }
        .wishlist-card .btn-sm { padding: 10px 18px; border-radius: 12px; font-size: .82rem; font-weight: 700; border: none; cursor: pointer; transition: all .3s; flex: 1; text-align: center; text-decoration: none; display: flex; align-items: center; justify-content: center; gap: 6px; }
        .wishlist-card .btn-view { background: #f0f4ff; color: #2563EB; }
        .wishlist-card .btn-view:hover { background: #2563EB; color: white; }
        .wishlist-card .btn-book { background: linear-gradient(135deg, #FF6F61, #FF9A8B); color: white; }
        .wishlist-card .btn-book:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(255,111,97,.35); }
        .wishlist-card .date-added { font-size: .78rem; color: #94a3b8; margin-top: 10px; display: flex; align-items: center; gap: 6px; }

        .empty-wishlist { text-align: center; padding: 80px 20px; }
        .empty-wishlist i { font-size: 4rem; color: #e2e8f0; margin-bottom: 20px; }
        .empty-wishlist h2 { color: #64748b; font-size: 1.3rem; margin-bottom: 10px; }
        .empty-wishlist p { color: #94a3b8; margin-bottom: 24px; }
        .empty-wishlist .btn-explore { background: linear-gradient(135deg, #FF6F61, #FF9A8B); color: white; padding: 14px 32px; border-radius: 14px; text-decoration: none; font-weight: 700; display: inline-flex; align-items: center; gap: 8px; transition: all .3s; }
        .empty-wishlist .btn-explore:hover { transform: translateY(-3px); box-shadow: 0 10px 30px rgba(255,111,97,.3); }

        @media(max-width:768px) {
            .wishlist-page { padding: 90px 0 40px; }
            .wishlist-grid { grid-template-columns: 1fr; }
            .wishlist-header { flex-direction: column; align-items: flex-start; gap: 12px; }
        }
    </style>
</head>
<body>
    <jsp:include page="/common/_navbar.jsp" />

    <section class="wishlist-page">
        <div class="container">
            <div class="wishlist-header">
                <div>
                    <h1><i class="fas fa-heart"></i> Danh sách yêu thích</h1>
                    <p style="color:#64748b;margin-top:6px">Lưu giữ những tour du lịch bạn quan tâm</p>
                </div>
                <c:if test="${wishlistCount > 0}">
                    <span class="count-badge"><i class="fas fa-heart"></i> ${wishlistCount} tour</span>
                </c:if>
            </div>

            <c:choose>
                <c:when test="${empty wishlists}">
                    <div class="empty-wishlist">
                        <i class="far fa-heart"></i>
                        <h2>Chưa có tour yêu thích</h2>
                        <p>Khám phá các tour hấp dẫn và thêm vào danh sách yêu thích của bạn</p>
                        <a href="${pageContext.request.contextPath}/tour" class="btn-explore">
                            <i class="fas fa-compass"></i> Khám phá tour
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="wishlist-grid">
                        <c:forEach items="${wishlists}" var="w">
                            <div class="wishlist-card" id="wishlist-${w.wishlistId}">
                                <div class="card-img">
                                    <img src="${w.tour.imageUrl != null ? w.tour.imageUrl : 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=600'}" 
                                         alt="${w.tour.tourName}">
                                    <button class="remove-btn" onclick="removeFromWishlist(${w.tour.tourId}, ${w.wishlistId})" title="Xóa khỏi yêu thích">
                                        <i class="fas fa-heart-broken"></i>
                                    </button>
                                </div>
                                <div class="card-body">
                                    <h3>${w.tour.tourName}</h3>
                                    <div class="price">
                                        <fmt:formatNumber value="${w.tour.price}" pattern="#,##0"/>đ
                                    </div>
                                    <c:if test="${not empty w.note}">
                                        <p style="font-size:.85rem;color:#64748b;margin-top:8px;font-style:italic">"${w.note}"</p>
                                    </c:if>
                                    <div class="card-actions">
                                        <a href="${pageContext.request.contextPath}/tour?action=detail&id=${w.tour.tourId}" class="btn-sm btn-view">
                                            <i class="fas fa-eye"></i> Chi tiết
                                        </a>
                                        <a href="${pageContext.request.contextPath}/booking?id=${w.tour.tourId}" class="btn-sm btn-book">
                                            <i class="fas fa-shopping-cart"></i> Đặt ngay
                                        </a>
                                    </div>
                                    <div class="date-added">
                                        <i class="far fa-clock"></i>
                                        Đã thêm: <fmt:formatDate value="${w.addedAt}" pattern="dd/MM/yyyy"/>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <jsp:include page="/common/_footer.jsp" />

    <script>
        function removeFromWishlist(tourId, wishlistId) {
            if (!confirm('Bạn có muốn xóa tour này khỏi danh sách yêu thích?')) return;

            fetch('${pageContext.request.contextPath}/wishlist', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'action=remove&tourId=' + tourId
            })
            .then(r => r.json())
            .then(data => {
                if (data.success) {
                    const card = document.getElementById('wishlist-' + wishlistId);
                    card.style.transform = 'scale(0.8)';
                    card.style.opacity = '0';
                    setTimeout(() => {
                        card.remove();
                        if (document.querySelectorAll('.wishlist-card').length === 0) {
                            location.reload();
                        }
                    }, 400);
                }
            });
        }
    </script>
</body>
</html>
