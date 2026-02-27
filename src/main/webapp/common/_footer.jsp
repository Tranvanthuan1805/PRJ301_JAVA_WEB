<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer style="background: #1B1F3B; color: white; padding: 80px 0 30px; position: relative; overflow: hidden;">
    <!-- Decorative orbs -->
    <div style="position:absolute;width:400px;height:400px;background:radial-gradient(circle,rgba(255,111,97,0.06),transparent 60%);top:-200px;right:-100px;border-radius:50%;"></div>
    <div style="position:absolute;width:300px;height:300px;background:radial-gradient(circle,rgba(0,180,216,0.05),transparent 60%);bottom:-150px;left:-50px;border-radius:50%;"></div>

    <div class="container" style="position:relative;z-index:1;">
        <div style="display: grid; grid-template-columns: 1.5fr 1fr 1fr 1fr; gap: 50px; margin-bottom: 50px;">
            <!-- Brand -->
            <div>
                <h3 style="font-size: 1.5rem; margin-bottom: 18px; font-weight: 800;">
                    <span style="color: #FF6F61;">🏖️</span> DN HUB
                </h3>
                <p style="color: rgba(255,255,255,0.45); font-size: 0.88rem; line-height: 1.8; max-width: 280px;">
                    Nền tảng đặt tour du lịch Đà Nẵng hàng đầu. Tours xác minh bởi đối tác uy tín, AI dự báo doanh thu.
                </p>
                <div style="display: flex; gap: 12px; margin-top: 20px;">
                    <a href="#" style="width:38px;height:38px;border-radius:10px;background:rgba(255,255,255,0.06);border:1px solid rgba(255,255,255,0.08);display:flex;align-items:center;justify-content:center;color:rgba(255,255,255,0.5);transition:0.3s;font-size:0.9rem;">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="#" style="width:38px;height:38px;border-radius:10px;background:rgba(255,255,255,0.06);border:1px solid rgba(255,255,255,0.08);display:flex;align-items:center;justify-content:center;color:rgba(255,255,255,0.5);transition:0.3s;font-size:0.9rem;">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a href="#" style="width:38px;height:38px;border-radius:10px;background:rgba(255,255,255,0.06);border:1px solid rgba(255,255,255,0.08);display:flex;align-items:center;justify-content:center;color:rgba(255,255,255,0.5);transition:0.3s;font-size:0.9rem;">
                        <i class="fab fa-github"></i>
                    </a>
                </div>
            </div>

            <!-- Tours -->
            <div>
                <h4 style="margin-bottom: 20px; font-size: 0.92rem; font-weight: 700;">Tours</h4>
                <ul style="list-style: none; display: grid; gap: 12px;">
                    <li><a href="${pageContext.request.contextPath}/tour" style="color: rgba(255,255,255,0.45); font-size: 0.88rem;">Tất cả Tours</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour?categoryId=1" style="color: rgba(255,255,255,0.45); font-size: 0.88rem;">Tour Biển</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour?categoryId=2" style="color: rgba(255,255,255,0.45); font-size: 0.88rem;">Tour Núi</a></li>
                    <li><a href="${pageContext.request.contextPath}/tour?categoryId=3" style="color: rgba(255,255,255,0.45); font-size: 0.88rem;">Tour Ẩm Thực</a></li>
                </ul>
            </div>

            <!-- Tài khoản -->
            <div>
                <h4 style="margin-bottom: 20px; font-size: 0.92rem; font-weight: 700;">Tài Khoản</h4>
                <ul style="list-style: none; display: grid; gap: 12px;">
                    <li><a href="${pageContext.request.contextPath}/profile" style="color: rgba(255,255,255,0.45); font-size: 0.88rem;">Hồ Sơ</a></li>
                    <li><a href="${pageContext.request.contextPath}/my-orders" style="color: rgba(255,255,255,0.45); font-size: 0.88rem;">Đơn Hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/pricing" style="color: rgba(255,255,255,0.45); font-size: 0.88rem;">Gói VIP</a></li>
                    <li><a href="${pageContext.request.contextPath}/history" style="color: rgba(255,255,255,0.45); font-size: 0.88rem;">Lịch Sử</a></li>
                </ul>
            </div>

            <!-- Liên hệ -->
            <div>
                <h4 style="margin-bottom: 20px; font-size: 0.92rem; font-weight: 700;">Liên Hệ</h4>
                <div style="display:grid;gap:14px;">
                    <p style="color: rgba(255,255,255,0.45); font-size: 0.85rem; display: flex; align-items: flex-start; gap: 10px;">
                        <i class="fas fa-map-marker-alt" style="color: #FF6F61; margin-top: 3px;"></i>
                        ĐH FPT Đà Nẵng, Ngũ Hành Sơn
                    </p>
                    <p style="color: rgba(255,255,255,0.45); font-size: 0.85rem; display: flex; align-items: center; gap: 10px;">
                        <i class="fas fa-phone" style="color: #FF6F61;"></i>
                        +84 123 456 789
                    </p>
                    <p style="color: rgba(255,255,255,0.45); font-size: 0.85rem; display: flex; align-items: center; gap: 10px;">
                        <i class="fas fa-envelope" style="color: #FF6F61;"></i>
                        contact@dananghub.vn
                    </p>
                </div>
            </div>
        </div>

        <hr style="border: 0; border-top: 1px solid rgba(255,255,255,0.06); margin-bottom: 25px;">
        <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 10px;">
            <div style="color: rgba(255,255,255,0.3); font-size: 0.78rem;">
                &copy; 2026 Da Nang Travel Hub — PRJ301 FPT University
            </div>
            <div style="color: rgba(255,255,255,0.3); font-size: 0.78rem;">
                Made with ❤️ in Đà Nẵng
            </div>
        </div>
    </div>
</footer>
<jsp:include page="/views/ai-chatbot/chatbot.jsp" />
