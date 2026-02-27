<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Da Nang Travel Hub | Đặt Tour Du Lịch & AI Dự Báo</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
    /* ═══ RESET ═══ */
    *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
    html{scroll-behavior:smooth}
    body{font-family:'Plus Jakarta Sans',system-ui,sans-serif;background:#F7F8FC;color:#1B1F3B;line-height:1.65;-webkit-font-smoothing:antialiased;overflow-x:hidden}
    a{text-decoration:none;color:inherit;transition:.3s}
    img{max-width:100%;display:block}
    ul{list-style:none}

    /* ═══ NAV ═══ */
    .nav{position:fixed;top:0;left:0;right:0;z-index:1000;padding:16px 0;transition:.4s}
    .nav.scrolled{background:rgba(255,255,255,.95);backdrop-filter:blur(20px);box-shadow:0 2px 30px rgba(0,0,0,.06);padding:8px 0}
    .nav-inner{max-width:1280px;margin:0 auto;padding:0 30px}
    .nav-bar{display:flex;align-items:center;justify-content:space-between;height:56px;background:rgba(27,31,59,.6);backdrop-filter:blur(24px);border-radius:999px;padding:0 8px 0 28px;border:1px solid rgba(255,255,255,.08);box-shadow:0 8px 32px rgba(0,0,0,.18)}
    .nav.scrolled .nav-bar{background:transparent;backdrop-filter:none;border:none;box-shadow:none;padding:0 10px}
    .logo{font-size:1.25rem;font-weight:800;color:#fff;display:flex;align-items:center;gap:6px}
    .logo .a{color:#FF6F61}
    .nav.scrolled .logo{color:#1B1F3B}
    .nav-menu{display:flex;gap:4px;align-items:center}
    .nav-menu a{color:rgba(255,255,255,.75);font-weight:600;font-size:.88rem;padding:8px 18px;border-radius:999px;transition:.3s}
    .nav-menu a:hover{color:#fff;background:rgba(255,255,255,.1)}
    .nav.scrolled .nav-menu a{color:#6B7194}
    .nav.scrolled .nav-menu a:hover{color:#1B1F3B;background:#EFF1F8}
    .nav-right{display:flex;align-items:center;gap:10px}
    .nav-right a{color:rgba(255,255,255,.8);font-weight:600;font-size:.88rem}
    .nav.scrolled .nav-right a{color:#6B7194}
    .btn-cta{display:inline-flex;align-items:center;gap:6px;padding:10px 22px;border-radius:999px;font-weight:700;font-size:.85rem;border:none;cursor:pointer;transition:.3s;font-family:inherit}
    .btn-accent{background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;box-shadow:0 4px 15px rgba(255,111,97,.3)}
    .btn-accent:hover{transform:translateY(-2px);box-shadow:0 8px 25px rgba(255,111,97,.45)}

    /* ═══ HERO ═══ */
    .hero{position:relative;min-height:100vh;display:flex;align-items:center;overflow:hidden}
    .hero-img{position:absolute;inset:0;background:url('https://images.unsplash.com/photo-1559592442-7e182c3c03fb?auto=format&fit=crop&w=1920&q=85') center/cover;animation:kenBurns 30s ease-in-out infinite alternate;z-index:0}
    @keyframes kenBurns{0%{transform:scale(1.05)}100%{transform:scale(1.15) translate(-1%,1%)}}
    .hero-dark{position:absolute;inset:0;background:linear-gradient(180deg,rgba(27,31,59,.35) 0%,rgba(27,31,59,.55) 40%,rgba(27,31,59,.88) 100%);z-index:1}
    .hero::after{content:'';position:absolute;bottom:0;left:0;right:0;height:200px;background:linear-gradient(transparent,#F7F8FC);z-index:2}
    .hero-wrap{position:relative;z-index:3;max-width:1280px;margin:0 auto;padding:130px 30px 180px;width:100%;display:flex;align-items:center;justify-content:space-between;gap:60px}
    .hero-left{max-width:620px;color:#fff}
    .hero-badge{display:inline-flex;align-items:center;gap:8px;padding:8px 20px;background:rgba(255,255,255,.1);backdrop-filter:blur(10px);border:1px solid rgba(255,255,255,.12);border-radius:999px;font-size:.82rem;font-weight:600;color:rgba(255,255,255,.9);margin-bottom:30px;animation:fadeUp .8s ease}
    .hero-badge .dot{width:8px;height:8px;background:#06D6A0;border-radius:50%;animation:pulse 2s ease infinite}
    @keyframes pulse{0%,100%{opacity:1;transform:scale(1)}50%{opacity:.5;transform:scale(1.6)}}
    .hero-left h1{font-size:3.8rem;font-weight:800;line-height:1.1;margin-bottom:24px;letter-spacing:-1.5px;animation:fadeUp .8s ease .1s both}
    .hero-left h1 .hl{background:linear-gradient(135deg,#FF6F61,#FF9A8B);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text}
    .hero-left>p{font-size:1.12rem;opacity:.78;max-width:500px;line-height:1.75;margin-bottom:40px;animation:fadeUp .8s ease .2s both}
    @keyframes fadeUp{from{opacity:0;transform:translateY(30px)}to{opacity:1;transform:translateY(0)}}
    .search-box{display:flex;gap:6px;background:rgba(255,255,255,.1);backdrop-filter:blur(20px);border:1px solid rgba(255,255,255,.15);border-radius:999px;padding:6px;max-width:520px;box-shadow:0 10px 40px rgba(0,0,0,.15);animation:fadeUp .8s ease .3s both}
    .search-box input{flex:1;border:none;padding:14px 22px;font-size:.95rem;outline:none;background:transparent;color:#fff;font-family:inherit}
    .search-box input::placeholder{color:rgba(255,255,255,.45)}
    .search-box .btn-cta{padding:14px 28px}

    /* Hero floating cards */
    .hero-right{display:flex;flex-direction:column;gap:16px;min-width:290px}
    .float-card{background:rgba(255,255,255,.1);backdrop-filter:blur(20px);border:1px solid rgba(255,255,255,.12);border-radius:16px;padding:20px;color:#fff;display:flex;align-items:center;gap:14px;animation:floatY 5s ease-in-out infinite}
    .float-card:nth-child(2){animation-delay:1.5s}
    .float-card:nth-child(3){animation-delay:3s}
    @keyframes floatY{0%,100%{transform:translateY(0)}50%{transform:translateY(-12px)}}
    .float-card .ic{width:48px;height:48px;border-radius:14px;background:rgba(255,255,255,.12);display:flex;align-items:center;justify-content:center;font-size:1.4rem;flex-shrink:0}
    .float-card h4{font-size:.9rem;font-weight:700;margin-bottom:2px}
    .float-card p{font-size:.78rem;opacity:.65}

    /* ═══ CATEGORIES ═══ */
    .cats{max-width:1280px;margin:-70px auto 0;padding:0 30px;position:relative;z-index:10}
    .cats-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:20px}
    .cat{background:#fff;border-radius:20px;padding:32px 24px;text-align:center;cursor:pointer;border:1px solid #E8EAF0;box-shadow:0 4px 20px rgba(27,31,59,.05);transition:.4s cubic-bezier(.175,.885,.32,1.275);position:relative;overflow:hidden}
    .cat::before{content:'';position:absolute;inset:0;background:linear-gradient(135deg,#FF6F61,#FF9A8B);opacity:0;transition:.4s;z-index:0}
    .cat:hover::before{opacity:1}
    .cat:hover{transform:translateY(-10px);box-shadow:0 20px 50px rgba(255,111,97,.2)}
    .cat>*{position:relative;z-index:1}
    .cat .ci{width:64px;height:64px;border-radius:18px;background:linear-gradient(135deg,rgba(255,111,97,.08),rgba(255,154,139,.04));display:flex;align-items:center;justify-content:center;margin:0 auto 16px;font-size:1.5rem;color:#FF6F61;transition:.4s}
    .cat:hover .ci{background:rgba(255,255,255,.2);color:#fff;transform:scale(1.12) rotate(-5deg)}
    .cat .cn{font-weight:700;color:#1B1F3B;font-size:1rem;transition:.3s}
    .cat:hover .cn{color:#fff}
    .cat .cd{font-size:.82rem;color:#A0A5C3;margin-top:6px;transition:.3s}
    .cat:hover .cd{color:rgba(255,255,255,.8)}

    /* ═══ STATS ═══ */
    .stats{max-width:1280px;margin:70px auto;padding:0 30px}
    .stats-bar{display:grid;grid-template-columns:repeat(4,1fr);background:#1B1F3B;border-radius:24px;position:relative;overflow:hidden}
    .stats-bar::before{content:'';position:absolute;inset:0;background:radial-gradient(circle at 20% 50%,rgba(255,111,97,.12),transparent 50%),radial-gradient(circle at 80% 50%,rgba(0,180,216,.12),transparent 50%)}
    .st{padding:42px 28px;text-align:center;position:relative;border-right:1px solid rgba(255,255,255,.06)}
    .st:last-child{border-right:none}
    .st .num{font-size:2.4rem;font-weight:800;color:#fff;letter-spacing:-1px}
    .st .lab{font-size:.88rem;color:rgba(255,255,255,.5);margin-top:6px;font-weight:500}

    /* ═══ SECTION HEADER ═══ */
    .sh{display:flex;justify-content:space-between;align-items:flex-end;margin-bottom:48px;max-width:1280px;margin-left:auto;margin-right:auto;padding:0 30px}
    .sh h2{font-size:2.2rem;font-weight:800;color:#1B1F3B;letter-spacing:-.5px}
    .sh .sub{color:#6B7194;margin-top:10px;font-size:1rem}
    .sh .more{color:#FF6F61;font-weight:700;font-size:.95rem;display:flex;align-items:center;gap:6px;flex-shrink:0}
    .sh .more:hover{gap:12px}

    /* ═══ TOUR CARDS ═══ */
    .tours{max-width:1280px;margin:0 auto 100px;padding:0 30px}
    .tour-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:28px}
    .tc{background:#fff;border-radius:20px;overflow:hidden;border:1px solid #E8EAF0;box-shadow:0 2px 8px rgba(27,31,59,.04);transition:.4s;display:flex;flex-direction:column}
    .tc:hover{transform:translateY(-10px);box-shadow:0 25px 60px rgba(27,31,59,.1)}
    .tc .iw{position:relative;height:250px;overflow:hidden}
    .tc .iw img{width:100%;height:100%;object-fit:cover;transition:transform .7s cubic-bezier(.4,0,.2,1)}
    .tc:hover .iw img{transform:scale(1.1)}
    .tc .bov{position:absolute;top:16px;left:16px;display:flex;gap:8px}
    .tc .bt{padding:6px 14px;border-radius:999px;font-size:.72rem;font-weight:700;letter-spacing:.3px}
    .bt-d{background:rgba(27,31,59,.7);backdrop-filter:blur(10px);color:#fff}
    .bt-a{background:rgba(255,111,97,.88);color:#fff}
    .tc .wl{position:absolute;top:16px;right:16px;width:38px;height:38px;border-radius:50%;background:rgba(255,255,255,.85);backdrop-filter:blur(10px);display:flex;align-items:center;justify-content:center;cursor:pointer;transition:.3s;border:none;color:#A0A5C3;font-size:.9rem}
    .tc .wl:hover{background:#fff;color:#FF6F61;transform:scale(1.12)}
    .tc .ct{padding:24px;flex:1;display:flex;flex-direction:column}
    .tc .loc{font-size:.75rem;text-transform:uppercase;letter-spacing:1.5px;color:#A0A5C3;font-weight:700;margin-bottom:8px;display:flex;align-items:center;gap:5px}
    .tc .ct h3{font-size:1.15rem;color:#1B1F3B;margin-bottom:10px;line-height:1.4;font-weight:700}
    .tc .desc{color:#6B7194;font-size:.88rem;line-height:1.6;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden;margin-bottom:20px}
    .tc .bot{margin-top:auto;padding-top:20px;border-top:1px solid #E8EAF0;display:flex;justify-content:space-between;align-items:center}
    .tc .pl{font-size:.75rem;color:#A0A5C3}
    .tc .pr{font-size:1.3rem;font-weight:800;color:#1B1F3B}
    .tc .pr span{font-size:.82rem;font-weight:500;color:#A0A5C3}
    .btn-book{padding:10px 24px;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;border:none;border-radius:999px;font-weight:700;cursor:pointer;transition:.3s;font-size:.85rem;font-family:inherit;box-shadow:0 4px 12px rgba(255,111,97,.2)}
    .btn-book:hover{transform:scale(1.06);box-shadow:0 8px 20px rgba(255,111,97,.35)}

    /* Empty state */
    .empty{text-align:center;padding:100px 30px;background:#fff;border-radius:24px;box-shadow:0 4px 20px rgba(27,31,59,.04)}
    .empty .em{font-size:5rem;margin-bottom:18px;filter:grayscale(.3)}
    .empty h3{color:#1B1F3B;margin-bottom:10px;font-size:1.4rem}
    .empty p{color:#6B7194;max-width:400px;margin:0 auto 25px}

    /* ═══ CTA ═══ */
    .cta{background:#1B1F3B;padding:110px 0;position:relative;overflow:hidden}
    .cta::before{content:'';position:absolute;width:600px;height:600px;background:radial-gradient(circle,rgba(255,111,97,.12),transparent 60%);top:-200px;left:-100px;border-radius:50%}
    .cta::after{content:'';position:absolute;width:500px;height:500px;background:radial-gradient(circle,rgba(0,180,216,.1),transparent 60%);bottom:-200px;right:-100px;border-radius:50%}
    .cta-inner{max-width:1280px;margin:0 auto;padding:0 30px;display:grid;grid-template-columns:1fr 1fr;gap:80px;align-items:center;position:relative;z-index:1}
    .cta h2{font-size:2.8rem;font-weight:800;color:#fff;margin-bottom:20px;line-height:1.2;letter-spacing:-.5px}
    .cta h2 .hl{color:#FF6F61}
    .cta>div p,.cta-inner>div:first-child p{font-size:1.05rem;color:rgba(255,255,255,.6);margin-bottom:35px;line-height:1.7}
    .nl-form{display:flex;gap:10px}
    .nl-form input{flex:1;padding:16px 24px;border-radius:999px;border:2px solid rgba(255,255,255,.1);background:rgba(255,255,255,.06);color:#fff;font-size:.95rem;outline:none;font-family:inherit;transition:.3s}
    .nl-form input::placeholder{color:rgba(255,255,255,.35)}
    .nl-form input:focus{border-color:#FF6F61;background:rgba(255,255,255,.1)}
    .feats{display:grid;grid-template-columns:1fr 1fr;gap:18px}
    .feat{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:28px;transition:.5s cubic-bezier(.175,.885,.32,1.275)}
    .feat:hover{background:rgba(255,255,255,.08);transform:translateY(-6px);border-color:rgba(255,255,255,.12)}
    .feat .fi{font-size:1.8rem;margin-bottom:14px}
    .feat h4{font-size:.95rem;color:#fff;margin-bottom:6px;font-weight:700}
    .feat p{font-size:.82rem;color:rgba(255,255,255,.45);line-height:1.5}

    /* ═══ FOOTER ═══ */
    .foot{background:#1B1F3B;color:#fff;padding:80px 0 30px;position:relative;overflow:hidden}
    .foot::before{content:'';position:absolute;width:400px;height:400px;background:radial-gradient(circle,rgba(255,111,97,.05),transparent 60%);top:-200px;right:-100px;border-radius:50%}
    .foot-inner{max-width:1280px;margin:0 auto;padding:0 30px;position:relative;z-index:1}
    .foot-grid{display:grid;grid-template-columns:1.5fr 1fr 1fr 1fr;gap:50px;margin-bottom:50px}
    .foot h3{font-size:1.4rem;margin-bottom:18px;font-weight:800}
    .foot h4{margin-bottom:18px;font-size:.92rem;font-weight:700}
    .foot p,.foot li a{color:rgba(255,255,255,.42);font-size:.88rem;transition:.3s}
    .foot li a:hover{color:rgba(255,255,255,.8)}
    .foot li{margin-bottom:10px}
    .foot .socials{display:flex;gap:10px;margin-top:20px}
    .foot .soc{width:38px;height:38px;border-radius:10px;background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.07);display:flex;align-items:center;justify-content:center;color:rgba(255,255,255,.45);transition:.3s;font-size:.9rem}
    .foot .soc:hover{background:rgba(255,255,255,.1);color:#fff}
    .foot hr{border:0;border-top:1px solid rgba(255,255,255,.06);margin-bottom:25px}
    .foot-bottom{display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:10px;color:rgba(255,255,255,.3);font-size:.78rem}

    /* ═══ AI BOT ═══ */
    .ai-btn{position:fixed;bottom:28px;right:28px;width:60px;height:60px;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:1.3rem;cursor:pointer;box-shadow:0 8px 30px rgba(255,111,97,.35);z-index:1001;transition:.5s cubic-bezier(.175,.885,.32,1.275);border:3px solid rgba(255,255,255,.2)}
    .ai-btn:hover{transform:scale(1.15) rotate(10deg);box-shadow:0 14px 40px rgba(255,111,97,.5)}

    /* ═══ REVEAL ═══ */
    .rv{opacity:0;transform:translateY(30px);transition:all .7s cubic-bezier(.4,0,.2,1)}
    .rv.vis{opacity:1;transform:translateY(0)}

    /* ═══ RESPONSIVE ═══ */
    @media(max-width:1024px){
        .hero-right{display:none}
        .hero-left h1{font-size:3rem}
        .cats-grid,.tour-grid{grid-template-columns:repeat(2,1fr)}
        .cta-inner{grid-template-columns:1fr;gap:50px}
        .stats-bar{grid-template-columns:repeat(2,1fr)}
        .foot-grid{grid-template-columns:repeat(2,1fr)}
    }
    @media(max-width:768px){
        .nav-menu{display:none}
        .hero{min-height:90vh}
        .hero-left h1{font-size:2.2rem}
        .cats-grid{grid-template-columns:1fr 1fr;gap:12px}
        .cat{padding:22px 16px}
        .tour-grid{grid-template-columns:1fr}
        .feats{grid-template-columns:1fr}
        .sh{flex-direction:column;align-items:flex-start;gap:10px}
        .sh h2{font-size:1.6rem}
        .cta h2{font-size:2rem}
        .foot-grid{grid-template-columns:1fr}
    }
    @media(max-width:480px){
        .hero-left h1{font-size:1.8rem}
        .search-box{flex-direction:column;border-radius:16px}
        .search-box .btn-cta{border-radius:12px;width:100%;justify-content:center}
        .stats-bar{grid-template-columns:1fr}
    }
    </style>
</head>
<body>

<!-- ═══ NAV ═══ -->
<nav class="nav" id="mainNav">
    <div class="nav-inner">
        <div class="nav-bar">
            <a href="${pageContext.request.contextPath}/" class="logo">
                <span class="a">🏖️</span> DN HUB
            </a>
            <div class="nav-menu">
                <a href="${pageContext.request.contextPath}/">Trang Chủ</a>
                <a href="${pageContext.request.contextPath}/tour">Khám Phá</a>
                <a href="${pageContext.request.contextPath}/my-orders">Đơn Hàng</a>
                <a href="${pageContext.request.contextPath}/pricing">Gói VIP</a>
            </div>
            <div class="nav-right">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <c:if test="${sessionScope.user.role.roleName == 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/admin/orders" class="btn-cta btn-accent" style="padding:7px 16px;font-size:.78rem"><i class="fas fa-bolt"></i> Admin</a>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/profile" style="display:flex;align-items:center">
                            <span style="width:34px;height:34px;border-radius:50%;background:linear-gradient(135deg,#FF6F61,#FF9A8B);display:flex;align-items:center;justify-content:center;font-weight:800;font-size:.8rem;color:#fff">${sessionScope.user.username.substring(0,1).toUpperCase()}</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i></a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp">Đăng Nhập</a>
                        <a href="${pageContext.request.contextPath}/register.jsp" class="btn-cta btn-accent">Đăng Ký <i class="fas fa-arrow-right"></i></a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<!-- ═══ HERO ═══ -->
<section class="hero">
    <div class="hero-img"></div>
    <div class="hero-dark"></div>
    <div class="hero-wrap">
        <div class="hero-left">
            <div class="hero-badge"><span class="dot"></span> Hơn 5,000+ du khách tin tưởng</div>
            <h1>Khám Phá Vẻ Đẹp<br><span class="hl">Đà Nẵng</span> Cùng Bạn</h1>
            <p>Tours xác minh bởi đối tác uy tín, đặt tour tức thì, nhận dự báo xu hướng bằng AI thông minh.</p>
            <form action="${pageContext.request.contextPath}/tour" method="get" class="search-box">
                <input type="text" name="search" placeholder="Bạn muốn đi đâu? Bà Nà, Sơn Trà, Hội An...">
                <button type="submit" class="btn-cta btn-accent"><i class="fas fa-search"></i> Tìm Tour</button>
            </form>
        </div>
        <div class="hero-right">
            <div class="float-card">
                <div class="ic">🏖️</div>
                <div><h4>100+ Tours</h4><p>Đã xác minh chất lượng</p></div>
            </div>
            <div class="float-card">
                <div class="ic">🤖</div>
                <div><h4>AI Forecast</h4><p>Dự báo doanh thu thông minh</p></div>
            </div>
            <div class="float-card">
                <div class="ic">⚡</div>
                <div><h4>Đặt Tức Thì</h4><p>Thanh toán QR SePay</p></div>
            </div>
        </div>
    </div>
</section>

<!-- ═══ CATEGORIES ═══ -->
<section class="cats">
    <div class="cats-grid">
        <a href="${pageContext.request.contextPath}/tour?categoryId=1" class="cat rv">
            <div class="ci"><i class="fas fa-umbrella-beach"></i></div>
            <div class="cn">Biển & Đảo</div>
            <div class="cd">Mỹ Khê, Cù Lao Chàm</div>
        </a>
        <a href="${pageContext.request.contextPath}/tour?categoryId=2" class="cat rv">
            <div class="ci"><i class="fas fa-mountain"></i></div>
            <div class="cn">Núi & Trekking</div>
            <div class="cd">Bà Nà, Sơn Trà</div>
        </a>
        <a href="${pageContext.request.contextPath}/tour?categoryId=3" class="cat rv">
            <div class="ci"><i class="fas fa-utensils"></i></div>
            <div class="cn">Ẩm Thực</div>
            <div class="cd">Mì Quảng, Bánh Tráng</div>
        </a>
        <a href="${pageContext.request.contextPath}/tour?categoryId=4" class="cat rv">
            <div class="ci"><i class="fas fa-landmark"></i></div>
            <div class="cn">Văn Hóa</div>
            <div class="cd">Hội An, Marble Mountain</div>
        </a>
    </div>
</section>

<!-- ═══ STATS ═══ -->
<section class="stats">
    <div class="stats-bar rv">
        <div class="st"><div class="num" style="color:#FF6F61">100+</div><div class="lab">Tours Xác Minh</div></div>
        <div class="st"><div class="num" style="color:#00B4D8">50+</div><div class="lab">Đối Tác Uy Tín</div></div>
        <div class="st"><div class="num" style="color:#06D6A0">5K+</div><div class="lab">Khách Hài Lòng</div></div>
        <div class="st"><div class="num" style="color:#FFB703">4.9★</div><div class="lab">Đánh Giá</div></div>
    </div>
</section>

<!-- ═══ TRENDING TOURS ═══ -->
<div class="sh" style="margin-bottom:48px;">
    <div>
        <h2>Tours Được Yêu Thích</h2>
        <p class="sub">Được chọn lọc bởi chuyên gia du lịch Đà Nẵng</p>
    </div>
    <a href="${pageContext.request.contextPath}/tour" class="more">Xem tất cả <i class="fas fa-arrow-right"></i></a>
</div>
<section class="tours">
    <c:choose>
        <c:when test="${not empty listTours}">
            <div class="tour-grid">
                <c:forEach items="${listTours}" var="t" varStatus="loop">
                    <div class="tc rv" style="transition-delay:${loop.index * 0.1}s">
                        <div class="iw">
                            <img src="${not empty t.imageUrl ? t.imageUrl : 'https://images.unsplash.com/photo-1559592442-7e182c3c03fb?auto=format&fit=crop&w=600&q=80'}" alt="${t.tourName}">
                            <div class="bov">
                                <c:if test="${not empty t.duration}"><span class="bt bt-d"><i class="fas fa-clock"></i> ${t.duration}</span></c:if>
                                <c:if test="${not empty t.category}"><span class="bt bt-a">${t.category.categoryName}</span></c:if>
                            </div>
                            <button class="wl" type="button"><i class="far fa-heart"></i></button>
                        </div>
                        <div class="ct">
                            <div class="loc"><i class="fas fa-map-pin"></i> Đà Nẵng, Việt Nam</div>
                            <h3>${t.tourName}</h3>
                            <p class="desc">${not empty t.description ? t.description : 'Trải nghiệm du lịch đẳng cấp với hướng dẫn viên chuyên nghiệp tại Đà Nẵng.'}</p>
                            <div class="bot">
                                <div><div class="pl">Từ</div><div class="pr"><fmt:formatNumber value="${t.price}" type="number" groupingUsed="true"/>đ <span>/người</span></div></div>
                                <a href="${pageContext.request.contextPath}/tour?action=view&id=${t.tourId}" class="btn-book">Đặt Ngay</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty">
                <div class="em">🏝️</div>
                <h3>Sắp Ra Mắt Tours Mới!</h3>
                <p>Các tour đang được thêm vào hệ thống. Hãy quay lại sau nhé.</p>
                <a href="${pageContext.request.contextPath}/tour" class="btn-cta btn-accent" style="padding:14px 36px;font-size:1rem"><i class="fas fa-compass"></i> Khám Phá</a>
            </div>
        </c:otherwise>
    </c:choose>
</section>

<!-- ═══ CTA ═══ -->
<section class="cta">
    <div class="cta-inner">
        <div class="rv">
            <h2>Tham Gia<br><span class="hl">Da Nang Hub</span></h2>
            <p>Nhận ưu đãi độc quyền cho Bà Nà Hills, quyền truy cập sớm tour lễ hội và công cụ AI dự báo doanh thu.</p>
            <div class="nl-form">
                <input type="email" placeholder="Email của bạn">
                <button class="btn-cta btn-accent" style="padding:16px 30px">Đăng Ký <i class="fas fa-arrow-right"></i></button>
            </div>
        </div>
        <div class="feats rv">
            <div class="feat"><div class="fi">🛡️</div><h4>Đối Tác Uy Tín</h4><p>Mọi tour đều được xác minh bởi chuyên gia</p></div>
            <div class="feat"><div class="fi">🤖</div><h4>AI Dự Báo</h4><p>Công nghệ ML dự báo doanh thu chính xác</p></div>
            <div class="feat"><div class="fi">⚡</div><h4>Đặt Tức Thì</h4><p>Xác nhận realtime, không chờ đợi</p></div>
            <div class="feat"><div class="fi">💳</div><h4>QR SePay</h4><p>Thanh toán quét mã siêu nhanh</p></div>
        </div>
    </div>
</section>

<!-- ═══ FOOTER ═══ -->
<footer class="foot">
    <div class="foot-inner">
        <div class="foot-grid">
            <div>
                <h3><span style="color:#FF6F61">🏖️</span> DN HUB</h3>
                <p style="line-height:1.8;max-width:280px">Nền tảng đặt tour du lịch Đà Nẵng hàng đầu. Tours xác minh, AI dự báo doanh thu.</p>
                <div class="socials">
                    <a href="#" class="soc"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="soc"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="soc"><i class="fab fa-github"></i></a>
                </div>
            </div>
            <div>
                <h4>Tours</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/tour">Tất cả Tours</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour?categoryId=1">Tour Biển</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour?categoryId=2">Tour Núi</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour?categoryId=3">Tour Ẩm Thực</a></li>
                </ul>
            </div>
            <div>
                <h4>Tài Khoản</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/profile">Hồ Sơ</a></li>
                    <li><a href="${pageContext.request.contextPath}/my-orders">Đơn Hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/pricing">Gói VIP</a></li>
                    <li><a href="${pageContext.request.contextPath}/history">Lịch Sử</a></li>
                </ul>
            </div>
            <div>
                <h4>Liên Hệ</h4>
                <p style="margin-bottom:12px"><i class="fas fa-map-marker-alt" style="color:#FF6F61;margin-right:8px"></i>ĐH FPT Đà Nẵng</p>
                <p style="margin-bottom:12px"><i class="fas fa-phone" style="color:#FF6F61;margin-right:8px"></i>+84 123 456 789</p>
                <p><i class="fas fa-envelope" style="color:#FF6F61;margin-right:8px"></i>contact@dananghub.vn</p>
            </div>
        </div>
        <hr>
        <div class="foot-bottom">
            <span>&copy; 2026 Da Nang Travel Hub — PRJ301 FPT University</span>
            <span>Made with ❤️ in Đà Nẵng</span>
        </div>
    </div>
</footer>

<!-- AI Bot -->
<div class="ai-btn" id="aiTrigger"><i class="fas fa-robot"></i></div>

<script>
// Navbar scroll
window.addEventListener('scroll',function(){
    document.getElementById('mainNav').classList.toggle('scrolled',window.scrollY>60);
});
// Scroll reveal
const obs=new IntersectionObserver(e=>{e.forEach(el=>{if(el.isIntersecting)el.target.classList.add('vis')})},{threshold:.08,rootMargin:'0px 0px -40px 0px'});
document.querySelectorAll('.rv').forEach(el=>obs.observe(el));
// Wishlist
document.querySelectorAll('.wl').forEach(b=>{
    b.addEventListener('click',function(e){
        e.preventDefault();e.stopPropagation();
        const i=this.querySelector('i');
        i.classList.toggle('far');i.classList.toggle('fas');
        this.style.color=i.classList.contains('fas')?'#FF6F61':'';
        this.style.transform='scale(1.3)';setTimeout(()=>this.style.transform='',200);
    });
});
</script>
<jsp:include page="/views/ai-chatbot/chatbot.jsp" />
</body>
</html>