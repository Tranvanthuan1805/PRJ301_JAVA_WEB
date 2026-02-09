<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Da Nang Travel Hub | Verified Tours & AI Forecast</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>
    <jsp:include page="/common/_header.jsp" />

    <main>
        <!-- Dynamic Hero -->
        <section class="hero" style="background: linear-gradient(rgba(10,35,81,0.8), rgba(10,35,81,0.8)), url('https://images.unsplash.com/photo-1559592442-7e182c3c03fb?auto=format&fit=crop&w=1600&q=80'); height: 500px; background-size: cover; background-position: center; display: flex; align-items: center; justify-content: center; color: white; text-align: center;">
            <div class="container animate-up">
                <h1 style="font-size: 4rem; margin-bottom: 20px;">Your Da Nang Adventure <span style="color: var(--accent);">Starts Here</span></h1>
                <p style="font-size: 1.3rem; max-width: 800px; margin: 0 auto 40px auto; opacity: 0.9;">Book hand-picked tours and get predicted demand alerts so you never miss the best experiences.</p>
                <div style="background: white; padding: 20px; border-radius: 50px; display: flex; gap: 15px; max-width: 800px; margin: 0 auto; box-shadow: var(--shadow-lg);">
                    <input type="text" placeholder="Search tours, landmarks..." style="flex: 1; border: none; padding: 0 20px; outline: none; font-size: 1rem;">
                    <button class="btn btn-primary" style="padding: 12px 40px; border-radius: 30px;">Search</button>
                </div>
            </div>
        </section>

        <!-- Tour Categories -->
        <section class="container" style="margin-top: -50px; position: relative; z-index: 10;">
            <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px;">
                <div class="card" style="text-align: center; cursor: pointer;">
                    <i class="fas fa-umbrella-beach" style="font-size: 2rem; color: var(--accent); margin-bottom: 10px;"></i>
                    <p style="font-weight: 700;">Beach Tours</p>
                </div>
                <div class="card" style="text-align: center; cursor: pointer;">
                    <i class="fas fa-mountain" style="font-size: 2rem; color: var(--accent); margin-bottom: 10px;"></i>
                    <p style="font-weight: 700;">Mountain Hike</p>
                </div>
                <div class="card" style="text-align: center; cursor: pointer;">
                    <i class="fas fa-utensils" style="font-size: 2rem; color: var(--accent); margin-bottom: 10px;"></i>
                    <p style="font-weight: 700;">Foodie Trail</p>
                </div>
                <div class="card" style="text-align: center; cursor: pointer;">
                    <i class="fas fa-history" style="font-size: 2rem; color: var(--accent); margin-bottom: 10px;"></i>
                    <p style="font-weight: 700;">Cultural</p>
                </div>
            </div>
        </section>

        <!-- Tour Grid -->
        <section class="container" style="margin-top: 80px; margin-bottom: 80px;">
            <div style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 40px;">
                <div>
                    <h2 style="font-size: 2.5rem; color: var(--primary);">Trending in Da Nang</h2>
                    <p style="color: var(--text-muted);">Hand-picked by our local travel experts.</p>
                </div>
                <a href="${pageContext.request.contextPath}/tours" class="btn" style="color: var(--primary); font-weight: 700;">View All Tours <i class="fas fa-arrow-right"></i></a>
            </div>

            <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); gap: 30px;">
                <c:forEach items="${listTours}" var="t">
                    <div class="card" style="padding: 0; overflow: hidden; display: flex; flex-direction: column;">
                        <div style="position: relative;">
                            <img src="${t.imageUrl}" alt="${t.tourName}" style="width: 100%; height: 250px; object-fit: cover;">
                            <div style="position: absolute; top: 15px; left: 15px; background: rgba(10,35,81,0.9); color: white; padding: 5px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 700;">
                                <i class="fas fa-clock"></i> ${t.duration}
                            </div>
                        </div>
                        <div style="padding: 25px; flex: 1; display: flex; flex-direction: column;">
                            <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                                <span style="color: var(--text-muted); font-size: 0.8rem; text-transform: uppercase; letter-spacing: 1px;">Verified Experience</span>
                                <div style="color: #f1c40f;"><i class="fas fa-star"></i> 4.9</div>
                            </div>
                            <h3 style="margin-bottom: 12px; color: var(--primary); font-size: 1.4rem;">${t.tourName}</h3>
                            <p style="color: var(--text-muted); font-size: 0.9rem; margin-bottom: 25px; line-height: 1.5;">${t.shortDesc != null ? t.shortDesc : 'Discover the hidden gems and breathtaking views of Da Nang.'}</p>
                            
                            <div style="margin-top: auto; padding-top: 20px; border-top: 1px solid #f0f0f0; display: flex; justify-content: space-between; align-items: center;">
                                <div>
                                    <span style="font-size: 0.8rem; color: var(--text-muted); display: block;">From</span>
                                    <span style="font-size: 1.5rem; font-weight: 800; color: var(--success);"><fmt:formatNumber value="${t.price}" type="currency" currencySymbol="$"/></span>
                                </div>
                                <a href="${pageContext.request.contextPath}/detail?id=${t.tourId}" class="btn btn-primary">Book Now</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <c:if test="${empty listTours}">
                <div style="text-align: center; padding: 100px 0; background: #f9f9f9; border-radius: 12px;">
                    <i class="fas fa-search" style="font-size: 3rem; color: #ddd; margin-bottom: 20px;"></i>
                    <h3>No tours found in your current location.</h3>
                    <p>Try clearing your filters or check back later.</p>
                </div>
            </c:if>
        </section>

        <!-- Newsletter / Community -->
        <section style="background: var(--primary); color: white; padding: 100px 0;">
            <div class="container" style="display: flex; align-items: center; gap: 80px;">
                <div style="flex: 1;">
                    <h2 style="font-size: 3rem; margin-bottom: 20px;">Join the Hub</h2>
                    <p style="font-size: 1.1rem; opacity: 0.8; margin-bottom: 40px;">Get exclusive discounts for Ba Na Hills and early access to festival tour bookings.</p>
                    <div style="display: flex; gap: 15px;">
                        <input type="email" placeholder="Your email address" style="flex: 1; padding: 15px 25px; border-radius: 8px; border: none; outline: none;">
                        <button class="btn btn-primary">Subscribe</button>
                    </div>
                </div>
                <div style="flex: 1; display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="card" style="background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: white;">
                        <h4>Expert Guides</h4>
                        <p style="font-size: 0.8rem; opacity: 0.7;">Verified professionals with deep local knowledge.</p>
                    </div>
                    <div class="card" style="background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: white;">
                        <h4>Instant Booking</h4>
                        <p style="font-size: 0.8rem; opacity: 0.7;">Real-time confirmation for all transactions.</p>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="/common/_footer.jsp" />
    
    <!-- AI Chatbot Trigger -->
    <div id="ai-bot-trigger" style="position: fixed; bottom: 30px; right: 30px; width: 60px; height: 60px; background: var(--primary); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; cursor: pointer; box-shadow: var(--shadow-lg); z-index: 1001; transition: 0.3s;">
        <i class="fas fa-robot"></i>
    </div>

    <script>
        document.getElementById('ai-bot-trigger').addEventListener('mouseenter', function() {
            this.style.transform = 'scale(1.1) rotate(15deg)';
        });
        document.getElementById('ai-bot-trigger').addEventListener('mouseleave', function() {
            this.style.transform = 'scale(1) rotate(0deg)';
        });
    </script>
</body>
</html>