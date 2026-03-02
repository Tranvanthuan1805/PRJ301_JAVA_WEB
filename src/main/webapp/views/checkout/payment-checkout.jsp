<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán QR | EZTravel Đà Nẵng</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
    body{font-family:'Plus Jakarta Sans',system-ui,sans-serif;background:linear-gradient(135deg,#F7F8FC 0%,#EDE9FE 100%);color:#1B1F3B;min-height:100vh}
    .payment-page{max-width:900px;margin:0 auto;padding:100px 30px 80px}
    .payment-header{text-align:center;margin-bottom:40px}
    .payment-header h1{font-size:2rem;font-weight:800;letter-spacing:-.5px}
    .payment-header h1 i{color:#059669}
    .payment-header p{color:#6B7194;margin-top:6px}

    /* Steps */
    .steps{display:flex;justify-content:center;gap:0;margin-bottom:40px}
    .step{display:flex;align-items:center;gap:10px;padding:12px 24px}
    .step .num{width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-weight:800;font-size:.82rem;border:2px solid #E8EAF0;color:#A0A5C3;background:#fff}
    .step.active .num{background:linear-gradient(135deg,#059669,#34D399);color:#fff;border-color:#059669}
    .step.done .num{background:#059669;border-color:#059669;color:#fff}
    .step.active .text,.step.done .text{color:#059669;font-weight:700;font-size:.85rem}
    .step .text{font-weight:700;font-size:.85rem;color:#A0A5C3}
    .step-line{width:80px;height:2px;background:#E8EAF0;align-self:center}
    .step-line.done{background:#059669}

    .payment-layout{display:grid;grid-template-columns:1fr 1fr;gap:30px;align-items:start}

    /* QR Card */
    .qr-card{background:#fff;border-radius:24px;padding:36px;box-shadow:0 8px 40px rgba(27,31,59,.08);border:1px solid #E8EAF0;text-align:center}
    .qr-card h3{font-size:1.1rem;font-weight:800;margin-bottom:6px;display:flex;align-items:center;justify-content:center;gap:10px}
    .qr-card h3 i{color:#059669}
    .qr-card .subtitle{font-size:.82rem;color:#A0A5C3;margin-bottom:24px}
    .qr-frame{position:relative;display:inline-block;padding:16px;background:linear-gradient(135deg,#059669,#34D399);border-radius:20px;margin-bottom:20px;box-shadow:0 8px 30px rgba(5,150,105,.2)}
    .qr-frame img{width:280px;height:280px;border-radius:12px;background:#fff;display:block}
    .qr-amount{font-size:2rem;font-weight:800;color:#059669;margin:16px 0 6px;letter-spacing:-1px}
    .qr-amount small{font-size:.85rem;color:#A0A5C3;font-weight:600;display:block;margin-top:2px}

    /* Transaction info */
    .trans-info{margin-top:20px;text-align:left}
    .trans-row{display:flex;justify-content:space-between;padding:10px 0;border-bottom:1px solid #F0F1F5;font-size:.88rem}
    .trans-row:last-child{border-bottom:none}
    .trans-row .label{color:#6B7194;font-weight:600}
    .trans-row .value{color:#1B1F3B;font-weight:700}
    .trans-row .value.code{color:#FF6F61;font-family:'JetBrains Mono',monospace;letter-spacing:.5px;font-size:.82rem;background:rgba(255,111,97,.06);padding:4px 10px;border-radius:8px}
    .copy-btn{background:none;border:none;cursor:pointer;color:#FF6F61;font-size:.78rem;font-weight:700;margin-left:8px;transition:.3s}
    .copy-btn:hover{color:#1B1F3B}

    /* Status Card */
    .status-card{background:#fff;border-radius:24px;padding:36px;box-shadow:0 8px 40px rgba(27,31,59,.08);border:1px solid #E8EAF0}
    .status-card h3{font-size:1.1rem;font-weight:800;margin-bottom:24px;display:flex;align-items:center;gap:10px}
    .status-card h3 i{color:#FF6F61}

    /* Status Steps */
    .status-timeline{position:relative;padding-left:32px}
    .status-timeline::before{content:'';position:absolute;left:11px;top:8px;bottom:8px;width:2px;background:#E8EAF0}
    .timeline-item{position:relative;padding-bottom:28px}
    .timeline-item:last-child{padding-bottom:0}
    .timeline-item .dot{position:absolute;left:-32px;top:2px;width:22px;height:22px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:.55rem;z-index:2}
    .timeline-item .dot.active{background:#F59E0B;color:#fff;border:3px solid #FFF8E1;box-shadow:0 0 0 3px #F59E0B}
    .timeline-item .dot.waiting{background:#E8EAF0;color:#A0A5C3;border:3px solid #F7F8FC}
    .timeline-item .dot.done{background:#059669;color:#fff;border:3px solid #ECFDF5;box-shadow:0 0 0 3px #059669}
    .timeline-item h4{font-size:.92rem;font-weight:700;color:#1B1F3B;margin-bottom:3px}
    .timeline-item p{font-size:.78rem;color:#A0A5C3}
    .timeline-item.current h4{color:#F59E0B}

    /* Payment check */
    .payment-check{margin-top:28px;padding:20px;background:linear-gradient(135deg,rgba(255,111,97,.05),rgba(255,154,139,.03));border:1px solid rgba(255,111,97,.12);border-radius:16px}
    .payment-check h4{font-size:.92rem;font-weight:700;color:#1B1F3B;margin-bottom:12px;display:flex;align-items:center;gap:8px}
    .payment-check h4 i{color:#FF6F61}
    .check-status{display:flex;align-items:center;gap:12px;padding:14px 16px;background:#fff;border-radius:12px;margin-bottom:12px;border:1px solid #E8EAF0}
    .check-status .icon{width:36px;height:36px;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:1.1rem;flex-shrink:0}
    .check-status.pending .icon{background:#FFF8E1;color:#D97706}
    .check-status.paid .icon{background:#ECFDF5;color:#059669}
    .check-status .info{flex:1}
    .check-status .info .title{font-weight:700;font-size:.85rem}
    .check-status .info .desc{font-size:.75rem;color:#A0A5C3;margin-top:2px}
    .btn-check{display:flex;align-items:center;justify-content:center;gap:8px;width:100%;padding:14px;border-radius:12px;font-weight:700;font-size:.88rem;border:2px solid #FF6F61;cursor:pointer;font-family:inherit;transition:.3s;background:rgba(255,111,97,.06);color:#FF6F61}
    .btn-check:hover{background:#FF6F61;color:#fff}
    .spinner{animation:spin 1s linear infinite;display:inline-block}
    @keyframes spin{from{transform:rotate(0)}to{transform:rotate(360deg)}}

    /* Action buttons */
    .action-btns{display:flex;flex-direction:column;gap:10px;margin-top:20px}
    .btn-my-orders{display:flex;align-items:center;justify-content:center;gap:8px;padding:14px;border-radius:12px;font-weight:700;font-size:.88rem;border:none;cursor:pointer;font-family:inherit;transition:.3s;background:linear-gradient(135deg,#1B1F3B,#2D3561);color:#fff;text-decoration:none}
    .btn-my-orders:hover{transform:translateY(-2px);box-shadow:0 6px 20px rgba(27,31,59,.15)}
    .btn-home{display:flex;align-items:center;justify-content:center;gap:8px;padding:12px;border-radius:12px;font-weight:700;font-size:.85rem;border:2px solid #E8EAF0;cursor:pointer;font-family:inherit;transition:.3s;background:#fff;color:#6B7194;text-decoration:none}
    .btn-home:hover{border-color:#1B1F3B;color:#1B1F3B}

    .timer-text{font-size:.78rem;color:#DC2626;font-weight:600;margin-top:10px;display:flex;align-items:center;justify-content:center;gap:6px}
    .timer-text i{font-size:.7rem}

    @media(max-width:900px){.payment-layout{grid-template-columns:1fr}}
    @media(max-width:600px){.qr-frame img{width:220px;height:220px}.steps{flex-wrap:wrap}.step{padding:8px 12px}}
    </style>
</head>
<body>
<jsp:include page="/common/_header.jsp" />

<div class="payment-page">
    <div class="payment-header">
        <h1><i class="fas fa-check-circle"></i> Đơn Hàng Đã Tạo Thành Công!</h1>
        <p>Quét mã QR bên dưới để hoàn tất thanh toán</p>
    </div>

    <!-- Steps -->
    <div class="steps">
        <div class="step done"><div class="num"><i class="fas fa-check"></i></div><div class="text">Giỏ Hàng</div></div>
        <div class="step-line done"></div>
        <div class="step done"><div class="num"><i class="fas fa-check"></i></div><div class="text">Xác Nhận</div></div>
        <div class="step-line done"></div>
        <div class="step active"><div class="num">3</div><div class="text">Thanh Toán</div></div>
    </div>

    <div class="payment-layout">
        <!-- Left: QR Code -->
        <div class="qr-card">
            <h3><i class="fas fa-qrcode"></i> Mã QR Thanh Toán</h3>
            <div class="subtitle">Quét bằng ứng dụng ngân hàng hoặc ví điện tử</div>

            <div class="qr-frame">
                <img src="${qrUrl}" alt="QR Code thanh toán" id="qrImage">
            </div>

            <div class="qr-amount">
                <fmt:formatNumber value="${amount}" type="number" groupingUsed="true"/>đ
                <small>Số tiền thanh toán</small>
            </div>

            <div class="timer-text" id="timerText">
                <i class="fas fa-clock"></i> Mã QR hết hạn sau: <span id="countdown">15:00</span>
            </div>

            <div class="trans-info">
                <div class="trans-row">
                    <span class="label">Mã đơn hàng</span>
                    <span class="value">#${orderId}</span>
                </div>
                <div class="trans-row">
                    <span class="label">Mã giao dịch</span>
                    <span class="value code">${transCode}
                        <button class="copy-btn" onclick="copyCode()" title="Sao chép"><i class="fas fa-copy"></i></button>
                    </span>
                </div>
                <div class="trans-row">
                    <span class="label">Ngân hàng</span>
                    <span class="value">MB Bank</span>
                </div>
                <div class="trans-row">
                    <span class="label">Số tài khoản</span>
                    <span class="value">2806281106</span>
                </div>
                <div class="trans-row">
                    <span class="label">Nội dung CK</span>
                    <span class="value code">${transCode}</span>
                </div>
            </div>
        </div>

        <!-- Right: Status -->
        <div>
            <div class="status-card">
                <h3><i class="fas fa-clock"></i> Trạng Thái Đơn Hàng #${orderId}</h3>

                <div class="status-timeline">
                    <div class="timeline-item">
                        <div class="dot done"><i class="fas fa-check"></i></div>
                        <h4>✅ Đơn hàng đã tạo</h4>
                        <p>Đơn hàng #${orderId} đã được tạo thành công</p>
                    </div>
                    <div class="timeline-item current" id="paymentStep">
                        <div class="dot active"><i class="fas fa-spinner spinner"></i></div>
                        <h4>⏳ Chờ thanh toán</h4>
                        <p id="paymentDesc">Vui lòng quét QR để thanh toán ${totalFormatted}đ</p>
                    </div>
                    <div class="timeline-item" id="confirmStep">
                        <div class="dot waiting"><i class="fas fa-check"></i></div>
                        <h4>Xác nhận</h4>
                        <p>Hệ thống sẽ xác nhận sau khi nhận tiền</p>
                    </div>
                    <div class="timeline-item" id="completeStep">
                        <div class="dot waiting"><i class="fas fa-flag"></i></div>
                        <h4>Hoàn tất</h4>
                        <p>Bạn đã sẵn sàng cho chuyến đi!</p>
                    </div>
                </div>

                <!-- SePay Check -->
                <div class="payment-check">
                    <h4><i class="fas fa-search-dollar"></i> Kiểm Tra Thanh Toán (SePay)</h4>
                    <div class="check-status pending" id="checkStatus">
                        <div class="icon"><i class="fas fa-hourglass-half"></i></div>
                        <div class="info">
                            <div class="title" id="statusTitle">Chờ thanh toán...</div>
                            <div class="desc" id="statusDesc">Quét mã QR và chuyển khoản đúng số tiền</div>
                        </div>
                    </div>
                    <button class="btn-check" onclick="checkPayment()" id="btnCheck">
                        <i class="fas fa-sync-alt"></i> Kiểm Tra Thanh Toán
                    </button>
                </div>
            </div>

            <div class="action-btns">
                <a href="${pageContext.request.contextPath}/my-orders" class="btn-my-orders">
                    <i class="fas fa-box"></i> Xem Đơn Hàng Của Tôi
                </a>
                <a href="${pageContext.request.contextPath}/" class="btn-home">
                    <i class="fas fa-home"></i> Về Trang Chủ
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/common/_footer.jsp" />

<script>
// Countdown timer (15 minutes)
let timeLeft = 900;
const countdownEl = document.getElementById('countdown');
const timer = setInterval(() => {
    timeLeft--;
    const mins = Math.floor(timeLeft / 60);
    const secs = timeLeft % 60;
    countdownEl.textContent = mins.toString().padStart(2, '0') + ':' + secs.toString().padStart(2, '0');
    if (timeLeft <= 0) {
        clearInterval(timer);
        countdownEl.textContent = 'Hết hạn!';
        document.getElementById('timerText').style.color = '#DC2626';
    }
    if (timeLeft <= 120) {
        document.getElementById('timerText').style.color = '#DC2626';
    }
}, 1000);

// Copy transaction code
function copyCode() {
    navigator.clipboard.writeText('${transCode}').then(() => {
        alert('Đã sao chép mã giao dịch: ${transCode}');
    });
}

// SePay payment check simulation
let paymentConfirmed = false;
function checkPayment() {
    if (paymentConfirmed) return;

    const btn = document.getElementById('btnCheck');
    btn.innerHTML = '<i class="fas fa-spinner spinner"></i> Đang kiểm tra...';
    btn.disabled = true;

    // Simulate SePay API check (in production, this would call your backend)
    setTimeout(() => {
        // Check via SePay API
        const transCode = '${transCode}';
        const amount = ${amount};

        fetch('https://my.sepay.vn/userapi/transactions/list?transaction_date_min=' +
              new Date().toISOString().split('T')[0] +
              '&account_number=2806281106', {
            headers: {
                'Authorization': 'Bearer SEPAY_API_KEY',
                'Content-Type': 'application/json'
            }
        })
        .then(r => r.json())
        .then(data => {
            // Check if transaction with matching content exists
            let found = false;
            if (data && data.transactions) {
                for (let tx of data.transactions) {
                    if (tx.transaction_content &&
                        tx.transaction_content.includes(transCode) &&
                        tx.amount_in >= amount) {
                        found = true;
                        break;
                    }
                }
            }
            if (found) {
                confirmPaid();
            } else {
                btn.innerHTML = '<i class="fas fa-sync-alt"></i> Kiểm Tra Lại';
                btn.disabled = false;
                document.getElementById('statusDesc').textContent = 'Chưa phát hiện giao dịch. Thử kiểm tra lại sau 30s.';
            }
        })
        .catch(() => {
            // SePay API not available, show manual confirmation option
            btn.innerHTML = '<i class="fas fa-sync-alt"></i> Kiểm Tra Lại';
            btn.disabled = false;
            document.getElementById('statusDesc').textContent = 'Hệ thống đang kiểm tra. Vui lòng đợi hoặc liên hệ admin.';
        });
    }, 2000);
}

function confirmPaid() {
    paymentConfirmed = true;

    // Update status
    document.getElementById('checkStatus').className = 'check-status paid';
    document.getElementById('checkStatus').querySelector('.icon').innerHTML = '<i class="fas fa-check-circle"></i>';
    document.getElementById('statusTitle').textContent = '✅ Đã thanh toán thành công!';
    document.getElementById('statusTitle').style.color = '#059669';
    document.getElementById('statusDesc').textContent = 'Đơn hàng sẽ được xác nhận trong vòng 24h';

    document.getElementById('btnCheck').innerHTML = '<i class="fas fa-check"></i> Đã Thanh Toán';
    document.getElementById('btnCheck').style.background = '#ECFDF5';
    document.getElementById('btnCheck').style.borderColor = '#059669';
    document.getElementById('btnCheck').style.color = '#059669';
    document.getElementById('btnCheck').disabled = true;

    // Update timeline
    const payStep = document.getElementById('paymentStep');
    payStep.querySelector('.dot').className = 'dot done';
    payStep.querySelector('.dot').innerHTML = '<i class="fas fa-check"></i>';
    payStep.querySelector('h4').textContent = '✅ Đã thanh toán';
    payStep.querySelector('h4').style.color = '#059669';
    payStep.querySelector('p').textContent = 'Thanh toán thành công qua QR SePay';

    const confStep = document.getElementById('confirmStep');
    confStep.querySelector('.dot').className = 'dot active';
    confStep.querySelector('.dot').innerHTML = '<i class="fas fa-spinner spinner"></i>';
    confStep.querySelector('h4').style.color = '#F59E0B';
    confStep.querySelector('h4').textContent = '⏳ Đang xác nhận';
    confStep.querySelector('p').textContent = 'Admin sẽ xác nhận đơn hàng trong vòng 24h';

    clearInterval(timer);
    document.getElementById('timerText').style.display = 'none';
}

// Auto-check every 30 seconds
setInterval(() => {
    if (!paymentConfirmed) {
        checkPayment();
    }
}, 30000);
</script>
</body>
</html>
