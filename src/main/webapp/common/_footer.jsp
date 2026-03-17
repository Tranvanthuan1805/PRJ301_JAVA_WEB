<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
/* ═══ FOOTER — HALOVI STYLE (WHITE) ═══ */
.ez-footer{background:#fff;color:#475569;font-family:'Inter',system-ui,sans-serif;position:relative}
.ez-footer::before{content:'';position:absolute;top:0;left:0;right:0;height:1px;background:#E2E8F0}

/* Main Content */
.ft-main{max-width:1280px;margin:0 auto;padding:60px 30px 40px}
.ft-grid{display:grid;grid-template-columns:1.8fr 1fr 1fr 1fr;gap:50px;margin-bottom:40px}

/* Brand Column — Logo to */
.ft-brand-logo{margin-bottom:28px}
.ft-brand-logo-icon{display:flex;align-items:center;gap:4px;margin-bottom:8px}
.ft-brand-logo-icon svg{width:80px;height:80px}
.ft-brand-name{font-family:'Playfair Display',serif;font-size:2.8rem;font-weight:900;color:#1E293B;letter-spacing:-1px;line-height:1}
.ft-brand-name .ez{color:#2563EB}

.ft-brand-contact{display:flex;flex-direction:column;gap:10px;margin-top:6px}
.ft-brand-contact-item{display:flex;align-items:flex-start;gap:8px;font-size:.85rem;color:#64748B;line-height:1.5}
.ft-brand-contact-item i{color:#2563EB;font-size:.78rem;margin-top:3px;width:16px;text-align:center;flex-shrink:0}
.ft-brand-contact-item a{color:#2563EB;text-decoration:none;font-weight:600;transition:.3s}
.ft-brand-contact-item a:hover{color:#1D4ED8;text-decoration:underline}

/* Link Columns */
.ft-col h4{font-size:.92rem;font-weight:800;color:#1E293B;margin-bottom:20px;letter-spacing:.2px}
.ft-col ul{list-style:none;padding:0;margin:0}
.ft-col ul li{margin-bottom:12px}
.ft-col ul li a{color:#64748B;font-size:.85rem;text-decoration:none;transition:all .25s;display:inline-block}
.ft-col ul li a:hover{color:#2563EB;transform:translateX(3px)}

/* Bottom Bar */
.ft-divider{height:1px;background:#E2E8F0;margin:0}
.ft-bottom{max-width:1280px;margin:0 auto;padding:24px 30px;display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:16px}
.ft-copy{font-size:.82rem;color:#94A3B8;font-weight:500}
.ft-copy a{color:#2563EB;text-decoration:none;font-weight:700}
.ft-bottom-social{display:flex;gap:8px}
.ft-bottom-social a{width:36px;height:36px;border-radius:50%;border:1.5px solid #E2E8F0;display:flex;align-items:center;justify-content:center;color:#64748B;font-size:.85rem;transition:all .3s;text-decoration:none}
.ft-bottom-social a:hover.yt{color:#fff;background:#FF0000;border-color:#FF0000}
.ft-bottom-social a:hover.fb{color:#fff;background:#1877F2;border-color:#1877F2}
.ft-bottom-social a:hover.ig{color:#fff;background:linear-gradient(45deg,#f09433,#e6683c,#dc2743,#cc2366,#bc1888);border-color:#dc2743}
.ft-bottom-social a:hover.li{color:#fff;background:#0A66C2;border-color:#0A66C2}
.ft-bottom-social a:hover{transform:translateY(-3px);box-shadow:0 4px 12px rgba(0,0,0,.12)}

/* App Store Badges */
.ft-app-badges{display:flex;flex-direction:column;gap:10px;margin-top:8px}
.ft-app-badge{display:flex;align-items:center;gap:10px;padding:10px 20px;background:#1E293B;border-radius:10px;color:#fff;text-decoration:none;transition:all .3s;min-width:170px}
.ft-app-badge:hover{background:#334155;transform:translateY(-2px);box-shadow:0 4px 16px rgba(0,0,0,.15)}
.ft-app-badge i{font-size:1.4rem}
.ft-app-badge-text{display:flex;flex-direction:column}
.ft-app-badge-sub{font-size:.58rem;color:rgba(255,255,255,.6);font-weight:500;text-transform:uppercase;letter-spacing:.5px}
.ft-app-badge-name{font-size:.88rem;font-weight:700;line-height:1.1}

@media(max-width:992px){
    .ft-grid{grid-template-columns:1fr 1fr;gap:36px}
    .ft-brand-name{font-size:2.2rem}
}
@media(max-width:576px){
    .ft-grid{grid-template-columns:1fr}
    .ft-main{padding:40px 20px 30px}
    .ft-bottom{flex-direction:column;text-align:center;padding:20px}
    .ft-brand-name{font-size:2rem}
}
</style>

<footer class="ez-footer">
    <div class="ft-main">
        <div class="ft-grid">
            <!-- Brand Column -->
            <div class="ft-brand">
                <div class="ft-brand-logo">
                    <div class="ft-brand-name" style="font-size:2.6rem;margin-top:0"><span class="ez">ez</span>travel</div>
                </div>

                <div class="ft-brand-contact">
                    <div class="ft-brand-contact-item">
                        <i class="fas fa-map-marker-alt"></i>
                        <span>Đại học FPT Đà Nẵng,<br>Khu đô thị FPT City, Ngũ Hành Sơn</span>
                    </div>
                    <div class="ft-brand-contact-item">
                        <i class="fas fa-envelope"></i>
                        <a href="mailto:eztravel@gmail.com">eztravel@gmail.com</a>
                    </div>
                    <div class="ft-brand-contact-item">
                        <i class="fas fa-phone-alt"></i>
                        <a href="tel:0335111783">(0335) 111 783</a>
                    </div>
                    <div class="ft-brand-contact-item">
                        <i class="fas fa-globe"></i>
                        <a href="${pageContext.request.contextPath}/">www.eztravel.site</a>
                    </div>
                </div>
            </div>

            <!-- Tours Column -->
            <div class="ft-col">
                <h4>Dòng Tour</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/tour">Tất cả Tours</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour?categoryId=1">Tour Biển & Đảo</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour?categoryId=2">Tour Núi & Mạo hiểm</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour?categoryId=3">Tour Ẩm Thực</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour?categoryId=4">Tour Văn Hóa</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour">Tour Cao Cấp</a></li>
                </ul>
            </div>

            <!-- Dịch vụ Column -->
            <div class="ft-col">
                <h4>Dịch vụ</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/tour">Đặt Tour Online</a></li>
                    <li><a href="#">Vé máy bay</a></li>
                    <li><a href="#">Khách sạn</a></li>
                    <li><a href="${pageContext.request.contextPath}/provider">Nhà Cung Cấp</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour-compare">So Sánh Tour</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour-3d">Tour 3D Gallery</a></li>
                </ul>
            </div>

            <!-- Hỗ trợ Column + App Badges -->
            <div class="ft-col">
                <h4>Hỗ trợ</h4>
                <ul>
                    <li><a href="#">Help & FAQ</a></li>
                    <li><a href="${pageContext.request.contextPath}/my-orders">Đơn Hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/feedback">Feedback</a></li>
                    <li><a href="#">Liên hệ với chúng tôi</a></li>
                </ul>

                <div class="ft-app-badges">
                    <a href="#" class="ft-app-badge">
                        <i class="fab fa-google-play"></i>
                        <div class="ft-app-badge-text">
                            <span class="ft-app-badge-sub">Get it on</span>
                            <span class="ft-app-badge-name">Google Play</span>
                        </div>
                    </a>
                    <a href="#" class="ft-app-badge">
                        <i class="fab fa-apple"></i>
                        <div class="ft-app-badge-text">
                            <span class="ft-app-badge-sub">Download on the</span>
                            <span class="ft-app-badge-name">App Store</span>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bottom Divider -->
    <div class="ft-divider"></div>

    <!-- Bottom Bar -->
    <div class="ft-bottom">
        <div class="ft-copy">&copy; Phát triển bởi <a href="#">eztravel</a> 2026 — FPT University Đà Nẵng</div>
        <div class="ft-bottom-social">
            <a href="#" class="yt" title="YouTube"><i class="fab fa-youtube"></i></a>
            <a href="#" class="fb" title="Facebook"><i class="fab fa-facebook-f"></i></a>
            <a href="#" class="ig" title="Instagram"><i class="fab fa-instagram"></i></a>
            <a href="#" class="li" title="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
        </div>
    </div>
</footer>

<jsp:include page="/views/ai-chatbot/chatbot.jsp" />