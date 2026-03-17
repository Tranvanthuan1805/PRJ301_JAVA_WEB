<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>${editMode ? 'Sửa Tour' : 'Thêm Tour'} | Admin EzTravel</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="https://cdn.tailwindcss.com"></script>
<script>tailwind.config={theme:{extend:{fontFamily:{sans:['Inter','sans-serif']}}}}</script>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Inter',sans-serif;background:#0a0f1e;color:#e2e8f0;min-height:100vh}
a{text-decoration:none;color:inherit}

/* Form Styles */
.form-card{background:rgba(17,24,39,.7);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:32px;backdrop-filter:blur(12px)}
.form-grid{display:grid;grid-template-columns:1fr 1fr;gap:20px}
@media(max-width:768px){.form-grid{grid-template-columns:1fr}}
.form-full{grid-column:1/-1}
.form-group{display:flex;flex-direction:column;gap:6px}
.form-label{font-size:.82rem;font-weight:600;color:#94a3b8;display:flex;align-items:center;gap:4px}
.form-label .req{color:#f87171;font-weight:700}
.form-label i{font-size:.7rem;opacity:.5}
.form-input{width:100%;padding:12px 16px;border:1px solid rgba(255,255,255,.08);border-radius:10px;font-family:'Inter',sans-serif;font-size:.88rem;transition:all .3s;background:rgba(15,23,42,.6);color:#e2e8f0;outline:none}
.form-input:focus{border-color:#3b82f6;box-shadow:0 0 0 3px rgba(59,130,246,.12);background:rgba(15,23,42,.8)}
.form-input::placeholder{color:#475569}
textarea.form-input{min-height:110px;resize:vertical}
select.form-input{cursor:pointer;appearance:none;background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%2394a3b8' stroke-width='2'%3E%3Cpath d='M6 9l6 6 6-6'/%3E%3C/svg%3E");background-repeat:no-repeat;background-position:right 14px center}
.form-hint{font-size:.72rem;color:#64748b;margin-top:2px}

/* Section Dividers */
.section-title{font-size:.78rem;font-weight:700;color:#60a5fa;text-transform:uppercase;letter-spacing:1.5px;padding:12px 0 6px;margin-top:8px;border-top:1px solid rgba(255,255,255,.05);grid-column:1/-1;display:flex;align-items:center;gap:8px}
.section-title i{font-size:.72rem}

/* Image Preview */
.preview-box{border-radius:12px;overflow:hidden;max-height:200px;background:rgba(15,23,42,.4);border:2px dashed rgba(255,255,255,.08);display:flex;align-items:center;justify-content:center;min-height:120px;transition:.3s}
.preview-box:hover{border-color:rgba(59,130,246,.2)}
.preview-box img{max-width:100%;max-height:200px;object-fit:cover}
.preview-box .placeholder{color:#475569;font-size:.82rem;display:flex;flex-direction:column;align-items:center;gap:8px}
.preview-box .placeholder i{font-size:1.5rem;opacity:.4}

/* Toggle */
.toggle-wrap{display:flex;align-items:center;gap:14px;padding:14px 18px;background:rgba(15,23,42,.4);border-radius:10px;border:1px solid rgba(255,255,255,.06)}
.toggle{position:relative;width:48px;height:26px;flex-shrink:0}
.toggle input{opacity:0;width:0;height:0}
.toggle-slider{position:absolute;cursor:pointer;top:0;left:0;right:0;bottom:0;background:#334155;border-radius:26px;transition:.3s}
.toggle-slider:before{content:'';position:absolute;width:20px;height:20px;left:3px;bottom:3px;background:#fff;border-radius:50%;transition:.3s}
.toggle input:checked+.toggle-slider{background:linear-gradient(135deg,#3b82f6,#2563eb)}
.toggle input:checked+.toggle-slider:before{transform:translateX(22px)}
.toggle-text{font-size:.85rem;font-weight:600}

/* Buttons */
.btn-group{display:flex;gap:12px;justify-content:flex-end;margin-top:24px;padding-top:20px;border-top:1px solid rgba(255,255,255,.06)}
.btn{display:inline-flex;align-items:center;gap:8px;padding:12px 28px;border-radius:10px;font-family:'Inter',sans-serif;font-size:.88rem;font-weight:700;cursor:pointer;transition:all .3s;border:none;text-decoration:none}
.btn-primary{background:linear-gradient(135deg,#3b82f6,#2563eb);color:#fff;box-shadow:0 4px 15px rgba(59,130,246,.3)}
.btn-primary:hover{transform:translateY(-1px);box-shadow:0 6px 20px rgba(59,130,246,.4)}
.btn-cancel{background:rgba(255,255,255,.05);color:#94a3b8;border:1px solid rgba(255,255,255,.08)}
.btn-cancel:hover{color:#e2e8f0;background:rgba(255,255,255,.08)}

/* Back link */
.back-link{display:inline-flex;align-items:center;gap:8px;font-size:.85rem;font-weight:600;color:#60a5fa;margin-bottom:20px;padding:8px 16px;border-radius:8px;transition:.2s}
.back-link:hover{background:rgba(59,130,246,.08);color:#93c5fd}

/* Page Title */
.page-title{font-size:1.4rem;font-weight:800;color:#fff;margin-bottom:24px;display:flex;align-items:center;gap:12px}
.page-title i{color:#3b82f6;font-size:1.1rem}
.page-title .hl{background:linear-gradient(135deg,#3b82f6,#60a5fa);-webkit-background-clip:text;-webkit-text-fill-color:transparent}

/* Success Alert */
.alert-success{padding:14px 18px;background:rgba(16,185,129,.12);border:1px solid rgba(16,185,129,.25);border-radius:10px;color:#34d399;font-weight:600;font-size:.85rem;margin-bottom:20px;display:flex;align-items:center;gap:8px}
.alert-error{padding:14px 18px;background:rgba(239,68,68,.12);border:1px solid rgba(239,68,68,.25);border-radius:10px;color:#f87171;font-weight:600;font-size:.85rem;margin-bottom:20px;display:flex;align-items:center;gap:8px}

/* Price Input Icon */
.input-icon-wrap{position:relative}
.input-icon-wrap .form-input{padding-right:52px}
.input-icon-wrap .suffix{position:absolute;right:14px;top:50%;transform:translateY(-50%);font-size:.8rem;font-weight:700;color:#64748b}
</style>
</head>
<body class="bg-[#0a0f1e] text-slate-200 min-h-screen">
<jsp:include page="/common/_admin-sidebar.jsp"/>
<c:set var="pageTitle" value="${editMode ? 'Sửa Tour' : 'Thêm Tour'}" scope="request"/>
<jsp:include page="/common/_admin-header.jsp"/>

<main class="lg:ml-[260px] pt-20 pb-10 px-4 lg:px-8" style="max-width:900px">

    <a href="${ctx}/admin/dashboard" class="back-link"><i class="fas fa-arrow-left"></i> Quay lại Dashboard</a>

    <c:if test="${param.success == 'created'}">
        <div class="alert-success"><i class="fas fa-check-circle"></i> Tour đã được tạo thành công!</div>
    </c:if>
    <c:if test="${param.success == 'updated'}">
        <div class="alert-success"><i class="fas fa-check-circle"></i> Tour đã được cập nhật thành công!</div>
    </c:if>

    <h1 class="page-title">
        <c:choose>
            <c:when test="${editMode}"><i class="fas fa-pen-to-square"></i> Sửa Tour: <span class="hl">${tour.tourName}</span></c:when>
            <c:otherwise><i class="fas fa-plus-circle"></i> Thêm <span class="hl">Tour Mới</span></c:otherwise>
        </c:choose>
    </h1>

    <c:if test="${not empty error}">
        <div class="alert-error"><i class="fas fa-exclamation-triangle"></i> ${error}</div>
    </c:if>

    <div class="form-card">
        <form action="${ctx}/admin/tours" method="post" id="tourForm">
            <input type="hidden" name="action" value="${editMode ? 'update' : 'create'}">
            <c:if test="${editMode}">
                <input type="hidden" name="tourId" value="${tour.tourId}">
            </c:if>

            <div class="form-grid">

                <!-- ═══ THÔNG TIN CƠ BẢN ═══ -->
                <div class="section-title"><i class="fas fa-info-circle"></i> Thông Tin Cơ Bản</div>

                <div class="form-group form-full">
                    <label class="form-label"><i class="fas fa-heading"></i> Tên Tour <span class="req">*</span></label>
                    <input type="text" name="tourName" class="form-input" required value="${editMode ? tour.tourName : ''}" placeholder="VD: Tour Bà Nà Hills 1 ngày">
                </div>

                <div class="form-group form-full">
                    <label class="form-label"><i class="fas fa-align-left"></i> Mô tả ngắn</label>
                    <input type="text" name="shortDesc" class="form-input" value="${editMode ? tour.shortDesc : ''}" placeholder="Mô tả ngắn hiển thị trên card tour">
                </div>

                <div class="form-group">
                    <label class="form-label"><i class="fas fa-folder"></i> Danh Mục <span class="req">*</span></label>
                    <select name="categoryId" class="form-input" required>
                        <option value="">— Chọn danh mục —</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.categoryId}" ${editMode && not empty tour.category && tour.category.categoryId == cat.categoryId ? 'selected' : ''}>${cat.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label class="form-label"><i class="fas fa-building"></i> Nhà cung cấp <span class="req">*</span></label>
                    <select name="providerId" class="form-input" required>
                        <option value="">— Chọn nhà cung cấp —</option>
                        <c:forEach var="prov" items="${providers}">
                            <option value="${prov.providerId}" ${editMode && not empty tour.provider && tour.provider.providerId == prov.providerId ? 'selected' : ''}>${prov.businessName}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- ═══ GIÁ & SỐ LƯỢNG ═══ -->
                <div class="section-title"><i class="fas fa-coins"></i> Giá & Sức Chứa</div>

                <div class="form-group">
                    <label class="form-label"><i class="fas fa-tag"></i> Giá (VND) <span class="req">*</span></label>
                    <div class="input-icon-wrap">
                        <input type="number" name="price" class="form-input" required min="0" step="1000" value="${editMode ? tour.price : ''}" placeholder="500000">
                        <span class="suffix">VNĐ</span>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label"><i class="fas fa-users"></i> Số chỗ tối đa</label>
                    <input type="number" name="maxPeople" class="form-input" min="1" value="${editMode ? tour.maxPeople : '20'}" placeholder="20">
                </div>

                <!-- ═══ THỜI GIAN & ĐỊA ĐIỂM ═══ -->
                <div class="section-title"><i class="fas fa-clock"></i> Thời Gian & Địa Điểm</div>

                <div class="form-group">
                    <label class="form-label"><i class="fas fa-hourglass-half"></i> Thời lượng tour</label>
                    <input type="text" name="duration" class="form-input" value="${editMode ? tour.duration : ''}" placeholder="VD: 1 ngày, 2N1Đ, 3 giờ">
                </div>

                <div class="form-group">
                    <label class="form-label"><i class="fas fa-bus"></i> Phương tiện</label>
                    <input type="text" name="transport" class="form-input" value="${editMode ? tour.transport : ''}" placeholder="VD: Xe bus, Cáp treo, Tàu">
                </div>

                <div class="form-group">
                    <label class="form-label"><i class="fas fa-map-pin"></i> Nơi khởi hành</label>
                    <input type="text" name="startLocation" class="form-input" value="${editMode ? tour.startLocation : ''}" placeholder="VD: Đà Nẵng">
                </div>

                <div class="form-group">
                    <label class="form-label"><i class="fas fa-location-dot"></i> Điểm đến</label>
                    <input type="text" name="destination" class="form-input" value="${editMode ? tour.destination : ''}" placeholder="VD: Bà Nà Hills">
                </div>

                <!-- ═══ THỜI GIAN TỒN TẠI TRÊN HỆ THỐNG ═══ -->
                <div class="section-title"><i class="fas fa-calendar-alt"></i> Thời Gian Tồn Tại Trên Hệ Thống</div>

                <div class="form-group">
                    <label class="form-label"><i class="fas fa-calendar-plus"></i> Ngày bắt đầu <span class="req">*</span></label>
                    <input type="date" name="startDate" class="form-input" required
                           value="<fmt:formatDate value='${tour.startDate}' pattern='yyyy-MM-dd'/>">
                    <span class="form-hint"><i class="fas fa-info-circle"></i> Tour bắt đầu hiển thị trên website từ ngày này</span>
                </div>

                <div class="form-group">
                    <label class="form-label"><i class="fas fa-calendar-minus"></i> Ngày kết thúc <span class="req">*</span></label>
                    <input type="date" name="endDate" class="form-input" required
                           value="<fmt:formatDate value='${tour.endDate}' pattern='yyyy-MM-dd'/>">
                    <span class="form-hint"><i class="fas fa-info-circle"></i> Tour sẽ tự động ẩn sau ngày này</span>
                    <span id="date-error" class="text-red-400 text-[0.7rem] font-bold mt-1 hidden"><i class="fas fa-exclamation-circle"></i> Ngày kết thúc phải sau ngày bắt đầu!</span>
                </div>

                <!-- ═══ HÌNH ẢNH ═══ -->
                <div class="section-title"><i class="fas fa-image"></i> Hình Ảnh</div>

                <div class="form-group form-full">
                    <label class="form-label"><i class="fas fa-link"></i> URL Hình ảnh</label>
                    <input type="url" name="imageUrl" class="form-input" id="imageUrlInput" value="${editMode ? tour.imageUrl : ''}" placeholder="https://example.com/image.jpg" oninput="previewImage(this.value)">
                </div>

                <div class="form-group form-full">
                    <div class="preview-box" id="previewBox">
                        <c:choose>
                            <c:when test="${editMode && not empty tour.imageUrl}">
                                <img src="${tour.imageUrl}" alt="Preview" id="previewImg">
                            </c:when>
                            <c:otherwise>
                                <span class="placeholder" id="previewPlaceholder"><i class="fas fa-cloud-arrow-up"></i> Xem trước hình ảnh</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- ═══ MÔ TẢ CHI TIẾT ═══ -->
                <div class="section-title"><i class="fas fa-file-lines"></i> Mô Tả Chi Tiết</div>

                <div class="form-group form-full">
                    <label class="form-label"><i class="fas fa-pen-fancy"></i> Mô tả chi tiết</label>
                    <textarea name="description" class="form-input" rows="5" placeholder="Mô tả chi tiết về tour, bao gồm các hoạt động, trải nghiệm...">${editMode ? tour.description : ''}</textarea>
                </div>

                <div class="form-group form-full">
                    <label class="form-label"><i class="fas fa-route"></i> Lịch trình</label>
                    <textarea name="itinerary" class="form-input" rows="5" placeholder="Lịch trình tour theo từng mốc thời gian...">${editMode ? tour.itinerary : ''}</textarea>
                </div>

                <!-- ═══ TRẠNG THÁI ═══ -->
                <c:if test="${editMode}">
                    <div class="section-title"><i class="fas fa-toggle-on"></i> Trạng Thái Tour</div>
                    <div class="form-group form-full">
                        <div class="toggle-wrap">
                            <label class="toggle">
                                <input type="checkbox" name="isActive" id="toggleActive" ${tour.active ? 'checked' : ''} onchange="updateToggleText()">
                                <span class="toggle-slider"></span>
                            </label>
                            <span class="toggle-text" id="toggleText">${tour.active ? '✅ Đang hoạt động — Tour hiển thị trên website' : '⛔ Đã tắt — Tour ẩn khỏi website'}</span>
                        </div>
                    </div>
                </c:if>

            </div>

            <div class="btn-group">
                <a href="${ctx}/admin/dashboard" class="btn btn-cancel"><i class="fas fa-times"></i> Hủy</a>
                <button type="submit" class="btn btn-primary" id="submitBtn">
                    <i class="fas fa-save"></i> ${editMode ? 'Cập Nhật Tour' : 'Tạo Tour Mới'}
                </button>
            </div>
        </form>
    </div>

</main>

<script>
function previewImage(url) {
    var box = document.getElementById('previewBox');
    if (url && url.startsWith('http')) {
        box.innerHTML = '<img src="' + url + '" alt="Preview" onerror="this.parentElement.innerHTML=\'<span class=placeholder><i class=\\'fas fa-exclamation-triangle\\'></i> Không tải được ảnh</span>\'">';
    } else {
        box.innerHTML = '<span class="placeholder"><i class="fas fa-cloud-arrow-up"></i> Xem trước hình ảnh</span>';
    }
}

function updateToggleText() {
    var cb = document.getElementById('toggleActive');
    var text = document.getElementById('toggleText');
    if (cb.checked) {
        text.innerHTML = '✅ Đang hoạt động — Tour hiển thị trên website';
    } else {
        text.innerHTML = '⛔ Đã tắt — Tour ẩn khỏi website';
    }
}

// Form submit confirmation
document.getElementById('tourForm').addEventListener('submit', function(e) {
    var btn = document.getElementById('submitBtn');
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang lưu...';
    btn.disabled = true;
    btn.style.opacity = '.7';
});

// Date validation
document.getElementById('tourForm').addEventListener('submit', function(e) {
    var sd = document.querySelector('[name=startDate]').value;
    var ed = document.querySelector('[name=endDate]').value;
    var errorSpan = document.getElementById('date-error');
    
    if (sd && ed && sd > ed) {
        e.preventDefault();
        errorSpan.classList.remove('hidden');
        document.querySelector('[name=endDate]').classList.add('border-red-500');
        
        var btn = document.getElementById('submitBtn');
        btn.innerHTML = '<i class="fas fa-save"></i> ${editMode ? "Cập Nhật Tour" : "Tạo Tour Mới"}';
        btn.disabled = false;
        btn.style.opacity = '1';
    } else {
        errorSpan.classList.add('hidden');
    }
});
</script>
<script src="${ctx}/js/i18n.js"></script>
</body>
</html>
