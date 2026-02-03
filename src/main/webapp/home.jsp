<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kanra - Travel Booking</title>
    <!-- Bootstrap 5 for Grid System only (minimizing conflict with custom CSS) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/kanra.css">
</head>
<body>

    <!-- NAVBAR -->
    <nav class="kanra-navbar d-flex justify-content-between align-items-center sticky-top">
        <div class="d-flex align-items-center gap-5">
            <a href="home" class="kanra-brand">
                <i class="bi bi-stars"></i> Kanra
            </a>
            
            <form action="search" method="GET" class="kanra-search d-none d-md-flex">
                <i class="bi bi-search text-muted"></i>
                <input type="text" name="keyword" placeholder="Search destinations..." value="${param.keyword}">
            </form>
        </div>

        <div class="d-flex align-items-center">
            <ul class="nav d-none d-lg-flex me-4">
                <li class="nav-item"><a href="home" class="nav-link active">Reviews</a></li>
                <li class="nav-item"><a href="#destinations" class="nav-link">Destinations</a></li>
                <li class="nav-item"><a href="history" class="nav-link">Ticket</a></li>
                <li class="nav-item"><a href="#" class="nav-link">Blog</a></li>
            </ul>

            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <div class="dropdown">
                        <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle text-dark" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                            <div class="rounded-circle bg-warning d-flex justify-content-center align-items-center text-white fw-bold me-2" style="width: 40px; height: 40px;">
                                ${sessionScope.user.username.charAt(0).toUpperCase()}
                            </div>
                            <span>${sessionScope.user.username}</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end border-0 shadow" aria-labelledby="userDropdown">
                            <li><a class="dropdown-item" href="user.jsp">Profile</a></li>
                            <li><a class="dropdown-item" href="history">My Bookings</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="logout">Logout</a></li>
                        </ul>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="login.jsp" class="btn-kanra">Get the App</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

    <!-- HERO SECTION -->
    <section class="hero-section container">
        <div class="row align-items-center">
            <div class="col-lg-6">
                <!-- Text Content -->
                <h1 class="hero-title">
                    People don't <br>
                    take trips, trips <br>
                    take <span class="wave-underline">people</span>
                </h1>
                
                <p class="hero-desc">
                    To get the best of your adventure you just need to leave and go where you like. 
                    We are waiting for you!
                </p>

                <div class="d-flex gap-3 align-items-center">
                    <a href="#destinations" class="btn-kanra">Plan a Trip &nbsp; <i class="bi bi-arrow-right"></i></a>
                    <a href="#" class="text-decoration-none text-dark fw-bold d-flex align-items-center gap-2">
                        <i class="bi bi-play-circle-fill text-warning fs-2"></i> Watch Our Story
                    </a>
                </div>
            </div>

            <div class="col-lg-6 position-relative mt-5 mt-lg-0">
                <!-- Image Content -->
                 <div class="hero-image-container">
                    <div class="hero-placeholder-img"></div>
                 </div>
                 
                 <!-- Decor Elements -->
                 <div class="floating-badge">
                     <div class="text-center text-primary mb-1"><i class="bi bi-camera-video-fill fs-3"></i></div>
                     <h3>24/7</h3>
                     <p>Guide Support</p>
                 </div>
                 
                 <div class="position-absolute" style="top: -20px; left: 20px; z-index: -1; color: #ff6b4a; opacity: 0.5;">
                     <i class="bi bi-columns-gap fs-1"></i>
                 </div>
            </div>
        </div>
    </section>

    <!-- TOURS / DESTINATIONS -->
    <section id="destinations" class="container py-5">
        <div class="text-center mb-5">
            <span class="section-badge">DESTINATIONS</span>
            <h2 class="fw-bold display-5">Explore Our Tours</h2>
        </div>
        
        <!-- Filter Tabs (Visual Only for now) -->
        <div class="d-flex justify-content-center gap-4 mb-5">
            <button class="btn btn-dark rounded-pill px-4">All</button>
            <button class="btn btn-outline-light text-dark border-0">Hotel</button>
            <button class="btn btn-outline-light text-dark border-0">Homestay</button>
            <button class="btn btn-outline-light text-dark border-0">Transport</button>
        </div>

        <div class="row g-4">
            <c:if test="${empty listTours}">
                <!-- Mock Data if list is empty for UI Demo -->
                 <div class="col-md-4">
                    <div class="card h-100 border-0 shadow-sm rounded-4 overflow-hidden">
                        <img src="https://images.unsplash.com/photo-1502602898657-3e91760cbb34?q=80&w=2073&auto=format&fit=crop" class="card-img-top" height="250" style="object-fit: cover;">
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-1">Paris, France</h5>
                            <p class="text-muted small"><i class="bi bi-geo-alt"></i> Europe</p>
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <span class="fw-bold text-primary fs-5">$1,200</span>
                                <a href="booking.jsp" class="btn btn-sm btn-outline-dark rounded-pill px-3">Book Now</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 border-0 shadow-sm rounded-4 overflow-hidden">
                        <img src="https://images.unsplash.com/photo-1493246507139-91e8fad9978e?q=80&w=2070&auto=format&fit=crop" class="card-img-top" height="250" style="object-fit: cover;">
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-1">Kyoto, Japan</h5>
                            <p class="text-muted small"><i class="bi bi-geo-alt"></i> Asia</p>
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <span class="fw-bold text-primary fs-5">$1,500</span>
                                <a href="booking.jsp" class="btn btn-sm btn-outline-dark rounded-pill px-3">Book Now</a>
                            </div>
                        </div>
                    </div>
                </div>
                 <div class="col-md-4">
                    <div class="card h-100 border-0 shadow-sm rounded-4 overflow-hidden">
                        <img src="https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?q=80&w=1966&auto=format&fit=crop" class="card-img-top" height="250" style="object-fit: cover;">
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-1">Venice, Italy</h5>
                            <p class="text-muted small"><i class="bi bi-geo-alt"></i> Europe</p>
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <span class="fw-bold text-primary fs-5">$1,350</span>
                                <a href="booking.jsp" class="btn btn-sm btn-outline-dark rounded-pill px-3">Book Now</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Real Data Loop -->
            <c:forEach items="${listTours}" var="t">
                 <div class="col-md-4">
                    <div class="card h-100 border-0 shadow-sm rounded-4 overflow-hidden">
                        <img src="${t.imageUrl}" class="card-img-top" height="250" style="object-fit: cover;">
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-1">${t.name}</h5>
                            <p class="text-muted small"><i class="bi bi-geo-alt"></i> ${t.location}</p>
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <span class="fw-bold text-primary fs-5">
                                    <fmt:formatNumber value="${t.price}" type="currency" currencySymbol="$"/>
                                </span>
                                <a href="detail?id=${t.id}" class="btn btn-sm btn-outline-dark rounded-pill px-3">View</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>

    <!-- FOOTER -->
    <footer class="kanra-footer container-fluid">
        <div class="container position-relative z-1">
            <div class="row">
                <div class="col-md-6">
                    <h2 class="display-6 fw-bold mb-4">Your travel companion that <br> carries all the information</h2>
                    <div class="d-flex gap-2">
                        <img src="https://randomuser.me/api/portraits/women/44.jpg" class="rounded-circle border border-white" width="40">
                        <img src="https://randomuser.me/api/portraits/men/32.jpg" class="rounded-circle border border-white" width="40" style="margin-left: -15px;">
                        <img src="https://randomuser.me/api/portraits/women/68.jpg" class="rounded-circle border border-white" width="40" style="margin-left: -15px;">
                        <div class="bg-white text-dark rounded-circle d-flex align-items-center justify-content-center fw-bold" style="width: 40px; margin-left: -15px;">3K+</div>
                        <div class="ms-3 align-self-center">
                            <div class="fw-bold">Travelled more than</div>
                            <small class="text-warning">2000 places 🏖️</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Decorative Hiker (Use a transparent PNG if available, else a CSS shape) -->
        <div class="d-none d-lg-block position-absolute" style="bottom: 0; right: 100px; width: 300px;">
           <img src="https://purepng.com/public/uploads/large/purepng.com-travelertravelerpassengertouristvisiting-1421526932450j46i1.png" alt="Traveler" style="width: 100%;">
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>