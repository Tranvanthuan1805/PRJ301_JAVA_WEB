<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tour 3D Gallery | eztravel Đà Nẵng</title>
    <meta name="description" content="Khám phá các tour du lịch Đà Nẵng dưới dạng 3D 360° immersive. Trải nghiệm trước khi đặt tour.">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
*{margin:0;padding:0;box-sizing:border-box}
html{scroll-behavior:smooth}
body{font-family:'Plus Jakarta Sans',system-ui,sans-serif;background:#050510;color:#fff;-webkit-font-smoothing:antialiased;overflow-x:hidden}
a{text-decoration:none;color:inherit}

/* ═══ HERO SECTION ═══ */
.hero-3d{position:relative;min-height:100vh;display:flex;flex-direction:column;align-items:center;justify-content:center;padding:40px 20px;overflow:hidden}
.hero-3d::before{content:'';position:absolute;inset:0;background:radial-gradient(ellipse at 50% 0%,rgba(124,58,237,.15) 0%,transparent 50%),radial-gradient(ellipse at 80% 80%,rgba(255,111,97,.08) 0%,transparent 40%)}

/* Animated Grid Background */
.grid-bg{position:fixed;inset:0;z-index:0;opacity:.06;background-image:linear-gradient(rgba(255,255,255,.1) 1px,transparent 1px),linear-gradient(90deg,rgba(255,255,255,.1) 1px,transparent 1px);background-size:60px 60px;animation:gridMove 20s linear infinite}
@keyframes gridMove{to{background-position:60px 60px}}

/* Floating Particles */
.particle{position:fixed;width:3px;height:3px;background:#7C3AED;border-radius:50%;pointer-events:none;z-index:1}

/* ═══ BACK NAV ═══ */
.back-nav{position:fixed;top:20px;left:20px;z-index:1000;display:flex;align-items:center;gap:8px;padding:12px 20px;border-radius:14px;background:rgba(255,255,255,.06);backdrop-filter:blur(16px);border:1px solid rgba(255,255,255,.08);color:#fff;font-weight:700;font-size:.85rem;transition:.3s}
.back-nav:hover{background:rgba(255,255,255,.12);transform:translateX(-4px)}

/* ═══ HEADER ═══ */
.gallery-header{text-align:center;margin-bottom:60px;position:relative;z-index:10}
.badge-3d{display:inline-flex;align-items:center;gap:8px;padding:8px 20px;border-radius:999px;background:rgba(124,58,237,.15);border:1px solid rgba(124,58,237,.25);color:#A78BFA;font-size:.75rem;font-weight:800;letter-spacing:1.5px;text-transform:uppercase;margin-bottom:20px}
.badge-3d i{animation:spin3d 3s linear infinite}
@keyframes spin3d{to{transform:rotateY(360deg)}}
.gallery-header h1{font-size:3.2rem;font-weight:900;letter-spacing:-1.5px;line-height:1.1;margin-bottom:14px}
.gallery-header h1 .gradient{background:linear-gradient(135deg,#7C3AED,#A855F7,#FF6F61,#FF9A8B);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text}
.gallery-header p{font-size:1.05rem;color:rgba(255,255,255,.4);max-width:500px;margin:0 auto;line-height:1.7}
.header-stats{display:flex;justify-content:center;gap:40px;margin-top:28px}
.hstat{text-align:center}
.hstat .num{font-size:1.6rem;font-weight:900;color:#fff}
.hstat .lbl{font-size:.72rem;color:rgba(255,255,255,.3);font-weight:700;text-transform:uppercase;letter-spacing:1px;margin-top:2px}

/* ═══ 3D CAROUSEL ═══ */
.carousel-scene{perspective:1200px;width:100%;max-width:1000px;height:480px;margin:0 auto 40px;position:relative;z-index:10}
.carousel-3d{width:100%;height:100%;position:relative;transform-style:preserve-3d}
.carousel-card{position:absolute;width:320px;height:420px;left:50%;top:50%;margin-left:-160px;margin-top:-210px;border-radius:24px;overflow:hidden;backface-visibility:hidden;cursor:pointer;transition:all .8s cubic-bezier(.23,1,.32,1);border:1px solid rgba(255,255,255,.08)}
.carousel-card:hover{border-color:rgba(124,58,237,.4)}
.carousel-card img{width:100%;height:100%;object-fit:cover;transition:transform 8s ease}
.carousel-card:hover img{transform:scale(1.1)}
.card-overlay{position:absolute;inset:0;background:linear-gradient(transparent 40%,rgba(5,5,16,.95) 100%);display:flex;flex-direction:column;justify-content:flex-end;padding:28px}
.card-provider{display:inline-flex;align-items:center;gap:6px;padding:4px 12px;border-radius:8px;background:rgba(124,58,237,.2);border:1px solid rgba(124,58,237,.3);font-size:.65rem;font-weight:800;color:#A78BFA;text-transform:uppercase;letter-spacing:.5px;margin-bottom:10px;width:fit-content}
.card-title{font-size:1.2rem;font-weight:800;margin-bottom:6px;letter-spacing:-.3px}
.card-meta{display:flex;gap:14px;font-size:.78rem;color:rgba(255,255,255,.5);margin-bottom:12px}
.card-meta i{color:#FF6F61;font-size:.7rem}
.card-price{font-size:1.3rem;font-weight:900;color:#FF6F61;letter-spacing:-.5px}
.card-price span{font-size:.75rem;font-weight:500;color:rgba(255,255,255,.35)}
.card-3d-badge{position:absolute;top:16px;right:16px;padding:6px 14px;border-radius:10px;background:rgba(124,58,237,.85);backdrop-filter:blur(8px);font-size:.7rem;font-weight:800;display:flex;align-items:center;gap:5px;box-shadow:0 4px 16px rgba(124,58,237,.4)}
.card-3d-badge i{animation:spin3d 3s linear infinite}

/* Carousel Controls */
.carousel-controls{display:flex;align-items:center;justify-content:center;gap:16px;position:relative;z-index:10;margin-bottom:60px}
.car-btn{width:52px;height:52px;border-radius:16px;border:1px solid rgba(255,255,255,.08);background:rgba(255,255,255,.04);backdrop-filter:blur(16px);color:rgba(255,255,255,.6);cursor:pointer;font-size:1rem;transition:.3s;display:flex;align-items:center;justify-content:center}
.car-btn:hover{background:rgba(124,58,237,.2);border-color:rgba(124,58,237,.4);color:#fff;transform:scale(1.08)}
.car-dots{display:flex;gap:6px;align-items:center}
.car-dot{width:8px;height:8px;border-radius:50%;background:rgba(255,255,255,.15);cursor:pointer;transition:.3s}
.car-dot.active{background:#7C3AED;transform:scale(1.4);box-shadow:0 0 12px rgba(124,58,237,.5)}
.car-counter{color:rgba(255,255,255,.3);font-size:.82rem;font-weight:700;min-width:50px;text-align:center}

/* ═══ SAMPLE 3D TOUR GRID ═══ */
.grid-section{max-width:1200px;margin:0 auto;padding:0 24px 80px;position:relative;z-index:10}
.section-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:36px}
.section-header h2{font-size:1.6rem;font-weight:900;display:flex;align-items:center;gap:10px}
.section-header h2 i{color:#7C3AED;font-size:1.2rem}
.section-header .view-all{color:rgba(255,255,255,.4);font-size:.85rem;font-weight:700;display:flex;align-items:center;gap:6px;transition:.3s}
.section-header .view-all:hover{color:#A78BFA}

.tour-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(280px,1fr));gap:20px}
.tour-card{background:rgba(255,255,255,.03);border:1px solid rgba(255,255,255,.06);border-radius:20px;overflow:hidden;cursor:pointer;transition:all .4s cubic-bezier(.175,.885,.32,1.275);position:relative}
.tour-card:hover{transform:translateY(-8px);border-color:rgba(124,58,237,.3);box-shadow:0 20px 60px rgba(124,58,237,.1)}
.tour-card-img{width:100%;height:200px;overflow:hidden;position:relative}
.tour-card-img img{width:100%;height:100%;object-fit:cover;transition:transform 5s ease}
.tour-card:hover .tour-card-img img{transform:scale(1.15)}
.tour-card-3d{position:absolute;top:12px;left:12px;padding:5px 12px;border-radius:8px;background:rgba(124,58,237,.85);backdrop-filter:blur(8px);font-size:.65rem;font-weight:800;display:flex;align-items:center;gap:4px}
.tour-card-3d i{animation:spin3d 3s linear infinite}
.tour-card-body{padding:20px}
.tour-card-provider{font-size:.68rem;color:#A78BFA;font-weight:700;text-transform:uppercase;letter-spacing:.5px;margin-bottom:6px}
.tour-card-name{font-size:1rem;font-weight:800;margin-bottom:8px;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden}
.tour-card-info{display:flex;gap:12px;font-size:.75rem;color:rgba(255,255,255,.4);margin-bottom:14px}
.tour-card-info i{color:rgba(255,255,255,.2)}
.tour-card-footer{display:flex;align-items:center;justify-content:space-between;padding-top:14px;border-top:1px solid rgba(255,255,255,.06)}
.tour-card-price{font-size:1.1rem;font-weight:900;color:#FF6F61}
.tour-card-price span{font-size:.7rem;color:rgba(255,255,255,.3);font-weight:500}
.btn-view3d{padding:8px 16px;border-radius:10px;background:rgba(124,58,237,.15);border:1px solid rgba(124,58,237,.25);color:#A78BFA;font-size:.75rem;font-weight:800;transition:.3s;display:flex;align-items:center;gap:5px}
.btn-view3d:hover{background:rgba(124,58,237,.3);color:#fff}

/* ═══ 3D RUBIK SECTION ═══ */
.rubik-section{text-align:center;padding:80px 20px;position:relative;z-index:10}
.rubik-section h2{font-size:1.8rem;font-weight:900;margin-bottom:12px}
.rubik-section h2 span{color:#FF6F61}
.rubik-section p{color:rgba(255,255,255,.35);font-size:.88rem;margin-bottom:40px}
.rubik-container{perspective:1000px;width:280px;height:280px;margin:0 auto;cursor:grab}
.rubik-container:active{cursor:grabbing}
.rubik-cube{width:100%;height:100%;position:relative;transform-style:preserve-3d;animation:rubikSpin 25s ease-in-out infinite}
.rubik-face{position:absolute;width:280px;height:280px;display:grid;grid-template-columns:repeat(3,1fr);gap:3px;padding:3px}
.rubik-face.front{transform:rotateY(0deg) translateZ(140px)}
.rubik-face.back{transform:rotateY(180deg) translateZ(140px)}
.rubik-face.right{transform:rotateY(90deg) translateZ(140px)}
.rubik-face.left{transform:rotateY(-90deg) translateZ(140px)}
.rubik-face.top{transform:rotateX(90deg) translateZ(140px)}
.rubik-face.bottom{transform:rotateX(-90deg) translateZ(140px)}
.rubik-cell{border-radius:6px;overflow:hidden;cursor:pointer;transition:transform .3s;position:relative}
.rubik-cell:hover{transform:scale(1.08);z-index:2}
.rubik-cell img{width:100%;height:100%;object-fit:cover}
.rubik-cell .cell-label{position:absolute;inset:0;background:rgba(124,58,237,.8);display:flex;align-items:center;justify-content:center;font-size:.55rem;font-weight:800;opacity:0;transition:.3s}
.rubik-cell:hover .cell-label{opacity:1}
@keyframes rubikSpin{0%{transform:rotateX(-15deg) rotateY(0)}25%{transform:rotateX(10deg) rotateY(90deg)}50%{transform:rotateX(-5deg) rotateY(180deg)}75%{transform:rotateX(15deg) rotateY(270deg)}100%{transform:rotateX(-15deg) rotateY(360deg)}}

/* ═══ CTA SECTION ═══ */
.cta-section{text-align:center;padding:60px 20px 100px;position:relative;z-index:10}
.cta-card{max-width:640px;margin:0 auto;padding:48px;border-radius:28px;background:linear-gradient(135deg,rgba(124,58,237,.1),rgba(255,111,97,.05));border:1px solid rgba(124,58,237,.15);position:relative;overflow:hidden}
.cta-card::before{content:'';position:absolute;width:200px;height:200px;background:radial-gradient(circle,rgba(124,58,237,.15),transparent);top:-80px;right:-80px;border-radius:50%}
.cta-card h3{font-size:1.5rem;font-weight:900;margin-bottom:10px;position:relative}
.cta-card p{color:rgba(255,255,255,.4);font-size:.88rem;margin-bottom:24px;position:relative}
.cta-btns{display:flex;gap:12px;justify-content:center;position:relative}
.btn-cta{padding:14px 28px;border-radius:14px;font-weight:800;font-size:.9rem;cursor:pointer;transition:.3s;display:flex;align-items:center;gap:8px;font-family:inherit;border:none}
.btn-cta-primary{background:linear-gradient(135deg,#7C3AED,#A855F7);color:#fff;box-shadow:0 6px 24px rgba(124,58,237,.3)}
.btn-cta-primary:hover{transform:translateY(-3px);box-shadow:0 12px 36px rgba(124,58,237,.5)}
.btn-cta-outline{background:transparent;color:rgba(255,255,255,.6);border:1px solid rgba(255,255,255,.1)}
.btn-cta-outline:hover{border-color:rgba(255,255,255,.3);color:#fff}

/* ═══ RESPONSIVE ═══ */
@media(max-width:768px){
    .gallery-header h1{font-size:2rem}
    .header-stats{gap:20px}
    .carousel-scene{height:380px}
    .carousel-card{width:260px;height:340px;margin-left:-130px;margin-top:-170px}
    .tour-grid{grid-template-columns:1fr}
    .rubik-container{width:200px;height:200px}
    .rubik-face{width:200px;height:200px}
    .rubik-face.front{transform:rotateY(0deg) translateZ(100px)}
    .rubik-face.back{transform:rotateY(180deg) translateZ(100px)}
    .rubik-face.right{transform:rotateY(90deg) translateZ(100px)}
    .rubik-face.left{transform:rotateY(-90deg) translateZ(100px)}
    .rubik-face.top{transform:rotateX(90deg) translateZ(100px)}
    .rubik-face.bottom{transform:rotateX(-90deg) translateZ(100px)}
    .cta-btns{flex-direction:column}
}
</style>
</head>
<body>

<div class="grid-bg"></div>

<!-- BACK NAV -->
<a href="${pageContext.request.contextPath}/" class="back-nav">
    <i class="fas fa-arrow-left"></i> Trang Chủ
</a>

<!-- ═══ HERO ═══ -->
<section class="hero-3d">
    <div class="gallery-header">
        <div class="badge-3d"><i class="fas fa-cube"></i> IMMERSIVE 3D EXPERIENCE</div>
        <h1>Tour <span class="gradient">3D Gallery</span></h1>
        <p>Khám phá các tour du lịch Đà Nẵng qua trải nghiệm 3D 360° sống động. Nhà cung cấp showcase tour theo dạng thực tế ảo.</p>
        <div class="header-stats">
            <div class="hstat"><div class="num" id="tourCount">0</div><div class="lbl">Tours 3D</div></div>
            <div class="hstat"><div class="num">360°</div><div class="lbl">Panorama</div></div>
            <div class="hstat"><div class="num">4K</div><div class="lbl">Chất Lượng</div></div>
        </div>
    </div>

    <!-- 3D CAROUSEL -->
    <div class="carousel-scene">
        <div class="carousel-3d" id="carousel3d"></div>
    </div>

    <div class="carousel-controls">
        <button class="car-btn" onclick="prevSlide()"><i class="fas fa-chevron-left"></i></button>
        <div class="car-dots" id="carDots"></div>
        <span class="car-counter" id="carCounter">1 / 8</span>
        <button class="car-btn" onclick="nextSlide()"><i class="fas fa-chevron-right"></i></button>
    </div>
</section>

<!-- ═══ TOUR GRID ═══ -->
<section class="grid-section">
    <div class="section-header">
        <h2><i class="fas fa-fire"></i> Tour 3D Nổi Bật</h2>
        <a href="${pageContext.request.contextPath}/tour" class="view-all">Xem tất cả <i class="fas fa-arrow-right"></i></a>
    </div>
    <div class="tour-grid" id="tourGrid"></div>
</section>

<!-- ═══ RUBIK 3D ═══ -->
<section class="rubik-section">
    <h2>Bộ Sưu Tập <span>Rubik 3D</span></h2>
    <p>Kéo chuột để xoay khối Rubik và khám phá ảnh tour</p>
    <div class="rubik-container" id="rubikContainer">
        <div class="rubik-cube" id="rubikCube"></div>
    </div>
</section>

<!-- ═══ CTA ═══ -->
<section class="cta-section">
    <div class="cta-card">
        <h3>🚀 Bạn là Nhà Cung Cấp Tour?</h3>
        <p>Đăng ký để showcase tour của bạn dưới dạng 3D 360° và thu hút nhiều khách hàng hơn!</p>
        <div class="cta-btns">
            <a href="${pageContext.request.contextPath}/provider" class="btn-cta btn-cta-primary"><i class="fas fa-rocket"></i> Đăng Ký Ngay</a>
            <a href="${pageContext.request.contextPath}/tour" class="btn-cta btn-cta-outline"><i class="fas fa-eye"></i> Xem Tours</a>
        </div>
    </div>
</section>

<script>
/* ═══════════════════════════════════════════
   3D TOUR GALLERY - SAMPLE DATA + CAROUSEL
   ═══════════════════════════════════════════ */

const CTX = '${pageContext.request.contextPath}';

// ═══ SAMPLE TOUR DATA (Đà Nẵng) ═══
const sampleTours = [
<c:choose>
    <c:when test="${not empty tours}">
        <c:forEach items="${tours}" var="tour" varStatus="i">
            <c:if test="${i.index < 12}">
            {
                id: ${tour.tourId},
                name: "${tour.tourName}",
                image: "${not empty tour.imageUrl ? tour.imageUrl : 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=600'}",
                price: ${tour.price},
                duration: "${not empty tour.duration ? tour.duration : '1 ngày'}",
                destination: "${not empty tour.destination ? tour.destination : 'Đà Nẵng'}",
                provider: "${not empty tour.provider.businessName ? tour.provider.businessName : 'eztravel'}",
                fromDB: true
            },
            </c:if>
        </c:forEach>
    </c:when>
</c:choose>
];

// Add sample tours if database has less than 8
const sampleDefaults = [
    {
        id: 'demo-1', name: 'Bà Nà Hills - Cầu Vàng Trọn Ngày',
        image: 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=600',
        price: 850000, duration: '1 ngày', destination: 'Bà Nà Hills',
        provider: 'DaNang Premium Tours', desc: 'Trải nghiệm Cầu Vàng và làng Pháp trên đỉnh Bà Nà'
    },
    {
        id: 'demo-2', name: 'Phố Cổ Hội An Về Đêm',
        image: 'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=600',
        price: 450000, duration: '4 giờ', destination: 'Hội An',
        provider: 'Heritage Vietnam Travel', desc: 'Dạo phố đèn lồng và thả hoa đăng trên sông Hoài'
    },
    {
        id: 'demo-3', name: 'Ngũ Hành Sơn & Làng Đá Non Nước',
        image: 'https://images.unsplash.com/photo-1528127269322-539801943592?w=600',
        price: 350000, duration: '3 giờ', destination: 'Ngũ Hành Sơn',
        provider: 'Marble Mountain Tour Co.', desc: 'Khám phá hang động và chùa cổ trên núi đá cẩm thạch'
    },
    {
        id: 'demo-4', name: 'Bán Đảo Sơn Trà - Chùa Linh Ứng',
        image: 'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=600',
        price: 550000, duration: '5 giờ', destination: 'Sơn Trà',
        provider: 'Son Tra Eco Tours', desc: 'Ngắm voọc chà vá chân nâu & tượng Phật bà cao nhất'
    },
    {
        id: 'demo-5', name: 'Kayak Sông Hàn Hoàng Hôn',
        image: 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=600',
        price: 650000, duration: '2 giờ', destination: 'Sông Hàn',
        provider: 'DaNang Water Sports', desc: 'Chèo kayak ngắm cầu Rồng phun lửa lúc hoàng hôn'
    },
    {
        id: 'demo-6', name: 'Tour Cù Lao Chàm Lặn San Hô',
        image: 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=600',
        price: 1200000, duration: '1 ngày', destination: 'Cù Lao Chàm',
        provider: 'Ocean Explorer VN', desc: 'Lặn biển ngắm san hô và sinh vật biển tuyệt đẹp'
    },
    {
        id: 'demo-7', name: 'Mỹ Sơn Holy Land Sunrise Tour',
        image: 'https://images.unsplash.com/photo-1600100397608-e5a6c0d5b7d0?w=600',
        price: 780000, duration: '6 giờ', destination: 'Mỹ Sơn',
        provider: 'Champa Heritage Tours', desc: 'Thánh địa Mỹ Sơn - Di sản UNESCO bình minh huyền bí'
    },
    {
        id: 'demo-8', name: 'Đường Hầm Hải Vân & Lăng Cô',
        image: 'https://images.unsplash.com/photo-1506929562872-bb421503ef21?w=600',
        price: 950000, duration: '1 ngày', destination: 'Hải Vân - Lăng Cô',
        provider: 'Central Coast Adventures', desc: 'Vượt đèo Hải Vân ngắm vịnh Lăng Cô tuyệt đẹp'
    }
];

// Merge DB tours with sample if needed
const allTours = sampleTours.length >= 4 ? sampleTours : [...sampleTours, ...sampleDefaults.slice(0, 8 - sampleTours.length)];

// ═══ BUILD 3D CAROUSEL ═══
const carouselEl = document.getElementById('carousel3d');
const dotsEl = document.getElementById('carDots');
let currentSlide = 0;
const totalSlides = Math.min(allTours.length, 8);
const angleStep = 360 / totalSlides;

allTours.slice(0, 8).forEach((tour, i) => {
    const card = document.createElement('div');
    card.className = 'carousel-card';
    card.dataset.index = i;
    card.onclick = () => goToTour(tour);
    card.innerHTML = `
        <img src="${tour.image}" alt="${tour.name}" onerror="this.src='https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=600'">
        <div class="card-3d-badge"><i class="fas fa-cube"></i> 3D</div>
        <div class="card-overlay">
            <div class="card-provider"><i class="fas fa-building"></i> ${tour.provider || 'eztravel'}</div>
            <div class="card-title">${tour.name}</div>
            <div class="card-meta">
                <span><i class="fas fa-clock"></i> ${tour.duration}</span>
                <span><i class="fas fa-map-pin"></i> ${tour.destination}</span>
            </div>
            <div class="card-price">${Number(tour.price).toLocaleString('vi-VN')}đ <span>/người</span></div>
        </div>
    `;
    carouselEl.appendChild(card);

    // Dot
    const dot = document.createElement('div');
    dot.className = 'car-dot' + (i === 0 ? ' active' : '');
    dot.onclick = () => { currentSlide = i; updateCarousel(); };
    dotsEl.appendChild(dot);
});

function updateCarousel() {
    const cards = document.querySelectorAll('.carousel-card');
    cards.forEach((card, i) => {
        const angle = (i - currentSlide) * angleStep;
        const rad = angle * Math.PI / 180;
        const z = 380 * Math.cos(rad);
        const x = 380 * Math.sin(rad);
        const scale = (z + 380) / 760 * 0.5 + 0.5;
        card.style.transform = `translateX(${x}px) translateZ(${z}px) scale(${scale})`;
        card.style.opacity = Math.max(scale, 0.2);
        card.style.zIndex = Math.round(z + 500);
        card.style.filter = i === currentSlide ? 'none' : 'brightness(0.6)';
    });
    document.querySelectorAll('.car-dot').forEach((d, i) => d.classList.toggle('active', i === currentSlide));
    document.getElementById('carCounter').textContent = (currentSlide + 1) + ' / ' + totalSlides;
}
function nextSlide() { currentSlide = (currentSlide + 1) % totalSlides; updateCarousel(); }
function prevSlide() { currentSlide = (currentSlide - 1 + totalSlides) % totalSlides; updateCarousel(); }
updateCarousel();
setInterval(nextSlide, 5000);

// ═══ BUILD TOUR GRID ═══
const gridEl = document.getElementById('tourGrid');
allTours.forEach(tour => {
    const card = document.createElement('div');
    card.className = 'tour-card';
    card.onclick = () => goToTour(tour);
    card.innerHTML = `
        <div class="tour-card-img">
            <img src="${tour.image}" alt="${tour.name}" onerror="this.src='https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=600'">
            <div class="tour-card-3d"><i class="fas fa-cube"></i> 3D 360°</div>
        </div>
        <div class="tour-card-body">
            <div class="tour-card-provider"><i class="fas fa-building"></i> ${tour.provider || 'eztravel'}</div>
            <div class="tour-card-name">${tour.name}</div>
            <div class="tour-card-info">
                <span><i class="fas fa-clock"></i> ${tour.duration}</span>
                <span><i class="fas fa-map-pin"></i> ${tour.destination}</span>
            </div>
            <div class="tour-card-footer">
                <div class="tour-card-price">${Number(tour.price).toLocaleString('vi-VN')}đ <span>/người</span></div>
                <div class="btn-view3d"><i class="fas fa-cube"></i> Xem 3D</div>
            </div>
        </div>
    `;
    gridEl.appendChild(card);
});

// Update tour count
document.getElementById('tourCount').textContent = allTours.length;

// ═══ BUILD RUBIK CUBE ═══
const rubikImages = [
    'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=200',
    'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=200',
    'https://images.unsplash.com/photo-1528127269322-539801943592?w=200',
    'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=200',
    'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=200',
    'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=200',
    'https://images.unsplash.com/photo-1506929562872-bb421503ef21?w=200',
    'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=200',
    'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=200'
];
const rubikLabels = ['Bà Nà','Hội An','Ngũ Hành Sơn','Sơn Trà','Sông Hàn','Cù Lao Chàm','Lăng Cô','Mỹ Sơn','Đà Nẵng'];
const faces = ['front','back','right','left','top','bottom'];
const cube = document.getElementById('rubikCube');

faces.forEach(face => {
    const faceEl = document.createElement('div');
    faceEl.className = 'rubik-face ' + face;
    for (let i = 0; i < 9; i++) {
        const cell = document.createElement('div');
        cell.className = 'rubik-cell';
        cell.innerHTML = `<img src="${rubikImages[i]}" alt="${rubikLabels[i]}"><div class="cell-label">${rubikLabels[i]}</div>`;
        faceEl.appendChild(cell);
    }
    cube.appendChild(faceEl);
});

// Rubik drag interaction
const rubikCont = document.getElementById('rubikContainer');
let isDragging = false, rX = -15, rY = 0, sX, sY;
rubikCont.addEventListener('mouseenter', () => cube.style.animationPlayState = 'paused');
rubikCont.addEventListener('mouseleave', () => { if (!isDragging) cube.style.animationPlayState = 'running'; });
rubikCont.addEventListener('mousedown', e => { isDragging = true; sX = e.clientX; sY = e.clientY; cube.style.animationPlayState = 'paused'; });
document.addEventListener('mousemove', e => { if (!isDragging) return; rY += (e.clientX - sX) * .5; rX -= (e.clientY - sY) * .5; cube.style.transform = `rotateX(${rX}deg) rotateY(${rY}deg)`; sX = e.clientX; sY = e.clientY; });
document.addEventListener('mouseup', () => isDragging = false);

// ═══ NAVIGATE TO TOUR ═══
function goToTour(tour) {
    if (tour.fromDB) {
        window.location.href = CTX + '/tour-3d?id=' + tour.id;
    } else {
        window.location.href = CTX + '/tour-3d?id=' + (tour.id || 1);
    }
}

// ═══ FLOATING PARTICLES ═══
for (let i = 0; i < 30; i++) {
    const p = document.createElement('div');
    p.className = 'particle';
    p.style.left = Math.random() * 100 + 'vw';
    p.style.top = Math.random() * 100 + 'vh';
    p.style.opacity = Math.random() * 0.4 + 0.1;
    p.style.animation = `particleFloat ${8 + Math.random() * 12}s ease-in-out infinite`;
    p.style.animationDelay = -Math.random() * 10 + 's';
    document.body.appendChild(p);
}
const style = document.createElement('style');
style.textContent = '@keyframes particleFloat{0%,100%{transform:translateY(0) translateX(0)}25%{transform:translateY(-30px) translateX(15px)}50%{transform:translateY(-60px) translateX(-10px)}75%{transform:translateY(-30px) translateX(20px)}}'
document.head.appendChild(style);

// ═══ KEYBOARD CONTROLS ═══
document.addEventListener('keydown', e => {
    if (e.key === 'ArrowLeft') prevSlide();
    if (e.key === 'ArrowRight') nextSlide();
});
</script>
</body>
</html>
