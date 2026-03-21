<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Trở Thành Nhà Cung Cấp Tour | EZTravel</title>
            <link
                href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
            <style>
                * {
                    box-sizing: border-box
                }

                body {
                    font-family: 'Plus Jakarta Sans', system-ui, sans-serif;
                    background: #F4F5FA;
                    color: #1B1F3B
                }

                /* HERO */
                .pv-hero {
                    margin-top: 64px;
                    background: linear-gradient(135deg, #0F172A 0%, #1E293B 50%, #334155 100%);
                    padding: 80px 0 120px;
                    position: relative;
                    overflow: hidden;
                    text-align: center
                }

                .pv-hero::before {
                    content: '';
                    position: absolute;
                    width: 700px;
                    height: 700px;
                    background: radial-gradient(circle, rgba(59, 130, 246, .12), transparent 65%);
                    top: -300px;
                    right: -150px;
                    border-radius: 50%
                }

                .pv-hero::after {
                    content: '';
                    position: absolute;
                    width: 500px;
                    height: 500px;
                    background: radial-gradient(circle, rgba(255, 111, 97, .08), transparent 65%);
                    bottom: -250px;
                    left: -100px;
                    border-radius: 50%
                }

                .pv-hero h1 {
                    font-size: 2.8rem;
                    font-weight: 900;
                    color: #fff;
                    letter-spacing: -1px;
                    max-width: 700px;
                    margin: 0 auto 16px;
                    line-height: 1.2;
                    position: relative;
                    z-index: 2
                }

                .pv-hero h1 .accent {
                    background: linear-gradient(135deg, #3B82F6, #60A5FA);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent
                }

                .pv-hero p {
                    color: rgba(255, 255, 255, .55);
                    font-size: 1.1rem;
                    max-width: 550px;
                    margin: 0 auto 32px;
                    line-height: 1.7;
                    position: relative;
                    z-index: 2
                }

                .hero-stats {
                    display: flex;
                    justify-content: center;
                    gap: 48px;
                    position: relative;
                    z-index: 2
                }

                .hero-stat {
                    text-align: center
                }

                .hero-stat .val {
                    font-size: 2rem;
                    font-weight: 900;
                    color: #fff;
                    letter-spacing: -1px
                }

                .hero-stat .lbl {
                    font-size: .78rem;
                    color: rgba(255, 255, 255, .4);
                    font-weight: 600;
                    margin-top: 2px
                }

                /* FEATURES */
                .pv-features {
                    max-width: 1100px;
                    margin: -60px auto 60px;
                    padding: 0 30px;
                    display: grid;
                    grid-template-columns: repeat(3, 1fr);
                    gap: 20px;
                    position: relative;
                    z-index: 10
                }

                .feat-card {
                    background: #fff;
                    border-radius: 20px;
                    padding: 32px 28px;
                    box-shadow: 0 8px 30px rgba(0, 0, 0, .05);
                    border: 1px solid #E8EAF0;
                    transition: .3s;
                    text-align: center
                }

                .feat-card:hover {
                    transform: translateY(-4px);
                    box-shadow: 0 12px 40px rgba(0, 0, 0, .08)
                }

                .feat-icon {
                    width: 60px;
                    height: 60px;
                    border-radius: 16px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 1.4rem;
                    margin: 0 auto 18px
                }

                .feat-card:nth-child(1) .feat-icon {
                    background: rgba(59, 130, 246, .08);
                    color: #3B82F6
                }

                .feat-card:nth-child(2) .feat-icon {
                    background: rgba(5, 150, 105, .08);
                    color: #059669
                }

                .feat-card:nth-child(3) .feat-icon {
                    background: rgba(255, 111, 97, .08);
                    color: #FF6F61
                }

                .feat-card h3 {
                    font-size: 1.05rem;
                    font-weight: 800;
                    margin-bottom: 8px
                }

                .feat-card p {
                    font-size: .85rem;
                    color: #6B7194;
                    line-height: 1.7
                }

                /* HOW IT WORKS */
                .how-section {
                    max-width: 900px;
                    margin: 0 auto 60px;
                    padding: 0 30px
                }

                .how-section h2 {
                    text-align: center;
                    font-size: 1.8rem;
                    font-weight: 900;
                    margin-bottom: 40px;
                    letter-spacing: -.5px
                }

                .how-steps {
                    display: grid;
                    grid-template-columns: repeat(4, 1fr);
                    gap: 24px
                }

                .how-step {
                    text-align: center;
                    position: relative
                }

                .how-step::after {
                    content: '→';
                    position: absolute;
                    right: -18px;
                    top: 20px;
                    font-size: 1.5rem;
                    color: #CBD5E1;
                    font-weight: 800
                }

                .how-step.active .how-num {
                    background: linear-gradient(135deg, #3B82F6, #60A5FA);
                    box-shadow: 0 6px 20px rgba(59, 130, 246, .4);
                    transform: scale(1.15);
                    transition: all .4s ease
                }

                .how-step.active h4 {
                    color: #3B82F6
                }

                .how-step.active p {
                    color: #475569
                }

                .how-step:last-child::after {
                    display: none
                }

                .how-num {
                    width: 44px;
                    height: 44px;
                    background: linear-gradient(135deg, #1E293B, #334155);
                    color: #fff;
                    border-radius: 14px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-weight: 900;
                    font-size: 1rem;
                    margin: 0 auto 14px
                }

                .how-step h4 {
                    font-size: .92rem;
                    font-weight: 800;
                    margin-bottom: 4px
                }

                .how-step p {
                    font-size: .78rem;
                    color: #A0A5C3;
                    line-height: 1.6
                }

                /* REGISTER FORM */
                .register-section {
                    max-width: 700px;
                    margin: 0 auto 80px;
                    padding: 0 30px
                }

                .reg-card {
                    background: #fff;
                    border-radius: 24px;
                    box-shadow: 0 8px 40px rgba(0, 0, 0, .06);
                    border: 1px solid #E8EAF0;
                    overflow: hidden
                }

                .reg-head {
                    background: linear-gradient(135deg, #1E293B, #334155);
                    padding: 28px 36px;
                    color: #fff
                }

                .reg-head h2 {
                    font-size: 1.3rem;
                    font-weight: 900;
                    display: flex;
                    align-items: center;
                    gap: 10px
                }

                .reg-head h2 i {
                    color: #60A5FA
                }

                .reg-head p {
                    font-size: .82rem;
                    color: rgba(255, 255, 255, .5);
                    margin-top: 4px
                }

                .reg-body {
                    padding: 32px 36px
                }

                .field {
                    margin-bottom: 20px
                }

                .field label {
                    display: block;
                    font-size: .82rem;
                    font-weight: 700;
                    color: #4A4E6F;
                    margin-bottom: 8px
                }

                .field label i {
                    color: #3B82F6;
                    margin-right: 5px
                }

                .field input,
                .field select,
                .field textarea {
                    width: 100%;
                    padding: 14px 16px;
                    border: 2px solid #E8EAF0;
                    border-radius: 14px;
                    font-size: .92rem;
                    font-family: inherit;
                    font-weight: 600;
                    outline: none;
                    transition: .3s;
                    background: #FAFBFF;
                    color: #1B1F3B
                }

                .field input:focus,
                .field select:focus,
                .field textarea:focus {
                    border-color: #3B82F6;
                    background: #fff;
                    box-shadow: 0 0 0 3px rgba(59, 130, 246, .08)
                }

                .field textarea {
                    resize: vertical;
                    min-height: 100px
                }

                .btn-register {
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    gap: 10px;
                    width: 100%;
                    padding: 18px;
                    border-radius: 14px;
                    font-weight: 800;
                    font-size: 1rem;
                    border: none;
                    cursor: pointer;
                    font-family: inherit;
                    transition: .3s;
                    background: linear-gradient(135deg, #3B82F6, #60A5FA);
                    color: #fff;
                    box-shadow: 0 6px 20px rgba(59, 130, 246, .25);
                    letter-spacing: .3px
                }

                .btn-register:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 10px 30px rgba(59, 130, 246, .4)
                }

                /* PENDING STATE */
                .pending-card {
                    max-width: 600px;
                    margin: 0 auto 80px;
                    padding: 0 30px
                }

                .pending-box {
                    background: #fff;
                    border-radius: 24px;
                    padding: 48px 36px;
                    text-align: center;
                    box-shadow: 0 8px 30px rgba(0, 0, 0, .05);
                    border: 1px solid #E8EAF0
                }

                .pending-icon {
                    width: 80px;
                    height: 80px;
                    background: rgba(245, 158, 11, .08);
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 2.2rem;
                    margin: 0 auto 20px
                }

                .pending-box h3 {
                    font-size: 1.2rem;
                    font-weight: 800;
                    margin-bottom: 8px
                }

                .pending-box p {
                    color: #6B7194;
                    line-height: 1.7;
                    max-width: 400px;
                    margin: 0 auto
                }

                /* ALERT */
                .alert {
                    padding: 14px 20px;
                    border-radius: 14px;
                    margin-bottom: 20px;
                    font-size: .88rem;
                    font-weight: 600;
                    display: flex;
                    align-items: center;
                    gap: 8px
                }

                .alert-success {
                    background: #ECFDF5;
                    color: #059669;
                    border: 1px solid rgba(5, 150, 105, .15)
                }

                .alert-error {
                    background: #FEF2F2;
                    color: #DC2626;
                    border: 1px solid rgba(220, 38, 38, .15)
                }

                @media(max-width:768px) {
                    .pv-features {
                        grid-template-columns: 1fr
                    }

                    .how-steps {
                        grid-template-columns: repeat(2, 1fr)
                    }

                    .how-step::after {
                        display: none
                    }

                    .hero-stats {
                        gap: 24px
                    }

                    .pv-hero h1 {
                        font-size: 2rem
                    }
                }
            </style>
        </head>

        <body>
            <jsp:include page="/common/_header.jsp" />

            <!-- HERO -->
            <div class="pv-hero">
                <h1>Trở Thành <span class="accent">Nhà Cung Cấp</span> Tour Du Lịch</h1>
                <p>Đưa tour của bạn đến hàng ngàn khách hàng. Upload ảnh, mô tả và tạo trải nghiệm tour 3D ngay trên nền
                    tảng EZTravel.</p>
                <div class="hero-stats">
                    <div class="hero-stat">
                        <div class="val">500+</div>
                        <div class="lbl">Tours Hoạt Động</div>
                    </div>
                    <div class="hero-stat">
                        <div class="val">50K+</div>
                        <div class="lbl">Khách Hàng</div>
                    </div>
                    <div class="hero-stat">
                        <div class="val">100+</div>
                        <div class="lbl">Nhà Cung Cấp</div>
                    </div>
                </div>
            </div>

            <!-- FEATURES -->
            <div class="pv-features">
                <div class="feat-card">
                    <div class="feat-icon"><i class="fas fa-cloud-upload-alt"></i></div>
                    <h3>Upload Tour Dễ Dàng</h3>
                    <p>Tạo tour với ảnh, mô tả chi tiết, lịch trình. Mọi thứ đều online, nhanh chóng.</p>
                </div>
                <div class="feat-card">
                    <div class="feat-icon"><i class="fas fa-cube"></i></div>
                    <h3>Tour 3D Trải Nghiệm</h3>
                    <p>Upload ảnh panorama để tạo trải nghiệm tour 3D 360° cho khách hàng trước khi đặt.</p>
                </div>
                <div class="feat-card">
                    <div class="feat-icon"><i class="fas fa-chart-line"></i></div>
                    <h3>Quản Lý & Thống Kê</h3>
                    <p>Dashboard đầy đủ: theo dõi đơn hàng, doanh thu, đánh giá từ khách hàng.</p>
                </div>
            </div>

            <!-- HOW IT WORKS -->
            <div class="how-section">
                <h2>Cách Thức Hoạt Động</h2>
                <div class="how-steps">
                    <div class="how-step" id="step1">
                        <div class="how-num">1</div>
                        <h4>Đăng Ký</h4>
                        <p>Điền thông tin doanh nghiệp để đăng ký làm Nhà Cung Cấp</p>
                    </div>
                    <div class="how-step" id="step2">
                        <div class="how-num" id="step2Num">2</div>
                        <h4>Admin Duyệt</h4>
                        <p>Đội ngũ Admin xét duyệt hồ sơ trong 24h</p>
                    </div>
                    <div class="how-step" id="step3">
                        <div class="how-num">3</div>
                        <h4>Tạo Tour</h4>
                        <p>Upload tour với ảnh, video, trải nghiệm 3D</p>
                    </div>
                    <div class="how-step" id="step4">
                        <div class="how-num">4</div>
                        <h4>Nhận Đơn</h4>
                        <p>Tour được duyệt → hiển thị trên Khám Phá → nhận booking</p>
                    </div>
                </div>
            </div>

            <!-- ALERTS -->
            <div style="max-width:700px;margin:0 auto;padding:0 30px">
                <c:if test="${not empty sessionScope.success}">
                    <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${sessionScope.success}</div>
                    <c:remove var="success" scope="session" />
                </c:if>
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> ${sessionScope.error}</div>
                    <c:remove var="error" scope="session" />
                </c:if>
            </div>

            <!-- REGISTER or PENDING or LINK TO DASHBOARD -->
            <c:choose>
                <c:when test="${not empty provider && provider.status == 'Pending'}">
                    <div class="pending-card">
                        <div class="pending-box">
                            <div class="pending-icon">⏳</div>
                            <h3>Đang Chờ Duyệt</h3>
                            <p>Hồ sơ nhà cung cấp <strong>"${provider.businessName}"</strong> đã được gửi. Vui lòng chờ
                                Admin xét duyệt (thường trong vòng 24h).</p>
                        </div>
                    </div>
                </c:when>
                <c:when test="${not empty provider && provider.status == 'Approved'}">
                    <!-- Already approved → redirect handled in servlet -->
                </c:when>
                <c:otherwise>
                    <div class="register-section" id="registerForm">
                        <div class="reg-card">
                            <div class="reg-head">
                                <h2><i class="fas fa-store"></i> Đăng Ký Nhà Cung Cấp</h2>
                                <p>Điền thông tin bên dưới để bắt đầu</p>
                            </div>
                            <div class="reg-body">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user}">
                                        <form id="regForm" novalidate>
                                            <div class="field" id="f-businessName">
                                                <label><i class="fas fa-building"></i> Tên Doanh Nghiệp / Thương
                                                    Hiệu</label>
                                                <input type="text" id="businessName" name="businessName"
                                                    placeholder="VD: Đà Nẵng Adventure Tours" required>
                                                <div class="err"
                                                    style="font-size:.78rem;color:#dc2626;margin-top:5px;display:none">
                                                    Vui lòng nhập tên doanh nghiệp.</div>
                                            </div>
                                            <div class="field" id="f-providerType">
                                                <label><i class="fas fa-tag"></i> Loại Hình</label>
                                                <select id="providerType" name="providerType" required>
                                                    <option value="">Chọn loại hình</option>
                                                    <option value="Tour Operator">Công ty Lữ Hành</option>
                                                    <option value="Local Guide">Hướng Dẫn Viên Địa Phương</option>
                                                    <option value="Activity Provider">Nhà Cung Cấp Hoạt Động</option>
                                                    <option value="Hotel & Resort">Khách Sạn &amp; Resort</option>
                                                    <option value="Transport">Dịch Vụ Vận Chuyển</option>
                                                </select>
                                                <div class="err"
                                                    style="font-size:.78rem;color:#dc2626;margin-top:5px;display:none">
                                                    Vui lòng chọn loại hình.</div>
                                            </div>
                                            <div class="field" id="f-phone">
                                                <label><i class="fas fa-phone"></i> Số Điện Thoại Liên Hệ</label>
                                                <input type="tel" id="phone" name="phone"
                                                    value="${sessionScope.user.phoneNumber}" placeholder="0335 111 783"
                                                    required>
                                                <div class="err"
                                                    style="font-size:.78rem;color:#dc2626;margin-top:5px;display:none">
                                                    Số điện thoại không hợp lệ (VD: 0912345678).</div>
                                            </div>
                                            <div class="field">
                                                <label><i class="fas fa-pen"></i> Mô Tả Doanh Nghiệp</label>
                                                <textarea id="description" name="description"
                                                    placeholder="Giới thiệu ngắn về doanh nghiệp, kinh nghiệm, dịch vụ nổi bật..."
                                                    rows="4"></textarea>
                                            </div>
                                            <button type="button" class="btn-register" id="btnSubmit"
                                                onclick="submitProvider()">
                                                <span class="spinner-border spinner-border-sm" id="spinner"
                                                    style="display:none;width:16px;height:16px;border-width:2px;border-color:rgba(255,255,255,.4);border-top-color:#fff;border-radius:50%;animation:spin .7s linear infinite"></span>
                                                <i class="fas fa-paper-plane" id="btnIcon"></i>
                                                <span id="btnText">GỬI ĐĂNG KÝ</span>
                                            </button>
                                        </form>

                                        <!-- Toast -->
                                        <div id="pvToast"
                                            style="position:fixed;bottom:24px;right:24px;z-index:9999;padding:14px 20px;border-radius:12px;font-size:.9rem;font-weight:600;display:flex;align-items:center;gap:10px;min-width:300px;max-width:420px;box-shadow:0 8px 30px rgba(0,0,0,.15);opacity:0;transform:translateY(20px);transition:.35s;pointer-events:none">
                                        </div>

                                        <style>
                                            @keyframes spin {
                                                to {
                                                    transform: rotate(360deg)
                                                }
                                            }
                                        </style>
                                        <script>
                                            (function () {
                                                const ctx = '${pageContext.request.contextPath}';

                                                function setErr(fieldId, show) {
                                                    const f = document.getElementById(fieldId);
                                                    if (!f) return;
                                                    const err = f.querySelector('.err');
                                                    if (err) err.style.display = show ? 'block' : 'none';
                                                    const inp = f.querySelector('input,select,textarea');
                                                    if (inp) inp.style.borderColor = show ? '#dc2626' : '';
                                                }

                                                function validate() {
                                                    let ok = true;
                                                    const bn = document.getElementById('businessName').value.trim();
                                                    setErr('f-businessName', !bn); if (!bn) ok = false;
                                                    const pt = document.getElementById('providerType').value;
                                                    setErr('f-providerType', !pt); if (!pt) ok = false;
                                                    const ph = document.getElementById('phone').value.trim();
                                                    const phOk = /^(0|\+84)[0-9]{8,10}$/.test(ph);
                                                    setErr('f-phone', !phOk); if (!phOk) ok = false;
                                                    return ok;
                                                }

                                                window.submitProvider = async function () {
                                                    if (!validate()) return;

                                                    const btn = document.getElementById('btnSubmit');
                                                    const sp = document.getElementById('spinner');
                                                    const ic = document.getElementById('btnIcon');
                                                    const tx = document.getElementById('btnText');
                                                    btn.disabled = true;
                                                    sp.style.display = 'inline-block';
                                                    ic.style.display = 'none';
                                                    tx.textContent = 'Đang gửi...';

                                                    const payload = {
                                                        businessName: document.getElementById('businessName').value.trim(),
                                                        category: document.getElementById('providerType').value,
                                                        phone: document.getElementById('phone').value.trim(),
                                                        description: document.getElementById('description').value.trim()
                                                    };

                                                    try {
                                                        const res = await fetch(ctx + '/api/provider/register', {
                                                            method: 'POST',
                                                            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
                                                            body: JSON.stringify(payload)
                                                        });
                                                        const data = await res.json();
                                                        if (data.success) {
                                                            showToast('✅ ' + data.message, '#ECFDF5', '#065f46');
                                                            document.getElementById('regForm').reset();
                                                            // Highlight bước 2 rồi scroll đến đó
                                                            setTimeout(() => {
                                                                document.querySelectorAll('.how-step').forEach(s => s.classList.remove('active'));
                                                                const step2 = document.getElementById('step2');
                                                                if (step2) {
                                                                    step2.classList.add('active');
                                                                    step2.scrollIntoView({ behavior: 'smooth', block: 'center' });
                                                                }
                                                                // Thay form bằng pending state
                                                                setTimeout(() => {
                                                                    const regSection = document.getElementById('registerForm');
                                                                    if (regSection) {
                                                                        regSection.innerHTML =
                                                                            '<div style="max-width:600px;margin:0 auto 80px;padding:0 30px">' +
                                                                            '<div style="background:#fff;border-radius:24px;padding:48px 36px;text-align:center;box-shadow:0 8px 30px rgba(0,0,0,.05);border:1px solid #E8EAF0">' +
                                                                            '<div style="font-size:3rem;margin-bottom:16px">⏳</div>' +
                                                                            '<h3 style="font-size:1.2rem;font-weight:800;margin-bottom:8px">Đang Chờ Duyệt</h3>' +
                                                                            '<p style="color:#6B7194;line-height:1.7;max-width:400px;margin:0 auto">Hồ sơ nhà cung cấp đã được gửi thành công!<br>Admin sẽ xét duyệt trong vòng <strong>24h</strong>.</p>' +
                                                                            '</div></div>';
                                                                    }
                                                                }, 800);
                                                            }, 600);
                                                        } else {
                                                            showToast('❌ ' + data.message, '#FEF2F2', '#991b1b');
                                                        }
                                                    } catch (err) {
                                                        showToast('❌ Lỗi kết nối, vui lòng thử lại.', '#FEF2F2', '#991b1b');
                                                    } finally {
                                                        btn.disabled = false;
                                                        sp.style.display = 'none';
                                                        ic.style.display = '';
                                                        tx.textContent = 'GỬI ĐĂNG KÝ';
                                                    }
                                                };

                                                function showToast(msg, bg, color) {
                                                    const t = document.getElementById('pvToast');
                                                    t.textContent = msg;
                                                    t.style.background = bg;
                                                    t.style.color = color;
                                                    t.style.border = '1px solid ' + color + '33';
                                                    t.style.opacity = '1';
                                                    t.style.transform = 'translateY(0)';
                                                    clearTimeout(t._t);
                                                    t._t = setTimeout(() => { t.style.opacity = '0'; t.style.transform = 'translateY(20px)'; }, 5000);
                                                }
                                            })();
                                        </script>
                                    </c:when>
                                    <c:otherwise>
                                        <div style="text-align:center;padding:30px 0">
                                            <p style="color:#6B7194;margin-bottom:16px">Vui lòng đăng nhập để đăng ký
                                                làm Nhà Cung Cấp</p>
                                            <a href="${pageContext.request.contextPath}/login.jsp" class="btn-register"
                                                style="display:inline-flex;width:auto;padding:14px 32px">
                                                <i class="fas fa-sign-in-alt"></i> Đăng Nhập
                                            </a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>

            <jsp:include page="/common/_footer.jsp" />
        </body>

        </html>