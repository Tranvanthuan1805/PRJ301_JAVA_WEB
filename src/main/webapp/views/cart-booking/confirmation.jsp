<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Confirmed | Da Nang Travel Hub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body style="background: #fdfdfd; height: 100vh; display: flex; flex-direction: column;">
    <jsp:include page="/common/_header.jsp" />

    <main style="flex: 1; display: flex; align-items: center; justify-content: center; text-align: center;">
        <div class="card animate-up" style="max-width: 600px; padding: 60px;">
            <div style="width: 100px; height: 100px; background: rgba(46, 125, 50, 0.1); color: var(--success); border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 3rem; margin: 0 auto 30px auto;">
                <i class="fas fa-check"></i>
            </div>
            <h1 style="color: var(--primary); margin-bottom: 15px;">Experience Booked!</h1>
            <p style="color: var(--text-muted); font-size: 1.1rem; margin-bottom: 40px;">
                Thank you for choosing Da Nang Travel Hub. Your order <strong style="color: var(--primary);">#${orderId}</strong> has been confirmed. 
                A confirmation email with your e-tickets has been sent.
            </p>
            
            <div style="display: flex; gap: 20px; justify-content: center;">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Discover More</a>
                <a href="#" class="btn" style="border: 1px solid #ddd; background: white;">View My Bookings</a>
            </div>
        </div>
    </main>

    <jsp:include page="/common/_footer.jsp" />
</body>
</html>
