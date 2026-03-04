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
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Inter',sans-serif;background:#0F172A;color:#E2E8F0;min-height:100vh}
a{text-decoration:none;color:inherit}
.container{max-width:800px;margin:0 auto;padding:0 24px}
.page{padding:120px 0 60px}

.back-link{display:inline-flex;align-items:center;gap:6px;color:#64748B;font-size:.85rem;font-weight:600;margin-bottom:20px;transition:.3s}
.back-link:hover{color:#fff}
.form-title{font-size:1.5rem;font-weight:800;color:#fff;margin-bottom:24px}
.form-title .hl{color:#60A5FA}

.form-card{background:rgba(30,41,59,.5);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:28px}
.form-grid{display:grid;grid-template-columns:1fr 1fr;gap:16px}
.form-full{grid-column:1/-1}
.form-group{display:flex;flex-direction:column;gap:6px}
.form-label{font-size:.78rem;font-weight:700;color:#94A3B8;letter-spacing:.5px}
.form-label .req{color:#F87171}
.form-input{padding:10px 14px;border-radius:8px;border:1px solid rgba(255,255,255,.1);background:rgba(15,23,42,.8);color:#fff;font-size:.88rem;outline:none;transition:.3s;font-family:inherit}
.form-input:focus{border-color:#3B82F6;box-shadow:0 0 0 3px rgba(59,130,246,.1)}
textarea.form-input{min-height:100px;resize:vertical}
select.form-input{cursor:pointer}

.form-row{display:flex;gap:12px;margin-top:20px}
.btn{display:inline-flex;align-items:center;gap:6px;padding:10px 24px;border-radius:8px;font-weight:700;font-size:.88rem;cursor:pointer;transition:.3s;border:none;font-family:inherit}
.btn-primary{background:#2563EB;color:#fff}
.btn-primary:hover{background:#3B82F6}
.btn-cancel{background:rgba(255,255,255,.06);color:#94A3B8;border:1px solid rgba(255,255,255,.1)}
.btn-cancel:hover{color:#fff}

.preview-box{margin-top:10px;border-radius:10px;overflow:hidden;max-height:200px;background:rgba(15,23,42,.5);border:1px dashed rgba(255,255,255,.1);display:flex;align-items:center;justify-content:center;min-height:100px}
.preview-box img{max-width:100%;max-height:200px;object-fit:cover}
.preview-box .placeholder{color:#475569;font-size:.82rem}

.toggle-group{display:flex;align-items:center;gap:10px;margin-top:8px}
.toggle{position:relative;width:44px;height:24px}
.toggle input{opacity:0;width:0;height:0}
.toggle-slider{position:absolute;cursor:pointer;top:0;left:0;right:0;bottom:0;background:#334155;border-radius:24px;transition:.3s}
.toggle-slider:before{content:'';position:absolute;width:18px;height:18px;left:3px;bottom:3px;background:#fff;border-radius:50%;transition:.3s}
.toggle input:checked+.toggle-slider{background:#2563EB}
.toggle input:checked+.toggle-slider:before{transform:translateX(20px)}
.toggle-label{font-size:.85rem;font-weight:600}

@media(max-width:768px){.form-grid{grid-template-columns:1fr}}
</style>
</head>
<body>
<jsp:include page="/common/_header.jsp"/>

<main class="page">
<div class="container">

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
