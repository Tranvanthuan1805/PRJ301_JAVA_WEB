<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white text-center">
                    <h4 class="mb-0">Scan to Pay</h4>
                </div>
                <div class="card-body text-center p-4">
                    <p class="mb-2"><strong>Plan:</strong> ${plan.planName}</p>
                    <p class="mb-4"><strong>Amount:</strong> <span class="text-danger fw-bold fs-4">${amount} VND</span></p>
                    
                    <div class="border p-2 d-inline-block rounded bg-white mb-4">
                        <img src="${qrUrl}" alt="SePay QR Code" class="img-fluid" style="max-width: 300px;">
                    </div>

                    <div class="alert alert-info text-start small">
                        <strong>Instructions:</strong><br>
                        1. Open your Banking App.<br>
                        2. Scan the QR Code.<br>
                        3. Ensure the transfer content is <strong>${transCode}</strong>.<br>
                        4. Confirm payment. The system will auto-detect it.
                    </div>

                    <div id="statusMessage" class="text-muted">
                        <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                        Waiting for payment...
                    </div>
                </div>
                <div class="card-footer text-center">
                    <a href="pricing" class="btn btn-outline-secondary btn-sm">Cancel</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const transCode = "${transCode}";
    const checkUrl = "${pageContext.request.contextPath}/check-payment?code=" + transCode;

    function checkStatus() {
        fetch(checkUrl)
            .then(response => response.json())
            .then(data => {
                console.log("Status:", data.status);
                if (data.status === "Paid") {
                    document.getElementById("statusMessage").innerHTML = 
                        '<span class="text-success fw-bold">Payment Received! Redirecting...</span>';
                    setTimeout(() => {
                        window.location.href = "${pageContext.request.contextPath}/views/subscription/success.jsp";
                    }, 1500);
                }
            })
            .catch(err => console.error("Error checking status", err));
    }

    // Poll every 2 seconds
    setInterval(checkStatus, 2000);
</script>

</body>
</html>
