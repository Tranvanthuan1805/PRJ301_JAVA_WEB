<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo Tour Mới | EZTravel Provider</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<style>
*{box-sizing:border-box}body{font-family:'Plus Jakarta Sans',system-ui,sans-serif;background:#F4F5FA;color:#1B1F3B}

.create-hero{margin-top:64px;background:linear-gradient(135deg,#0F172A,#1E293B);padding:44px 0;text-align:center;position:relative;overflow:hidden}
.create-hero::before{content:'';position:absolute;width:400px;height:400px;background:radial-gradient(circle,rgba(59,130,246,.1),transparent 60%);top:-200px;right:-50px;border-radius:50%}
.create-hero h1{font-size:1.8rem;font-weight:900;color:#fff;position:relative;z-index:2;display:flex;align-items:center;justify-content:center;gap:10px}
.create-hero h1 i{color:#60A5FA}
.create-hero p{color:rgba(255,255,255,.45);font-size:.88rem;position:relative;z-index:2}

.form-page{max-width:900px;margin:-30px auto 60px;padding:0 30px;position:relative;z-index:10}

.form-card{background:#fff;border-radius:24px;box-shadow:0 8px 40px rgba(0,0,0,.06);border:1px solid #E8EAF0;overflow:hidden}
.form-body{padding:36px 40px}

.form-section{margin-bottom:28px}
.form-section-title{font-size:.95rem;font-weight:800;color:#1E293B;margin-bottom:16px;display:flex;align-items:center;gap:8px;padding-bottom:8px;border-bottom:2px solid #F0F1F5}
.form-section-title i{color:#3B82F6;font-size:.85rem}

.field{margin-bottom:18px}
.field label{display:block;font-size:.82rem;font-weight:700;color:#4A4E6F;margin-bottom:6px}
.field label .req{color:#EF4444}
.field input,.field select,.field textarea{width:100%;padding:14px 16px;border:2px solid #E8EAF0;border-radius:14px;font-size:.88rem;font-family:inherit;font-weight:600;outline:none;transition:.3s;background:#FAFBFF;color:#1B1F3B}
.field input:focus,.field select:focus,.field textarea:focus{border-color:#3B82F6;box-shadow:0 0 0 3px rgba(59,130,246,.08);background:#fff}
.field textarea{resize:vertical;min-height:100px}
.field-row{display:grid;grid-template-columns:1fr 1fr;gap:16px}
.field-hint{font-size:.75rem;color:#A0A5C3;margin-top:4px}

/* Upload */
.upload-zone{border:2px dashed #E8EAF0;border-radius:16px;padding:36px;text-align:center;cursor:pointer;transition:.3s;background:#FAFBFF}
.upload-zone:hover{border-color:#3B82F6;background:rgba(59,130,246,.02)}
.upload-zone.active{border-color:#3B82F6;background:rgba(59,130,246,.04)}
.upload-zone i{font-size:2rem;color:#CBD5E1;margin-bottom:10px}
.upload-zone p{font-size:.85rem;color:#6B7194;font-weight:600}
.upload-zone small{font-size:.75rem;color:#A0A5C3}
.upload-zone input[type=file]{display:none}
.preview-img{max-height:200px;border-radius:12px;margin-top:12px;box-shadow:0 4px 12px rgba(0,0,0,.08)}

/* 3D Toggle */
.toggle-3d{display:flex;align-items:center;gap:14px;padding:20px 24px;background:linear-gradient(135deg,rgba(59,130,246,.04),rgba(96,165,250,.02));border:1px solid rgba(59,130,246,.12);border-radius:16px;cursor:pointer;transition:.3s}
.toggle-3d:hover{background:rgba(59,130,246,.06)}
.toggle-3d .toggle-icon{width:50px;height:50px;background:linear-gradient(135deg,#3B82F6,#60A5FA);border-radius:14px;display:flex;align-items:center;justify-content:center;font-size:1.2rem;color:#fff;flex-shrink:0}
.toggle-3d .toggle-text h4{font-size:.95rem;font-weight:800;color:#1E293B;margin-bottom:2px}
.toggle-3d .toggle-text p{font-size:.78rem;color:#6B7194}
.toggle-3d .toggle-switch{margin-left:auto}
.toggle-switch input{width:44px;height:24px;-webkit-appearance:none;background:#E8EAF0;border-radius:999px;position:relative;outline:none;cursor:pointer;transition:.3s}
.toggle-switch input:checked{background:#3B82F6}
.toggle-switch input::before{content:'';position:absolute;width:18px;height:18px;background:#fff;border-radius:50%;top:3px;left:3px;transition:.3s;box-shadow:0 1px 4px rgba(0,0,0,.15)}
.toggle-switch input:checked::before{left:23px}

/* 3D Upload Section */
.upload-3d{margin-top:16px;padding:20px;background:#FAFBFF;border:1px solid #E8EAF0;border-radius:16px;display:none}
.upload-3d.show{display:block}
.upload-3d h4{font-size:.88rem;font-weight:800;color:#1E293B;margin-bottom:8px;display:flex;align-items:center;gap:6px}
.upload-3d h4 i{color:#3B82F6}
.upload-3d p{font-size:.78rem;color:#A0A5C3;margin-bottom:14px}
.upload-multi{border:2px dashed #E8EAF0;border-radius:14px;padding:28px;text-align:center;cursor:pointer;transition:.3s}
.upload-multi:hover{border-color:#3B82F6}
.upload-multi i{font-size:1.5rem;color:#3B82F6;margin-bottom:8px}
.preview-3d{display:flex;gap:8px;flex-wrap:wrap;margin-top:12px}
.preview-3d img{width:80px;height:80px;object-fit:cover;border-radius:10px;border:2px solid #E8EAF0}

/* Submit */
.form-footer{padding:24px 40px;background:#FAFBFF;border-top:1px solid #E8EAF0;display:flex;justify-content:space-between;align-items:center}
.btn-back{padding:14px 24px;border-radius:14px;font-weight:700;font-size:.88rem;font-family:inherit;text-decoration:none;background:#fff;color:#6B7194;border:2px solid #E8EAF0;transition:.3s;display:flex;align-items:center;gap:6px}
.btn-back:hover{border-color:#1E293B;color:#1E293B}
.btn-submit{padding:16px 36px;border-radius:14px;font-weight:800;font-size:.95rem;font-family:inherit;border:none;cursor:pointer;background:linear-gradient(135deg,#3B82F6,#60A5FA);color:#fff;box-shadow:0 6px 20px rgba(59,130,246,.25);transition:.3s;display:flex;align-items:center;gap:8px}
.btn-submit:hover{transform:translateY(-2px);box-shadow:0 10px 30px rgba(59,130,246,.4)}

@media(max-width:600px){.field-row{grid-template-columns:1fr}.form-body{padding:24px 20px}.form-footer{padding:20px;flex-direction:column;gap:12px}}
</style>
</head>
<body>
<jsp:include page="/common/_header.jsp" />

<div class="create-hero">
    <h1><i class="fas fa-plus-circle"></i> Tạo Tour Mới</h1>
    <p>Điền thông tin tour và upload ảnh để gửi Admin duyệt</p>
</div>

<div class="form-page">
    <form action="${pageContext.request.contextPath}/provider" method="POST" enctype="multipart/form-data" class="form-card">
        <input type="hidden" name="action" value="submit-tour">
        <div class="form-body">

            <!-- BASIC INFO -->
            <div class="form-section">
                <div class="form-section-title"><i class="fas fa-info-circle"></i> Thông Tin Cơ Bản</div>
                <div class="field" id="field-tourName">
                    <label>Tên Tour <span class="req">*</span></label>
                    <input type="text" name="tourName" id="tourName" placeholder="VD: Tour Bà Nà Hills - Cầu Vàng Trọn Ngày">
                    <span class="error-msg" id="msg-tourName">Vui lòng nhập tên tour</span>
                </div>
                <div class="field-row">
                    <div class="field" id="field-categoryId">
                        <label>Danh Mục <span class="req">*</span></label>
                        <select name="categoryId" id="categoryId">
                            <option value="">Chọn danh mục</option>
                            <c:forEach items="${categories}" var="cat">
                                <option value="${cat.categoryId}">${cat.categoryName}</option>
                            </c:forEach>
                        </select>
                        <span class="error-msg" id="msg-categoryId">Vui lòng chọn danh mục</span>
                    </div>
                    <div class="field" id="field-price">
                        <label>Giá Tour (VNĐ) <span class="req">*</span></label>
                        <input type="number" name="price" id="price" placeholder="500000" min="0">
                        <span class="error-msg" id="msg-price">Vui lòng nhập giá tour hợp lệ</span>
                    </div>
                </div>
                <div class="field">
                    <label>Mô Tả Ngắn</label>
                    <input type="text" name="shortDesc" placeholder="1-2 câu mô tả hấp dẫn về tour" maxlength="500">
                </div>
                <div class="field">
                    <label>Mô Tả Chi Tiết</label>
                    <textarea name="description" placeholder="Mô tả chi tiết về tour: điểm đến, hoạt động, bao gồm gì..." rows="4"></textarea>
                </div>
            </div>

            <!-- DETAILS -->
            <div class="form-section">
                <div class="form-section-title"><i class="fas fa-route"></i> Chi Tiết Tour</div>
                <div class="field-row">
                    <div class="field">
                        <label>Thời Gian</label>
                        <input type="text" name="duration" placeholder="VD: 1 ngày, 2N1Đ">
                    </div>
                    <div class="field">
                        <label>Phương Tiện</label>
                        <input type="text" name="transport" placeholder="VD: Xe du lịch 45 chỗ">
                    </div>
                </div>
                <div class="field-row">
                    <div class="field">
                        <label>Điểm Khởi Hành</label>
                        <input type="text" name="startLocation" placeholder="VD: Đà Nẵng">
                    </div>
                    <div class="field">
                        <label>Điểm Đến</label>
                        <input type="text" name="destination" placeholder="VD: Bà Nà Hills">
                    </div>
                </div>
                <div class="field">
                    <label>Lịch Trình</label>
                    <textarea name="itinerary" placeholder="7:00 - Đón khách tại khách sạn&#10;8:30 - Xuất phát đi Bà Nà&#10;..." rows="5"></textarea>
                </div>
            </div>

            <!-- IMAGES -->
            <div class="form-section">
                <div class="form-section-title"><i class="fas fa-camera"></i> Hình Ảnh Tour</div>
                <div class="field">
                    <label>Ảnh Đại Diện <span class="req">*</span></label>
                    <div class="upload-zone" id="mainUpload" onclick="document.getElementById('tourImage').click()">
                        <i class="fas fa-cloud-upload-alt"></i>
                        <p>Click để chọn ảnh đại diện</p>
                        <small>JPG, PNG, WebP • Tối đa 10MB</small>
                        <input type="file" id="tourImage" name="tourImage" accept="image/*" onchange="previewMain(this)">
                        <img id="mainPreview" class="preview-img" style="display:none">
                    </div>
                    <span class="error-msg" id="msg-tourImage" style="text-align:center">Vui lòng chọn ảnh đại diện</span>
                </div>

                <!-- 3D Toggle -->
                <div class="toggle-3d" onclick="document.getElementById('enable3D').click()">
                    <div class="toggle-icon"><i class="fas fa-cube"></i></div>
                    <div class="toggle-text">
                        <h4>Bật Trải Nghiệm Tour 3D</h4>
                        <p>Upload nhiều ảnh panorama để tạo tour thực tế ảo 360°</p>
                    </div>
                    <div class="toggle-switch" onclick="event.stopPropagation()">
                        <input type="checkbox" id="enable3D" name="enable3D" onchange="toggle3DSection()">
                    </div>
                </div>

                <!-- 3D Upload -->
                <div class="upload-3d" id="section3D">
                    <h4><i class="fas fa-vr-cardboard"></i> Ảnh Tour 3D (Panorama)</h4>
                    <p>Upload ít nhất 4 ảnh panorama từ nhiều góc độ để tạo trải nghiệm 3D cho khách hàng</p>
                    <div class="upload-multi" onclick="document.getElementById('tourImages3D').click()">
                        <i class="fas fa-images"></i>
                        <p style="font-size:.85rem;color:#6B7194;font-weight:600">Click để chọn nhiều ảnh 3D</p>
                        <small style="font-size:.75rem;color:#A0A5C3">Chọn nhiều ảnh cùng lúc</small>
                        <input type="file" id="tourImages3D" name="tourImages3D" accept="image/*" multiple onchange="preview3D(this)" style="display:none">
                    </div>
                    <div class="preview-3d" id="preview3DContainer"></div>
                </div>
            </div>
        </div>

        <div class="form-footer">
            <a href="${pageContext.request.contextPath}/provider?action=dashboard" class="btn-back">
                <i class="fas fa-arrow-left"></i> Quay Lại
            </a>
            <button type="submit" class="btn-submit">
                <i class="fas fa-paper-plane"></i> GỬI TOUR ĐỂ DUYỆT
            </button>
        </div>
    </form>
</div>

<jsp:include page="/common/_footer.jsp" />

<script>
function previewMain(input) {
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = e => {
            const img = document.getElementById('mainPreview');
            img.src = e.target.result;
            img.style.display = 'block';
            document.getElementById('mainUpload').classList.add('active');
        };
        reader.readAsDataURL(input.files[0]);
    }
}

function toggle3DSection() {
    const section = document.getElementById('section3D');
    section.classList.toggle('show', document.getElementById('enable3D').checked);
}

function preview3D(input) {
    const container = document.getElementById('preview3DContainer');
    container.innerHTML = '';
    if (input.files) {
        Array.from(input.files).forEach(file => {
            const reader = new FileReader();
            reader.onload = e => {
                const img = document.createElement('img');
                img.src = e.target.result;
                container.appendChild(img);
            };
            reader.readAsDataURL(file);
        });
    }
}

// Form validation
document.querySelector('.form-card').addEventListener('submit', function(e) {
    // Reset
    document.querySelectorAll('.error-msg').forEach(m => m.style.display = 'none');
    document.querySelectorAll('.field').forEach(f => f.classList.remove('has-error'));
    document.getElementById('mainUpload').classList.remove('has-error');

    const tourName = document.getElementById('tourName').value.trim();
    const categoryId = document.getElementById('categoryId').value;
    const price = document.getElementById('price').value;
    const tourImage = document.getElementById('tourImage').files.length;
    
    let isValid = true;
    let firstErrorElement = null;

    if (!tourName) {
        isValid = false;
        document.getElementById('msg-tourName').style.display = 'block';
        document.getElementById('field-tourName').classList.add('has-error');
        if (!firstErrorElement) firstErrorElement = document.getElementById('tourName');
    }

    if (!categoryId) {
        isValid = false;
        document.getElementById('msg-categoryId').style.display = 'block';
        document.getElementById('field-categoryId').classList.add('has-error');
        if (!firstErrorElement) firstErrorElement = document.getElementById('categoryId');
    }

    if (!price || price <= 0) {
        isValid = false;
        document.getElementById('msg-price').style.display = 'block';
        document.getElementById('field-price').classList.add('has-error');
        if (!firstErrorElement) firstErrorElement = document.getElementById('price');
    }

    if (tourImage === 0) {
        isValid = false;
        document.getElementById('msg-tourImage').style.display = 'block';
        document.getElementById('mainUpload').classList.add('has-error');
    }

    if (!isValid) {
        e.preventDefault();
        if (firstErrorElement) firstErrorElement.focus();
        return;
    }

    const btn = document.querySelector('.btn-submit');
    btn.disabled = true;
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang gửi...';
});
</script>
</body>
</html>
