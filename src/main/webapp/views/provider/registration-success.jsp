<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Đăng Ký Thành Công | Da Nang Travel Hub</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                :root {
                    --primary-color: #FF7F5C;
                    --secondary-color: #2C3E50;
                    --light-bg: #F8F9FA;
                    --card-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                    --success-color: #28a745;
                }

                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    background-color: var(--light-bg);
                }

                .success-container {
                    min-height: 80vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 40px 20px;
                }

                .success-card {
                    background: white;
                    border-radius: 20px;
                    padding: 60px 40px;
                    box-shadow: var(--card-shadow);
                    text-align: center;
                    max-width: 600px;
                    width: 100%;
                }

                .success-icon {
                    width: 120px;
                    height: 120px;
                    background: linear-gradient(135deg, var(--success-color), #34c759);
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    margin: 0 auto 30px;
                    animation: scaleIn 0.5s ease-out;
                }

                .success-icon i {
                    font-size: 4rem;
                    color: white;
                }

                @keyframes scaleIn {
                    0% {
                        transform: scale(0);
                        opacity: 0;
                    }

                    50% {
                        transform: scale(1.1);
                    }

                    100% {
                        transform: scale(1);
                        opacity: 1;
                    }
                }

                .success-title {
                    font-size: 2.5rem;
                    font-weight: 700;
                    color: var(--secondary-color);
                    margin-bottom: 20px;
                }

                .success-message {
                    font-size: 1.1rem;
                    color: #6c757d;
                    margin-bottom: 30px;
                    line-height: 1.6;
                }

                .info-box {
                    background: var(--light-bg);
                    border-radius: 15px;
                    padding: 25px;
                    margin: 30px 0;
                    text-align: left;
                }

                .info-box h5 {
                    color: var(--secondary-color);
                    font-weight: 700;
                    margin-bottom: 15px;
                }

                .info-item {
                    display: flex;
                    align-items: start;
                    margin-bottom: 12px;
                    color: #495057;
                }

                .info-item i {
                    color: var(--primary-color);
                    margin-right: 10px;
                    margin-top: 3px;
                    font-size: 1.1rem;
                }

                .btn-primary-custom {
                    background: var(--primary-color);
                    color: white;
                    border: none;
                    padding: 15px 40px;
                    border-radius: 25px;
                    font-weight: 700;
                    font-size: 1.1rem;
                    transition: all 0.3s;
                    text-decoration: none;
                    display: inline-block;
                    margin: 10px;
                }

                .btn-primary-custom:hover {
                    background: #ff6a47;
                    transform: scale(1.05);
                    box-shadow: 0 6px 20px rgba(255, 127, 92, 0.4);
                    color: white;
                }

                .btn-secondary-custom {
                    background: var(--secondary-color);
                    color: white;
                    border: none;
                    padding: 15px 40px;
                    border-radius: 25px;
                    font-weight: 700;
                    font-size: 1.1rem;
                    transition: all 0.3s;
                    text-decoration: none;
                    display: inline-block;
                    margin: 10px;
                }

                .btn-secondary-custom:hover {
                    background: #1a252f;
                    transform: scale(1.05);
                    box-shadow: 0 6px 20px rgba(44, 62, 80, 0.3);
                    color: white;
                }

                .registration-details {
                    background: white;
                    border: 2px solid var(--primary-color);
                    border-radius: 15px;
                    padding: 25px;
                    margin: 30px 0;
                }

                .detail-row {
                    display: flex;
                    justify-content: space-between;
                    padding: 12px 0;
                    border-bottom: 1px solid #dee2e6;
                }

                .detail-row:last-child {
                    border-bottom: none;
                }

                .detail-label {
                    font-weight: 600;
                    color: var(--secondary-color);
                }

                .detail-value {
                    color: #495057;
                    text-align: right;
                }

                @media (max-width: 768px) {
                    .success-card {
                        padding: 40px 25px;
                    }

                    .success-title {
                        font-size: 2rem;
                    }

                    .success-icon {
                        width: 100px;
                        height: 100px;
                    }

                    .success-icon i {
                        font-size: 3rem;
                    }

                    .btn-primary-custom,
                    .btn-secondary-custom {
                        width: 100%;
                        margin: 5px 0;
                    }

                    .detail-row {
                        flex-direction: column;
                        gap: 5px;
                    }

                    .detail-value {
                        text-align: left;
                    }
                }
            </style>
        </head>

        <body>

            <!-- Include Header -->
            <jsp:include page="/common/_header.jsp" />

            <div class="success-container">
                <div class="success-card">
                    <!-- Success Icon -->
                    <div class="success-icon">
                        <i class="fas fa-check"></i>
                    </div>

                    <!-- Success Title -->
                    <h1 class="success-title">Đăng Ký Thành Công!</h1>

                    <!-- Success Message -->
                    <p class="success-message">
                        Cảm ơn bạn đã đăng ký trở thành đối tác của Da Nang Travel Hub. Chúng tôi đã nhận được thông
                        tin đăng ký của bạn và sẽ xem xét trong thời gian sớm nhất.
                    </p>

                    <!-- Registration Details -->
                    <c:if test="${not empty registration}">
                        <div class="registration-details">
                            <h5 style="color: var(--secondary-color); font-weight: 700; margin-bottom: 20px;">
                                <i class="fas fa-file-alt"></i> Thông Tin Đăng Ký
                            </h5>
                            <div class="detail-row">
                                <span class="detail-label">Tên doanh nghiệp:</span>
                                <span class="detail-value">${registration.businessName}</span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Loại dịch vụ:</span>
                                <span class="detail-value">
                                    <c:choose>
                                        <c:when test="${registration.providerType == 'Hotel'}">Khách sạn</c:when>
                                        <c:when test="${registration.providerType == 'TourOperator'}">Tour</c:when>
                                        <c:otherwise>Vận chuyển</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Email:</span>
                                <span class="detail-value">${registration.email}</span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Số điện thoại:</span>
                                <span class="detail-value">${registration.phoneNumber}</span>
                            </div>
                        </div>
                    </c:if>

                    <!-- Next Steps Info -->
                    <div class="info-box">
                        <h5><i class="fas fa-clipboard-list"></i> Các Bước Tiếp Theo</h5>
                        <div class="info-item">
                            <i class="fas fa-envelope"></i>
                            <span>Chúng tôi sẽ gửi email xác nhận đến địa chỉ bạn đã đăng ký</span>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-user-check"></i>
                            <span>Đội ngũ của chúng tôi sẽ xem xét hồ sơ trong vòng 2-3 ngày làm việc</span>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-phone"></i>
                            <span>Chúng tôi sẽ liên hệ với bạn qua số điện thoại đã đăng ký để hoàn tất thủ tục</span>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-rocket"></i>
                            <span>Sau khi được phê duyệt, bạn có thể bắt đầu đăng tải dịch vụ ngay lập tức</span>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/providers" class="btn-primary-custom">
                            <i class="fas fa-building"></i> Xem Danh Sách Nhà Cung Cấp
                        </a>
                        <a href="${pageContext.request.contextPath}/" class="btn-secondary-custom">
                            <i class="fas fa-home"></i> Về Trang Chủ
                        </a>
                    </div>

                    <!-- Contact Info -->
                    <div class="mt-4" style="color: #6c757d; font-size: 0.95rem;">
                        <p>Có câu hỏi? Liên hệ với chúng tôi:</p>
                        <p>
                            <i class="fas fa-envelope" style="color: var(--primary-color);"></i>
                            support@danangtravelhub.com
                            <br>
                            <i class="fas fa-phone" style="color: var(--primary-color);"></i>
                            0236 3 888 999
                        </p>
                    </div>
                </div>
            </div>

            <!-- Include Footer -->
            <jsp:include page="/common/_footer.jsp" />

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>