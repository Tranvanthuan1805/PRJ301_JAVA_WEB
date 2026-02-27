<%@ page contentType="text/html;charset=UTF-8" language="java" %>
</main>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="footer-content">
            <div class="footer-brand">
                <div style="display:flex;align-items:center;gap:10px;margin-bottom:12px;">
                    <i class="fas fa-plane-departure" style="font-size:22px;color:#67e8f9;"></i>
                    <span style="font-size:20px;font-weight:700;color:#fff;">VietAir</span>
                </div>
                <p>Hệ thống quản lý tour du lịch Đà Nẵng với dữ liệu lịch sử 2020-2025. Đồng hành cùng bạn khám phá vẻ đẹp miền Trung.</p>
            </div>
            <div class="footer-section">
                <h4>Liên hệ</h4>
                <ul>
                    <li><i class="fas fa-phone"></i> 1900 1234</li>
                    <li><i class="fas fa-envelope"></i> support@vietair.vn</li>
                    <li><i class="fas fa-map-marker-alt"></i> Đà Nẵng, Việt Nam</li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2026 VietAir. All rights reserved.</p>
        </div>
    </div>
</footer>

<!-- AI Chatbot -->
<jsp:include page="/views/ai-chatbot/chatbot.jsp" />

<!-- Hamburger Menu Script -->
<script>
    const navToggle = document.getElementById('navToggle');
    const navMenu = document.getElementById('navMenu');
    if (navToggle && navMenu) {
        navToggle.addEventListener('click', function() {
            navMenu.classList.toggle('active');
            this.classList.toggle('active');
        });
    }
</script>
</body>
</html>
