<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Quản Lý Mã Giảm Giá | Admin</title>
                <link
                    href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
                <style>
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box
                    }

                    body {
                        font-family: 'Plus Jakarta Sans', system-ui, sans-serif;
                        background: #F7F8FC;
                        color: #1B1F3B;
                        -webkit-font-smoothing: antialiased
                    }

                    .main {
                        margin-left: 260px;
                        padding: 32px 40px
                    }

                    .page-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 32px
                    }

                    .page-header h1 {
                        font-size: 1.6rem;
                        font-weight: 800;
                        display: flex;
                        align-items: center;
                        gap: 12px
                    }

                    .page-header h1 i {
                        color: #FF6F61
                    }

                    .btn {
                        padding: 10px 20px;
                        border-radius: 12px;
                        font-weight: 700;
                        font-size: .85rem;
                        border: none;
                        cursor: pointer;
                        font-family: inherit;
                        transition: .3s;
                        display: inline-flex;
                        align-items: center;
                        gap: 8px
                    }

                    .btn-primary {
                        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
                        color: #fff;
                        box-shadow: 0 4px 15px rgba(255, 111, 97, .2)
                    }

                    .btn-primary:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 8px 20px rgba(255, 111, 97, .35)
                    }

                    .btn-sm {
                        padding: 6px 14px;
                        font-size: .78rem;
                        border-radius: 8px
                    }

                    .btn-danger {
                        background: #FEE2E2;
                        color: #DC2626
                    }

                    .btn-danger:hover {
                        background: #DC2626;
                        color: #fff
                    }

                    .btn-success {
                        background: #D1FAE5;
                        color: #059669
                    }

                    .btn-warning {
                        background: #FEF3C7;
                        color: #D97706
                    }

                    /* Alert messages */
                    .alert {
                        padding: 14px 20px;
                        border-radius: 12px;
                        font-size: .85rem;
                        font-weight: 600;
                        margin-bottom: 20px;
                        display: flex;
                        align-items: center;
                        gap: 10px
                    }

                    .alert-success {
                        background: #D1FAE5;
                        color: #059669
                    }

                    .alert-error {
                        background: #FEE2E2;
                        color: #DC2626
                    }

                    /* Table */
                    .card {
                        background: #fff;
                        border-radius: 20px;
                        box-shadow: 0 4px 20px rgba(27, 31, 59, .05);
                        border: 1px solid #E8EAF0;
                        overflow: hidden
                    }

                    table {
                        width: 100%;
                        border-collapse: collapse
                    }

                    th {
                        background: #F7F8FC;
                        padding: 14px 18px;
                        text-align: left;
                        font-size: .78rem;
                        font-weight: 700;
                        color: #6B7194;
                        text-transform: uppercase;
                        letter-spacing: .5px
                    }

                    td {
                        padding: 14px 18px;
                        border-top: 1px solid #F0F1F5;
                        font-size: .88rem
                    }

                    tr:hover {
                        background: #FAFBFF
                    }

                    .code-badge {
                        display: inline-flex;
                        align-items: center;
                        gap: 6px;
                        padding: 6px 14px;
                        background: linear-gradient(135deg, rgba(255, 111, 97, .08), rgba(255, 154, 139, .04));
                        border: 1px solid rgba(255, 111, 97, .15);
                        border-radius: 8px;
                        font-weight: 800;
                        font-size: .82rem;
                        color: #FF6F61;
                        letter-spacing: .5px
                    }

                    .badge {
                        display: inline-flex;
                        padding: 4px 10px;
                        border-radius: 6px;
                        font-size: .72rem;
                        font-weight: 700
                    }

                    .badge-active {
                        background: #D1FAE5;
                        color: #059669
                    }

                    .badge-inactive {
                        background: #FEE2E2;
                        color: #DC2626
                    }

                    .badge-expired {
                        background: #F3F4F6;
                        color: #6B7194
                    }

                    .actions {
                        display: flex;
                        gap: 6px
                    }

                    /* Modal */
                    .modal-overlay {
                        display: none;
                        position: fixed;
                        inset: 0;
                        background: rgba(0, 0, 0, .5);
                        z-index: 999;
                        justify-content: center;
                        align-items: center
                    }

                    .modal-overlay.active {
                        display: flex
                    }

                    .modal {
                        background: #fff;
                        border-radius: 20px;
                        width: 580px;
                        max-height: 90vh;
                        overflow-y: auto;
                        box-shadow: 0 20px 60px rgba(0, 0, 0, .2)
                    }

                    .modal-header {
                        padding: 24px 28px;
                        border-bottom: 1px solid #F0F1F5;
                        display: flex;
                        justify-content: space-between;
                        align-items: center
                    }

                    .modal-header h3 {
                        font-size: 1.1rem;
                        font-weight: 800;
                        display: flex;
                        align-items: center;
                        gap: 10px
                    }

                    .modal-header h3 i {
                        color: #FF6F61
                    }

                    .modal-close {
                        background: none;
                        border: none;
                        font-size: 1.2rem;
                        cursor: pointer;
                        color: #A0A5C3;
                        padding: 8px
                    }

                    .modal-body {
                        padding: 24px 28px
                    }

                    .modal-footer {
                        padding: 16px 28px;
                        border-top: 1px solid #F0F1F5;
                        display: flex;
                        justify-content: flex-end;
                        gap: 10px
                    }

                    .form-grid {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 16px
                    }

                    .form-group {
                        display: flex;
                        flex-direction: column;
                        gap: 6px
                    }

                    .form-group.full {
                        grid-column: span 2
                    }

                    .form-group label {
                        font-size: .8rem;
                        font-weight: 700;
                        color: #4A4E6F
                    }

                    .form-group input,
                    .form-group select {
                        padding: 10px 14px;
                        border-radius: 10px;
                        border: 2px solid #E8EAF0;
                        font-family: inherit;
                        font-size: .88rem;
                        outline: none;
                        transition: .3s
                    }

                    .form-group input:focus,
                    .form-group select:focus {
                        border-color: #FF6F61;
                        box-shadow: 0 0 0 3px rgba(255, 111, 97, .08)
                    }

                    .empty-state {
                        text-align: center;
                        padding: 60px 20px;
                        color: #A0A5C3
                    }

                    .empty-state i {
                        font-size: 3rem;
                        margin-bottom: 16px;
                        opacity: .4
                    }

                    .empty-state p {
                        font-size: .95rem;
                        font-weight: 600
                    }

                    /* Stats */
                    .stats {
                        display: grid;
                        grid-template-columns: repeat(3, 1fr);
                        gap: 16px;
                        margin-bottom: 28px
                    }

                    .stat-card {
                        background: #fff;
                        border-radius: 16px;
                        padding: 20px 24px;
                        border: 1px solid #E8EAF0;
                        box-shadow: 0 2px 10px rgba(27, 31, 59, .03)
                    }

                    .stat-card .label {
                        font-size: .78rem;
                        font-weight: 700;
                        color: #A0A5C3;
                        margin-bottom: 6px
                    }

                    .stat-card .value {
                        font-size: 1.6rem;
                        font-weight: 800
                    }

                    .stat-card .value.green {
                        color: #059669
                    }

                    .stat-card .value.red {
                        color: #DC2626
                    }

                    .stat-card .value.blue {
                        color: #3B82F6
                    }
                </style>
            </head>

            <body>
                <jsp:include page="/common/_sidebar.jsp" />

                <div class="main">
                    <div class="page-header">
                        <h1><i class="fas fa-tags"></i> Quản Lý Mã Giảm Giá</h1>
                        <button class="btn btn-primary" onclick="openModal()"><i class="fas fa-plus"></i> Tạo Mã
                            Mới</button>
                    </div>

                    <!-- Alert Messages -->
                    <c:if test="${param.msg == 'created'}">
                        <div class="alert alert-success"><i class="fas fa-check-circle"></i> Tạo mã giảm giá thành công!
                        </div>
                    </c:if>
                    <c:if test="${param.msg == 'updated'}">
                        <div class="alert alert-success"><i class="fas fa-check-circle"></i> Cập nhật thành công!</div>
                    </c:if>
                    <c:if test="${param.msg == 'deleted'}">
                        <div class="alert alert-success"><i class="fas fa-check-circle"></i> Đã xóa mã giảm giá!</div>
                    </c:if>
                    <c:if test="${param.error == 'not_found'}">
                        <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> Không tìm thấy mã giảm
                            giá!</div>
                    </c:if>

                    <!-- Stats -->
                    <div class="stats">
                        <div class="stat-card">
                            <div class="label">Tổng Mã</div>
                            <div class="value blue">${coupons.size()}</div>
                        </div>
                        <div class="stat-card">
                            <div class="label">Đang Hoạt Động</div>
                            <div class="value green">
                                <c:set var="activeCount" value="0" />
                                <c:forEach items="${coupons}" var="c">
                                    <c:if test="${c.isActive}">
                                        <c:set var="activeCount" value="${activeCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                ${activeCount}
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="label">Tổng Lượt Dùng</div>
                            <div class="value red">
                                <c:set var="totalUsed" value="0" />
                                <c:forEach items="${coupons}" var="c">
                                    <c:set var="totalUsed" value="${totalUsed + c.usedCount}" />
                                </c:forEach>
                                ${totalUsed}
                            </div>
                        </div>
                    </div>

                    <!-- Table -->
                    <div class="card">
                        <c:choose>
                            <c:when test="${empty coupons}">
                                <div class="empty-state">
                                    <i class="fas fa-tags"></i>
                                    <p>Chưa có mã giảm giá nào</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Mã</th>
                                            <th>Giảm</th>
                                            <th>Đơn Tối Thiểu</th>
                                            <th>Giới Hạn</th>
                                            <th>Đã Dùng</th>
                                            <th>Thời Hạn</th>
                                            <th>Trạng Thái</th>
                                            <th>Thao Tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${coupons}" var="c">
                                            <tr>
                                                <td><span class="code-badge"><i class="fas fa-ticket-alt"></i>
                                                        ${c.code}</span></td>
                                                <td style="font-weight:700">
                                                    <c:choose>
                                                        <c:when test="${c.discountType == 'PERCENTAGE'}">
                                                            <fmt:formatNumber value="${c.discountValue}" type="number"
                                                                maxFractionDigits="0" />%
                                                            <c:if test="${c.maxDiscount != null}">
                                                                <small style="color:#A0A5C3;display:block">Tối đa
                                                                    <fmt:formatNumber value="${c.maxDiscount}"
                                                                        type="number" groupingUsed="true" />đ
                                                                </small>
                                                            </c:if>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatNumber value="${c.discountValue}" type="number"
                                                                groupingUsed="true" />đ
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${c.minOrderAmount > 0}">
                                                            <fmt:formatNumber value="${c.minOrderAmount}" type="number"
                                                                groupingUsed="true" />đ
                                                        </c:when>
                                                        <c:otherwise><span style="color:#A0A5C3">Không</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${c.usageLimit > 0}">${c.usageLimit} lượt</c:when>
                                                        <c:otherwise><span style="color:#A0A5C3">Không giới hạn</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td style="font-weight:700">${c.usedCount}</td>
                                                <td style="font-size:.82rem">
                                                    <c:if test="${c.startDate != null}">
                                                        <fmt:formatDate value="${c.startDate}" pattern="dd/MM/yyyy" />
                                                    </c:if>
                                                    <c:if test="${c.startDate != null && c.endDate != null}"> — </c:if>
                                                    <c:if test="${c.endDate != null}">
                                                        <fmt:formatDate value="${c.endDate}" pattern="dd/MM/yyyy" />
                                                    </c:if>
                                                    <c:if test="${c.startDate == null && c.endDate == null}"><span
                                                            style="color:#A0A5C3">Vĩnh viễn</span></c:if>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${c.isActive}"><span
                                                                class="badge badge-active">Hoạt động</span></c:when>
                                                        <c:otherwise><span class="badge badge-inactive">Tắt</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <div class="actions">
                                                        <a href="coupons?action=edit&id=${c.couponId}"
                                                            class="btn btn-sm btn-success"><i
                                                                class="fas fa-edit"></i></a>
                                                        <form method="post" action="coupons" style="display:inline">
                                                            <input type="hidden" name="action" value="toggle">
                                                            <input type="hidden" name="couponId" value="${c.couponId}">
                                                            <button type="submit" class="btn btn-sm btn-warning"
                                                                title="${c.isActive ? 'Tắt' : 'Bật'}">
                                                                <i class="fas fa-${c.isActive ? 'pause' : 'play'}"></i>
                                                            </button>
                                                        </form>
                                                        <form method="post" action="coupons" style="display:inline"
                                                            onsubmit="return confirm('Xóa mã ${c.code}?')">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="couponId" value="${c.couponId}">
                                                            <button type="submit" class="btn btn-sm btn-danger"><i
                                                                    class="fas fa-trash"></i></button>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Create/Edit Modal -->
                <div class="modal-overlay" id="couponModal">
                    <div class="modal">
                        <div class="modal-header">
                            <h3><i class="fas fa-tag"></i> <span id="modalTitle">Tạo Mã Giảm Giá</span></h3>
                            <button class="modal-close" onclick="closeModal()">&times;</button>
                        </div>
                        <form method="post" action="${pageContext.request.contextPath}/admin/coupons">
                            <input type="hidden" name="action" id="formAction" value="create">
                            <input type="hidden" name="couponId" id="formCouponId" value="">
                            <div class="modal-body">
                                <div class="form-grid">
                                    <div class="form-group full">
                                        <label>Mã Giảm Giá *</label>
                                        <input type="text" name="code" id="formCode" required
                                            placeholder="VD: SUMMER2026" style="text-transform:uppercase">
                                    </div>
                                    <div class="form-group">
                                        <label>Loại Giảm Giá *</label>
                                        <select name="discountType" id="formDiscountType">
                                            <option value="PERCENTAGE">Phần trăm (%)</option>
                                            <option value="FIXED">Số tiền cố định (đ)</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Giá Trị *</label>
                                        <input type="number" name="discountValue" id="formDiscountValue" required
                                            min="0" step="0.01" placeholder="VD: 10">
                                    </div>
                                    <div class="form-group">
                                        <label>Đơn Tối Thiểu (đ)</label>
                                        <input type="number" name="minOrderAmount" id="formMinOrder" min="0" step="1000"
                                            placeholder="0 = không giới hạn">
                                    </div>
                                    <div class="form-group">
                                        <label>Giảm Tối Đa (đ)</label>
                                        <input type="number" name="maxDiscount" id="formMaxDiscount" min="0" step="1000"
                                            placeholder="Chỉ cho loại %">
                                    </div>
                                    <div class="form-group">
                                        <label>Giới Hạn Lượt Dùng</label>
                                        <input type="number" name="usageLimit" id="formUsageLimit" min="0"
                                            placeholder="0 = không giới hạn">
                                    </div>
                                    <div class="form-group">
                                        <label>Kích Hoạt</label>
                                        <select name="isActive" id="formIsActive">
                                            <option value="on">Có</option>
                                            <option value="">Không</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Ngày Bắt Đầu</label>
                                        <input type="date" name="startDate" id="formStartDate">
                                    </div>
                                    <div class="form-group">
                                        <label>Ngày Kết Thúc</label>
                                        <input type="date" name="endDate" id="formEndDate">
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn" onclick="closeModal()"
                                    style="background:#F3F4F6;color:#6B7194">Hủy</button>
                                <button type="submit" class="btn btn-primary" id="formSubmitBtn">Tạo Mã</button>
                            </div>
                        </form>
                    </div>
                </div>

                <script>
                    function openModal() {
                        document.getElementById('formAction').value = 'create';
                        document.getElementById('formCouponId').value = '';
                        document.getElementById('modalTitle').textContent = 'Tạo Mã Giảm Giá';
                        document.getElementById('formSubmitBtn').textContent = 'Tạo Mã';
                        document.getElementById('formCode').value = '';
                        document.getElementById('formDiscountType').value = 'PERCENTAGE';
                        document.getElementById('formDiscountValue').value = '';
                        document.getElementById('formMinOrder').value = '';
                        document.getElementById('formMaxDiscount').value = '';
                        document.getElementById('formUsageLimit').value = '';
                        document.getElementById('formStartDate').value = '';
                        document.getElementById('formEndDate').value = '';
                        document.getElementById('formIsActive').value = 'on';
                        document.getElementById('couponModal').classList.add('active');
                    }

                    function closeModal() {
                        document.getElementById('couponModal').classList.remove('active');
                    }

                    // Auto-open edit modal if editCoupon is set
                    <c:if test="${editCoupon != null}">
                        (function() {
                            document.getElementById('formAction').value = 'update';
                        document.getElementById('formCouponId').value = '${editCoupon.couponId}';
                        document.getElementById('modalTitle').textContent = 'Sửa Mã Giảm Giá';
                        document.getElementById('formSubmitBtn').textContent = 'Cập Nhật';
                        document.getElementById('formCode').value = '${editCoupon.code}';
                        document.getElementById('formDiscountType').value = '${editCoupon.discountType}';
                        document.getElementById('formDiscountValue').value = '${editCoupon.discountValue}';
                        document.getElementById('formMinOrder').value = '${editCoupon.minOrderAmount}';
                        document.getElementById('formMaxDiscount').value = '${editCoupon.maxDiscount != null ? editCoupon.maxDiscount : ""}';
                        document.getElementById('formUsageLimit').value = '${editCoupon.usageLimit}';
                        <c:if test="${editCoupon.startDate != null}">
                            document.getElementById('formStartDate').value = '<fmt:formatDate value="${editCoupon.startDate}" pattern="yyyy-MM-dd" />';
                        </c:if>
                        <c:if test="${editCoupon.endDate != null}">
                            document.getElementById('formEndDate').value = '<fmt:formatDate value="${editCoupon.endDate}" pattern="yyyy-MM-dd" />';
                        </c:if>
                        document.getElementById('formIsActive').value = '${editCoupon.isActive ? "on" : ""}';
                        document.getElementById('couponModal').classList.add('active');
})();
                    </c:if>
                </script>
            </body>

            </html>