<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Secure Payment | Da Nang Travel Hub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body style="background: #f8f9fa;">
    <jsp:include page="/common/_header.jsp" />

    <main class="container" style="margin-top: 60px; margin-bottom: 100px;">
        <div style="max-width: 800px; margin: 0 auto; display: grid; grid-template-columns: 1fr 300px; gap: 40px;">
            <!-- Payment Form -->
            <div class="card" style="padding: 40px;">
                <h2 style="margin-bottom: 30px; color: var(--primary);">Secure Checkout</h2>
                
                <div style="background: rgba(43, 108, 176, 0.05); padding: 20px; border-radius: 8px; margin-bottom: 30px; display: flex; gap: 15px; align-items: center;">
                    <i class="fas fa-lock" style="color: var(--primary); font-size: 1.5rem;"></i>
                    <div>
                        <strong style="display: block;">SSL Encrypted Connection</strong>
                        <small style="color: #666;">Your transaction is protected by bank-level security.</small>
                    </div>
                </div>

                <form action="${pageContext.request.contextPath}/payment" method="POST">
                    <input type="hidden" name="plan" value="${plan}">
                    <input type="hidden" name="price" value="${price}">

                    <div style="margin-bottom: 30px;">
                        <label style="display: block; margin-bottom: 15px; font-weight: 700;">Select Payment Method</label>
                        <div style="display: grid; gap: 15px;">
                            <label style="display: flex; align-items: center; gap: 15px; padding: 20px; border: 2px solid var(--primary); border-radius: 12px; cursor: pointer; background: white;">
                                <input type="radio" name="method" value="bank" checked>
                                <img src="https://qr.sepay.vn/assets/img/bank-icons.png" style="height: 24px; filter: grayscale(1);">
                                <strong>Bank Transfer (Scanning QR)</strong>
                            </label>
                            <label style="display: flex; align-items: center; gap: 15px; padding: 20px; border: 1px solid #ddd; border-radius: 12px; cursor: pointer; opacity: 0.6;">
                                <input type="radio" name="method" value="card" disabled>
                                <i class="fas fa-credit-card"></i>
                                <span>Credit / Debit Card (Coming Soon)</span>
                            </label>
                        </div>
                    </div>

                    <div id="qr-section" style="text-align: center; background: white; padding: 30px; border: 1px solid #eee; border-radius: 12px; margin-bottom: 30px;">
                        <p style="margin-bottom: 20px; font-size: 0.9rem; color: var(--text-muted);">Please scan the QR code below using your banking app</p>
                        <img src="https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=SePay_Payment_Simulation_${plan}_${price}" style="border: 8px solid white; box-shadow: 0 10px 30px rgba(0,0,0,0.1); margin-bottom: 20px;">
                        <div style="display: flex; justify-content: center; gap: 10px; font-weight: 700; color: var(--primary);">
                            <i class="fas fa-spinner fa-spin"></i>
                            <span>Waiting for transfer...</span>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary" style="width: 100%; padding: 15px; font-size: 1.1rem; border-radius: 12px;">Confirm Simulation Success</button>
                    <p style="text-align: center; margin-top: 15px; font-size: 0.8rem; color: #999;">By clicking confirm, you agree to our Terms of Service.</p>
                </form>
            </div>

            <!-- Order Summary -->
            <aside>
                <div class="card" style="padding: 25px; position: sticky; top: 100px;">
                    <h4 style="margin-bottom: 20px; border-bottom: 1px solid #eee; padding-bottom: 10px;">Order Summary</h4>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 15px;">
                        <span style="color: #666;">Plan</span>
                        <strong style="color: var(--primary);">${plan}</strong>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 15px;">
                        <span style="color: #666;">Duration</span>
                        <strong>1 Month</strong>
                    </div>
                    <hr style="border: 0; border-top: 1px solid #eee; margin: 20px 0;">
                    <div style="display: flex; justify-content: space-between; font-size: 1.5rem; font-weight: 800; color: var(--primary);">
                        <span>Total</span>
                        <span>$${price}</span>
                    </div>
                </div>
            </aside>
        </div>
    </main>

    <jsp:include page="/common/_footer.jsp" />
</body>
</html>
