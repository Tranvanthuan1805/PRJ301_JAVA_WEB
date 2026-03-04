<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gói Dịch Vụ | Da Nang Travel Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .pricing-hero{background:linear-gradient(135deg,#1B1F3B,#2D3561);color:white;padding:100px 0 120px;text-align:center;position:relative;overflow:hidden;margin-top:64px}
        .pricing-hero::before{content:'';position:absolute;width:600px;height:600px;background:radial-gradient(circle,rgba(255,111,97,.1),transparent 60%);top:-200px;left:-100px;border-radius:50%}
        .pricing-hero::after{content:'';position:absolute;width:400px;height:400px;background:radial-gradient(circle,rgba(0,180,216,.08),transparent 60%);bottom:-150px;right:-50px;border-radius:50%}
        .pricing-hero h1{font-size:2.8rem;font-weight:800;margin-bottom:14px;letter-spacing:-.5px;position:relative;z-index:1}
        .pricing-hero h1 .hl{color:#FF6F61}
        .pricing-hero p{font-size:1.1rem;opacity:.7;max-width:500px;margin:0 auto;line-height:1.7;position:relative;z-index:1}

        .pricing-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));gap:28px;max-width:1050px;margin:-70px auto 70px;padding:0 30px;position:relative;z-index:10}

        .plan-card{background:#fff;border-radius:24px;padding:40px 32px;box-shadow:0 8px 30px rgba(27,31,59,.06);border:2px solid #E8EAF0;text-align:center;transition:.4s cubic-bezier(.175,.885,.32,1.275);position:relative;overflow:hidden}
        .plan-card:hover{transform:translateY(-10px);box-shadow:0 20px 50px rgba(27,31,59,.12)}
        .plan-card.popular{border-color:#FF6F61;box-shadow:0 8px 30px rgba(255,111,97,.1)}
        .plan-card.popular::before{content:'PHỔ BIẾN';position:absolute;top:22px;right:-32px;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:white;padding:5px 42px;font-size:.68rem;font-weight:800;transform:rotate(45deg);letter-spacing:1px;box-shadow:0 4px 12px rgba(255,111,97,.3)}

        .plan-icon{font-size:3.5rem;margin-bottom:18px;display:block}
        .plan-name{font-size:1.3rem;font-weight:800;color:#1B1F3B;margin-bottom:10px}
        .plan-price{font-size:2.5rem;font-weight:800;color:#1B1F3B;margin-bottom:5px;letter-spacing:-1px}
        .plan-price span{font-size:.9rem;font-weight:500;color:#A0A5C3}
        .plan-desc{color:#6B7194;font-size:.88rem;margin-bottom:28px;line-height:1.6}

        .plan-features{text-align:left;margin-bottom:32px}
        .plan-features li{list-style:none;padding:9px 0;font-size:.88rem;color:#4A4E6F;display:flex;align-items:center;gap:10px;border-bottom:1px solid #F5F6FA}
        .plan-features li:last-child{border-bottom:none}
        .plan-features li i{color:#06D6A0;font-size:.82rem;flex-shrink:0}

        .btn-plan{width:100%;padding:16px;border-radius:14px;font-size:.95rem;font-weight:800;cursor:pointer;transition:.3s;border:none;font-family:'Plus Jakarta Sans',sans-serif;display:flex;align-items:center;justify-content:center;gap:8px}
        .btn-plan.primary{background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;box-shadow:0 6px 20px rgba(255,111,97,.2)}
        .btn-plan.primary:hover{transform:translateY(-2px);box-shadow:0 10px 30px rgba(255,111,97,.35)}
        .btn-plan.outline{background:#fff;color:#1B1F3B;border:2px solid #E8EAF0}
        .btn-plan.outline:hover{border-color:#1B1F3B;background:rgba(27,31,59,.02)}

        .empty-plans{text-align:center;padding:50px;grid-column:1/-1;color:#6B7194}

        @media(max-width:768px){.pricing-hero h1{font-size:2rem}.pricing-grid{grid-template-columns:1fr}}
    </style>
</head>
<body>
    <jsp:include page="/common/_header.jsp" />

    <section class="pricing-hero">
        <h1>Chọn Gói <span class="hl">Phù Hợp</span></h1>
        <p>Nâng cấp tài khoản để trải nghiệm đầy đủ dịch vụ và công cụ quản lý tour du lịch</p>
    </section>

    <div class="pricing-grid">
        <c:forEach items="${plans}" var="p" varStatus="loop">
            <div class="plan-card ${loop.index == 1 ? 'popular' : ''}">
                <span class="plan-icon">${loop.index == 0 ? '🌱' : (loop.index == 1 ? '🚀' : '👑')}</span>
                <div class="plan-name">${p.planName}</div>
                <div class="plan-price">
                    <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>đ
                    <span>/ ${p.durationDays} ngày</span>
                </div>
                <div class="plan-desc">${p.description}</div>
                <ul class="plan-features">
                    <li><i class="fas fa-check-circle"></i> Quản lý tours</li>
                    <li><i class="fas fa-check-circle"></i> Hỗ trợ kỹ thuật</li>
                    <c:if test="${loop.index >= 1}">
                        <li><i class="fas fa-check-circle"></i> AI dự báo doanh thu</li>
                        <li><i class="fas fa-check-circle"></i> Phân tích nâng cao</li>
                    </c:if>
                    <c:if test="${loop.index >= 2}">
                        <li><i class="fas fa-check-circle"></i> Ưu tiên hiển thị tour</li>
                        <li><i class="fas fa-check-circle"></i> Hỗ trợ VIP 24/7</li>
                    </c:if>
                </ul>
                <a href="${pageContext.request.contextPath}/payment?planId=${p.planId}" class="btn-plan ${loop.index == 1 ? 'primary' : 'outline'}">
                    <i class="fas fa-${loop.index == 1 ? 'bolt' : 'arrow-right'}"></i> Chọn Gói Này
                </a>
            </div>
        </c:forEach>

        <c:if test="${empty plans}">
            <div class="empty-plans">
                <p>Chưa có gói dịch vụ nào. Vui lòng quay lại sau.</p>
            </div>
        </c:if>
    </div>

    <jsp:include page="/common/_footer.jsp" />
</body>
</html>
