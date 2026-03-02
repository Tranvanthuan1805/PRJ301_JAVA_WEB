<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/include/header.jsp">
    <jsp:param name="activeNav" value="payment" />
    <jsp:param name="pageTitle" value="Thanh toán VietQR" />
</jsp:include>

<style>
    .payment-card {
        max-width: 500px;
        margin: auto;
        border-radius: 20px;
        overflow: hidden;
        border: none;
        box-shadow: 0 10px 40px rgba(0,0,0,0.1);
    }
    .payment-header {
        background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
        color: white;
        text-align: center;
        padding: 30px;
    }
    .qr-container {
        padding: 40px;
        text-align: center;
        background: white;
    }
    .qr-image {
        max-width: 100%;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        border: 1px solid #f0f0f0;
        transition: transform 0.3s;
    }
    .qr-image:hover {
        transform: scale(1.05);
    }
    .payment-info {
        padding: 0 40px 40px;
        background: white;
    }
    .info-row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 12px;
        font-size: 0.95rem;
    }
    .info-label { color: #666; }
    .info-value { font-weight: 700; color: #333; }
    .status-check {
        padding-top: 20px;
        border-top: 1px solid #eee;
        text-align: center;
    }
    .pulse-dot {
        height: 10px;
        width: 10px;
        background-color: #28a745;
        border-radius: 50%;
        display: inline-block;
        box-shadow: 0 0 0 rgba(40, 167, 69, 0.4);
        animation: pulse 2s infinite;
        margin-right: 8px;
    }
    @keyframes pulse {
        0% { box-shadow: 0 0 0 0 rgba(40, 167, 69, 0.4); }
        70% { box-shadow: 0 0 0 10px rgba(40, 167, 69, 0); }
        100% { box-shadow: 0 0 0 0 rgba(40, 167, 69, 0); }
    }
</style>

<div class="container py-5">
    <div class="card payment-card">
        <div class="payment-header">
            <h3><i class="fas fa-qrcode"></i> Thanh toán VietQR</h3>
            <p class="mb-0 opacity-75">Quét mã bằng App ngân hàng hoặc Ví điện tử</p>
        </div>
        
        <div class="qr-container">
            <img src="${qrUrl}" alt="SePay QR Code" class="qr-image">
            <div class="mt-4 text-muted small">
                <p><i class="fas fa-shield-alt"></i> Thanh toán an toàn và tự động qua SePay</p>
            </div>
        </div>

        <div class="payment-info">
            <div class="info-row">
                <span class="info-label">Đơn hàng:</span>
                <span class="info-value">#${order.orderId} - ${order.tourName}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Số tiền:</span>
                <span class="info-value text-primary h4 mb-0">
                    <fmt:formatNumber value="${amount}" pattern="#,###"/>đ
                </span>
            </div>
            <div class="info-row">
                <span class="info-label">Nội dung (Phải giữ nguyên):</span>
                <span class="info-value border border-warning px-2 py-1 rounded bg-light">${transCode}</span>
            </div>
            
            <div class="status-check">
                <p><span class="pulse-dot"></span> Đang chờ hệ thống xác nhận thanh toán...</p>
                <div class="progress" style="height: 5px;">
                    <div class="progress-bar progress-bar-striped progress-bar-animated" style="width: 100%"></div>
                </div>
                <small class="text-muted mt-2 d-block">Vui lòng không đóng trang này cho đến khi nhận được xác nhận.</small>
            </div>
            
            <div class="mt-4 text-center">
                <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-outline-secondary btn-sm">
                    Quay lại danh sách đơn hàng
                </a>
            </div>
        </div>
    </div>
</div>

<script>
    // Polling de check trang thai thanh toan (giả lập hoặc gọi servlet check)
    setInterval(function() {
        fetch('${pageContext.request.contextPath}/check-payment?code=${transCode}')
            .then(res => res.json())
            .then(data => {
                if(data.status === 'Paid') {
                    window.location.href = '${pageContext.request.contextPath}/my-orders?msg=paid_success';
                }
            });
    }, 5000); // Check moi 5 giay
</script>

<jsp:include page="/include/footer.jsp" />
