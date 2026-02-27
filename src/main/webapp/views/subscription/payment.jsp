<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán | Da Nang Travel Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Inter', sans-serif; min-height: 100vh;
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            display: flex; align-items: center; justify-content: center; padding: 30px;
        }
        .payment-card {
            background: white; border-radius: 24px; padding: 50px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.08); max-width: 500px; width: 100%;
            text-align: center; animation: fadeIn 0.5s ease;
        }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }

        .payment-card h2 { font-size: 1.6rem; color: #0a2351; margin-bottom: 8px; }
        .payment-card .subtitle { color: #636e72; margin-bottom: 30px; }

        .plan-summary {
            background: #f8f9fa; padding: 20px; border-radius: 14px;
            margin-bottom: 25px; border: 1px solid #e9ecef;
        }
        .plan-summary .name { font-weight: 700; color: #0a2351; font-size: 1.1rem; }
        .plan-summary .price { font-size: 2rem; font-weight: 800; color: #2e7d32; margin: 8px 0; }

        .qr-wrap {
            background: white; padding: 20px; border-radius: 14px;
            border: 2px dashed #e9ecef; margin-bottom: 25px;
        }
        .qr-wrap img { max-width: 250px; border-radius: 10px; }

        .trans-code {
            background: #fff3cd; padding: 12px 20px; border-radius: 10px;
            font-family: monospace; font-size: 0.95rem; font-weight: 700;
            color: #856404; margin-bottom: 20px; word-break: break-all;
        }

        .status-checking {
            display: flex; align-items: center; justify-content: center; gap: 10px;
            color: #636e72; font-size: 0.9rem; margin-bottom: 20px;
        }
        .spinner {
            width: 20px; height: 20px; border: 3px solid #e9ecef;
            border-top-color: #0a2351; border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }
        @keyframes spin { to { transform: rotate(360deg); } }

        .status-paid {
            background: #d4edda; color: #155724; padding: 15px 20px;
            border-radius: 12px; font-weight: 700; font-size: 1.1rem;
            display: none;
        }

        .btn-back {
            display: inline-block; padding: 12px 30px; background: #e9ecef;
            color: #636e72; border-radius: 10px; text-decoration: none;
            font-weight: 600; transition: 0.3s;
        }
        .btn-back:hover { background: #dee2e6; }
    </style>
</head>
<body>
    <div class="payment-card">
        <h2>💳 Thanh Toán QR</h2>
        <p class="subtitle">Quét mã QR bằng app ngân hàng để thanh toán</p>

        <div class="plan-summary">
            <div class="name">${plan.planName}</div>
            <div class="price"><fmt:formatNumber value="${amount}" type="number" groupingUsed="true"/>đ</div>
        </div>

        <div class="qr-wrap">
            <img src="${qrUrl}" alt="QR Thanh Toán">
        </div>

        <div class="trans-code">
            Nội dung CK: <strong>${transCode}</strong>
        </div>

        <div class="status-checking" id="statusChecking">
            <div class="spinner"></div>
            <span>Đang chờ thanh toán...</span>
        </div>

        <div class="status-paid" id="statusPaid">
            <i class="fas fa-check-circle"></i> Thanh toán thành công!
        </div>

        <a href="${pageContext.request.contextPath}/pricing" class="btn-back"><i class="fas fa-arrow-left"></i> Quay lại</a>
    </div>

    <script>
        // Poll payment status every 5s
        const transCode = '${transCode}';
        const checkInterval = setInterval(function() {
            fetch('${pageContext.request.contextPath}/check-payment?code=' + transCode)
                .then(r => r.json())
                .then(data => {
                    if (data.status === 'Paid') {
                        document.getElementById('statusChecking').style.display = 'none';
                        document.getElementById('statusPaid').style.display = 'block';
                        clearInterval(checkInterval);
                        setTimeout(() => { window.location.href = '${pageContext.request.contextPath}/home'; }, 3000);
                    }
                })
                .catch(e => console.log('Check failed:', e));
        }, 5000);
    </script>
</body>
</html>
