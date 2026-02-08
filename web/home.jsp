<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - Travel Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .tour-card {
            transition: transform 0.3s;
            border: none;
        }
        .tour-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
        }
        .tour-card img {
            height: 220px;
            object-fit: cover;
            cursor: pointer;
        }
        .price-tag {
            color: #dc3545;
            font-weight: bold;
            font-size: 1.1rem;
        }
        .card-title a {
            text-decoration: none;
            color: #212529;
            transition: color 0.2s;
        }
        .card-title a:hover {
            color: #0d6efd;
        }
    </style>
</head>
<body class="bg-light d-flex flex-column min-vh-100">

    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold" href="home"><i class="bi bi-airplane-engines"></i> TRAVEL BOOKING</a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item"><a class="nav-link active" href="home">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="history">Lịch sử vé</a></li>
                    <li class="nav-item ms-2"><a class="btn btn-light btn-sm text-primary fw-bold" href="#">Đăng nhập</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="text-center mb-5 py-4 bg-white rounded shadow-sm">
            <h1 class="fw-bold text-primary">Khám Phá Các Tour Du Lịch Hot Nhất</h1>
            <p class="text-muted">Chúng tôi hiện có <span class="badge bg-danger">${listTours.size()}</span> tour đang mở bán.</p>
            
            <form action="search" method="GET" class="d-flex w-50 mx-auto mt-3">
                <input class="form-control me-2" type="search" name="keyword" 
                       placeholder="Bạn muốn đi đâu? (Ví dụ: Hội An)" 
                       value="${searchKeyword}"> 
                <button class="btn btn-primary px-4" type="submit"><i class="bi bi-search"></i> Tìm</button>
            </form>
        </div>

        <div class="row">
            <c:forEach items="${listTours}" var="t">
                <div class="col-md-4 mb-4">
                    <div class="card h-100 shadow-sm tour-card">
                        
                        <a href="detail?id=${t.tourId}" class="overflow-hidden rounded-top">
                            <img src="${t.imageUrl}" class="card-img-top" alt="${t.tourName}">
                        </a>
                        
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title fw-bold">
                                <a href="detail?id=${t.tourId}">${t.tourName}</a>
                            </h5>
                            
                            <p class="card-text text-muted small mb-2">
                                <i class="bi bi-clock"></i> ${t.duration} <br>
                                <i class="bi bi-geo-alt-fill"></i> ${t.startLocation}
                            </p>
                            
                            <p class="card-text text-secondary small flex-grow-1">
                                ${t.description != null && t.description.length() > 100 ? t.description.substring(0, 100).concat("...") : t.description}
                            </p>
                            
                            <div class="mt-auto border-top pt-3">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="price-tag">
                                        <fmt:formatNumber value="${t.price}" type="currency" currencySymbol="₫"/>
                                    </span>
                                    
                                    <div>
                                        <a href="detail?id=${t.tourId}" class="btn btn-outline-secondary btn-sm">
                                            Chi tiết
                                        </a>
                                        <a href="booking?id=${t.tourId}" class="btn btn-primary btn-sm fw-bold">
                                            Đặt ngay
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty listTours}">
                <div class="alert alert-warning text-center">
                    Không tìm thấy tour nào phù hợp với từ khóa "${searchKeyword}".
                    <br><a href="home" class="btn btn-outline-dark btn-sm mt-2">Xem tất cả</a>
                </div>
            </c:if>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>