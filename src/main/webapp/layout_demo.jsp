<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Da Nang Travel Hub | Discover the Future of Travel</title>
</head>
<body>
    <!-- Import Header -->
    <jsp:include page="/common/_header.jsp" />

    <main class="container" style="min-height: 80vh; padding-top: 50px;">
        <!-- Hero Section -->
        <section class="animate-up" style="text-align: center; margin-bottom: 80px;">
            <h1 style="font-size: 3.5rem; color: var(--primary); margin-bottom: 20px;">Explore <span style="color: var(--accent);">Da Nang</span> with Ease</h1>
            <p style="font-size: 1.2rem; color: var(--text-muted); max-width: 700px; margin: 0 auto 40px auto;">
                Book verified tours, track your itineraries, and get AI-powered travel forecasts for your trip to the most livable city in Vietnam.
            </p>
            <div style="display: flex; justify-content: center; gap: 20px;">
                <a href="${pageContext.request.contextPath}/tours" class="btn btn-primary">Start Exploring</a>
                <a href="#featured" class="btn" style="border: 2px solid var(--primary); color: var(--primary);">Learn More</a>
            </div>
        </section>

        <!-- Stats Section (Analytic Showcase) -->
        <section style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 100px;">
            <div class="card" style="text-align: center;">
                <h2 style="color: var(--accent);">10k+</h2>
                <p>Happy Travelers</p>
            </div>
            <div class="card" style="text-align: center;">
                <h2 style="color: var(--accent);">500+</h2>
                <p>Verified Tours</p>
            </div>
            <div class="card" style="text-align: center;">
                <h2 style="color: var(--accent);">98%</h2>
                <p>Satisfaction Rate</p>
            </div>
            <div class="card" style="text-align: center;">
                <h2 style="color: var(--accent);">AI</h2>
                <p>Smart Recommendations</p>
            </div>
        </section>

        <!-- Product Preview -->
        <div id="featured" style="margin-bottom: 50px;">
            <h2 style="margin-bottom: 30px;">Featured Experiences</h2>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 30px;">
                <!-- Tour Card 1 -->
                <div class="card">
                    <img src="https://images.unsplash.com/photo-1559592442-7e182c3c03fb?auto=format&fit=crop&w=400&q=80" alt="Bana Hills" style="width: 100%; height: 200px; object-fit: cover; border-radius: 8px; margin-bottom: 15px;">
                    <h3>Golden Bridge & Ba Na Hills</h3>
                    <p style="color: var(--text-muted); font-size: 0.9rem; margin-bottom: 15px;">Discover the breathtaking views and European village at the top of the mountains.</p>
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <span style="font-weight: 800; color: var(--success);">$55.00</span>
                        <a href="#" class="btn btn-primary" style="padding: 8px 16px;">Details</a>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Import Footer -->
    <jsp:include page="/common/_footer.jsp" />
</body>
</html>
