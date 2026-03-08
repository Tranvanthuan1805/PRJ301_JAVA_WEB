<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn Hàng Của Tôi | EZTravel Đà Nẵng</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
    *{box-sizing:border-box}
    body{font-family:'Plus Jakarta Sans',system-ui,sans-serif;background:#F4F5FA;color:#1B1F3B;-webkit-font-smoothing:antialiased}

    /* ═══ HERO HEADER ═══ */
    .orders-hero{margin-top:64px;background:linear-gradient(135deg,#1B1F3B 0%,#2D3561 40%,#3B4280 100%);padding:52px 0 90px;position:relative;overflow:hidden}
    .orders-hero::before{content:'';position:absolute;width:600px;height:600px;background:radial-gradient(circle,rgba(255,111,97,.12),transparent 65%);top:-250px;right:-100px;border-radius:50%}
    .orders-hero::after{content:'';position:absolute;width:400px;height:400px;background:radial-gradient(circle,rgba(6,214,160,.08),transparent 65%);bottom:-200px;left:-80px;border-radius:50%}
    .hero-content{max-width:1200px;margin:0 auto;padding:0 30px;position:relative;z-index:2;display:flex;justify-content:space-between;align-items:center}
    .hero-left h1{font-size:2.2rem;font-weight:900;color:#fff;letter-spacing:-.5px;margin-bottom:8px;display:flex;align-items:center;gap:12px}
    .hero-left h1 .icon-box{width:48px;height:48px;background:linear-gradient(135deg,#FF6F61,#FF9A8B);border-radius:14px;display:flex;align-items:center;justify-content:center;font-size:1.2rem;box-shadow:0 4px 15px rgba(255,111,97,.3)}
    .hero-left p{color:rgba(255,255,255,.55);font-size:.95rem;font-weight:500}
    .hero-right{display:flex;gap:10px}
    .hero-btn{padding:12px 22px;border-radius:12px;font-weight:700;font-size:.85rem;font-family:inherit;text-decoration:none;display:flex;align-items:center;gap:8px;transition:.3s;border:none;cursor:pointer}
    .hero-btn-primary{background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;box-shadow:0 4px 15px rgba(255,111,97,.2)}
    .hero-btn-primary:hover{transform:translateY(-2px);box-shadow:0 8px 25px rgba(255,111,97,.4)}
    .hero-btn-outline{background:rgba(255,255,255,.08);color:#fff;border:1px solid rgba(255,255,255,.15);backdrop-filter:blur(10px)}
    .hero-btn-outline:hover{background:rgba(255,255,255,.15)}

    .page-body{max-width:1200px;margin:0 auto;padding:0 30px}

    /* ═══ STATS ═══ */
    .stats-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin:-50px 0 32px;position:relative;z-index:10}
    .stat-card{background:#fff;padding:24px;border-radius:20px;text-align:center;box-shadow:0 8px 30px rgba(27,31,59,.06);border:1px solid #E8EAF0;transition:.3s;cursor:default;position:relative;overflow:hidden}
    .stat-card:hover{transform:translateY(-4px);box-shadow:0 12px 40px rgba(27,31,59,.1)}
    .stat-card::before{content:'';position:absolute;top:0;left:0;right:0;height:3px;border-radius:20px 20px 0 0}
    .stat-card:nth-child(1)::before{background:linear-gradient(90deg,#F59E0B,#FBBF24)}
    .stat-card:nth-child(2)::before{background:linear-gradient(90deg,#0284C7,#38BDF8)}
    .stat-card:nth-child(3)::before{background:linear-gradient(90deg,#059669,#34D399)}
    .stat-card:nth-child(4)::before{background:linear-gradient(90deg,#DC2626,#F87171)}
    .stat-icon{width:48px;height:48px;border-radius:14px;display:flex;align-items:center;justify-content:center;margin:0 auto 12px;font-size:1.1rem}
    .stat-card:nth-child(1) .stat-icon{background:rgba(245,158,11,.08);color:#F59E0B}
    .stat-card:nth-child(2) .stat-icon{background:rgba(2,132,199,.08);color:#0284C7}
    .stat-card:nth-child(3) .stat-icon{background:rgba(5,150,105,.08);color:#059669}
    .stat-card:nth-child(4) .stat-icon{background:rgba(220,38,38,.08);color:#DC2626}
    .stat-num{font-size:2.2rem;font-weight:900;letter-spacing:-1.5px;line-height:1}
    .stat-card:nth-child(1) .stat-num{color:#D97706}
    .stat-card:nth-child(2) .stat-num{color:#0284C7}
    .stat-card:nth-child(3) .stat-num{color:#059669}
    .stat-card:nth-child(4) .stat-num{color:#DC2626}
    .stat-label{font-size:.78rem;color:#A0A5C3;margin-top:6px;font-weight:700;letter-spacing:.3px;text-transform:uppercase}

    /* ═══ FILTER TABS ═══ */
    .filter-bar{display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;flex-wrap:wrap;gap:12px}
    .filter-tabs{display:flex;gap:6px;background:#fff;padding:5px;border-radius:14px;box-shadow:0 2px 10px rgba(27,31,59,.04);border:1px solid #E8EAF0}
    .filter-tab{padding:10px 20px;border-radius:10px;font-size:.82rem;font-weight:700;color:#6B7194;cursor:pointer;transition:.3s;border:none;background:transparent;font-family:inherit}
    .filter-tab:hover{color:#1B1F3B;background:rgba(27,31,59,.03)}
    .filter-tab.active{background:linear-gradient(135deg,#1B1F3B,#2D3561);color:#fff;box-shadow:0 2px 8px rgba(27,31,59,.15)}
    .order-count-label{font-size:.85rem;color:#A0A5C3;font-weight:600}
    .order-count-label span{color:#1B1F3B;font-weight:800}

    /* ═══ ORDER CARDS ═══ */
    .orders-grid{display:grid;gap:16px;margin-bottom:60px}
    .order-card{background:#fff;border-radius:20px;box-shadow:0 4px 20px rgba(27,31,59,.04);border:1px solid #E8EAF0;overflow:hidden;transition:.3s;animation:fadeUp .4s ease both}
    .order-card:hover{box-shadow:0 10px 35px rgba(27,31,59,.08);transform:translateY(-2px)}
    @keyframes fadeUp{from{opacity:0;transform:translateY(12px)}to{opacity:1;transform:translateY(0)}}

    .order-card-inner{display:grid;grid-template-columns:100px 1fr auto;gap:0}
    .order-thumb{width:100px;height:100%;min-height:120px;position:relative;overflow:hidden}
    .order-thumb img{width:100%;height:100%;object-fit:cover;transition:.4s}
    .order-card:hover .order-thumb img{transform:scale(1.08)}
    .order-thumb .thumb-overlay{position:absolute;inset:0;background:linear-gradient(90deg,rgba(27,31,59,.05),rgba(27,31,59,.2))}

    .order-body{padding:20px 24px;display:flex;flex-direction:column;justify-content:center;gap:6px}
    .order-top{display:flex;align-items:center;gap:12px;flex-wrap:wrap}
    .order-number{font-size:.78rem;font-weight:800;color:#FF6F61;background:rgba(255,111,97,.06);padding:4px 12px;border-radius:8px;letter-spacing:.5px}
    .order-date-tag{font-size:.75rem;color:#A0A5C3;font-weight:600;display:flex;align-items:center;gap:4px}
    .order-date-tag i{font-size:.65rem}
    .order-title{font-size:1.02rem;font-weight:800;color:#1B1F3B;margin:2px 0;line-height:1.4}
    .order-title a{color:inherit;text-decoration:none;transition:.3s}
    .order-title a:hover{color:#FF6F61}
    .order-details{display:flex;align-items:center;gap:16px;flex-wrap:wrap}
    .order-amount{font-size:1.1rem;font-weight:800;color:#059669;letter-spacing:-.5px}
    .order-qty{font-size:.78rem;color:#A0A5C3;font-weight:600;display:flex;align-items:center;gap:4px}
    .order-qty i{font-size:.65rem;color:#6B7194}

    /* Status Badges */
    .status-badge{display:inline-flex;align-items:center;gap:6px;padding:6px 14px;border-radius:999px;font-size:.72rem;font-weight:800;letter-spacing:.3px}
    .status-badge .dot{width:7px;height:7px;border-radius:50%}
    .status-pending{background:#FFF8E1;color:#D97706;border:1px solid rgba(245,158,11,.15)}.status-pending .dot{background:#F59E0B}
    .status-confirmed{background:#E0F2FE;color:#0284C7;border:1px solid rgba(2,132,199,.15)}.status-confirmed .dot{background:#0284C7}
    .status-completed{background:#ECFDF5;color:#059669;border:1px solid rgba(5,150,105,.15)}.status-completed .dot{background:#059669}
    .status-cancelled{background:#FEF2F2;color:#DC2626;border:1px solid rgba(220,38,38,.1)}.status-cancelled .dot{background:#DC2626}

    /* Payment Badge */
    .pay-badge{font-size:.7rem;font-weight:700;padding:3px 10px;border-radius:6px}
    .pay-paid{background:rgba(5,150,105,.06);color:#059669}
    .pay-unpaid{background:rgba(245,158,11,.06);color:#D97706}

    /* Actions */
    .order-actions-col{display:flex;flex-direction:column;gap:8px;padding:20px 24px;justify-content:center;align-items:flex-end;border-left:1px solid #F0F1F5}
    .btn-pay{display:flex;align-items:center;gap:6px;padding:10px 22px;border-radius:12px;font-weight:700;font-size:.82rem;font-family:inherit;text-decoration:none;transition:.3s;background:linear-gradient(135deg,#059669,#34D399);color:#fff;box-shadow:0 3px 12px rgba(5,150,105,.2);border:none;cursor:pointer;white-space:nowrap}
    .btn-pay:hover{transform:translateY(-2px);box-shadow:0 6px 20px rgba(5,150,105,.3)}
    .btn-pay i{font-size:.9rem}
    .btn-cancel{display:flex;align-items:center;gap:6px;padding:8px 16px;border-radius:10px;font-weight:700;font-size:.78rem;font-family:inherit;transition:.3s;background:rgba(220,38,38,.04);color:#DC2626;border:1px solid rgba(220,38,38,.1);cursor:pointer;white-space:nowrap}
    .btn-cancel:hover{background:#DC2626;color:#fff;border-color:#DC2626}
    .btn-view{display:flex;align-items:center;gap:5px;padding:8px 16px;border-radius:10px;font-weight:700;font-size:.78rem;font-family:inherit;text-decoration:none;transition:.3s;background:rgba(27,31,59,.03);color:#6B7194;border:1px solid #E8EAF0}
    .btn-view:hover{background:rgba(27,31,59,.06);color:#1B1F3B}

    /* ═══ EMPTY STATE ═══ */
    .empty-state{text-align:center;padding:80px 30px;background:#fff;border-radius:24px;border:1px solid #E8EAF0;box-shadow:0 8px 35px rgba(27,31,59,.04)}
    .empty-icon{width:100px;height:100px;margin:0 auto 24px;background:linear-gradient(135deg,rgba(255,111,97,.08),rgba(255,154,139,.04));border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:2.8rem}
    .empty-state h3{font-size:1.3rem;font-weight:800;color:#1B1F3B;margin-bottom:8px}
    .empty-state p{color:#6B7194;margin-bottom:24px;max-width:360px;margin-left:auto;margin-right:auto;line-height:1.7}
    .btn-explore{display:inline-flex;align-items:center;gap:8px;padding:14px 32px;border-radius:14px;font-weight:800;font-size:.92rem;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;box-shadow:0 6px 20px rgba(255,111,97,.25);transition:.3s;text-decoration:none}
    .btn-explore:hover{transform:translateY(-3px);box-shadow:0 10px 30px rgba(255,111,97,.4)}

    /* ═══ CANCEL REASON ═══ */
    .cancel-info{display:flex;align-items:center;gap:6px;font-size:.75rem;color:#DC2626;margin-top:2px}
    .cancel-info i{font-size:.65rem}

    /* ═══ RESPONSIVE ═══ */
    @media(max-width:900px){
        .stats-grid{grid-template-columns:repeat(2,1fr)}
        .order-card-inner{grid-template-columns:80px 1fr}
        .order-actions-col{grid-column:1/-1;flex-direction:row;border-left:none;border-top:1px solid #F0F1F5;padding:14px 24px;justify-content:flex-start}
        .hero-content{flex-direction:column;gap:16px;text-align:center}
        .hero-right{justify-content:center}
    }
    @media(max-width:600px){
        .stats-grid{grid-template-columns:repeat(2,1fr);gap:10px}
        .order-card-inner{grid-template-columns:1fr}
        .order-thumb{height:160px;width:100%}
        .filter-tabs{overflow-x:auto;-webkit-overflow-scrolling:touch}
        .hero-left h1{font-size:1.6rem;justify-content:center}
    }
    </style>
</head>
<body>
    <jsp:include page="/common/_header.jsp" />

    <!-- ═══ HERO ═══ -->
    <div class="orders-hero">
        <div class="hero-content">
            <div class="hero-left">
                <h1>
                    <span class="icon-box"><i class="fas fa-box"></i></span>
                    Đơn Hàng Của Tôi
                </h1>
                <p>Quản lý và theo dõi tất cả đơn hàng du lịch của bạn</p>
            </div>
            <div class="hero-right">
                <a href="${pageContext.request.contextPath}/tour" class="hero-btn hero-btn-primary">
                    <i class="fas fa-compass"></i> Đặt Tour Mới
                </a>
                <a href="${pageContext.request.contextPath}/history" class="hero-btn hero-btn-outline">
                    <i class="fas fa-clock-rotate-left"></i> Lịch Sử
                </a>
            </div>
        </div>
    </div>

    <div class="page-body">
        <!-- ═══ STATS ═══ -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-hourglass-half"></i></div>
                <div class="stat-num">${pendingCount}</div>
                <div class="stat-label">Chờ Xác Nhận</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-clipboard-check"></i></div>
                <div class="stat-num">${confirmedCount}</div>
                <div class="stat-label">Đã Xác Nhận</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-flag-checkered"></i></div>
                <div class="stat-num">${completedCount}</div>
                <div class="stat-label">Hoàn Thành</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-ban"></i></div>
                <div class="stat-num">${cancelledCount}</div>
                <div class="stat-label">Đã Hủy</div>
            </div>
        </div>

        <!-- ═══ FILTER ═══ -->
        <div class="filter-bar">
            <div class="filter-tabs">
                <button class="filter-tab active" data-filter="all">Tất Cả</button>
                <button class="filter-tab" data-filter="Pending">⏳ Chờ XN</button>
                <button class="filter-tab" data-filter="Confirmed">✅ Đã XN</button>
                <button class="filter-tab" data-filter="Completed">🏆 Hoàn Thành</button>
                <button class="filter-tab" data-filter="Cancelled">❌ Đã Hủy</button>
            </div>
            <div class="order-count-label">
                <i class="fas fa-list-ul"></i> Tổng: <span>${orders.size()}</span> đơn hàng
            </div>
        </div>

        <!-- ═══ ORDER LIST ═══ -->
        <c:choose>
            <c:when test="${not empty orders}">
                <div class="orders-grid" id="ordersGrid">
                    <c:forEach items="${orders}" var="o" varStatus="idx">
                        <div class="order-card" data-status="${o.status}" style="animation-delay:${idx.index * 0.06}s">
                            <div class="order-card-inner">
                                <!-- Thumbnail -->
                                <div class="order-thumb">
                                    <img src="${not empty o.tourImage ? o.tourImage : 'https://images.unsplash.com/photo-1559592442-7e182c3c03fb?auto=format&fit=crop&w=200&q=80'}"
                                         alt="${o.tourName}" loading="lazy">
                                    <div class="thumb-overlay"></div>
                                </div>

                                <!-- Body -->
                                <div class="order-body">
                                    <div class="order-top">
                                        <span class="order-number">#${o.orderId}</span>
                                        <span class="order-date-tag">
                                            <i class="far fa-calendar"></i>
                                            <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy • HH:mm"/>
                                        </span>
                                        <c:choose>
                                            <c:when test="${o.status == 'Pending'}"><span class="status-badge status-pending"><span class="dot"></span>Chờ xác nhận</span></c:when>
                                            <c:when test="${o.status == 'Confirmed'}"><span class="status-badge status-confirmed"><span class="dot"></span>Đã xác nhận</span></c:when>
                                            <c:when test="${o.status == 'Completed'}"><span class="status-badge status-completed"><span class="dot"></span>Hoàn thành</span></c:when>
                                            <c:when test="${o.status == 'Cancelled'}"><span class="status-badge status-cancelled"><span class="dot"></span>Đã hủy</span></c:when>
                                            <c:otherwise><span class="status-badge status-pending"><span class="dot"></span>${o.status}</span></c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="order-title">
                                        <a href="${pageContext.request.contextPath}/tour?action=view&id=${o.tourId}">
                                            ${o.tourName}
                                        </a>
                                    </div>

                                    <div class="order-details">
                                        <span class="order-amount">
                                            <fmt:formatNumber value="${o.totalAmount}" type="number" groupingUsed="true"/>đ
                                        </span>
                                        <c:if test="${o.numberOfPeople > 0}">
                                            <span class="order-qty"><i class="fas fa-user"></i> ${o.numberOfPeople} người</span>
                                        </c:if>
                                        <c:if test="${not empty o.tourDuration}">
                                            <span class="order-qty"><i class="fas fa-clock"></i> ${o.tourDuration}</span>
                                        </c:if>
                                        <c:if test="${not empty o.paymentStatus}">
                                            <c:choose>
                                                <c:when test="${o.paymentStatus == 'Paid'}">
                                                    <span class="pay-badge pay-paid"><i class="fas fa-check-circle"></i> Đã TT</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="pay-badge pay-unpaid"><i class="fas fa-clock"></i> Chưa TT</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                    </div>

                                    <c:if test="${o.status == 'Cancelled' && not empty o.cancelReason}">
                                        <div class="cancel-info"><i class="fas fa-info-circle"></i> ${o.cancelReason}</div>
                                    </c:if>
                                </div>

                                <!-- Actions -->
                                <div class="order-actions-col">
                                    <c:if test="${o.status == 'Pending'}">
                                        <a href="${pageContext.request.contextPath}/my-orders?action=pay&id=${o.orderId}" class="btn-pay">
                                            <i class="fas fa-qrcode"></i> Thanh Toán
                                        </a>
                                        <form action="${pageContext.request.contextPath}/my-orders" method="post" style="margin:0"
                                              onsubmit="return confirm('Bạn có chắc muốn hủy đơn hàng #${o.orderId}?')">
                                            <input type="hidden" name="action" value="cancel">
                                            <input type="hidden" name="orderId" value="${o.orderId}">
                                            <button type="submit" class="btn-cancel"><i class="fas fa-times"></i> Hủy Đơn</button>
                                        </form>
                                    </c:if>
                                    <a href="${pageContext.request.contextPath}/my-orders?action=view&id=${o.orderId}" class="btn-view">
                                        <i class="fas fa-eye"></i> Chi Tiết
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">📦</div>
                    <h3>Chưa có đơn hàng nào</h3>
                    <p>Hãy khám phá những tour du lịch Đà Nẵng hấp dẫn và đặt chuyến đi đầu tiên của bạn!</p>
                    <a href="${pageContext.request.contextPath}/tour" class="btn-explore">
                        <i class="fas fa-compass"></i> Khám Phá Tours
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <jsp:include page="/common/_footer.jsp" />

    <script>
    // Filter tabs
    document.querySelectorAll('.filter-tab').forEach(tab => {
        tab.addEventListener('click', () => {
            document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
            tab.classList.add('active');

            const filter = tab.dataset.filter;
            const cards = document.querySelectorAll('.order-card');
            let visibleCount = 0;

            cards.forEach((card, i) => {
                const status = card.dataset.status;
                const show = filter === 'all' || status === filter;
                card.style.display = show ? '' : 'none';
                if (show) {
                    card.style.animationDelay = (visibleCount * 0.06) + 's';
                    visibleCount++;
                }
            });

            // Update count
            const countLabel = document.querySelector('.order-count-label span');
            if (countLabel) countLabel.textContent = visibleCount;
        });
    });
    </script>
</body>
</html>
