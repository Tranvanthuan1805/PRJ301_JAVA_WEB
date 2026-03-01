<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Lỗi | Da Nang Travel Hub</title>
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
                        min-height: 100vh;
                        background: #1B1F3B;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: white;
                        position: relative;
                        overflow: hidden;
                        -webkit-font-smoothing: antialiased
                    }

                    /* Animated Grid */
                    .grid-bg {
                        position: fixed;
                        inset: 0;
                        background-image: linear-gradient(rgba(255, 255, 255, .03) 1px, transparent 1px), linear-gradient(90deg, rgba(255, 255, 255, .03) 1px, transparent 1px);
                        background-size: 60px 60px;
                        animation: gridMove 20s linear infinite
                    }

                    @keyframes gridMove {
                        0% {
                            transform: translate(0, 0)
                        }

                        100% {
                            transform: translate(60px, 60px)
                        }
                    }

                    /* Orbs */
                    .bg-orbs {
                        position: fixed;
                        inset: 0;
                        pointer-events: none
                    }

                    .orb {
                        position: absolute;
                        border-radius: 50%;
                        filter: blur(100px);
                        animation: orbFloat 15s ease-in-out infinite
                    }

                    .orb-1 {
                        width: 500px;
                        height: 500px;
                        background: rgba(255, 111, 97, .08);
                        top: -20%;
                        left: -10%;
                        animation-delay: 0s
                    }

                    .orb-2 {
                        width: 400px;
                        height: 400px;
                        background: rgba(0, 180, 216, .06);
                        bottom: -20%;
                        right: -10%;
                        animation-delay: 5s
                    }

                    @keyframes orbFloat {

                        0%,
                        100% {
                            transform: translate(0, 0)
                        }

                        50% {
                            transform: translate(30px, -30px)
                        }
                    }

                    .error-box {
                        text-align: center;
                        max-width: 550px;
                        padding: 30px;
                        animation: fadeIn .7s ease;
                        position: relative;
                        z-index: 10
                    }

                    @keyframes fadeIn {
                        from {
                            opacity: 0;
                            transform: translateY(25px)
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0)
                        }
                    }

                    .error-code {
                        font-size: 10rem;
                        font-weight: 900;
                        line-height: 1;
                        background: linear-gradient(135deg, rgba(255, 111, 97, .2), rgba(255, 154, 139, .1));
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                        letter-spacing: -5px;
                        position: relative
                    }

                    .error-code::after {
                        content: '';
                        position: absolute;
                        bottom: 10px;
                        left: 50%;
                        transform: translateX(-50%);
                        width: 120px;
                        height: 4px;
                        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
                        border-radius: 999px
                    }

                    .error-icon {
                        font-size: 3rem;
                        margin: 30px 0 16px;
                        animation: bounce 2s ease-in-out infinite
                    }

                    @keyframes bounce {

                        0%,
                        100% {
                            transform: translateY(0)
                        }

                        50% {
                            transform: translateY(-12px)
                        }
                    }

                    .error-title {
                        font-size: 1.8rem;
                        font-weight: 800;
                        margin-bottom: 12px
                    }

                    .error-desc {
                        opacity: .6;
                        margin-bottom: 35px;
                        line-height: 1.8;
                        font-size: .95rem;
                        max-width: 400px;
                        margin-left: auto;
                        margin-right: auto
                    }

                    .btn-home {
                        display: inline-flex;
                        align-items: center;
                        gap: 10px;
                        padding: 16px 36px;
                        background: linear-gradient(135deg, #FF6F61, #FF9A8B);
                        color: white;
                        text-decoration: none;
                        border-radius: 999px;
                        font-weight: 800;
                        transition: .4s cubic-bezier(.175, .885, .32, 1.275);
                        font-size: .95rem;
                        box-shadow: 0 8px 30px rgba(255, 111, 97, .3);
                        border: 2px solid rgba(255, 255, 255, .1)
                    }

                    .btn-home:hover {
                        transform: translateY(-4px) scale(1.02);
                        box-shadow: 0 16px 40px rgba(255, 111, 97, .45)
                    }

                    .error-links {
                        margin-top: 30px;
                        display: flex;
                        justify-content: center;
                        gap: 24px;
                        font-size: .85rem
                    }

                    .error-links a {
                        color: rgba(255, 255, 255, .4);
                        transition: .3s
                    }

                    .error-links a:hover {
                        color: rgba(255, 255, 255, .8)
                    }
                </style>
            </head>

            <body>
                <div class="grid-bg"></div>
                <div class="bg-orbs">
                    <div class="orb orb-1"></div>
                    <div class="orb orb-2"></div>
                </div>

                <div class="error-box">
                    <div class="error-code">500</div>
                    <div class="error-icon">🛠️</div>
                    <h1 class="error-title">Oops! Có Lỗi Xảy Ra</h1>
                    <p class="error-desc">
                        <c:out value="${errorMessage}"
                            default="Hệ thống đang gặp sự cố khi xử lý yêu cầu của bạn. Vui lòng thử lại sau hoặc liên hệ đội ngũ hỗ trợ." />
                    </p>
                    <a href="${pageContext.request.contextPath}/" class="btn-home">
                        <i class="fas fa-home"></i> Về Trang Chủ
                    </a>
                    <div class="error-links">
                        <a href="${pageContext.request.contextPath}/tour"><i class="fas fa-compass"></i> Khám Phá
                            Tours</a>
                        <a href="mailto:contact@dananghub.vn"><i class="fas fa-envelope"></i> Liên Hệ</a>
                    </div>
                </div>
            </body>

            </html>