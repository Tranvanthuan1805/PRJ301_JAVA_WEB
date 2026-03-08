<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xem Tour 3D | eztravel</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .tour3d-page { padding: 120px 0 60px; min-height: 100vh; background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #0f172a 100%); color: white; }

        .tour3d-header { text-align: center; margin-bottom: 50px; }
        .tour3d-header h1 { font-size: 2.2rem; font-weight: 800; margin-bottom: 10px; }
        .tour3d-header h1 span { background: linear-gradient(135deg, #FF6F61, #FF9A8B); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .tour3d-header p { color: rgba(255,255,255,.6); }

        /* 3D Carousel */
        .carousel-wrapper { perspective: 1200px; width: 100%; max-width: 900px; margin: 0 auto; height: 450px; position: relative; }
        .carousel-3d { width: 100%; height: 100%; position: relative; transform-style: preserve-3d; transition: transform 1s cubic-bezier(.23,1,.32,1); }
        .carousel-slide { position: absolute; width: 320px; height: 400px; left: 50%; top: 50%; margin-left: -160px; margin-top: -200px; border-radius: 24px; overflow: hidden; backface-visibility: hidden; box-shadow: 0 20px 60px rgba(0,0,0,.5); transition: all 1s cubic-bezier(.23,1,.32,1); cursor: pointer; }
        .carousel-slide img { width: 100%; height: 100%; object-fit: cover; }
        .carousel-slide .slide-overlay { position: absolute; bottom: 0; left: 0; right: 0; padding: 24px; background: linear-gradient(transparent, rgba(0,0,0,.85)); }
        .carousel-slide .slide-overlay h3 { font-size: 1.1rem; font-weight: 800; margin-bottom: 4px; }
        .carousel-slide .slide-overlay .price { color: #FF9A8B; font-weight: 800; font-size: 1rem; }

        /* Carousel Controls */
        .carousel-controls { display: flex; justify-content: center; gap: 16px; margin-top: 30px; }
        .carousel-btn { width: 52px; height: 52px; border-radius: 50%; border: 2px solid rgba(255,255,255,.2); background: rgba(255,255,255,.05); backdrop-filter: blur(10px); color: white; font-size: 1.1rem; cursor: pointer; transition: all .3s; display: flex; align-items: center; justify-content: center; }
        .carousel-btn:hover { background: #FF6F61; border-color: #FF6F61; transform: scale(1.1); }
        .carousel-dots { display: flex; gap: 8px; align-items: center; }
        .carousel-dot { width: 10px; height: 10px; border-radius: 50%; background: rgba(255,255,255,.2); cursor: pointer; transition: all .3s; }
        .carousel-dot.active { background: #FF6F61; transform: scale(1.3); }

        /* 3D Rubik Cube Gallery */
        .rubik-section { margin-top: 80px; text-align: center; }
        .rubik-section h2 { font-size: 1.6rem; font-weight: 800; margin-bottom: 40px; }
        .rubik-section h2 span { color: #FF6F61; }

        .rubik-container { perspective: 1000px; width: 300px; height: 300px; margin: 0 auto; }
        .rubik-cube { width: 100%; height: 100%; position: relative; transform-style: preserve-3d; animation: rubikRotate 20s ease-in-out infinite; }

        .rubik-face { position: absolute; width: 300px; height: 300px; display: grid; grid-template-columns: repeat(3, 1fr); gap: 4px; padding: 4px; }
        .rubik-face.front  { transform: rotateY(0deg) translateZ(150px); }
        .rubik-face.back   { transform: rotateY(180deg) translateZ(150px); }
        .rubik-face.right  { transform: rotateY(90deg) translateZ(150px); }
        .rubik-face.left   { transform: rotateY(-90deg) translateZ(150px); }
        .rubik-face.top    { transform: rotateX(90deg) translateZ(150px); }
        .rubik-face.bottom { transform: rotateX(-90deg) translateZ(150px); }

        .rubik-cell { border-radius: 8px; overflow: hidden; position: relative; cursor: pointer; transition: transform .3s; }
        .rubik-cell:hover { transform: scale(1.08); z-index: 2; }
        .rubik-cell img { width: 100%; height: 100%; object-fit: cover; }
        .rubik-cell .cell-label { position: absolute; bottom: 0; left: 0; right: 0; padding: 4px; background: rgba(0,0,0,.7); font-size: .55rem; font-weight: 700; text-align: center; opacity: 0; transition: opacity .3s; }
        .rubik-cell:hover .cell-label { opacity: 1; }

        @keyframes rubikRotate {
            0%   { transform: rotateX(-15deg) rotateY(0deg); }
            25%  { transform: rotateX(15deg) rotateY(90deg); }
            50%  { transform: rotateX(-10deg) rotateY(180deg); }
            75%  { transform: rotateX(10deg) rotateY(270deg); }
            100% { transform: rotateX(-15deg) rotateY(360deg); }
        }

        /* Interaction hint */
        .interact-hint { display: flex; align-items: center; justify-content: center; gap: 8px; margin-top: 20px; color: rgba(255,255,255,.4); font-size: .82rem; }
        .interact-hint i { animation: swipeHint 2s ease infinite; }
        @keyframes swipeHint { 0%,100% { transform: translateX(0); } 50% { transform: translateX(10px); } }

        /* Tour Detail Modal */
        .modal-overlay { position: fixed; inset: 0; background: rgba(0,0,0,.8); backdrop-filter: blur(8px); z-index: 1000; display: none; align-items: center; justify-content: center; }
        .modal-overlay.active { display: flex; }
        .modal-content { background: white; border-radius: 24px; max-width: 600px; width: 90%; max-height: 80vh; overflow-y: auto; color: #1B1F3B; }
        .modal-img { width: 100%; height: 250px; object-fit: cover; border-radius: 24px 24px 0 0; }
        .modal-body { padding: 28px; }
        .modal-body h2 { font-size: 1.3rem; font-weight: 800; margin-bottom: 8px; }
        .modal-close { position: absolute; top: 16px; right: 16px; width: 40px; height: 40px; border-radius: 50%; background: rgba(255,255,255,.9); border: none; cursor: pointer; font-size: 1.1rem; display: flex; align-items: center; justify-content: center; }

        @media(max-width:768px) {
            .tour3d-page { padding: 90px 0 40px; }
            .carousel-wrapper { height: 350px; }
            .carousel-slide { width: 240px; height: 300px; margin-left: -120px; margin-top: -150px; }
            .rubik-container { width: 220px; height: 220px; }
            .rubik-face { width: 220px; height: 220px; }
            .rubik-face.front  { transform: rotateY(0deg) translateZ(110px); }
            .rubik-face.back   { transform: rotateY(180deg) translateZ(110px); }
            .rubik-face.right  { transform: rotateY(90deg) translateZ(110px); }
            .rubik-face.left   { transform: rotateY(-90deg) translateZ(110px); }
            .rubik-face.top    { transform: rotateX(90deg) translateZ(110px); }
            .rubik-face.bottom { transform: rotateX(-90deg) translateZ(110px); }
        }
    </style>
</head>
<body>
    <jsp:include page="/common/_navbar.jsp" />

    <section class="tour3d-page">
        <div class="container">
            <div class="tour3d-header">
                <h1><span>3D</span> Tour Gallery</h1>
                <p>Trải nghiệm xem tour theo góc nhìn 3D tương tác</p>
            </div>

            <!-- 3D Carousel -->
            <div class="carousel-wrapper">
                <div class="carousel-3d" id="carousel3d">
                    <c:forEach items="${tours}" var="tour" varStatus="i">
                        <c:if test="${i.index < 8}">
                            <div class="carousel-slide" data-index="${i.index}" 
                                 onclick="showTourDetail(${tour.tourId}, '${tour.tourName}', '${tour.imageUrl}', ${tour.price})">
                                <img src="${tour.imageUrl != null ? tour.imageUrl : 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=600'}" alt="${tour.tourName}">
                                <div class="slide-overlay">
                                    <h3>${tour.tourName}</h3>
                                    <div class="price"><fmt:formatNumber value="${tour.price}" pattern="#,##0"/>đ</div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <div class="carousel-controls">
                <button class="carousel-btn" onclick="prevSlide()"><i class="fas fa-chevron-left"></i></button>
                <div class="carousel-dots" id="dots"></div>
                <button class="carousel-btn" onclick="nextSlide()"><i class="fas fa-chevron-right"></i></button>
            </div>

            <div class="interact-hint">
                <i class="fas fa-hand-pointer"></i> Kéo hoặc nhấn để xem tour chi tiết
            </div>

            <!-- 3D Rubik Gallery -->
            <div class="rubik-section">
                <h2>Bộ sưu tập <span>Rubik 3D</span></h2>
                <div class="rubik-container" id="rubikContainer">
                    <div class="rubik-cube" id="rubikCube">
                        <!-- Faces generated by JS -->
                    </div>
                </div>
                <div class="interact-hint" style="margin-top:24px">
                    <i class="fas fa-sync-alt"></i> Di chuột vào để tương tác
                </div>
            </div>
        </div>
    </section>

    <!-- Tour Detail Modal -->
    <div class="modal-overlay" id="tourModal" onclick="closeTourModal(event)">
        <div class="modal-content" onclick="event.stopPropagation()">
            <img class="modal-img" id="modalImg" src="" alt="">
            <div class="modal-body">
                <h2 id="modalName"></h2>
                <p id="modalPrice" style="font-size:1.2rem;font-weight:800;color:#FF6F61;margin-bottom:16px"></p>
                <a id="modalBookBtn" href="#" style="display:inline-flex;align-items:center;gap:8px;padding:14px 28px;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:white;border-radius:14px;font-weight:700;text-decoration:none;transition:all .3s">
                    <i class="fas fa-shopping-cart"></i> Đặt tour ngay
                </a>
            </div>
        </div>
    </div>

    <jsp:include page="/common/_footer.jsp" />

    <script>
        // 3D Carousel
        const slides = document.querySelectorAll('.carousel-slide');
        const total = slides.length;
        let current = 0;
        const angleStep = 360 / total;

        function updateCarousel() {
            slides.forEach((slide, i) => {
                const angle = (i - current) * angleStep;
                const rad = angle * Math.PI / 180;
                const z = 350 * Math.cos(rad);
                const x = 350 * Math.sin(rad);
                const scale = (z + 350) / 700 * 0.5 + 0.5;
                const opacity = scale;

                slide.style.transform = 'translateX(' + x + 'px) translateZ(' + z + 'px) scale(' + scale + ')';
                slide.style.opacity = opacity;
                slide.style.zIndex = Math.round(z);
            });

            // Update dots
            document.querySelectorAll('.carousel-dot').forEach((d, i) => {
                d.classList.toggle('active', i === current);
            });
        }

        function nextSlide() { current = (current + 1) % total; updateCarousel(); }
        function prevSlide() { current = (current - 1 + total) % total; updateCarousel(); }

        // Create dots
        const dotsContainer = document.getElementById('dots');
        for (let i = 0; i < total; i++) {
            const dot = document.createElement('div');
            dot.className = 'carousel-dot' + (i === 0 ? ' active' : '');
            dot.onclick = () => { current = i; updateCarousel(); };
            dotsContainer.appendChild(dot);
        }
        updateCarousel();

        // Auto-rotate
        setInterval(nextSlide, 4000);

        // 3D Rubik Cube
        const tourImages = [
            'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=200',
            'https://images.unsplash.com/photo-1506929562872-bb421503ef21?w=200',
            'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=200',
            'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=200',
            'https://images.unsplash.com/photo-1513407030348-c983a97b98d8?w=200',
            'https://images.unsplash.com/photo-1533577116850-9cc66cad8a9b?w=200',
            'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=200',
            'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=200',
            'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=200',
        ];

        const faces = ['front', 'back', 'right', 'left', 'top', 'bottom'];
        const cube = document.getElementById('rubikCube');

        faces.forEach(face => {
            const faceEl = document.createElement('div');
            faceEl.className = 'rubik-face ' + face;
            for (let i = 0; i < 9; i++) {
                const cell = document.createElement('div');
                cell.className = 'rubik-cell';
                const img = document.createElement('img');
                img.src = tourImages[i % tourImages.length];
                cell.appendChild(img);
                faceEl.appendChild(cell);
            }
            cube.appendChild(faceEl);
        });

        // Mouse interaction for Rubik cube
        const rubikContainer = document.getElementById('rubikContainer');
        let isDragging = false;
        let rotX = -15, rotY = 0;
        let startX, startY;

        rubikContainer.addEventListener('mouseenter', () => {
            cube.style.animationPlayState = 'paused';
        });
        rubikContainer.addEventListener('mouseleave', () => {
            cube.style.animationPlayState = 'running';
        });
        rubikContainer.addEventListener('mousedown', e => {
            isDragging = true; startX = e.clientX; startY = e.clientY;
            cube.style.animationPlayState = 'paused';
        });
        document.addEventListener('mousemove', e => {
            if (!isDragging) return;
            rotY += (e.clientX - startX) * 0.5;
            rotX -= (e.clientY - startY) * 0.5;
            cube.style.transform = 'rotateX(' + rotX + 'deg) rotateY(' + rotY + 'deg)';
            startX = e.clientX; startY = e.clientY;
        });
        document.addEventListener('mouseup', () => { isDragging = false; });

        // Tour Detail Modal
        function showTourDetail(id, name, img, price) {
            document.getElementById('modalImg').src = img || 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=600';
            document.getElementById('modalName').textContent = name;
            document.getElementById('modalPrice').textContent = new Intl.NumberFormat('vi-VN').format(price) + 'đ';
            document.getElementById('modalBookBtn').href = '${pageContext.request.contextPath}/booking?id=' + id;
            document.getElementById('tourModal').classList.add('active');
        }

        function closeTourModal(e) {
            if (e.target === document.getElementById('tourModal')) {
                document.getElementById('tourModal').classList.remove('active');
            }
        }
    </script>
</body>
</html>
