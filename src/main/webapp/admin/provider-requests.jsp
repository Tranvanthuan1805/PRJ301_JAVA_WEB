<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Đơn Đăng Ký NCC | Admin EZTravel</title>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
            <style>
                body {
                    background: #f1f5f9;
                    font-family: 'Segoe UI', system-ui, sans-serif;
                }

                .sidebar {
                    width: 240px;
                    min-height: 100vh;
                    background: #0f172a;
                    position: fixed;
                    top: 0;
                    left: 0;
                    padding: 24px 16px;
                }

                .sidebar .brand {
                    color: #fff;
                    font-size: 1.2rem;
                    font-weight: 800;
                    padding: 0 8px 20px;
                    border-bottom: 1px solid rgba(255, 255, 255, .08);
                    margin-bottom: 16px;
                }

                .sidebar a {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    padding: 10px 12px;
                    border-radius: 8px;
                    color: rgba(255, 255, 255, .55);
                    font-size: .88rem;
                    text-decoration: none;
                    margin-bottom: 2px;
                    transition: .2s;
                }

                .sidebar a:hover,
                .sidebar a.active {
                    background: rgba(59, 130, 246, .15);
                    color: #fff;
                }

                .main {
                    margin-left: 240px;
                    padding: 32px;
                }

                .badge-pending {
                    background: #ef4444;
                    color: #fff;
                    font-size: .65rem;
                    padding: 2px 7px;
                    border-radius: 20px;
                    margin-left: auto;
                }

                .status-badge {
                    padding: 4px 12px;
                    border-radius: 20px;
                    font-size: .75rem;
                    font-weight: 700;
                }

                .status-pending {
                    background: #fef3c7;
                    color: #92400e;
                }

                .status-approved {
                    background: #d1fae5;
                    color: #065f46;
                }

                .status-rejected {
                    background: #fee2e2;
                    color: #991b1b;
                }

                .tab-btn {
                    border: none;
                    background: none;
                    padding: 8px 18px;
                    border-radius: 8px;
                    font-size: .88rem;
                    font-weight: 600;
                    cursor: pointer;
                    color: #64748b;
                    transition: .2s;
                }

                .tab-btn.active {
                    background: #3b82f6;
                    color: #fff;
                }

                .toast-container {
                    position: fixed;
                    bottom: 24px;
                    right: 24px;
                    z-index: 9999;
                }
            </style>
        </head>

        <body>

            <!-- Sidebar -->
            <div class="sidebar">
                <div class="brand"><i class="fas fa-plane" style="color:#60A5FA"></i> EZTravel Admin</div>
                <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-th-large"></i>
                    Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/provider-requests" class="active">
                    <i class="fas fa-handshake"></i> Đơn NCC
                    <c:if test="${pendingCount > 0}">
                        <span class="badge-pending" id="pendingBadge">${pendingCount}</span>
                    </c:if>
                    <c:if test="${pendingCount == 0}">
                        <span class="badge-pending" id="pendingBadge" style="display:none">0</span>
                    </c:if>
                </a>
                <a href="${pageContext.request.contextPath}/home"><i class="fas fa-globe"></i> Xem Website</a>
            </div>

            <!-- Main content -->
            <div class="main">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <div>
                        <h4 class="fw-bold mb-1">Đơn Đăng Ký Nhà Cung Cấp</h4>
                        <p class="text-muted mb-0" style="font-size:.85rem">Xét duyệt các đơn đăng ký từ người dùng
                        </p>
                    </div>
                    <span class="badge bg-warning text-dark fs-6">${pendingCount} đơn chờ duyệt</span>
                </div>

                <!-- Tab filter -->
                <div class="mb-3">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger mb-3">${errorMessage}</div>
                    </c:if>
                    <a href="?status=all">
                        <button class="tab-btn ${activeFilter == 'all' ? 'active' : ''}">Tất Cả</button>
                    </a>
                    <a href="?status=pending">
                        <button class="tab-btn ${activeFilter == 'pending' ? 'active' : ''}">🟡 Chờ Duyệt</button>
                    </a>
                    <a href="?status=approved">
                        <button class="tab-btn ${activeFilter == 'approved' ? 'active' : ''}">✅ Đã Duyệt</button>
                    </a>
                    <a href="?status=rejected">
                        <button class="tab-btn ${activeFilter == 'rejected' ? 'active' : ''}">❌ Từ Chối</button>
                    </a>
                </div>

                <!-- Bảng danh sách -->
                <div class="card border-0 shadow-sm">
                    <div class="card-body p-0">
                        <table class="table table-hover mb-0" id="regTable">
                            <thead class="table-light">
                                <tr>
                                    <th style="width:50px">#</th>
                                    <th>Tên Doanh Nghiệp</th>
                                    <th>Loại Hình</th>
                                    <th>Người Đăng Ký</th>
                                    <th>SĐT</th>
                                    <th>Ngày Gửi</th>
                                    <th>Trạng Thái</th>
                                    <th style="width:160px">Hành Động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${registrations}" var="r">
                                    <tr id="row-${r.id}">
                                        <td class="text-muted fw-bold">#${r.id}</td>
                                        <td>
                                            <div class="fw-bold">${r.businessName}</div>
                                            <c:if test="${not empty r.description}">
                                                <small class="text-muted">${r.description.length() > 60 ?
                                                    r.description.substring(0,60).concat('...') :
                                                    r.description}</small>
                                            </c:if>
                                        </td>
                                        <td><span
                                                class="badge bg-primary bg-opacity-10 text-primary">${r.category}</span>
                                        </td>
                                        <td>
                                            <c:if test="${not empty r.user}">
                                                <div>${r.user.fullName != null ? r.user.fullName : r.user.username}
                                                </div>
                                                <small class="text-muted">${r.user.email}</small>
                                            </c:if>
                                        </td>
                                        <td>${r.phone}</td>
                                        <td style="font-size:.82rem;white-space:nowrap">
                                            ${r.createdAt != null ? r.createdAt.toString().replace('T','
                                            ').substring(0,16) : ''}
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${r.status == 'pending'}">
                                                    <span class="status-badge status-pending">🟡 Chờ duyệt</span>
                                                </c:when>
                                                <c:when test="${r.status == 'approved'}">
                                                    <span class="status-badge status-approved">✅ Đã duyệt</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge status-rejected">❌ Từ chối</span>
                                                    <c:if test="${not empty r.adminNote}">
                                                        <div style="font-size:.72rem;color:#9ca3af;margin-top:3px">
                                                            ${r.adminNote}</div>
                                                    </c:if>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:if test="${r.status == 'pending'}">
                                                <button class="btn btn-sm btn-success me-1"
                                                    onclick="doAction(${r.id}, 'approve', '${r.businessName}')">
                                                    <i class="fas fa-check"></i> Duyệt
                                                </button>
                                                <button class="btn btn-sm btn-danger"
                                                    onclick="openRejectModal(${r.id}, '${r.businessName}')">
                                                    <i class="fas fa-times"></i> Từ Chối
                                                </button>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty registrations}">
                                    <tr>
                                        <td colspan="8" class="text-center py-5 text-muted">
                                            <i class="fas fa-inbox fa-2x mb-2 d-block opacity-25"></i>
                                            Không có đơn nào
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Modal từ chối -->
            <div class="modal fade" id="rejectModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Từ Chối Đơn</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <p>Từ chối đơn của <strong id="rejectBizName"></strong>?</p>
                            <label class="form-label fw-bold">Lý do từ chối <span class="text-danger">*</span></label>
                            <textarea id="rejectNote" class="form-control" rows="3"
                                placeholder="Nhập lý do để thông báo cho người đăng ký..."></textarea>
                            <div id="rejectNoteErr" class="text-danger mt-1" style="display:none;font-size:.82rem">
                                Vui lòng nhập lý do.</div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                            <button class="btn btn-danger" id="btnConfirmReject">
                                <i class="fas fa-times"></i> Xác Nhận Từ Chối
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Toast container -->
            <div class="toast-container" id="toastContainer"></div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                const ctx = '${pageContext.request.contextPath}';
                let rejectModal, currentRejectId;

                document.addEventListener('DOMContentLoaded', function () {
                    rejectModal = new bootstrap.Modal(document.getElementById('rejectModal'));

                    // ── WebSocket realtime ────────────────────────────────────────────────
                    const wsUrl = (location.protocol === 'https:' ? 'wss' : 'ws') +
                        '://' + location.host + ctx + '/ws/notifications';
                    const ws = new WebSocket(wsUrl);

                    ws.onmessage = function (e) {
                        try {
                            const data = JSON.parse(e.data);

                            if (data.type === 'NEW_PROVIDER') {
                                // Hiện toast thông báo
                                showToast('🔔 Nhà cung cấp mới đăng ký: <strong>' + esc(data.businessName) + '</strong>', 'info');
                                // Cập nhật badge
                                updateBadge(data.count);
                                // Tự động refresh bảng
                                refreshTable();
                            }

                            if (data.type === 'STATUS_UPDATE') {
                                updateBadge(data.count);
                            }
                        } catch (err) { /* bỏ qua */ }
                    };

                    ws.onerror = function () {
                        console.warn('WebSocket không kết nối được — realtime tắt');
                    };
                });

                // ── Duyệt đơn ────────────────────────────────────────────────────────────
                async function doAction(id, action, bizName) {
                    const note = action === 'approve' ? '' : document.getElementById('rejectNote').value.trim();

                    const res = await fetch(ctx + '/api/admin/provider', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ registrationId: id, action, adminNote: note })
                    });
                    const data = await res.json();

                    if (data.success) {
                        showToast('✅ ' + data.message, 'success');
                        updateBadge(data.pendingCount);
                        // Cập nhật row trong bảng mà không reload trang
                        const row = document.getElementById('row-' + id);
                        if (row) {
                            const statusCell = row.cells[6];
                            const actionCell = row.cells[7];
                            if (action === 'approve') {
                                statusCell.innerHTML = '<span class="status-badge status-approved">✅ Đã duyệt</span>';
                            } else {
                                statusCell.innerHTML = '<span class="status-badge status-rejected">❌ Từ chối</span>'
                                    + (note ? '<div style="font-size:.72rem;color:#9ca3af;margin-top:3px">' + esc(note) + '</div>' : '');
                            }
                            actionCell.innerHTML = '';
                        }
                        if (rejectModal) rejectModal.hide();
                    } else {
                        showToast('❌ ' + data.message, 'danger');
                    }
                }

                // ── Modal từ chối ─────────────────────────────────────────────────────────
                function openRejectModal(id, bizName) {
                    currentRejectId = id;
                    document.getElementById('rejectBizName').textContent = bizName;
                    document.getElementById('rejectNote').value = '';
                    document.getElementById('rejectNoteErr').style.display = 'none';
                    rejectModal.show();
                }

                document.getElementById('btnConfirmReject').addEventListener('click', function () {
                    const note = document.getElementById('rejectNote').value.trim();
                    if (!note) {
                        document.getElementById('rejectNoteErr').style.display = 'block';
                        return;
                    }
                    doAction(currentRejectId, 'reject', '');
                });

                // ── Refresh bảng qua AJAX ─────────────────────────────────────────────────
                async function refreshTable() {
                    try {
                        const res = await fetch(location.href, { headers: { 'X-Requested-With': 'XMLHttpRequest' } });
                        const html = await res.text();
                        const parser = new DOMParser();
                        const doc = parser.parseFromString(html, 'text/html');
                        const newTbody = doc.querySelector('#regTable tbody');
                        if (newTbody) {
                            document.querySelector('#regTable tbody').innerHTML = newTbody.innerHTML;
                        }
                    } catch (e) { /* bỏ qua */ }
                }

                // ── Badge ─────────────────────────────────────────────────────────────────
                function updateBadge(count) {
                    const badge = document.getElementById('pendingBadge');
                    if (!badge) return;
                    if (count > 0) {
                        badge.textContent = count;
                        badge.style.display = 'inline-block';
                    } else {
                        badge.style.display = 'none';
                    }
                }

                // ── Toast ─────────────────────────────────────────────────────────────────
                function showToast(msg, type) {
                    const t = document.createElement('div');
                    t.className = 'toast align-items-center text-bg-' + type + ' border-0 show mb-2';
                    t.setAttribute('role', 'alert');
                    t.innerHTML = '<div class="d-flex"><div class="toast-body">' + msg + '</div>'
                        + '<button type="button" class="btn-close btn-close-white me-2 m-auto" onclick="this.closest(\'.toast\').remove()"></button></div>';
                    document.getElementById('toastContainer').appendChild(t);
                    setTimeout(() => t.remove(), 6000);
                }

                function esc(s) {
                    return String(s || '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
                }
            </script>

        </body>

        </html>