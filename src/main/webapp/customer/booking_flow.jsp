<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Complete Your Booking | Da Nang Travel Hub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body style="background: #fdfdfd;">
    <jsp:include page="/common/_header.jsp" />

    <main class="container" style="max-width: 900px; margin-top: 60px; margin-bottom: 100px;">
        <!-- Step Progress Bar -->
        <div style="display: flex; justify-content: space-between; margin-bottom: 50px; position: relative;">
            <div style="position: absolute; top: 15px; left: 10%; right: 10%; height: 2px; background: #eee; z-index: 1;"></div>
            <div style="position: absolute; top: 15px; left: 10%; width: ${(step - 1) * 40}%; height: 2px; background: var(--primary); z-index: 2; transition: 0.5s;"></div>
            
            <div style="z-index: 3; text-align: center;">
                <div style="width: 30px; height: 30px; background: ${step >= 1 ? 'var(--primary)' : '#eee'}; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 10px auto;">1</div>
                <small style="color: ${step >= 1 ? 'var(--primary)' : '#999'}; font-weight: 700;">Details</small>
            </div>
            <div style="z-index: 3; text-align: center;">
                <div style="width: 30px; height: 30px; background: ${step >= 2 ? 'var(--primary)' : '#eee'}; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 10px auto;">2</div>
                <small style="color: ${step >= 2 ? 'var(--primary)' : '#999'}; font-weight: 700;">Contact</small>
            </div>
            <div style="z-index: 3; text-align: center;">
                <div style="width: 30px; height: 30px; background: ${step >= 3 ? 'var(--primary)' : '#eee'}; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 10px auto;">3</div>
                <small style="color: ${step >= 3 ? 'var(--primary)' : '#999'}; font-weight: 700;">Payment</small>
            </div>
        </div>

        <div style="display: grid; grid-template-columns: 1fr 300px; gap: 40px;">
            <!-- Form Area -->
            <div class="card" style="padding: 40px;">
                <form action="${pageContext.request.contextPath}/customer/book" method="POST">
                    <input type="hidden" name="tourId" value="${tour.tourId}">
                    <input type="hidden" name="step" value="${step}">

                    <c:choose>
                        <c:when test="${step == 1}">
                            <h2 style="margin-bottom: 25px;">Select Travel Details</h2>
                            <div style="margin-bottom: 20px;">
                                <label style="display: block; margin-bottom: 8px; font-weight: 600;">Trip Date</label>
                                <input type="date" name="travelDate" required style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px;">
                            </div>
                            <div style="margin-bottom: 30px;">
                                <label style="display: block; margin-bottom: 8px; font-weight: 600;">Number of People</label>
                                <input type="number" name="quantity" min="1" max="${tour.maxPeople}" value="1" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px;">
                                <small style="color: var(--text-muted);">Max capacity: ${tour.maxPeople} guests</small>
                            </div>
                        </c:when>

                        <c:when test="${step == 2}">
                            <h2 style="margin-bottom: 25px;">Who's traveling?</h2>
                            <div style="margin-bottom: 20px;">
                                <label style="display: block; margin-bottom: 8px; font-weight: 600;">Full Name</label>
                                <input type="text" name="fullName" required style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px;" placeholder="As shown on ID/Passport">
                            </div>
                            <div style="margin-bottom: 20px;">
                                <label style="display: block; margin-bottom: 8px; font-weight: 600;">Phone Number</label>
                                <input type="tel" name="phone" required style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px;" placeholder="+84 000 000 000">
                            </div>
                        </c:when>

                        <c:when test="${step == 3}">
                            <h2 style="margin-bottom: 25px;">Secure Payment</h2>
                            <div style="background: rgba(46, 125, 50, 0.05); border: 1px dashed var(--success); padding: 20px; border-radius: 8px; margin-bottom: 30px; display: flex; gap: 15px; align-items: center;">
                                <i class="fas fa-shield-alt" style="color: var(--success); font-size: 1.5rem;"></i>
                                <p style="font-size: 0.9rem;">Your payment is encrypted and processed directly by our secure banking partners.</p>
                            </div>
                            <div style="display: grid; gap: 15px;">
                                <label style="display: flex; align-items: center; gap: 15px; padding: 15px; border: 1px solid #eee; border-radius: 8px; cursor: pointer;">
                                    <input type="radio" name="payment" value="momo" checked>
                                    <img src="https://upload.wikimedia.org/wikipedia/vi/f/fe/MoMo_Logo.png" width="30">
                                    <span>MoMo Wallet</span>
                                </label>
                                <label style="display: flex; align-items: center; gap: 15px; padding: 15px; border: 1px solid #eee; border-radius: 8px; cursor: pointer;">
                                    <input type="radio" name="payment" value="bank">
                                    <i class="fas fa-university"></i>
                                    <span>Bank Transfer (NAPAS 24/7)</span>
                                </label>
                            </div>
                        </c:when>
                    </c:choose>

                    <div style="margin-top: 40px; display: flex; justify-content: space-between;">
                        <c:if test="${step > 1}">
                            <button type="button" onclick="history.back()" class="btn" style="background: white; border: 1px solid #ddd;">Back</button>
                        </c:if>
                        <c:if test="${step <= 1}"><div></div></c:if>
                        <button type="submit" class="btn btn-primary">${step == 3 ? 'Confirm & Pay' : 'Next Step'}</button>
                    </div>
                </form>
            </div>

            <!-- Summary Sidebar -->
            <div style="position: sticky; top: 100px; height: fit-content;">
                <div class="card" style="padding: 20px; background: #fff;">
                    <h4 style="margin-bottom: 15px; color: var(--primary);">Tour Summary</h4>
                    <img src="${tour.imageUrl}" style="width: 100%; border-radius: 6px; margin-bottom: 15px;">
                    <p style="font-weight: 700; margin-bottom: 5px;">${tour.tourName}</p>
                    <small style="color: var(--text-muted);"><i class="fas fa-map-marker-alt"></i> ${tour.startLocation}</small>
                    
                    <hr style="margin: 20px 0; border: 0; border-top: 1px solid #eee;">
                    
                    <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                        <span>Price per guest</span>
                        <span style="font-weight: 600;">$<fmt:formatNumber value="${tour.price}" /></span>
                    </div>
                    <div style="display: flex; justify-content: space-between; font-size: 1.2rem; font-weight: 800; color: var(--primary); margin-top: 20px;">
                        <span>Total</span>
                        <span>$<fmt:formatNumber value="${tour.price}" /></span>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="/common/_footer.jsp" />
</body>
</html>
