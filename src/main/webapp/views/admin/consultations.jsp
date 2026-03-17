<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tư Vấn Khách Hàng — Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        *{margin:0;padding:0;box-sizing:border-box}
        body{font-family:'Inter',sans-serif;background:#0B1120;color:#E2E8F0;min-height:100vh}
        .main{margin-left:260px;padding:32px;min-height:100vh}

        /* Header */
        .page-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:32px}
        .page-title{font-size:1.6rem;font-weight:800;color:#fff}
        .page-title i{color:#3B82F6;margin-right:8px}

        /* Stats */
        .stats-row{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:28px}
        .stat-card{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:14px;padding:20px;transition:.3s;cursor:pointer;text-decoration:none;color:inherit}
        .stat-card:hover{background:rgba(255,255,255,.07);transform:translateY(-2px)}
        .stat-card.active{border-color:rgba(59,130,246,.4);background:rgba(59,130,246,.08)}
        .stat-num{font-size:2rem;font-weight:900;color:#fff;margin-bottom:4px}
        .stat-label{font-size:.78rem;color:#94A3B8;font-weight:500}
        .stat-icon{float:right;width:40px;height:40px;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:1rem}
        .stat-icon.blue{background:rgba(59,130,246,.12);color:#60A5FA}
        .stat-icon.orange{background:rgba(245,158,11,.12);color:#FBBF24}
        .stat-icon.green{background:rgba(16,185,129,.12);color:#34D399}
        .stat-icon.purple{background:rgba(139,92,246,.12);color:#A78BFA}

        /* Table */
        .table-wrap{background:rgba(255,255,255,.03);border:1px solid rgba(255,255,255,.06);border-radius:16px;overflow:hidden}
        .table-header{padding:20px 24px;border-bottom:1px solid rgba(255,255,255,.06);display:flex;align-items:center;justify-content:space-between}
        .table-header h3{font-size:.95rem;font-weight:700;color:#fff}
        table{width:100%;border-collapse:collapse}
        th{padding:14px 20px;text-align:left;font-size:.72rem;font-weight:700;color:#64748B;text-transform:uppercase;letter-spacing:.5px;border-bottom:1px solid rgba(255,255,255,.06)}
        td{padding:16px 20px;border-bottom:1px solid rgba(255,255,255,.04);font-size:.85rem}
        tr:hover td{background:rgba(255,255,255,.02)}
        .name-cell{font-weight:700;color:#fff}
        .email-cell{color:#60A5FA;font-size:.8rem}
        .phone-cell{color:#94A3B8;font-size:.8rem}
        .type-badge{padding:4px 10px;border-radius:6px;font-size:.7rem;font-weight:700;background:rgba(59,130,246,.1);color:#60A5FA;display:inline-block}
        .msg-cell{max-width:200px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;color:#94A3B8;font-size:.82rem}

        /* Status badges */
        .badge{padding:4px 12px;border-radius:999px;font-size:.68rem;font-weight:700;display:inline-flex;align-items:center;gap:4px}
        .badge-info{background:rgba(59,130,246,.12);color:#60A5FA}
        .badge-warning{background:rgba(245,158,11,.12);color:#FBBF24}
        .badge-success{background:rgba(16,185,129,.12);color:#34D399}
        .badge-secondary{background:rgba(148,163,184,.12);color:#94A3B8}

        /* Actions */
        .action-btn{padding:6px 12px;border-radius:8px;font-size:.72rem;font-weight:600;border:none;cursor:pointer;transition:.2s;display:inline-flex;align-items:center;gap:4px}
        .action-btn.primary{background:rgba(59,130,246,.15);color:#60A5FA}
        .action-btn.primary:hover{background:rgba(59,130,246,.25)}
        .action-btn.success{background:rgba(16,185,129,.15);color:#34D399}
        .action-btn.success:hover{background:rgba(16,185,129,.25)}

        /* Modal */
        .modal-overlay{display:none;position:fixed;inset:0;background:rgba(0,0,0,.6);z-index:1000;align-items:center;justify-content:center}
        .modal-overlay.show{display:flex}
        .modal{background:#1E293B;border-radius:16px;padding:28px;width:440px;max-width:90vw;border:1px solid rgba(255,255,255,.08)}
        .modal h3{font-size:1.1rem;font-weight:800;color:#fff;margin-bottom:20px}
        .modal label{font-size:.78rem;font-weight:600;color:#94A3B8;display:block;margin-bottom:6px}
        .modal select,.modal textarea{width:100%;padding:10px 14px;border:1px solid rgba(255,255,255,.1);border-radius:8px;background:rgba(255,255,255,.05);color:#E2E8F0;font-size:.85rem;font-family:'Inter',sans-serif;outline:none;margin-bottom:16px}
        .modal select:focus,.modal textarea:focus{border-color:#3B82F6}
        .modal textarea{min-height:100px;resize:vertical}
        .modal-btns{display:flex;gap:10px;justify-content:flex-end}
        .modal-btns button{padding:10px 20px;border-radius:8px;font-size:.82rem;font-weight:700;border:none;cursor:pointer;transition:.2s}
        .modal-btns .cancel{background:rgba(255,255,255,.06);color:#94A3B8}
        .modal-btns .cancel:hover{background:rgba(255,255,255,.1)}
        .modal-btns .save{background:#3B82F6;color:#fff}
        .modal-btns .save:hover{background:#2563EB}

        .empty-state{text-align:center;padding:60px 20px;color:#64748B}
        .empty-state i{font-size:3rem;opacity:.3;margin-bottom:16px}
        .empty-state p{font-size:.9rem}

        .date-cell{color:#64748B;font-size:.78rem}

        @media(max-width:1023px){.main{margin-left:0;padding:20px}}
        @media(max-width:768px){.stats-row{grid-template-columns:repeat(2,1fr)}}
    </style>
</head>
<body>
    <jsp:include page="/common/_admin-sidebar.jsp"/>
    <jsp:include page="/common/_admin-header.jsp"/>

    <div class="main">
        <div class="page-header">
            <h1 class="page-title"><i class="fas fa-comments"></i> Yêu Cầu Tư Vấn</h1>
        </div>

        <c:if test="${not empty errorMessage}">
            <div style="background:rgba(239,68,68,.12);border:1px solid rgba(239,68,68,.3);border-radius:12px;padding:16px 20px;margin-bottom:20px;color:#F87171;font-size:.85rem;display:flex;align-items:center;gap:10px">
                <i class="fas fa-exclamation-triangle"></i>
                <span>${errorMessage} — Hãy chạy SQL tạo bảng Consultations trên Supabase.</span>
            </div>
        </c:if>

        <!-- Stats -->
        <div class="stats-row">
            <a href="${ctx}/admin/consultations" class="stat-card ${empty currentStatus ? 'active' : ''}">
                <div class="stat-icon purple"><i class="fas fa-inbox"></i></div>
                <div class="stat-num">${totalAll}</div>
                <div class="stat-label">Tổng yêu cầu</div>
            </a>
            <a href="${ctx}/admin/consultations?status=new" class="stat-card ${currentStatus == 'new' ? 'active' : ''}">
                <div class="stat-icon blue"><i class="fas fa-bell"></i></div>
                <div class="stat-num">${totalNew}</div>
                <div class="stat-label">Chưa xử lý</div>
            </a>
            <a href="${ctx}/admin/consultations?status=contacted" class="stat-card ${currentStatus == 'contacted' ? 'active' : ''}">
                <div class="stat-icon orange"><i class="fas fa-phone"></i></div>
                <div class="stat-num">${totalContacted}</div>
                <div class="stat-label">Đã liên hệ</div>
            </a>
            <a href="${ctx}/admin/consultations?status=done" class="stat-card ${currentStatus == 'done' ? 'active' : ''}">
                <div class="stat-icon green"><i class="fas fa-check-circle"></i></div>
                <div class="stat-num">${totalDone}</div>
                <div class="stat-label">Hoàn thành</div>
            </a>
        </div>

        <!-- Table -->
        <div class="table-wrap">
            <div class="table-header">
                <h3><i class="fas fa-list" style="margin-right:8px;opacity:.5"></i> Danh sách yêu cầu</h3>
            </div>
            <c:choose>
                <c:when test="${not empty consultations}">
                    <table>
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Khách hàng</th>
                                <th>Loại tour</th>
                                <th>Tin nhắn</th>
                                <th>Ngày gửi</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${consultations}" var="c" varStatus="s">
                                <tr>
                                    <td style="color:#64748B;font-weight:600">${s.count}</td>
                                    <td>
                                        <div class="name-cell">${c.fullName}</div>
                                        <div class="email-cell">${c.email}</div>
                                        <c:if test="${not empty c.phone}"><div class="phone-cell"><i class="fas fa-phone" style="font-size:.6rem;margin-right:4px"></i>${c.phone}</div></c:if>
                                    </td>
                                    <td><span class="type-badge">${c.tourTypeLabel}</span></td>
                                    <td class="msg-cell" title="${c.message}">${c.message}</td>
                                    <td class="date-cell"><fmt:formatDate value="${c.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td><span class="badge ${c.statusBadge}">
                                        <c:choose>
                                            <c:when test="${c.status == 'new'}"><i class="fas fa-circle" style="font-size:.4rem"></i> Mới</c:when>
                                            <c:when test="${c.status == 'contacted'}"><i class="fas fa-phone"></i> Đã liên hệ</c:when>
                                            <c:when test="${c.status == 'done'}"><i class="fas fa-check"></i> Hoàn thành</c:when>
                                            <c:otherwise>${c.status}</c:otherwise>
                                        </c:choose>
                                    </span></td>
                                    <td>
                                        <button class="action-btn primary" onclick="openModal(${c.consultationId},'${c.status}','${c.adminNote}')">
                                            <i class="fas fa-edit"></i> Cập nhật
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-inbox"></i>
                        <p>Chưa có yêu cầu tư vấn nào</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Update Status Modal -->
    <div class="modal-overlay" id="statusModal">
        <div class="modal">
            <h3><i class="fas fa-edit" style="margin-right:8px;color:#3B82F6"></i> Cập nhật trạng thái</h3>
            <form method="POST" action="${ctx}/admin/consultations">
                <input type="hidden" name="action" value="updateStatus">
                <input type="hidden" name="id" id="modalId">
                <label>Trạng thái</label>
                <select name="status" id="modalStatus">
                    <option value="new">🔵 Mới</option>
                    <option value="contacted">🟡 Đã liên hệ</option>
                    <option value="done">🟢 Hoàn thành</option>
                </select>
                <label>Ghi chú Admin</label>
                <textarea name="note" id="modalNote" placeholder="Ghi chú xử lý..."></textarea>
                <div class="modal-btns">
                    <button type="button" class="cancel" onclick="closeModal()">Hủy</button>
                    <button type="submit" class="save">Lưu</button>
                </div>
            </form>
        </div>
    </div>

    <script>
    function openModal(id, status, note) {
        document.getElementById('modalId').value = id;
        document.getElementById('modalStatus').value = status || 'new';
        document.getElementById('modalNote').value = note || '';
        document.getElementById('statusModal').classList.add('show');
    }
    function closeModal() {
        document.getElementById('statusModal').classList.remove('show');
    }
    document.getElementById('statusModal').addEventListener('click', function(e) {
        if (e.target === this) closeModal();
    });
    </script>
</body>
</html>
