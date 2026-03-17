<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
/* ═══ TOP BAR — WHITE, LARGE, HALOVI STYLE ═══ */
.top-bar{background:#fff;color:#475569;height:90px;display:flex;align-items:center;position:fixed;top:0;left:0;right:0;z-index:2001;padding:0 40px;border-bottom:1px solid #E2E8F0}
.top-bar-inner{max-width:1400px;margin:0 auto;width:100%;display:flex;align-items:center;justify-content:space-between}

/* Logo — Large like HALOVI */
.top-bar-brand{display:flex;align-items:center;gap:14px;text-decoration:none;flex-shrink:0;padding-right:36px}
.top-bar-logo-icon{position:relative;width:56px;height:56px}
.top-bar-logo-icon svg{width:56px;height:56px}
.top-bar-brand-text{display:flex;flex-direction:column;gap:0}
.top-bar-brand-name{font-family:'Playfair Display',serif;font-size:2.2rem;font-weight:900;color:#1E293B;letter-spacing:-0.5px;line-height:1.1}
.top-bar-brand-name .ez-highlight{color:#2563EB}
.top-bar-brand-slogan{font-size:.65rem;color:#94A3B8;font-weight:600;text-transform:uppercase;letter-spacing:2.5px}

/* Info blocks — Smooth 1-by-1 Slide */
.top-bar-info{flex:1;overflow:hidden;position:relative;margin:0 20px}
.top-bar-info-track{display:flex;transition:transform .7s cubic-bezier(.25,.46,.45,.94)}
.top-bar-info-item{display:flex;align-items:center;gap:16px;padding:0 28px;border-left:1.5px solid #E2E8F0;position:relative;min-width:33.333%;max-width:33.333%;box-sizing:border-box;flex-shrink:0}
.top-bar-info-item:first-child{border-left:none}
.top-bar-info-icon{width:46px;height:46px;border-radius:50%;border:2px solid #CBD5E1;display:flex;align-items:center;justify-content:center;flex-shrink:0;color:#2563EB;font-size:1.1rem;transition:all .3s ease}
.top-bar-info-item:hover .top-bar-info-icon{border-color:#2563EB;background:rgba(37,99,235,.08);transform:scale(1.08)}
.top-bar-info-content{display:flex;flex-direction:column;gap:3px}
.top-bar-info-label{font-size:.82rem;font-weight:800;color:#1E293B;text-transform:uppercase;letter-spacing:.4px;white-space:nowrap}
.top-bar-info-value{font-size:.85rem;color:#64748B;font-weight:500;white-space:nowrap}
.top-bar-info-value a{color:#64748B;text-decoration:none;transition:.3s}
.top-bar-info-value a:hover{color:#2563EB}

/* Social icons */
.top-bar-right{display:flex;align-items:center;gap:8px;padding-left:32px;border-left:1.5px solid #E2E8F0}
.top-bar-social{display:flex;gap:8px}
.top-bar-social a{width:38px;height:38px;border-radius:50%;display:flex;align-items:center;justify-content:center;color:#64748B;font-size:.9rem;transition:all .3s;border:1.5px solid #E2E8F0}
.top-bar-social a:hover.yt{color:#fff;background:#FF0000;border-color:#FF0000}
.top-bar-social a:hover.fb{color:#fff;background:#1877F2;border-color:#1877F2}
.top-bar-social a:hover.ig{color:#fff;background:linear-gradient(45deg,#f09433,#e6683c,#dc2743,#cc2366,#bc1888);border-color:#dc2743}
.top-bar-social a:hover.tt{color:#fff;background:#000;border-color:#000}
.top-bar-social a:hover{transform:translateY(-3px);box-shadow:0 4px 12px rgba(0,0,0,.15)}

/* ═══ NAVIGATION BAR — WHITE ═══ */
.hdr-nav{position:fixed;top:90px;left:0;right:0;z-index:1999;background:#fff;padding:0 40px;transition:all .3s ease;box-shadow:0 2px 12px rgba(0,0,0,.06);border-bottom:1px solid #E2E8F0}
.hdr-nav-inner{max-width:1400px;margin:0 auto;height:56px;display:flex;align-items:center;justify-content:space-between}

.nav-links{display:flex;align-items:center;gap:4px;list-style:none;margin:0;padding:0}
.nav-links li a{color:#475569;text-decoration:none;font-weight:600;font-size:.9rem;padding:12px 20px;border-radius:8px;transition:all .25s;display:flex;align-items:center;gap:7px}
.nav-links li a:hover,.nav-links li a.active{color:#2563EB;background:rgba(37,99,235,.06)}
.nav-links li a i{font-size:.7rem;color:#94A3B8}
.nav-links li a:hover i,.nav-links li a.active i{color:#2563EB}

/* Search box in nav — White style */
.nav-search{display:flex;align-items:center;background:#F8FAFC;border-radius:8px;padding:0 14px;height:40px;min-width:240px;border:1.5px solid #E2E8F0;transition:all .3s}
.nav-search:focus-within{background:#fff;border-color:#2563EB;box-shadow:0 0 0 3px rgba(37,99,235,.1)}
.nav-search input{background:none;border:none;outline:none;color:#1E293B;font-size:.85rem;font-weight:500;width:100%;padding:0 8px}
.nav-search input::placeholder{color:#94A3B8}
.nav-search-btn{background:none;border:none;color:#94A3B8;cursor:pointer;font-size:.9rem;padding:4px;transition:.3s}
.nav-search-btn:hover{color:#2563EB}

.hdr-actions{display:flex;align-items:center;gap:14px}
.btn-hdr-login{color:#475569;font-weight:700;font-size:.9rem;text-decoration:none;transition:.3s;padding:8px 16px;border-radius:8px}
.btn-hdr-login:hover{color:#2563EB;background:rgba(37,99,235,.06)}
.btn-hdr-register{background:linear-gradient(135deg,#2563EB,#3B82F6);color:#fff;text-decoration:none;font-weight:700;font-size:.88rem;padding:10px 24px;border-radius:8px;box-shadow:0 4px 14px rgba(37,99,235,.3);transition:all .3s;display:flex;align-items:center;gap:6px}
.btn-hdr-register:hover{transform:translateY(-2px);box-shadow:0 6px 20px rgba(37,99,235,.4)}
.logo{display:none}

.user-tag{display:flex;align-items:center;gap:10px;text-decoration:none;color:#1E293B;font-weight:700}
.avatar-circle{width:38px;height:38px;border-radius:50%;background:linear-gradient(135deg,#2563EB,#60A5FA);color:#fff;display:flex;align-items:center;justify-content:center;font-size:.9rem;font-weight:700;box-shadow:0 3px 10px rgba(37,99,235,.2);transition:.3s}
.avatar-circle:hover{transform:scale(1.08)}
.logout-link{color:#94A3B8;font-size:1rem;transition:.3s;text-decoration:none}
.logout-link:hover{color:#EF4444}
.admin-badge{background:#1E293B;color:#fff;padding:6px 16px;border-radius:8px;font-size:.72rem;font-weight:800;text-decoration:none;letter-spacing:.5px;transition:.3s}
.admin-badge:hover{background:#334155}
.cart-link{position:relative;color:#475569;font-size:1.1rem;transition:.3s;text-decoration:none}
.cart-link:hover{color:#2563EB}
.cart-badge{position:absolute;top:-6px;right:-8px;background:#EF4444;color:#fff;font-size:.6rem;font-weight:800;min-width:16px;height:16px;border-radius:50%;display:flex;align-items:center;justify-content:center;border:2px solid #fff}

/* Language Flags — 2 flags toggle */
.lang-flags{display:flex;align-items:center;gap:4px}
.lang-flag-btn{width:36px;height:28px;border-radius:6px;border:2px solid #E2E8F0;display:flex;align-items:center;justify-content:center;cursor:pointer;transition:all .25s;background:#F8FAFC;padding:2px;overflow:hidden}
.lang-flag-btn img{width:24px;height:16px;border-radius:2px;object-fit:cover}
.lang-flag-btn:hover{border-color:#94A3B8;transform:scale(1.08)}
.lang-flag-btn.active{border-color:#2563EB;box-shadow:0 0 0 2px rgba(37,99,235,.2);background:#EFF6FF}

body{padding-top:146px}

@media(max-width:1200px){
    .top-bar-info-item{padding:0 20px}
    .top-bar-info-label{font-size:.76rem}
    .top-bar-info-value{font-size:.78rem}
    .top-bar-info-icon{width:42px;height:42px;font-size:1rem}
    .nav-search{min-width:180px}
}
@media(max-width:992px){
    .top-bar-info{display:none}
    .top-bar-right{display:none}
    .nav-links{display:none}
    .nav-search{display:none}
    .hdr-nav-inner{justify-content:space-between}
    .logo{display:flex;font-family:'Playfair Display',serif;font-size:1.3rem;font-weight:800;color:#1E293B;text-decoration:none;align-items:center;gap:8px}
    .logo .ez{color:#2563EB}
}
@media(max-width:576px){
    .top-bar{display:none}
    body{padding-top:56px}
    .hdr-nav{top:0}
}
</style>

<!-- ═══ TOP BAR ═══ -->
<div class="top-bar">
    <div class="top-bar-inner">
        <!-- Brand Logo — Large -->
        <a href="${pageContext.request.contextPath}/" class="top-bar-brand">
            <div class="top-bar-logo-icon">
                <svg viewBox="0 0 56 56" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <rect x="2" y="2" width="52" height="52" rx="12" fill="#fff" stroke="#2563EB" stroke-width="2.5"/>
                    <path d="M28 12l-14 20h8v12h12V32h8L28 12z" fill="#2563EB" opacity=".15"/>
                    <path d="M20 28l8-12 8 12" stroke="#2563EB" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
                    <path d="M28 16v18" stroke="#2563EB" stroke-width="2" stroke-linecap="round"/>
                    <path d="M22 34h12" stroke="#1E293B" stroke-width="2" stroke-linecap="round"/>
                    <circle cx="28" cy="24" r="3" fill="#2563EB"/>
                    <rect x="14" y="44" width="28" height="3" rx="1.5" fill="#2563EB"/>
                </svg>
            </div>
            <div class="top-bar-brand-text">
                <span class="top-bar-brand-name"><span class="ez-highlight">ez</span>travel</span>
                <span class="top-bar-brand-slogan">Explore Da Nang</span>
            </div>
        </a>

        <!-- Info Blocks — Smooth 1-by-1 Slide -->
        <div class="top-bar-info" id="infoSlider">
            <div class="top-bar-info-track" id="infoTrack">
                <div class="top-bar-info-item">
                    <div class="top-bar-info-icon"><i class="fas fa-map-marker-alt"></i></div>
                    <div class="top-bar-info-content">
                        <span class="top-bar-info-label">Đại học FPT Đà Nẵng</span>
                        <span class="top-bar-info-value">Khu đô thị FPT City, Ngũ Hành Sơn</span>
                    </div>
                </div>
                <div class="top-bar-info-item">
                    <div class="top-bar-info-icon"><i class="fas fa-clock"></i></div>
                    <div class="top-bar-info-content">
                        <span class="top-bar-info-label">8:00AM - 10:00PM</span>
                        <span class="top-bar-info-value">Thứ Hai đến Chủ Nhật</span>
                    </div>
                </div>
                <div class="top-bar-info-item">
                    <div class="top-bar-info-icon"><i class="fas fa-envelope"></i></div>
                    <div class="top-bar-info-content">
                        <span class="top-bar-info-label">Online 24/7</span>
                        <span class="top-bar-info-value"><a href="mailto:eztravel@gmail.com">eztravel@gmail.com</a></span>
                    </div>
                </div>
                <div class="top-bar-info-item">
                    <div class="top-bar-info-icon"><i class="fas fa-phone-alt"></i></div>
                    <div class="top-bar-info-content">
                        <span class="top-bar-info-label">Hotline: 0335 111 783</span>
                        <span class="top-bar-info-value">Miễn phí cuộc gọi tư vấn</span>
                    </div>
                </div>
                <div class="top-bar-info-item">
                    <div class="top-bar-info-icon"><i class="fas fa-globe"></i></div>
                    <div class="top-bar-info-content">
                        <span class="top-bar-info-label">www.eztravel.site</span>
                        <span class="top-bar-info-value">Website chính thức</span>
                    </div>
                </div>
                <div class="top-bar-info-item">
                    <div class="top-bar-info-icon"><i class="fas fa-tag"></i></div>
                    <div class="top-bar-info-content">
                        <span class="top-bar-info-label">Giảm 20% Tour Hè 2026</span>
                        <span class="top-bar-info-value">Áp dụng đến 30/06/2026</span>
                    </div>
                </div>
                <div class="top-bar-info-item">
                    <div class="top-bar-info-icon"><i class="fas fa-shield-alt"></i></div>
                    <div class="top-bar-info-content">
                        <span class="top-bar-info-label">Cam kết hoàn tiền 100%</span>
                        <span class="top-bar-info-value">Nếu không hài lòng dịch vụ</span>
                    </div>
                </div>
                <div class="top-bar-info-item">
                    <div class="top-bar-info-icon"><i class="fas fa-star"></i></div>
                    <div class="top-bar-info-content">
                        <span class="top-bar-info-label">10,000+ Khách hàng</span>
                        <span class="top-bar-info-value">Đánh giá 4.9/5 sao</span>
                    </div>
                </div>
                <div class="top-bar-info-item">
                    <div class="top-bar-info-icon"><i class="fas fa-map-signs"></i></div>
                    <div class="top-bar-info-content">
                        <span class="top-bar-info-label">500+ Tour Đà Nẵng</span>
                        <span class="top-bar-info-value">Bà Nà, Hội An, Sơn Trà...</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Social Icons -->
        <div class="top-bar-right">
            <div class="top-bar-social">
                <a href="#" class="yt" title="YouTube"><i class="fab fa-youtube"></i></a>
                <a href="#" class="fb" title="Facebook"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="ig" title="Instagram"><i class="fab fa-instagram"></i></a>
                <a href="#" class="tt" title="TikTok"><i class="fab fa-tiktok"></i></a>
            </div>
        </div>
    </div>
</div>

<!-- ═══ NAVIGATION BAR — WHITE ═══ -->
<nav class="hdr-nav">
    <div class="hdr-nav-inner">
        <!-- Mobile logo -->
        <a href="${pageContext.request.contextPath}/" class="logo">
            <span><span class="ez">ez</span>travel</span>
        </a>

        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/" data-i18n="nav.home"><i class="fas fa-home"></i> Trang Chủ</a></li>
            <li><a href="${pageContext.request.contextPath}/tour" data-i18n="nav.explore"><i class="fas fa-compass"></i> Khám Phá</a></li>
            <li><a href="${pageContext.request.contextPath}/my-orders" data-i18n="nav.orders"><i class="fas fa-receipt"></i> Đơn Hàng</a></li>
            <li><a href="${pageContext.request.contextPath}/history" data-i18n="nav.history"><i class="fas fa-history"></i> Lịch Sử</a></li>
            <li><a href="${pageContext.request.contextPath}/provider" data-i18n="nav.provider"><i class="fas fa-handshake"></i> Nhà Cung Cấp</a></li>
        </ul>

        <div style="display:flex;align-items:center;gap:14px">
            <!-- Search box -->
            <form class="nav-search" action="${pageContext.request.contextPath}/tour" method="GET">
                <input type="text" name="search" placeholder="Tìm kiếm tour..." data-i18n="search.placeholder" autocomplete="off">
                <button type="submit" class="nav-search-btn"><i class="fas fa-search"></i></button>
            </form>

            <!-- Language Flags: VN / EN -->
            <div class="lang-flags" id="langFlags">
                <div class="lang-flag-btn active" onclick="I18N.setLang('vi')" title="Tiếng Việt">
                    <img src="https://flagcdn.com/w40/vn.png" alt="VN">
                </div>
                <div class="lang-flag-btn" onclick="I18N.setLang('en')" title="English">
                    <img src="https://flagcdn.com/w40/gb.png" alt="EN">
                </div>
            </div>

            <div class="hdr-actions">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <c:if test="${sessionScope.user.role.roleName == 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/admin/dashboard" class="admin-badge">
                                <i class="fas fa-bolt"></i> Admin
                            </a>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/cart" class="cart-link" title="Giỏ hàng">
                            <i class="fas fa-shopping-cart"></i>
                            <c:if test="${not empty sessionScope.cart}">
                                <span class="cart-badge">${sessionScope.cart.size()}</span>
                            </c:if>
                        </a>
                        <a href="${pageContext.request.contextPath}/profile" class="user-tag">
                            <div class="avatar-circle">
                                ${sessionScope.user.username.substring(0,1).toUpperCase()}
                            </div>
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" class="logout-link">
                            <i class="fas fa-sign-out-alt"></i>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn-hdr-login" data-i18n="nav.login">Đăng Nhập</a>
                        <a href="${pageContext.request.contextPath}/register.jsp" class="btn-hdr-register">
                            <span data-i18n="nav.register">Đăng Ký</span> <i class="fas fa-arrow-right"></i>
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<script src="${pageContext.request.contextPath}/js/i18n.js"></script>
<script>
// ═══ INFO SLIDER — Smooth 1-by-1 slide ═══
(function(){
    var track = document.getElementById('infoTrack');
    if (!track) return;
    var items = track.querySelectorAll('.top-bar-info-item');
    var totalItems = items.length; // 9
    var visibleCount = 3;
    var current = 0;
    var maxSlide = totalItems - visibleCount; // 6
    var interval;

    function slideTo(idx) {
        current = idx;
        var percent = (100 / 3) * current; // each item = 33.333%
        track.style.transform = 'translateX(-' + percent + '%)';
    }

    function next() {
        if (current >= maxSlide) {
            // Smooth reset: briefly disable transition, jump to 0
            track.style.transition = 'none';
            current = 0;
            track.style.transform = 'translateX(0)';
            // Force reflow then re-enable transition
            track.offsetHeight;
            track.style.transition = 'transform .7s cubic-bezier(.25,.46,.45,.94)';
        } else {
            current++;
            slideTo(current);
        }
    }

    // Auto slide every 3 seconds
    interval = setInterval(next, 3000);

    // Pause on hover
    var slider = document.getElementById('infoSlider');
    if (slider) {
        slider.addEventListener('mouseenter', function() { clearInterval(interval); });
        slider.addEventListener('mouseleave', function() { interval = setInterval(next, 3000); });
    }
})();
</script>
