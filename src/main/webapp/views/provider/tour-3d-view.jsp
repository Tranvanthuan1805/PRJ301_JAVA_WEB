<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${tour.tourName} - Trải Nghiệm 3D | eztravel</title>
    <meta name="description" content="Trải nghiệm tour ${tour.tourName} dưới dạng 3D 360° immersive. Khám phá trước khi đặt tour tại eztravel Đà Nẵng.">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
<style>
*{margin:0;padding:0;box-sizing:border-box}
html,body{width:100%;height:100%;overflow:hidden;font-family:'Plus Jakarta Sans',system-ui,sans-serif;background:#0a0a0f}

/* ═══ FULL SCREEN 3D CANVAS ═══ */
#viewer3D{position:fixed;inset:0;z-index:1;cursor:grab}
#viewer3D:active{cursor:grabbing}

/* ═══ TOP BAR (OVERLAY) ═══ */
.viewer-topbar{position:fixed;top:0;left:0;right:0;z-index:100;display:flex;align-items:center;justify-content:space-between;padding:16px 24px;background:linear-gradient(180deg,rgba(0,0,0,.7) 0%,transparent 100%);pointer-events:none}
.viewer-topbar>*{pointer-events:auto}
.tb-back{display:flex;align-items:center;gap:8px;color:#fff;text-decoration:none;font-weight:700;font-size:.88rem;padding:10px 18px;border-radius:12px;background:rgba(255,255,255,.1);backdrop-filter:blur(12px);border:1px solid rgba(255,255,255,.1);transition:.3s}
.tb-back:hover{background:rgba(255,255,255,.2);transform:translateX(-4px)}
.tb-title{text-align:center;flex:1}
.tb-title h1{font-size:1.1rem;font-weight:800;color:#fff;text-shadow:0 2px 10px rgba(0,0,0,.5)}
.tb-title p{font-size:.75rem;color:rgba(255,255,255,.5);font-weight:500}
.tb-actions{display:flex;gap:8px}
.tb-btn{display:flex;align-items:center;gap:6px;padding:10px 16px;border-radius:12px;background:rgba(255,255,255,.1);backdrop-filter:blur(12px);border:1px solid rgba(255,255,255,.1);color:#fff;font-weight:700;font-size:.82rem;cursor:pointer;transition:.3s;font-family:inherit;text-decoration:none}
.tb-btn:hover{background:rgba(255,255,255,.2)}
.tb-btn.primary{background:linear-gradient(135deg,#FF6F61,#FF9A8B);border-color:transparent;box-shadow:0 4px 16px rgba(255,111,97,.3)}
.tb-btn.primary:hover{transform:translateY(-2px);box-shadow:0 8px 24px rgba(255,111,97,.5)}

/* ═══ HOTSPOT NAVIGATION (LEFT SIDEBAR) ═══ */
.hotspot-nav{position:fixed;left:20px;top:50%;transform:translateY(-50%);z-index:100;display:flex;flex-direction:column;gap:6px}
.hotspot-dot{width:52px;height:52px;border-radius:14px;background:rgba(255,255,255,.08);backdrop-filter:blur(16px);border:1px solid rgba(255,255,255,.08);display:flex;align-items:center;justify-content:center;cursor:pointer;transition:all .4s cubic-bezier(.175,.885,.32,1.275);position:relative;overflow:hidden}
.hotspot-dot::before{content:'';position:absolute;inset:0;background:linear-gradient(135deg,#FF6F61,#FF9A8B);opacity:0;transition:.3s;border-radius:14px}
.hotspot-dot.active::before,.hotspot-dot:hover::before{opacity:1}
.hotspot-dot i{position:relative;z-index:2;color:rgba(255,255,255,.6);font-size:.88rem;transition:.3s}
.hotspot-dot.active i,.hotspot-dot:hover i{color:#fff}
.hotspot-dot.active{transform:scale(1.1);box-shadow:0 4px 20px rgba(255,111,97,.4)}
.hotspot-label{position:absolute;left:62px;white-space:nowrap;background:rgba(0,0,0,.85);color:#fff;padding:6px 14px;border-radius:8px;font-size:.75rem;font-weight:700;opacity:0;transform:translateX(-8px);transition:.3s;pointer-events:none}
.hotspot-dot:hover .hotspot-label{opacity:1;transform:translateX(0)}

/* ═══ INFO PANEL (RIGHT SIDEBAR) ═══ */
.info-panel{position:fixed;right:20px;top:50%;transform:translateY(-50%);z-index:100;width:320px;background:rgba(10,10,15,.85);backdrop-filter:blur(24px);border:1px solid rgba(255,255,255,.06);border-radius:24px;overflow:hidden;transition:all .5s cubic-bezier(.175,.885,.32,1.275)}
.info-panel.collapsed{width:52px;border-radius:14px;cursor:pointer}
.info-panel.collapsed .panel-content{opacity:0;pointer-events:none}
.info-panel.collapsed .collapse-btn i{transform:rotate(180deg)}

.panel-header{padding:20px 22px 0;display:flex;align-items:center;justify-content:space-between}
.panel-tag{font-size:.68rem;font-weight:800;letter-spacing:1px;text-transform:uppercase;color:#FF6F61;display:flex;align-items:center;gap:6px}
.panel-tag .pulse{width:6px;height:6px;border-radius:50%;background:#FF6F61;animation:pulse 2s infinite}
@keyframes pulse{0%,100%{opacity:1}50%{opacity:.3}}
.collapse-btn{width:32px;height:32px;border-radius:8px;background:rgba(255,255,255,.06);border:none;color:rgba(255,255,255,.5);cursor:pointer;display:flex;align-items:center;justify-content:center;transition:.3s}
.collapse-btn:hover{background:rgba(255,255,255,.12);color:#fff}
.collapse-btn i{transition:transform .3s}

.panel-content{padding:16px 22px 22px;transition:opacity .3s}
.spot-title{font-size:1.2rem;font-weight:900;color:#fff;margin:12px 0 6px;letter-spacing:-.3px}
.spot-desc{font-size:.82rem;color:rgba(255,255,255,.45);line-height:1.7;margin-bottom:16px}

.spot-stats{display:grid;grid-template-columns:1fr 1fr;gap:8px;margin-bottom:18px}
.spot-stat{padding:12px 14px;background:rgba(255,255,255,.04);border-radius:12px;border:1px solid rgba(255,255,255,.04)}
.spot-stat .stat-icon{font-size:.78rem;color:#60A5FA;margin-bottom:4px}
.spot-stat .stat-label{font-size:.65rem;color:rgba(255,255,255,.3);font-weight:700;text-transform:uppercase;letter-spacing:.5px}
.spot-stat .stat-value{font-size:.95rem;font-weight:800;color:#fff;margin-top:2px}

.panel-divider{height:1px;background:rgba(255,255,255,.06);margin:0 -22px;width:calc(100% + 44px)}

.tour-price-section{margin-top:16px}
.tour-price-label{font-size:.72rem;color:rgba(255,255,255,.35);font-weight:600;text-transform:uppercase;letter-spacing:1px}
.tour-price-value{font-size:1.6rem;font-weight:900;color:#FF6F61;letter-spacing:-1px;margin-top:4px}
.tour-price-value span{font-size:.78rem;font-weight:500;color:rgba(255,255,255,.35)}

.panel-cta{display:flex;gap:8px;margin-top:16px}
.panel-cta .btn-3d{flex:1;padding:14px;border-radius:14px;font-weight:800;font-size:.85rem;border:none;cursor:pointer;font-family:inherit;transition:.3s;display:flex;align-items:center;justify-content:center;gap:6px}
.btn-3d-primary{background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;box-shadow:0 4px 16px rgba(255,111,97,.25)}
.btn-3d-primary:hover{transform:translateY(-2px);box-shadow:0 8px 24px rgba(255,111,97,.45)}
.btn-3d-outline{background:rgba(255,255,255,.06);color:rgba(255,255,255,.7);border:1px solid rgba(255,255,255,.1)}
.btn-3d-outline:hover{background:rgba(255,255,255,.1);color:#fff}

/* ═══ BOTTOM CONTROLS ═══ */
.viewer-controls{position:fixed;bottom:20px;left:50%;transform:translateX(-50%);z-index:100;display:flex;align-items:center;gap:6px;background:rgba(10,10,15,.75);backdrop-filter:blur(16px);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:8px 12px}
.ctrl-btn{width:42px;height:42px;border-radius:12px;background:transparent;border:none;color:rgba(255,255,255,.5);cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:.9rem;transition:.3s;position:relative}
.ctrl-btn:hover{background:rgba(255,255,255,.1);color:#fff}
.ctrl-btn.active{color:#FF6F61}
.ctrl-divider{width:1px;height:28px;background:rgba(255,255,255,.08);margin:0 4px}
.ctrl-tooltip{position:absolute;bottom:calc(100% + 8px);left:50%;transform:translateX(-50%);white-space:nowrap;background:rgba(0,0,0,.9);color:#fff;padding:5px 10px;border-radius:6px;font-size:.68rem;font-weight:700;opacity:0;transition:.2s;pointer-events:none}
.ctrl-btn:hover .ctrl-tooltip{opacity:1}

/* ═══ SPOT THUMBNAILS (BOTTOM CAROUSEL) ═══ */
.spot-carousel{position:fixed;bottom:80px;left:50%;transform:translateX(-50%);z-index:100;display:flex;gap:8px;padding:10px;background:rgba(10,10,15,.7);backdrop-filter:blur(16px);border:1px solid rgba(255,255,255,.06);border-radius:18px}
.spot-thumb{width:80px;height:56px;border-radius:12px;overflow:hidden;cursor:pointer;position:relative;border:2px solid transparent;transition:all .3s}
.spot-thumb img{width:100%;height:100%;object-fit:cover;transition:transform .5s}
.spot-thumb:hover img{transform:scale(1.1)}
.spot-thumb.active{border-color:#FF6F61;box-shadow:0 0 16px rgba(255,111,97,.3)}
.spot-thumb .thumb-label{position:absolute;bottom:0;left:0;right:0;padding:3px 6px;background:linear-gradient(transparent,rgba(0,0,0,.8));font-size:.55rem;color:#fff;font-weight:700;text-align:center}

/* ═══ LOADING SCREEN ═══ */
.loading-screen{position:fixed;inset:0;z-index:9999;background:#0a0a0f;display:flex;flex-direction:column;align-items:center;justify-content:center;transition:opacity .8s ease}
.loading-screen.hide{opacity:0;pointer-events:none}
.loader-ring{width:80px;height:80px;border-radius:50%;border:3px solid rgba(255,255,255,.06);border-top-color:#FF6F61;animation:spin .8s linear infinite;margin-bottom:24px}
@keyframes spin{to{transform:rotate(360deg)}}
.loader-text{font-size:.88rem;color:rgba(255,255,255,.4);font-weight:700}
.loader-progress{width:200px;height:3px;background:rgba(255,255,255,.06);border-radius:999px;margin-top:12px;overflow:hidden}
.loader-progress-fill{height:100%;background:linear-gradient(90deg,#FF6F61,#FF9A8B);border-radius:999px;width:0;transition:width .3s}

/* ═══ COMPASS ═══ */
.compass{position:fixed;bottom:80px;right:24px;z-index:100;width:60px;height:60px;background:rgba(10,10,15,.7);backdrop-filter:blur(16px);border-radius:50%;border:1px solid rgba(255,255,255,.08);display:flex;align-items:center;justify-content:center}
.compass-needle{width:2px;height:24px;background:linear-gradient(#FF6F61 50%,rgba(255,255,255,.3) 50%);border-radius:2px;transition:transform .3s}
.compass-n{position:absolute;top:6px;font-size:.55rem;font-weight:900;color:#FF6F61}
.compass-s{position:absolute;bottom:6px;font-size:.55rem;font-weight:900;color:rgba(255,255,255,.3)}

/* ═══ AMBIENT EFFECTS ═══ */
.ambient-glow{position:fixed;width:300px;height:300px;border-radius:50%;filter:blur(100px);pointer-events:none;z-index:0}
.glow-1{top:-100px;left:-100px;background:rgba(255,111,97,.08);animation:float1 15s ease-in-out infinite}
.glow-2{bottom:-100px;right:-100px;background:rgba(59,130,246,.06);animation:float2 18s ease-in-out infinite}
@keyframes float1{0%,100%{transform:translate(0,0)}50%{transform:translate(40px,30px)}}
@keyframes float2{0%,100%{transform:translate(0,0)}50%{transform:translate(-30px,-40px)}}

/* ═══ GYROSCOPE INDICATOR ═══ */
.gyro-indicator{position:fixed;top:80px;right:24px;z-index:100;padding:8px 14px;border-radius:10px;background:rgba(16,185,129,.15);border:1px solid rgba(16,185,129,.2);color:#34D399;font-size:.72rem;font-weight:700;display:none;align-items:center;gap:6px}

@media(max-width:768px){
    .info-panel{display:none}
    .hotspot-nav{display:none}
    .spot-carousel{bottom:70px;max-width:90vw;overflow-x:auto}
    .viewer-topbar{padding:12px 16px}
    .tb-title h1{font-size:.9rem}
    .compass{display:none}
}
@media(max-width:480px){
    .tb-actions{gap:4px}
    .tb-btn span{display:none}
}
</style>
</head>
<body>

<!-- LOADING -->
<div class="loading-screen" id="loadingScreen">
    <div class="loader-ring"></div>
    <div class="loader-text">Đang tải trải nghiệm 3D...</div>
    <div class="loader-progress"><div class="loader-progress-fill" id="progressFill"></div></div>
</div>

<!-- AMBIENT -->
<div class="ambient-glow glow-1"></div>
<div class="ambient-glow glow-2"></div>

<!-- 3D VIEWER CANVAS -->
<div id="viewer3D"></div>

<!-- TOP BAR -->
<div class="viewer-topbar">
    <a href="${pageContext.request.contextPath}/detail?id=${tour.tourId}" class="tb-back">
        <i class="fas fa-arrow-left"></i> Quay lại
    </a>
    <div class="tb-title">
        <h1><i class="fas fa-cube" style="color:#FF6F61"></i> ${tour.tourName}</h1>
        <p>Trải Nghiệm Tour 3D Immersive • 360°</p>
    </div>
    <div class="tb-actions">
        <button class="tb-btn" onclick="toggleFullscreen()" title="Toàn màn hình">
            <i class="fas fa-expand"></i> <span>Fullscreen</span>
        </button>
        <a href="${pageContext.request.contextPath}/booking?id=${tour.tourId}" class="tb-btn primary">
            <i class="fas fa-bolt"></i> <span>Đặt Tour</span>
        </a>
    </div>
</div>

<!-- HOTSPOT NAV (left) -->
<div class="hotspot-nav" id="hotspotNav"></div>

<!-- INFO PANEL (right) -->
<div class="info-panel" id="infoPanel">
    <div class="panel-header">
        <div class="panel-tag"><span class="pulse"></span> ĐANG XEM 3D</div>
        <button class="collapse-btn" onclick="togglePanel()"><i class="fas fa-chevron-right"></i></button>
    </div>
    <div class="panel-content">
        <div class="spot-title" id="spotTitle">Tổng Quan Tour</div>
        <div class="spot-desc" id="spotDesc">${not empty tour.shortDesc ? tour.shortDesc : 'Khám phá tour qua trải nghiệm 3D sống động.'}</div>
        <div class="spot-stats">
            <div class="spot-stat">
                <div class="stat-icon"><i class="fas fa-clock"></i></div>
                <div class="stat-label">Thời Gian</div>
                <div class="stat-value">${not empty tour.duration ? tour.duration : 'N/A'}</div>
            </div>
            <div class="spot-stat">
                <div class="stat-icon"><i class="fas fa-users"></i></div>
                <div class="stat-label">Số Người</div>
                <div class="stat-value">${tour.maxPeople} khách</div>
            </div>
            <div class="spot-stat">
                <div class="stat-icon"><i class="fas fa-bus"></i></div>
                <div class="stat-label">Phương Tiện</div>
                <div class="stat-value">${not empty tour.transport ? tour.transport : 'Xe du lịch'}</div>
            </div>
            <div class="spot-stat">
                <div class="stat-icon"><i class="fas fa-map-pin"></i></div>
                <div class="stat-label">Điểm Đến</div>
                <div class="stat-value" style="font-size:.78rem">${not empty tour.destination ? tour.destination : 'Đà Nẵng'}</div>
            </div>
        </div>
        <div class="panel-divider"></div>
        <div class="tour-price-section">
            <div class="tour-price-label">Giá Tour</div>
            <div class="tour-price-value"><fmt:formatNumber value="${tour.price}" type="number" groupingUsed="true"/>đ <span>/người</span></div>
        </div>
        <div class="panel-cta">
            <a href="${pageContext.request.contextPath}/booking?id=${tour.tourId}" class="btn-3d btn-3d-primary"><i class="fas fa-bolt"></i> Đặt Ngay</a>
            <button class="btn-3d btn-3d-outline" onclick="toggleAutoRotate()"><i class="fas fa-sync-alt"></i> Xoay</button>
        </div>
    </div>
</div>

<!-- BOTTOM CAROUSEL -->
<div class="spot-carousel" id="spotCarousel"></div>

<!-- BOTTOM CONTROLS -->
<div class="viewer-controls">
    <button class="ctrl-btn" onclick="zoomIn()"><i class="fas fa-search-plus"></i><span class="ctrl-tooltip">Phóng To</span></button>
    <button class="ctrl-btn" onclick="zoomOut()"><i class="fas fa-search-minus"></i><span class="ctrl-tooltip">Thu Nhỏ</span></button>
    <div class="ctrl-divider"></div>
    <button class="ctrl-btn" id="btnAutoRotate" onclick="toggleAutoRotate()"><i class="fas fa-sync-alt"></i><span class="ctrl-tooltip">Tự Xoay</span></button>
    <button class="ctrl-btn" onclick="resetView()"><i class="fas fa-crosshairs"></i><span class="ctrl-tooltip">Reset</span></button>
    <div class="ctrl-divider"></div>
    <button class="ctrl-btn" onclick="prevSpot()"><i class="fas fa-chevron-left"></i><span class="ctrl-tooltip">Trước</span></button>
    <button class="ctrl-btn" onclick="nextSpot()"><i class="fas fa-chevron-right"></i><span class="ctrl-tooltip">Tiếp</span></button>
    <div class="ctrl-divider"></div>
    <button class="ctrl-btn" onclick="toggleFullscreen()"><i class="fas fa-expand"></i><span class="ctrl-tooltip">Fullscreen</span></button>
</div>

<!-- COMPASS -->
<div class="compass" id="compass">
    <span class="compass-n">N</span>
    <div class="compass-needle" id="compassNeedle"></div>
    <span class="compass-s">S</span>
</div>

<!-- GYROSCOPE -->
<div class="gyro-indicator" id="gyroIndicator">
    <i class="fas fa-mobile-alt"></i> Gyroscope Active
</div>

<script>
/* ═══════════════════════════════════════════
   3D PANORAMA VIEWER - THREE.JS ENGINE
   ═══════════════════════════════════════════ */

// Tour data from server
const TOUR_ID = ${tour.tourId};
const TOUR_NAME = "${tour.tourName}";
const CTX = '${pageContext.request.contextPath}';
const TOUR_IMAGE = "${tour.imageUrl}";

// 3D Spots data - using tour images or defaults
const spots = [];

// Collect tour images from JSTL
<c:choose>
    <c:when test="${not empty tour.images && tour.images.size() > 0}">
        <c:forEach items="${tour.images}" var="img" varStatus="status">
        spots.push({
            id: ${status.index},
            name: '${not empty img.caption ? img.caption : "Điểm tham quan "}${status.index + 1}',
            icon: ['fa-panorama','fa-mountain','fa-water','fa-tree','fa-landmark','fa-torii-gate','fa-mosque','fa-church'][${status.index} % 8],
            image: '${img.imageUrl}',
            description: 'Khám phá ${not empty img.caption ? img.caption : tour.tourName} từ góc nhìn 360°'
        });
        </c:forEach>
    </c:when>
    <c:otherwise>
        /* Default scenic spots using the tour main image */
    </c:otherwise>
</c:choose>

// If no images, create default spots from main tour image
if (spots.length === 0) {
    const defaultSpots = [
        { name: 'Cổng Chào', icon: 'fa-torii-gate', desc: 'Điểm xuất phát của hành trình' },
        { name: 'Quang Cảnh Chính', icon: 'fa-panorama', desc: 'Toàn cảnh 360° tuyệt đẹp' },
        { name: 'Cảnh Hoàng Hôn', icon: 'fa-sun', desc: 'Khoảnh khắc hoàng hôn tuyệt đẹp' },
        { name: 'Nơi Dừng Chân', icon: 'fa-mug-hot', desc: 'Nghỉ ngơi và tận hưởng' }
    ];
    defaultSpots.forEach((s, i) => {
        spots.push({
            id: i,
            name: s.name,
            icon: s.icon,
            image: TOUR_IMAGE,
            description: s.desc
        });
    });
}

// ═══ THREE.JS SETUP ═══
let scene, camera, renderer, sphere;
let isUserInteracting = false, autoRotate = true;
let lon = 0, lat = 0, phi = 0, theta = 0;
let onPointerDownLon = 0, onPointerDownLat = 0;
let onPointerDownX = 0, onPointerDownY = 0;
let currentFov = 75, targetFov = 75;
let currentSpotIndex = 0;

function initViewer() {
    const container = document.getElementById('viewer3D');
    scene = new THREE.Scene();
    camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 1, 1100);
    camera.target = new THREE.Vector3(0, 0, 0);

    renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
    renderer.setPixelRatio(window.devicePixelRatio);
    renderer.setSize(window.innerWidth, window.innerHeight);
    renderer.outputEncoding = THREE.sRGBEncoding;
    container.appendChild(renderer.domElement);

    // Create sphere geometry for panorama
    const geometry = new THREE.SphereGeometry(500, 60, 40);
    geometry.scale(-1, 1, 1); // Invert faces

    // Load first texture
    loadSpot(0);

    // Events
    container.addEventListener('pointerdown', onPointerDown, false);
    document.addEventListener('pointermove', onPointerMove, false);
    document.addEventListener('pointerup', onPointerUp, false);
    container.addEventListener('wheel', onWheel, { passive: false });
    window.addEventListener('resize', onResize, false);

    // Touch support
    container.addEventListener('touchstart', onTouchStart, { passive: false });
    container.addEventListener('touchmove', onTouchMove, { passive: false });
    container.addEventListener('touchend', onTouchEnd, false);

    // Gyroscope
    if (window.DeviceOrientationEvent) {
        window.addEventListener('deviceorientation', onDeviceOrientation, false);
    }

    // Keyboard
    document.addEventListener('keydown', onKeyDown, false);

    buildUI();
    animate();
}

function loadSpot(index) {
    currentSpotIndex = index;
    const spot = spots[index];

    // Show loading briefly
    const fill = document.getElementById('progressFill');
    fill.style.width = '30%';

    const loader = new THREE.TextureLoader();
    loader.load(
        spot.image,
        (texture) => {
            texture.mapping = THREE.EquirectangularReflectionMapping;
            texture.encoding = THREE.sRGBEncoding;

            const material = new THREE.MeshBasicMaterial({ map: texture });
            const geometry = new THREE.SphereGeometry(500, 60, 40);
            geometry.scale(-1, 1, 1);

            if (sphere) scene.remove(sphere);
            sphere = new THREE.Mesh(geometry, material);
            scene.add(sphere);

            fill.style.width = '100%';
            setTimeout(() => {
                document.getElementById('loadingScreen').classList.add('hide');
            }, 500);

            // Update UI
            updateSpotUI(index);
        },
        (xhr) => {
            const pct = (xhr.loaded / xhr.total * 100);
            fill.style.width = Math.min(pct, 95) + '%';
        },
        () => {
            // Error - use a generated gradient sphere
            const canvas = document.createElement('canvas');
            canvas.width = 2048; canvas.height = 1024;
            const ctx = canvas.getContext('2d');
            const grad = ctx.createLinearGradient(0, 0, 2048, 1024);
            grad.addColorStop(0, '#1a1a2e');
            grad.addColorStop(0.3, '#16213e');
            grad.addColorStop(0.6, '#0f3460');
            grad.addColorStop(1, '#e94560');
            ctx.fillStyle = grad;
            ctx.fillRect(0, 0, 2048, 1024);
            // Add some stars
            ctx.fillStyle = '#fff';
            for (let i = 0; i < 200; i++) {
                const x = Math.random() * 2048;
                const y = Math.random() * 512;
                const r = Math.random() * 2;
                ctx.beginPath();
                ctx.arc(x, y, r, 0, Math.PI * 2);
                ctx.fill();
            }
            // Add text
            ctx.font = 'bold 48px Plus Jakarta Sans, sans-serif';
            ctx.fillStyle = 'rgba(255,255,255,0.6)';
            ctx.textAlign = 'center';
            ctx.fillText(spot.name, 1024, 512);
            ctx.font = '24px Plus Jakarta Sans, sans-serif';
            ctx.fillStyle = 'rgba(255,255,255,0.3)';
            ctx.fillText('360° Virtual Tour', 1024, 560);

            const texture = new THREE.CanvasTexture(canvas);
            const material = new THREE.MeshBasicMaterial({ map: texture });
            const geometry = new THREE.SphereGeometry(500, 60, 40);
            geometry.scale(-1, 1, 1);

            if (sphere) scene.remove(sphere);
            sphere = new THREE.Mesh(geometry, material);
            scene.add(sphere);

            fill.style.width = '100%';
            setTimeout(() => {
                document.getElementById('loadingScreen').classList.add('hide');
            }, 500);
            updateSpotUI(index);
        }
    );
}

// ═══ POINTER EVENTS ═══
function onPointerDown(e) {
    isUserInteracting = true;
    onPointerDownX = e.clientX;
    onPointerDownY = e.clientY;
    onPointerDownLon = lon;
    onPointerDownLat = lat;
}
function onPointerMove(e) {
    if (!isUserInteracting) return;
    lon = (onPointerDownX - e.clientX) * 0.15 + onPointerDownLon;
    lat = (e.clientY - onPointerDownY) * 0.15 + onPointerDownLat;
}
function onPointerUp() { isUserInteracting = false; }

// ═══ TOUCH EVENTS ═══
let touchStartX, touchStartY;
function onTouchStart(e) {
    if (e.touches.length === 1) {
        e.preventDefault();
        isUserInteracting = true;
        onPointerDownX = e.touches[0].clientX;
        onPointerDownY = e.touches[0].clientY;
        onPointerDownLon = lon;
        onPointerDownLat = lat;
    }
}
function onTouchMove(e) {
    if (e.touches.length === 1 && isUserInteracting) {
        e.preventDefault();
        lon = (onPointerDownX - e.touches[0].clientX) * 0.15 + onPointerDownLon;
        lat = (e.touches[0].clientY - onPointerDownY) * 0.15 + onPointerDownLat;
    }
}
function onTouchEnd() { isUserInteracting = false; }

// ═══ ZOOM ═══
function onWheel(e) {
    e.preventDefault();
    targetFov += e.deltaY * 0.05;
    targetFov = Math.max(30, Math.min(100, targetFov));
}
function zoomIn() { targetFov = Math.max(30, targetFov - 10); }
function zoomOut() { targetFov = Math.min(100, targetFov + 10); }

// ═══ GYROSCOPE ═══
function onDeviceOrientation(e) {
    if (e.alpha !== null) {
        document.getElementById('gyroIndicator').style.display = 'flex';
    }
}

// ═══ KEYBOARD ═══
function onKeyDown(e) {
    switch(e.key) {
        case 'ArrowLeft': lon -= 10; break;
        case 'ArrowRight': lon += 10; break;
        case 'ArrowUp': lat += 10; break;
        case 'ArrowDown': lat -= 10; break;
        case '+': case '=': zoomIn(); break;
        case '-': zoomOut(); break;
        case ' ': toggleAutoRotate(); e.preventDefault(); break;
        case 'f': case 'F': toggleFullscreen(); break;
    }
}

// ═══ RESIZE ═══
function onResize() {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
}

// ═══ ANIMATION LOOP ═══
function animate() {
    requestAnimationFrame(animate);

    // Auto-rotate
    if (autoRotate && !isUserInteracting) {
        lon += 0.04;
    }

    // Smooth FOV
    currentFov += (targetFov - currentFov) * 0.1;
    camera.fov = currentFov;
    camera.updateProjectionMatrix();

    // Clamp lat
    lat = Math.max(-85, Math.min(85, lat));
    phi = THREE.MathUtils.degToRad(90 - lat);
    theta = THREE.MathUtils.degToRad(lon);

    camera.target.x = 500 * Math.sin(phi) * Math.cos(theta);
    camera.target.y = 500 * Math.cos(phi);
    camera.target.z = 500 * Math.sin(phi) * Math.sin(theta);
    camera.lookAt(camera.target);

    // Update compass
    const needle = document.getElementById('compassNeedle');
    if (needle) needle.style.transform = 'rotate(' + (lon % 360) + 'deg)';

    renderer.render(scene, camera);
}

// ═══ UI BUILDERS ═══
function buildUI() {
    // Build hotspot nav
    const nav = document.getElementById('hotspotNav');
    let navHtml = '';
    spots.forEach((s, i) => {
        navHtml += '<div class="hotspot-dot' + (i === 0 ? ' active' : '') + '" onclick="goToSpot(' + i + ')">';
        navHtml += '<i class="fas ' + s.icon + '"></i>';
        navHtml += '<span class="hotspot-label">' + s.name + '</span>';
        navHtml += '</div>';
    });
    nav.innerHTML = navHtml;

    // Build carousel
    const carousel = document.getElementById('spotCarousel');
    let carouselHtml = '';
    spots.forEach((s, i) => {
        carouselHtml += '<div class="spot-thumb' + (i === 0 ? ' active' : '') + '" onclick="goToSpot(' + i + ')">';
        carouselHtml += '<img src="' + s.image + '" alt="' + s.name + '" onerror="this.src=\'data:image/svg+xml,%3Csvg xmlns=\\\'http://www.w3.org/2000/svg\\\' viewBox=\\\'0 0 80 56\\\'%3E%3Crect fill=\\\'%231a1a2e\\\' width=\\\'80\\\' height=\\\'56\\\'/%3E%3Ctext x=\\\'40\\\' y=\\\'28\\\' fill=\\\'%23fff\\\' text-anchor=\\\'middle\\\' font-size=\\\'10\\\'%3E3D%3C/text%3E%3C/svg%3E\'">';
        carouselHtml += '<div class="thumb-label">' + s.name + '</div>';
        carouselHtml += '</div>';
    });
    carousel.innerHTML = carouselHtml;
}

function updateSpotUI(index) {
    const spot = spots[index];

    // Update info panel
    document.getElementById('spotTitle').textContent = spot.name;
    document.getElementById('spotDesc').textContent = spot.description;

    // Update hotspot nav
    document.querySelectorAll('.hotspot-dot').forEach((d, i) => {
        d.classList.toggle('active', i === index);
    });

    // Update carousel
    document.querySelectorAll('.spot-thumb').forEach((t, i) => {
        t.classList.toggle('active', i === index);
    });
}

// ═══ CONTROLS ═══
function goToSpot(index) {
    if (index < 0 || index >= spots.length) return;
    loadSpot(index);
    // Smooth transition - reset view slightly
    lon += 30;
}
function prevSpot() { goToSpot((currentSpotIndex - 1 + spots.length) % spots.length); }
function nextSpot() { goToSpot((currentSpotIndex + 1) % spots.length); }
function resetView() { lon = 0; lat = 0; targetFov = 75; }

function toggleAutoRotate() {
    autoRotate = !autoRotate;
    document.getElementById('btnAutoRotate').classList.toggle('active', autoRotate);
}

function toggleFullscreen() {
    if (!document.fullscreenElement) {
        document.documentElement.requestFullscreen();
    } else {
        document.exitFullscreen();
    }
}

function togglePanel() {
    document.getElementById('infoPanel').classList.toggle('collapsed');
}

// ═══ INIT ═══
window.addEventListener('DOMContentLoaded', initViewer);
</script>
</body>
</html>
