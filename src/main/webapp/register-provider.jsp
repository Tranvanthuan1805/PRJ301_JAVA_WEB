<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Đăng Ký Nhà Cung Cấp | EZTravel</title>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
            <style>
                * {
                    box-sizing: border-box;
                    margin: 0;
                    padding: 0
                }

                body {
                    font-family: 'Segoe UI', system-ui, sans-serif;
                    background: #F4F5FA;
                    color: #1B1F3B;
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 32px 16px
                }

                .card {
                    background: #fff;
                    border-radius: 20px;
                    box-shadow: 0 8px 40px rgba(0, 0, 0, .08);
                    width: 100%;
                    max-width: 560px;
                    overflow: hidden
                }

                .card-head {
                    background: linear-gradient(135deg, #1E293B, #334155);
                    padding: 28px 32px;
                    color: #fff
                }

                .card-head h2 {
                    font-size: 1.25rem;
                    font-weight: 800;
                    display: flex;
                    align-items: center;
                    gap: 10px
                }

                .card-head h2 i {
                    color: #60A5FA
                }

                .card-head p {
                    font-size: .82rem;
                    color: rgba(255, 255, 255, .5);
                    margin-top: 6px
                }

                .card-body {
                    padding: 32px
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
                    padding: 13px 16px;
                    border: 2px solid #E8EAF0;
                    border-radius: 12px;
                    font-size: .92rem;
                    font-family: inherit;
                    font-weight: 500;
                    outline: none;
                    transition: .25s;
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

                .field .err {
                    font-size: .78rem;
                    color: #dc2626;
                    margin-top: 5px;
                    display: none
                }

                .field.invalid input,
                .field.invalid select,
                .field.invalid textarea {
                    border-color: #dc2626
                }

                .field.invalid .err {
                    display: block
                }

                .field textarea {
                    resize: vertical;
                    min-height: 100px
                }

                .btn-submit {
                    width: 100%;
                    padding: 16px;
                    border-radius: 12px;
                    border: none;
                    cursor: pointer;
                    font-size: 1rem;
                    font-weight: 800;
                    font-family: inherit;
                    background: linear-gradient(135deg, #3B82F6, #60A5FA);
                    color: #fff;
                    box-shadow: 0 6px 20px rgba(59, 130, 246, .25);
                    transition: .3s;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    gap: 10px
                }

                .btn-submit:hover:not(:disabled) {
                    transform: translateY(-2px);
                    box-shadow: 0 10px 30px rgba(59, 130, 246, .4)
                }

                .btn-submit:disabled {
                    opacity: .65;
                    cursor: not-allowed;
                    transform: none
                }

                /* Toast */
                .toast {
                    position: fixed;
                    bottom: 24px;
                    right: 24px;
                    z-index: 9999;
                    padding: 14px 20px;
                    border-radius: 12px;
                    font-size: .9rem;
                    font-weight: 600;
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    min-width: 300px;
                    max-width: 420px;
                    box-shadow: 0 8px 30px rgba(0, 0, 0, .15);
                    opacity: 0;
                    transform: translateY(20px);
                    transition: .35s;
                    pointer-events: none
                }

                .toast.show {
                    opacity: 1;
                    transform: translateY(0)
                }

                .toast.success {
                    background: #ECFDF5;
                    color: #065f46;
                    border: 1px solid rgba(5, 150, 105, .2)
                }

                .toast.error {
                    background: #FEF2F2;
                    color: #991b1b;
                    border: 1px solid rgba(220, 38, 38, .2)
                }

                .spinner {
                    width: 18px;
                    height: 18px;
                    border: 2px solid rgba(255, 255, 255, .4);
                    border-top-color: #fff;
                    border-radius: 50%;
                    animation: spin .7s linear infinite;
                    display: none
                }

                @keyframes spin {
                    to {
                        transform: rotate(360deg)
                    }
                }
            </style>
        </head>

        <body>

            <div class="card">
                <div class="card-head">
                    <h2><i class="fas fa-store"></i> Đăng Ký Nhà Cung Cấp</h2>
                    <p>Điền thông tin bên dưới để gửi đơn đăng ký. Admin sẽ xét duyệt trong 24h.</p>
                </div>
                <div class="card-body">

                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <div style="text-align:center;padding:20px 0">
                                <p style="color:#6B7194;margin-bottom:16px">Vui lòng đăng nhập để tiếp tục</p>
                                <a href="${pageContext.request.contextPath}/login.jsp"
                                    style="display:inline-flex;align-items:center;gap:8px;padding:12px 28px;background:#3B82F6;color:#fff;border-radius:10px;font-weight:700;text-decoration:none">
                                    <i class="fas fa-sign-in-alt"></i> Đăng Nhập
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <form id="regForm" novalidate>

                                <div class="field" id="f-businessName">
                                    <label><i class="fas fa-building"></i> Tên Doanh Nghiệp / Thương Hiệu</label>
                                    <input type="text" id="businessName" name="businessName"
                                        placeholder="VD: Đà Nẵng Adventure Tours" maxlength="255">
                                    <div class="err">Vui lòng nhập tên doanh nghiệp.</div>
                                </div>

                                <div class="field" id="f-category">
                                    <label><i class="fas fa-tag"></i> Loại Hình</label>
                                    <select id="category" name="category">
                                        <option value="">-- Chọn loại hình --</option>
                                        <option value="Tour Operator">Công ty Lữ Hành</option>
                                        <option value="Local Guide">Hướng Dẫn Viên Địa Phương</option>
                                        <option value="Activity Provider">Nhà Cung Cấp Hoạt Động</option>
                                        <option value="Hotel & Resort">Khách Sạn &amp; Resort</option>
                                        <option value="Transport">Dịch Vụ Vận Chuyển</option>
                                    </select>
                                    <div class="err">Vui lòng chọn loại hình.</div>
                                </div>

                                <div class="field" id="f-phone">
                                    <label><i class="fas fa-phone"></i> Số Điện Thoại</label>
                                    <input type="tel" id="phone" name="phone" placeholder="0335 111 783"
                                        value="${sessionScope.user.phoneNumber}">
                                    <div class="err">Số điện thoại không hợp lệ (VD: 0912345678).</div>
                                </div>

                                <div class="field" id="f-description">
                                    <label><i class="fas fa-pen"></i> Mô Tả Doanh Nghiệp <span
                                            style="color:#9ca3af;font-weight:400">(tuỳ chọn)</span></label>
                                    <textarea id="description" name="description" rows="4"
                                        placeholder="Giới thiệu ngắn về doanh nghiệp, kinh nghiệm, dịch vụ nổi bật..."></textarea>
                                </div>

                                <button type="submit" class="btn-submit" id="btnSubmit">
                                    <div class="spinner" id="spinner"></div>
                                    <i class="fas fa-paper-plane" id="btnIcon"></i>
                                    <span id="btnText">GỬI ĐĂNG KÝ</span>
                                </button>
                            </form>
                        </c:otherwise>
                    </c:choose>

                </div>
            </div>

            <!-- Toast container -->
            <div class="toast" id="toast"></div>

            <script>
                (function () {
                    const ctx = '${pageContext.request.contextPath}';
                    const form = document.getElementById('regForm');
                    const btnSubmit = document.getElementById('btnSubmit');
                    const spinner = document.getElementById('spinner');
                    const btnIcon = document.getElementById('btnIcon');
                    const btnText = document.getElementById('btnText');
                    const toast = document.getElementById('toast');

                    if (!form) return; // user chưa đăng nhập

                    // ── Validate client-side ──────────────────────────────────────────────
                    function validate() {
                        let ok = true;

                        const businessName = document.getElementById('businessName').value.trim();
                        setFieldState('f-businessName', businessName.length > 0);
                        if (!businessName) ok = false;

                        const category = document.getElementById('category').value;
                        setFieldState('f-category', category !== '');
                        if (!category) ok = false;

                        const phone = document.getElementById('phone').value.trim();
                        const phoneOk = /^(0|\+84)[0-9]{8,10}$/.test(phone);
                        setFieldState('f-phone', phoneOk);
                        if (!phoneOk) ok = false;

                        return ok;
                    }

                    function setFieldState(fieldId, valid) {
                        const el = document.getElementById(fieldId);
                        if (valid) el.classList.remove('invalid');
                        else el.classList.add('invalid');
                    }

                    // Xoá lỗi khi user bắt đầu nhập lại
                    ['businessName', 'category', 'phone'].forEach(id => {
                        document.getElementById(id).addEventListener('input', () => {
                            document.getElementById('f-' + id).classList.remove('invalid');
                        });
                    });

                    // ── Submit AJAX ───────────────────────────────────────────────────────
                    form.addEventListener('submit', async function (e) {
                        e.preventDefault();
                        if (!validate()) return;

                        // Disable nút + hiện spinner
                        btnSubmit.disabled = true;
                        spinner.style.display = 'block';
                        btnIcon.style.display = 'none';
                        btnText.textContent = 'Đang gửi...';

                        const payload = {
                            businessName: document.getElementById('businessName').value.trim(),
                            category: document.getElementById('category').value,
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
                                showToast('✅ ' + data.message, 'success');
                                form.reset(); // xoá form sau khi thành công
                            } else {
                                showToast('❌ ' + data.message, 'error');
                            }
                        } catch (err) {
                            showToast('❌ Lỗi kết nối, vui lòng thử lại.', 'error');
                        } finally {
                            // Khôi phục nút
                            btnSubmit.disabled = false;
                            spinner.style.display = 'none';
                            btnIcon.style.display = '';
                            btnText.textContent = 'GỬI ĐĂNG KÝ';
                        }
                    });

                    // ── Toast helper ──────────────────────────────────────────────────────
                    function showToast(msg, type) {
                        toast.textContent = msg;
                        toast.className = 'toast ' + type + ' show';
                        clearTimeout(toast._timer);
                        toast._timer = setTimeout(() => {
                            toast.classList.remove('show');
                        }, 5000);
                    }
                })();
            </script>

        </body>

        </html>