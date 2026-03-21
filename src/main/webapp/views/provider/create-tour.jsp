<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Tạo Tour Mới | EZTravel NCC</title>
            <link
                href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
            <style>
                * {
                    box-sizing: border-box;
                    margin: 0;
                    padding: 0
                }

                body {
                    font-family: 'Plus Jakarta Sans', system-ui, sans-serif;
                    background: #F4F5FA;
                    color: #1B1F3B
                }

                .page-wrap {
                    max-width: 860px;
                    margin: 40px auto;
                    padding: 0 20px 60px
                }

                .page-title {
                    font-size: 1.8rem;
                    font-weight: 800;
                    color: #1B1F3B;
                    margin-bottom: 8px
                }

                .page-sub {
                    color: #64748B;
                    font-size: .95rem;
                    margin-bottom: 32px
                }

                .card {
                    background: #fff;
                    border-radius: 16px;
                    padding: 32px;
                    box-shadow: 0 2px 12px rgba(0, 0, 0, .06);
                    margin-bottom: 24px
                }

                .card h3 {
                    font-size: 1rem;
                    font-weight: 700;
                    color: #1B1F3B;
                    margin-bottom: 20px;
                    display: flex;
                    align-items: center;
                    gap: 8px
                }

                .card h3 i {
                    color: #2563EB
                }

                .form-grid {
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    gap: 18px
                }

                .form-group {
                    display: flex;
                    flex-direction: column;
                    gap: 6px
                }

                .form-group.full {
                    grid-column: 1 / -1
                }

                label {
                    font-size: .82rem;
                    font-weight: 700;
                    color: #374151;
                    text-transform: uppercase;
                    letter-spacing: .5px
                }

                input,
                select,
                textarea {
                    border: 1.5px solid #E2E8F0;
                    border-radius: 10px;
                    padding: 11px 14px;
                    font-size: .9rem;
                    font-family: inherit;
                    color: #1B1F3B;
                    transition: border-color .2s;
                    outline: none;
                    width: 100%
                }

                input:focus,
                select:focus,
                textarea:focus {
                    border-color: #2563EB;
                    box-shadow: 0 0 0 3px rgba(37, 99, 235, .1)
                }

                textarea {
                    resize: vertical;
                    min-height: 100px
                }

                .upload-box {
                    border: 2px dashed #CBD5E1;
                    border-radius: 12px;
                    padding: 32px;
                    text-align: center;
                    cursor: pointer;
                    transition: .3s;
                    background: #F8FAFC
                }

                .upload-box:hover {
                    border-color: #2563EB;
                    background: #EFF6FF
                }

                .upload-box i {
                    font-size: 2rem;
                    color: #94A3B8;
                    margin-bottom: 10px
                }

                .upload-box p {
                    color: #64748B;
                    font-size: .88rem
                }

                .upload-box input[type=file] {
                    display: none
                }

                .toggle-3d {
                    display: flex;
                    align-items: center;
                    gap: 12px;
                    padding: 14px 18px;
                    background: #F8FAFC;
                    border-radius: 10px;
                    border: 1.5px solid #E2E8F0
                }

                .toggle-3d label {
                    text-transform: none;
                    font-size: .9rem;
                    font-weight: 600;
                    color: #374151;
                    cursor: pointer;
                    margin: 0
                }

                .toggle-3d input[type=checkbox] {
                    width: 18px;
                    height: 18px;
                    cursor: pointer
                }

                .images-3d-section {
                    display: none;
                    margin-top: 16px
                }

                .images-3d-section.show {
                    display: block
                }

                .btn-submit {
                    width: 100%;
                    padding: 15px;
                    border-radius: 12px;
                    background: linear-gradient(135deg, #2563EB, #3B82F6);
                    color: #fff;
                    font-size: 1rem;
                    font-weight: 700;
                    border: none;
                    cursor: pointer;
                    transition: all .3s;
                    font-family: inherit;
                    box-shadow: 0 4px 16px rgba(37, 99, 235, .25)
                }

                .btn-submit:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 8px 24px rgba(37, 99, 235, .35)
                }

                .btn-back {
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                    color: #64748B;
                    text-decoration: none;
                    font-size: .88rem;
                    font-weight: 600;
                    margin-bottom: 24px;
                    transition: .2s
                }

                .btn-back:hover {
                    color: #2563EB
                }

                .alert {
                    padding: 14px 18px;
                    border-radius: 10px;
                    margin-bottom: 20px;
                    font-size: .9rem;
                    font-weight: 600
                }

                .alert-success {
                    background: #D1FAE5;
                    color: #065F46;
                    border: 1px solid #A7F3D0
                }

                .alert-error {
                    background: #FEE2E2;
                    color: #991B1B;
                    border: 1px solid #FECACA
                }

                @media(max-width:640px) {
                    .form-grid {
                        grid-template-columns: 1fr
                    }
                }
            </style>
        </head>

        <body>
            <div class="page-wrap">
                <a href="${pageContext.request.contextPath}/provider?action=dashboard" class="btn-back">
                    <i class="fas fa-arrow-left"></i> Quay lại Dashboard
                </a>

                <div class="page-title"><i class="fas fa-plus-circle" style="color:#2563EB;margin-right:10px"></i>Tạo
                    Tour Mới</div>
                <div class="page-sub">Điền thông tin tour của bạn. Tour sẽ được Admin duyệt trước khi hiển thị.</div>

                <c:if test="${not empty sessionScope.success}">
                    <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${sessionScope.success}</div>
                    <c:remove var="success" scope="session" />
                </c:if>
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> ${sessionScope.error}</div>
                    <c:remove var="error" scope="session" />
                </c:if>

                <form action="${pageContext.request.contextPath}/provider" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="submit-tour">

                    <!-- Thông tin cơ bản -->
                    <div class="card">
                        <h3><i class="fas fa-info-circle"></i> Thông Tin Cơ Bản</h3>
                        <div class="form-grid">
                            <div class="form-group full">
                                <label>Tên Tour *</label>
                                <input type="text" name="tourName" placeholder="VD: Tour Bà Nà Hills 1 Ngày" required>
                            </div>
                            <div class="form-group full">
                                <label>Mô tả ngắn *</label>
                                <input type="text" name="shortDesc" placeholder="Tóm tắt tour trong 1-2 câu" required>
                            </div>
                            <div class="form-group full">
                                <label>Mô tả chi tiết</label>
                                <textarea name="description"
                                    placeholder="Mô tả đầy đủ về tour, điểm nổi bật, dịch vụ bao gồm..."></textarea>
                            </div>
                            <div class="form-group">
                                <label>Danh mục *</label>
                                <select name="categoryId" required>
                                    <option value="">-- Chọn danh mục --</option>
                                    <c:forEach var="cat" items="${categories}">
                                        <option value="${cat.categoryId}">${cat.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Giá (VNĐ) *</label>
                                <input type="number" name="price" placeholder="VD: 500000" min="0" step="1000" required>
                            </div>
                        </div>
                    </div>

                    <!-- Chi tiết hành trình -->
                    <div class="card">
                        <h3><i class="fas fa-route"></i> Chi Tiết Hành Trình</h3>
                        <div class="form-grid">
                            <div class="form-group">
                                <label>Thời gian *</label>
                                <input type="text" name="duration" placeholder="VD: 1 ngày, 2 ngày 1 đêm" required>
                            </div>
                            <div class="form-group">
                                <label>Phương tiện</label>
                                <select name="transport">
                                    <option value="Xe du lịch">Xe du lịch</option>
                                    <option value="Xe máy">Xe máy</option>
                                    <option value="Tàu thuyền">Tàu thuyền</option>
                                    <option value="Máy bay">Máy bay</option>
                                    <option value="Tự túc">Tự túc</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Điểm khởi hành *</label>
                                <input type="text" name="startLocation" placeholder="VD: Đà Nẵng" required>
                            </div>
                            <div class="form-group">
                                <label>Điểm đến *</label>
                                <input type="text" name="destination" placeholder="VD: Bà Nà Hills" required>
                            </div>
                            <div class="form-group full">
                                <label>Lịch trình chi tiết</label>
                                <textarea name="itinerary" rows="5"
                                    placeholder="Mô tả lịch trình từng ngày..."></textarea>
                            </div>
                        </div>
                    </div>

                    <!-- Hình ảnh -->
                    <div class="card">
                        <h3><i class="fas fa-images"></i> Hình Ảnh</h3>
                        <div class="form-group" style="margin-bottom:16px">
                            <label>Ảnh đại diện tour</label>
                            <div class="upload-box" onclick="document.getElementById('tourImage').click()">
                                <i class="fas fa-cloud-upload-alt"></i>
                                <p>Click để chọn ảnh (JPG, PNG, tối đa 10MB)</p>
                                <input type="file" id="tourImage" name="tourImage" accept="image/*"
                                    onchange="previewImage(this, 'imgPreview')">
                            </div>
                            <img id="imgPreview"
                                style="display:none;max-width:100%;border-radius:10px;margin-top:10px;max-height:200px;object-fit:cover">
                        </div>

                        <div class="toggle-3d">
                            <input type="checkbox" id="enable3D" name="enable3D" onchange="toggle3D(this)">
                            <label for="enable3D"><i class="fas fa-cube" style="color:#7C3AED;margin-right:6px"></i> Bật
                                tính năng xem 3D (tải thêm ảnh 360°)</label>
                        </div>
                        <div class="images-3d-section" id="images3DSection">
                            <div class="form-group" style="margin-top:0">
                                <label>Ảnh 3D / 360° (có thể chọn nhiều ảnh)</label>
                                <div class="upload-box" onclick="document.getElementById('tourImages3D').click()">
                                    <i class="fas fa-vr-cardboard"></i>
                                    <p>Chọn nhiều ảnh 360° cho trải nghiệm 3D</p>
                                    <input type="file" id="tourImages3D" name="tourImages3D" accept="image/*" multiple>
                                </div>
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn-submit">
                        <i class="fas fa-paper-plane"></i> Gửi Tour Để Duyệt
                    </button>
                </form>
            </div>

            <script>
                function previewImage(input, previewId) {
                    var preview = document.getElementById(previewId);
                    if (input.files && input.files[0]) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            preview.src = e.target.result;
                            preview.style.display = 'block';
                        };
                        reader.readAsDataURL(input.files[0]);
                    }
                }
                function toggle3D(cb) {
                    var sec = document.getElementById('images3DSection');
                    sec.classList.toggle('show', cb.checked);
                }
            </script>
        </body>

        </html>