<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>${editMode ? 'Sửa Danh Mục' : 'Thêm Danh Mục'} | Admin</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="https://cdn.tailwindcss.com"></script>
<script>tailwind.config={theme:{extend:{fontFamily:{sans:['Inter','sans-serif']}}}}</script>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Inter',sans-serif;background:#0a0f1e;color:#e2e8f0;min-height:100vh}
a{text-decoration:none;color:inherit}
.form-card{background:rgba(17,24,39,.7);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:32px;backdrop-filter:blur(12px)}
.form-grid{display:grid;grid-template-columns:1fr 1fr;gap:20px}
@media(max-width:768px){.form-grid{grid-template-columns:1fr}}
.form-full{grid-column:1/-1}
.form-group{display:flex;flex-direction:column;gap:6px}
.form-label{font-size:.82rem;font-weight:600;color:#94a3b8;display:flex;align-items:center;gap:4px}
.form-label .req{color:#f87171;font-weight:700}
.form-label i{font-size:.7rem;opacity:.5}
.form-input{width:100%;padding:12px 16px;border:1px solid rgba(255,255,255,.08);border-radius:10px;font-family:'Inter',sans-serif;font-size:.88rem;transition:all .3s;background:rgba(15,23,42,.6);color:#e2e8f0;outline:none}
.form-input:focus{border-color:#3b82f6;box-shadow:0 0 0 3px rgba(59,130,246,.12)}
.form-input::placeholder{color:#475569}
textarea.form-input{min-height:100px;resize:vertical}
.section-title{font-size:.78rem;font-weight:700;color:#60a5fa;text-transform:uppercase;letter-spacing:1.5px;padding:12px 0 6px;margin-top:8px;border-top:1px solid rgba(255,255,255,.05);grid-column:1/-1;display:flex;align-items:center;gap:8px}
.section-title i{font-size:.72rem}
.btn-group{display:flex;gap:12px;justify-content:flex-end;margin-top:24px;padding-top:20px;border-top:1px solid rgba(255,255,255,.06)}
.btn{display:inline-flex;align-items:center;gap:8px;padding:12px 28px;border-radius:10px;font-family:'Inter',sans-serif;font-size:.88rem;font-weight:700;cursor:pointer;transition:all .3s;border:none;text-decoration:none}
.btn-primary{background:linear-gradient(135deg,#3b82f6,#2563eb);color:#fff;box-shadow:0 4px 15px rgba(59,130,246,.3)}
.btn-primary:hover{transform:translateY(-1px);box-shadow:0 6px 20px rgba(59,130,246,.4)}
.btn-cancel{background:rgba(255,255,255,.05);color:#94a3b8;border:1px solid rgba(255,255,255,.08)}
.btn-cancel:hover{color:#e2e8f0;background:rgba(255,255,255,.08)}
.back-link{display:inline-flex;align-items:center;gap:8px;font-size:.85rem;font-weight:600;color:#60a5fa;margin-bottom:20px;padding:8px 16px;border-radius:8px;transition:.2s}
.back-link:hover{background:rgba(59,130,246,.08);color:#93c5fd}
.page-title{font-size:1.4rem;font-weight:800;color:#fff;margin-bottom:24px;display:flex;align-items:center;gap:12px}
.page-title i{color:#3b82f6;font-size:1.1rem}
.page-title .hl{background:linear-gradient(135deg,#3b82f6,#60a5fa);-webkit-background-clip:text;-webkit-text-fill-color:transparent}
.preview-box{margin-top:8px;border-radius:10px;overflow:hidden;max-height:120px;background:rgba(15,23,42,.4);border:2px dashed rgba(255,255,255,.08);display:flex;align-items:center;justify-content:center;min-height:80px}
.preview-box img{max-width:100%;max-height:120px;object-fit:contain}
</style>
</head>
<body class="bg-[#0a0f1e] text-slate-200 min-h-screen">
<jsp:include page="/common/_admin-sidebar.jsp"/>
<jsp:include page="/common/_admin-header.jsp"/>

<main class="lg:ml-[260px] pt-20 pb-10 px-4 lg:px-8" style="max-width:700px">
    <a href="${ctx}/admin/dashboard" class="back-link"><i class="fas fa-arrow-left"></i> Quay lại Dashboard</a>
    <h1 class="page-title">
        <c:choose>
            <c:when test="${editMode}"><i class="fas fa-folder-open"></i> Sửa: <span class="hl">${editCategory.categoryName}</span></c:when>
            <c:otherwise><i class="fas fa-folder-plus"></i> Thêm <span class="hl">Danh Mục Mới</span></c:otherwise>
        </c:choose>
    </h1>
    <div class="form-card">
        <form action="${ctx}/admin/crud/category-save" method="post">
            <c:if test="${editMode}"><input type="hidden" name="categoryId" value="${editCategory.categoryId}"></c:if>
            <div class="form-grid">
                <div class="section-title"><i class="fas fa-info-circle"></i> Thông Tin Danh Mục</div>
                <div class="form-group form-full">
                    <label class="form-label"><i class="fas fa-tag"></i> Tên Danh Mục <span class="req">*</span></label>
                    <input type="text" name="categoryName" class="form-input" required value="${editMode ? editCategory.categoryName : ''}" placeholder="VD: Tour Mạo Hiểm">
                </div>
                <div class="form-group form-full">
                    <label class="form-label"><i class="fas fa-align-left"></i> Mô tả</label>
                    <textarea name="description" class="form-input" placeholder="Mô tả ngắn về danh mục...">${editMode ? editCategory.description : ''}</textarea>
                </div>
                <div class="form-group form-full">
                    <label class="form-label"><i class="fas fa-image"></i> Icon URL</label>
                    <input type="url" name="iconUrl" class="form-input" id="iconInput" value="${editMode ? editCategory.iconUrl : ''}" placeholder="https://..." oninput="previewIcon(this.value)">
                    <div class="preview-box" id="iconPreview">
                        <c:choose>
                            <c:when test="${editMode && not empty editCategory.iconUrl}"><img src="${editCategory.iconUrl}" alt="Icon"></c:when>
                            <c:otherwise><span style="color:#475569;font-size:.82rem"><i class="fas fa-image"></i> Xem trước icon</span></c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            <div class="btn-group">
                <a href="${ctx}/admin/dashboard" class="btn btn-cancel"><i class="fas fa-times"></i> Hủy</a>
                <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> ${editMode ? 'Cập Nhật' : 'Tạo Mới'}</button>
            </div>
        </form>
    </div>
</main>
<script>
function previewIcon(url){var b=document.getElementById('iconPreview');if(url&&url.startsWith('http')){b.innerHTML='<img src="'+url+'" alt="Icon">';}else{b.innerHTML='<span style="color:#475569;font-size:.82rem"><i class="fas fa-image"></i> Xem trước icon</span>';}}
</script>
</body>
</html>
