<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>${editMode ? 'Sửa Tour' : 'Thêm Tour'} | Admin</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="https://cdn.tailwindcss.com"></script>
<script>tailwind.config={theme:{extend:{fontFamily:{sans:['Inter','sans-serif']}}}}</script>
<style>
body{font-family:'Inter',sans-serif}
.form-input{width:100%;padding:10px 16px;border:1px solid rgba(255,255,255,.1);border-radius:10px;font-family:'Inter',sans-serif;font-size:.88rem;transition:.3s;background:rgba(15,23,42,.8);color:#e2e8f0;outline:none}
.form-input:focus{border-color:#3b82f6;box-shadow:0 0 0 3px rgba(59,130,246,.1)}
textarea.form-input{min-height:100px;resize:vertical}
select.form-input{cursor:pointer}
.preview-box{margin-top:10px;border-radius:10px;overflow:hidden;max-height:200px;background:rgba(15,23,42,.5);border:1px dashed rgba(255,255,255,.1);display:flex;align-items:center;justify-content:center;min-height:100px}
.preview-box img{max-width:100%;max-height:200px;object-fit:cover}
.preview-box .placeholder{color:#475569;font-size:.82rem}
.toggle{position:relative;width:44px;height:24px}
.toggle input{opacity:0;width:0;height:0}
.toggle-slider{position:absolute;cursor:pointer;top:0;left:0;right:0;bottom:0;background:#334155;border-radius:24px;transition:.3s}
.toggle-slider:before{content:'';position:absolute;width:18px;height:18px;left:3px;bottom:3px;background:#fff;border-radius:50%;transition:.3s}
.toggle input:checked+.toggle-slider{background:#2563EB}
.toggle input:checked+.toggle-slider:before{transform:translateX(20px)}
</style>
</head>
<body class="bg-[#0a0f1e] text-slate-200 min-h-screen">
<jsp:include page="/common/_admin-sidebar.jsp"/>
<c:set var="pageTitle" value="${editMode ? 'Sửa Tour' : 'Thêm Tour'}" scope="request"/>
<jsp:include page="/common/_admin-header.jsp"/>

<main class="lg:ml-[260px] pt-20 pb-10 px-4 lg:px-6 max-w-3xl">

    <a href="${ctx}/admin/tours" class="back-link"><i class="fas fa-arrow-left"></i> Quay lại danh sách tour</a>

    <h1 class="form-title">
        <c:choose>
            <c:when test="${editMode}"><i class="fas fa-pen"></i> Sửa Tour: <span class="hl">${tour.tourName}</span></c:when>
            <c:otherwise><i class="fas fa-plus-circle"></i> Thêm <span class="hl">Tour Mới</span></c:otherwise>
        </c:choose>
    </h1>

    <div class="form-card">
        <form action="${ctx}/admin/tours" method="post" id="tourForm">
            <input type="hidden" name="action" value="${editMode ? 'update' : 'create'}">
            <c:if test="${editMode}">
                <input type="hidden" name="tourId" value="${tour.tourId}">
            </c:if>

            <div class="form-grid">

                <c:if test="${not empty error}">
                    <div class="form-full" style="padding:12px 16px;background:rgba(239,68,68,.15);border:1px solid rgba(239,68,68,.3);border-radius:8px;color:#F87171;font-weight:600;font-size:.88rem">
                        <i class="fas fa-exclamation-triangle"></i> ${error}
                    </div>
                </c:if>
                <div class="form-group form-full">
                    <label class="form-label">Tên Tour <span class="req">*</span></label>
                    <input type="text" name="tourName" class="form-input" required value="${editMode ? tour.tourName : ''}" placeholder="VD: Tour Bà Nà Hills 1 ngày">
                </div>

                <div class="form-group form-full">
                    <label class="form-label">Mô tả ngắn</label>
                    <input type="text" name="shortDesc" class="form-input" value="${editMode ? tour.shortDesc : ''}" placeholder="Mô tả ngắn hiển thị trên card">
                </div>

                <div class="form-group">
                    <label class="form-label">Danh Mục <span class="req">*</span></label>
                    <select name="categoryId" class="form-input" required>
                        <option value="">Chọn danh mục</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.categoryId}" ${editMode && tour.categoryId == cat.categoryId ? 'selected' : ''}>${cat.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label class="form-label">Nhà cung cấp <span class="req">*</span></label>
                    <select name="providerId" class="form-input" required>
                        <option value="">Chọn nhà cung cấp</option>
                        <c:forEach var="prov" items="${providers}">
                            <option value="${prov.providerId}" ${editMode && tour.providerId == prov.providerId ? 'selected' : ''}>${prov.businessName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label class="form-label">Giá (VND) <span class="req">*</span></label>
                    <input type="number" name="price" class="form-input" required min="0" step="1000" value="${editMode ? tour.price : ''}" placeholder="500000">
                </div>

                <div class="form-group">
                    <label class="form-label">Thời gian</label>
                    <input type="text" name="duration" class="form-input" value="${editMode ? tour.duration : ''}" placeholder="VD: 1 ngày, 2N1Đ">
                </div>

                <div class="form-group">
                    <label class="form-label">Phương tiện</label>
                    <input type="text" name="transport" class="form-input" value="${editMode ? tour.transport : ''}" placeholder="VD: Xe bus, Cáp treo">
                </div>

                <div class="form-group">
                    <label class="form-label">Nơi khởi hành</label>
                    <input type="text" name="startLocation" class="form-input" value="${editMode ? tour.startLocation : ''}" placeholder="VD: Đà Nẵng">
                </div>

                <div class="form-group">
                    <label class="form-label">Điểm đến</label>
                    <input type="text" name="destination" class="form-input" value="${editMode ? tour.destination : ''}" placeholder="VD: Bà Nà Hills">
                </div>

                <div class="form-group">
                    <label class="form-label">Số chỗ tối đa</label>
                    <input type="number" name="maxPeople" class="form-input" min="1" value="${editMode ? tour.maxPeople : '20'}" placeholder="20">
                </div>

                <div class="form-group">
                    <label class="form-label">URL Hình ảnh</label>
                    <input type="url" name="imageUrl" class="form-input" id="imageUrlInput" value="${editMode ? tour.imageUrl : ''}" placeholder="https://..." oninput="previewImage(this.value)">
                </div>

                <div class="form-group form-full">
                    <div class="preview-box" id="previewBox">
                        <c:choose>
                            <c:when test="${editMode && not empty tour.imageUrl}">
                                <img src="${tour.imageUrl}" alt="Preview" id="previewImg">
                            </c:when>
                            <c:otherwise>
                                <span class="placeholder" id="previewPlaceholder"><i class="fas fa-image"></i> Xem trước ảnh</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="form-group form-full">
                    <label class="form-label">Mô tả chi tiết</label>
                    <textarea name="description" class="form-input" placeholder="Mô tả chi tiết về tour...">${editMode ? tour.description : ''}</textarea>
                </div>

                <div class="form-group form-full">
                    <label class="form-label">Lịch trình</label>
                    <textarea name="itinerary" class="form-input" placeholder="Lịch trình tour từng ngày...">${editMode ? tour.itinerary : ''}</textarea>
                </div>

                <c:if test="${editMode}">
                    <div class="form-group form-full">
                        <label class="form-label">Trạng thái</label>
                        <div class="toggle-group">
                            <label class="toggle">
                                <input type="checkbox" name="isActive" ${tour.active ? 'checked' : ''}>
                                <span class="toggle-slider"></span>
                            </label>
                            <span class="toggle-label">${tour.active ? 'Đang hoạt động' : 'Đã tắt'}</span>
                        </div>
                    </div>
                </c:if>
            </div>

            <div class="form-row">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> ${editMode ? 'Cập Nhật' : 'Tạo Tour'}
                </button>
                <a href="${ctx}/admin/tours" class="btn btn-cancel">Hủy</a>
            </div>
        </form>
    </div>

</div>
</main>

<script>
function previewImage(url) {
    var box = document.getElementById('previewBox');
    if (url && url.startsWith('http')) {
        box.innerHTML = '<img src="' + url + '" alt="Preview" onerror="this.parentElement.innerHTML=\'<span class=placeholder><i class=fas fa-exclamation-triangle></i> Không tải được ảnh</span>\'">';
    } else {
        box.innerHTML = '<span class="placeholder"><i class="fas fa-image"></i> Xem trước ảnh</span>';
    }
}
</script>
<script src="${ctx}/js/i18n.js"></script>
</body>
</html>
