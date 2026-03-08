<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
/* ═══ PREMIUM FOOTER ═══ */
.ez-footer{background:#0F172A;color:#CBD5E1;font-family:'Inter',system-ui,sans-serif;position:relative;overflow:hidden}
.ez-footer::before{content:'';position:absolute;top:0;left:0;right:0;height:4px;background:linear-gradient(90deg,#2563EB,#60A5FA,#3B82F6,#2563EB);background-size:300% 100%;animation:footerGlow 4s ease infinite}
@keyframes footerGlow{0%{background-position:0% 50%}50%{background-position:100% 50%}100%{background-position:0% 50%}}

.ft-main{max-width:1200px;margin:0 auto;padding:56px 24px 0}
.ft-grid{display:grid;grid-template-columns:1.6fr 1fr 1fr 1.3fr;gap:40px;margin-bottom:48px}


/* Brand Column */
.ft-brand h3{font-size:1.35rem;font-weight:800;color:#fff;margin-bottom:6px;display:flex;align-items:center;gap:8px}
.ft-brand h3 img{height:32px;width:auto;border-radius:4px}
.ft-brand h3 .ez{color:#3B82F6}
.ft-verified{display:inline-flex;align-items:center;gap:5px;font-size:.7rem;font-weight:700;color:#10B981;background:rgba(16,185,129,.1);padding:3px 10px;border-radius:99px;margin-bottom:14px}
.ft-verified i{font-size:.65rem}
.ft-brand>p{font-size:.82rem;color:#64748B;line-height:1.7;max-width:280px;margin-bottom:18px}

.ft-contact-item{display:flex;align-items:center;gap:8px;font-size:.82rem;color:#94A3B8;margin-bottom:8px}
.ft-contact-item i{color:#3B82F6;font-size:.78rem;width:16px;text-align:center}
.ft-contact-item a{color:#94A3B8;text-decoration:none;transition:.3s}
.ft-contact-item a:hover{color:#60A5FA}

.ft-social{display:flex;gap:8px;margin-top:16px}
.ft-social a{width:34px;height:34px;border-radius:8px;background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);display:flex;align-items:center;justify-content:center;color:#64748B;font-size:.82rem;transition:all .3s;text-decoration:none}
.ft-social a:hover{background:#2563EB;color:#fff;border-color:#2563EB;transform:translateY(-2px)}

.ft-hotline{display:inline-flex;align-items:center;gap:8px;background:linear-gradient(135deg,#2563EB,#3B82F6);color:#fff;padding:8px 18px;border-radius:10px;font-size:.82rem;font-weight:700;margin-top:14px;text-decoration:none;box-shadow:0 4px 14px rgba(37,99,235,.25);transition:.3s}
.ft-hotline:hover{transform:translateY(-2px);box-shadow:0 6px 20px rgba(37,99,235,.4)}
.ft-hotline i{font-size:.9rem}

/* Link Columns */
.ft-col h4{font-size:.85rem;font-weight:700;color:#fff;margin-bottom:18px;letter-spacing:.3px}
.ft-col ul{list-style:none;padding:0;margin:0}
.ft-col ul li{margin-bottom:10px}
.ft-col ul li a{color:#64748B;font-size:.82rem;text-decoration:none;transition:.3s;display:flex;align-items:center;gap:6px}
.ft-col ul li a:hover{color:#60A5FA;padding-left:4px}
.ft-col ul li a i{font-size:.55rem;color:#3B82F6;opacity:0;transition:.3s}
.ft-col ul li a:hover i{opacity:1}

/* Certifications & Payment */
.ft-certs{border-top:1px solid rgba(255,255,255,.06);padding:32px 0;margin-top:8px}
.ft-certs-inner{max-width:1200px;margin:0 auto;padding:0 24px}
.ft-certs-grid{display:grid;grid-template-columns:1fr 1fr 1.5fr;gap:36px;align-items:start}

.ft-cert-title{font-size:.78rem;font-weight:700;color:#94A3B8;margin-bottom:14px;letter-spacing:.3px}
.ft-cert-badges{display:flex;flex-wrap:wrap;gap:10px;align-items:center}
.ft-cert-badge{background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.08);border-radius:8px;padding:8px 14px;display:flex;align-items:center;gap:8px;font-size:.72rem;font-weight:700;color:#94A3B8;transition:.3s}
.ft-cert-badge:hover{border-color:rgba(59,130,246,.3);background:rgba(59,130,246,.06)}
.ft-cert-badge img{height:20px;width:auto}
.ft-cert-badge i{font-size:1rem}
.ft-cert-badge.govt{border-color:rgba(16,185,129,.2);color:#10B981}
.ft-cert-badge.govt i{color:#10B981}
.ft-cert-badge.dmca{border-color:rgba(239,68,68,.2);color:#F87171}

.ft-payment-logos{display:flex;flex-wrap:wrap;gap:8px;align-items:center}
.ft-pay-logo{background:rgba(255,255,255,.08);border:1px solid rgba(255,255,255,.06);border-radius:6px;padding:6px 12px;font-size:.68rem;font-weight:800;color:#CBD5E1;display:flex;align-items:center;gap:4px;letter-spacing:.3px;transition:.3s;height:34px}
.ft-pay-logo:hover{background:rgba(255,255,255,.12);border-color:rgba(255,255,255,.15)}
.ft-pay-logo.visa{color:#1A1F71;background:rgba(26,31,113,.1);border-color:rgba(26,31,113,.2)}
.ft-pay-logo.mc{color:#EB001B;background:rgba(235,0,27,.08);border-color:rgba(235,0,27,.15)}
.ft-pay-logo.jcb{color:#0E4C96;background:rgba(14,76,150,.1);border-color:rgba(14,76,150,.2)}
.ft-pay-logo.momo{color:#A50064;background:rgba(165,0,100,.08);border-color:rgba(165,0,100,.2)}
.ft-pay-logo.vnpay{color:#00427A;background:rgba(0,66,122,.1);border-color:rgba(0,66,122,.2)}
.ft-pay-logo.spay{color:#EE4D2D;background:rgba(238,77,45,.08);border-color:rgba(238,77,45,.15)}

/* Bottom Bar */
.ft-bottom{border-top:1px solid rgba(255,255,255,.06);padding:20px 0}
.ft-bottom-inner{max-width:1200px;margin:0 auto;padding:0 24px;display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:10px}
.ft-copy{font-size:.72rem;color:#475569}
.ft-copy a{color:#60A5FA;text-decoration:none}
.ft-made{font-size:.72rem;color:#475569}

@media(max-width:992px){.ft-grid{grid-template-columns:1fr 1fr;gap:32px}.ft-certs-grid{grid-template-columns:1fr}}
@media(max-width:576px){.ft-grid{grid-template-columns:1fr}}
</style>

<footer class="ez-footer">
    <div class="ft-main">
        <div class="ft-grid">
            <!-- Brand & Contact -->
            <div class="ft-brand">
                <h3>
                    <img src="${pageContext.request.contextPath}/images/logo.png" alt="logo" onerror="this.style.display='none'">
                    <span><span class="ez">ez</span>travel</span>
                </h3>
                <div class="ft-verified"><i class="fas fa-check-circle"></i> Verified Business</div>
                <p>Nền tảng đặt tour du lịch Đà Nẵng uy tín hàng đầu. Trải nghiệm đặt tour thông minh với AI hỗ trợ 24/7.</p>

                <div class="ft-contact-item"><i class="fas fa-map-marker-alt"></i> ĐH FPT Đà Nẵng, Ngũ Hành Sơn, Việt Nam</div>
                <div class="ft-contact-item"><i class="fas fa-envelope"></i> <a href="mailto:contact@eztravel.vn">contact@eztravel.vn</a></div>
                <div class="ft-contact-item"><i class="fas fa-clock"></i> T2 - CN: 8:00 - 22:00</div>

                <div class="ft-social">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                    <a href="#"><i class="fab fa-tiktok"></i></a>
                    <a href="#"><i class="fab fa-github"></i></a>
                </div>

                <a href="tel:0335111783" class="ft-hotline"><i class="fas fa-phone-alt"></i> 0335 111 783</a>
                <div style="font-size:.7rem;color:#475569;margin-top:6px">Từ 8:00 - 22:00 hàng ngày</div>
            </div>

            <!-- Tours Column -->
            <div class="ft-col">
                <h4><i class="fas fa-compass" style="color:#3B82F6;margin-right:6px;font-size:.78rem"></i> Dòng Tour</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/tour"><i class="fas fa-chevron-right"></i> Tất cả Tours</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour?categoryId=1"><i class="fas fa-chevron-right"></i> Tour Biển & Đảo</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour?categoryId=2"><i class="fas fa-chevron-right"></i> Tour Núi & Mạo hiểm</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour?categoryId=3"><i class="fas fa-chevron-right"></i> Tour Ẩm Thực</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour?categoryId=4"><i class="fas fa-chevron-right"></i> Tour Văn Hóa</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour"><i class="fas fa-chevron-right"></i> Tour Cao Cấp</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour"><i class="fas fa-chevron-right"></i> Tour Tiết Kiệm</a></li>
                </ul>
            </div>

            <!-- Account Column -->
            <div class="ft-col">
                <h4><i class="fas fa-user-circle" style="color:#3B82F6;margin-right:6px;font-size:.78rem"></i> Tài Khoản</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/profile"><i class="fas fa-chevron-right"></i> Hồ Sơ Cá Nhân</a></li>
                    <li><a href="${pageContext.request.contextPath}/my-orders"><i class="fas fa-chevron-right"></i> Đơn Hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/wishlist"><i class="fas fa-chevron-right"></i> <i class="fas fa-heart" style="color:#FF6F61;font-size:.6rem"></i> Yêu Thích</a></li>
                    <li><a href="${pageContext.request.contextPath}/feedback"><i class="fas fa-chevron-right"></i> Feedback Tour</a></li>
                    <li><a href="${pageContext.request.contextPath}/history"><i class="fas fa-chevron-right"></i> Lịch Sử</a></li>
                    <li><a href="${pageContext.request.contextPath}/provider"><i class="fas fa-chevron-right"></i> Nhà Cung Cấp</a></li>
                </ul>

                <h4 style="margin-top:24px"><i class="fas fa-info-circle" style="color:#3B82F6;margin-right:6px;font-size:.78rem"></i> Khám Phá</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/tour-compare"><i class="fas fa-chevron-right"></i> So Sánh Tour</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour-3d"><i class="fas fa-chevron-right"></i> Tour 3D Gallery</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i> Trợ giúp</a></li>
                </ul>
            </div>

            <!-- Booking Lookup -->
            <div class="ft-col">
                <h4><i class="fas fa-search" style="color:#3B82F6;margin-right:6px;font-size:.78rem"></i> Tra Cứu Booking</h4>
                <form action="${pageContext.request.contextPath}/my-orders" method="get" style="margin-bottom:20px">
                    <div style="display:flex;gap:6px">
                        <input type="text" name="code" placeholder="Nhập mã booking của quý khách" style="flex:1;padding:10px 14px;border-radius:8px;border:1px solid rgba(255,255,255,.1);background:rgba(255,255,255,.04);color:#CBD5E1;font-size:.82rem;outline:none;font-family:inherit;transition:.3s" onfocus="this.style.borderColor='#3B82F6'" onblur="this.style.borderColor='rgba(255,255,255,.1)'">
                        <button type="submit" style="padding:10px 16px;background:#2563EB;color:#fff;border:none;border-radius:8px;font-weight:700;font-size:.78rem;cursor:pointer;font-family:inherit;white-space:nowrap;transition:.3s" onmouseover="this.style.background='#3B82F6'" onmouseout="this.style.background='#2563EB'"><i class="fas fa-search"></i></button>
                    </div>
                </form>

                <h4><i class="fas fa-mobile-alt" style="color:#3B82F6;margin-right:6px;font-size:.78rem"></i> Dịch Vụ</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/tour"><i class="fas fa-chevron-right"></i> Đặt Tour Online</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i> Vé máy bay</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i> Khách sạn</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i> Combo du lịch</a></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Certifications & Payment -->
    <div class="ft-certs">
        <div class="ft-certs-inner">
            <!-- Row 1: Chứng nhận + Thương hiệu ngang -->
            <div style="display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:20px;margin-bottom:24px">
                <div style="display:flex;align-items:center;gap:8px;flex-wrap:wrap">
                    <span class="ft-cert-title" style="margin:0;white-space:nowrap">CHỨNG NHẬN</span>
                    <a href="http://online.gov.vn/" target="_blank" rel="noopener" class="ft-cert-img-badge" style="background:rgba(16,185,129,.06);border-color:rgba(16,185,129,.2)">
                        <img src="${pageContext.request.contextPath}/images/logos/bo-cong-thuong.png" alt="Đã thông báo Bộ Công Thương" class="ft-cert-img">
                    </a>
                    <a href="https://www.dmca.com/" target="_blank" rel="noopener" class="ft-cert-img-badge" style="background:rgba(248,113,113,.04);border-color:rgba(248,113,113,.15)">
                        <img src="${pageContext.request.contextPath}/images/logos/dmca-protected.png" alt="DMCA Protected" class="ft-cert-img">
                    </a>
                    <div class="ft-cert-img-badge" style="background:rgba(59,130,246,.05);border-color:rgba(59,130,246,.15)">
                        <img src="${pageContext.request.contextPath}/images/logos/ssl-secured.png" alt="SSL Secured" class="ft-cert-img">
                    </div>
                </div>
                <!-- Thương hiệu -->
                <div style="display:flex;align-items:center;gap:12px;padding:10px 20px;background:rgba(37,99,235,.06);border:1px solid rgba(37,99,235,.15);border-radius:12px">
                    <div style="width:40px;height:40px;background:linear-gradient(135deg,#2563EB,#60A5FA);border-radius:10px;display:flex;align-items:center;justify-content:center;position:relative;flex-shrink:0">
                        <span style="color:#fff;font-size:1rem;font-weight:900">ez</span>
                        <div style="position:absolute;bottom:-2px;right:-2px;width:14px;height:14px;background:#10B981;border-radius:50%;border:2px solid #0F172A;display:flex;align-items:center;justify-content:center">
                            <i class="fas fa-check" style="color:#fff;font-size:.4rem"></i>
                        </div>
                    </div>
                    <div>
                        <div style="font-size:.82rem;font-weight:800;color:#fff">eztravel <i class="fas fa-check-circle" style="color:#3B82F6;font-size:.65rem"></i></div>
                        <div style="font-size:.65rem;color:#64748B">Official Verified Partner · Đà Nẵng</div>
                    </div>
                </div>
            </div>

            <!-- Row 2: Thanh toán full width -->
            <div style="display:flex;align-items:center;gap:12px;flex-wrap:wrap">
                <span class="ft-cert-title" style="margin:0;white-space:nowrap">CHẤP NHẬN THANH TOÁN</span>
                <div class="ft-payment-logos ft-pay-real" style="flex:1">
                    <div class="ft-pay-img-card"><img src="${pageContext.request.contextPath}/images/logos/visa.png" alt="VISA"></div>
                    <div class="ft-pay-img-card"><img src="${pageContext.request.contextPath}/images/logos/mastercard.png" alt="MasterCard"></div>
                    <div class="ft-pay-img-card"><img src="${pageContext.request.contextPath}/images/logos/jcb.png" alt="JCB"></div>
                    <div class="ft-pay-img-card"><img src="${pageContext.request.contextPath}/images/logos/vnpay.png" alt="VNPAY"></div>
                    <div class="ft-pay-img-card"><img src="${pageContext.request.contextPath}/images/logos/shopeepay.png" alt="ShopeePay"></div>
                    <div class="ft-pay-img-card"><img src="${pageContext.request.contextPath}/images/logos/msb.png" alt="MSB"></div>
                    <div class="ft-pay-img-card"><img src="${pageContext.request.contextPath}/images/logos/123pay.png" alt="123pay"></div>
                    <div class="ft-pay-img-card"><img src="${pageContext.request.contextPath}/images/logos/momo.png" alt="MoMo"></div>
                </div>
            </div>
        </div>
    </div>

    <style>
    .ft-cert-img-badge{display:flex;align-items:center;justify-content:center;padding:8px 14px;border:1px solid;border-radius:10px;text-decoration:none;transition:all .3s}
    .ft-cert-img-badge:hover{transform:translateY(-2px);box-shadow:0 4px 12px rgba(0,0,0,.15)}
    .ft-cert-img{height:40px;max-width:140px;object-fit:contain;border-radius:4px}
    .ft-pay-real{gap:8px!important}
    .ft-pay-img-card{background:#fff;border-radius:8px;padding:5px 8px;display:flex;align-items:center;justify-content:center;transition:all .3s;box-shadow:0 1px 3px rgba(0,0,0,.06)}
    .ft-pay-img-card:hover{transform:translateY(-2px);box-shadow:0 4px 12px rgba(0,0,0,.12)}
    .ft-pay-img-card img{height:26px;max-width:64px;object-fit:contain}
    </style>



    <!-- Bottom Bar -->
    <div class="ft-bottom">
        <div class="ft-bottom-inner">
            <div class="ft-copy">&copy; 2026 <a href="#">eztravel</a> — PRJ301 FPT University Đà Nẵng. All rights reserved.</div>
            <div class="ft-made">Thiết kế bởi <span style="color:#3B82F6;font-weight:700">Team eztravel</span> với ❤️ tại Đà Nẵng</div>
        </div>
    </div>
</footer>


<jsp:include page="/views/ai-chatbot/chatbot.jsp" />