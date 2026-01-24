<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - Đặt Tour Du Lịch</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .tour-card img {
            height: 200px; /* Cố định chiều cao ảnh cho đều */
            object-fit: cover;
        }
        .price-tag {
            color: #d32f2f;
            font-weight: bold;
            font-size: 1.2rem;
        }
    </style>
</head>
<body class="bg-light">

    <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
        <div class="container">
            <a class="navbar-brand" href="home">TRAVEL BOOKING</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="home">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Đăng nhập</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="text-center mb-5">
            <h1 class="fw-bold">Khám Phá Các Tour Du Lịch Hot Nhất</h1>
            <p class="text-muted">Chúng tôi hiện có <span class="badge bg-danger">${totalTours}</span> tour đang mở bán.</p>
        </div>

        <div class="row">
            <c:forEach items="${listTours}" var="t">
                
                <div class="col-md-4 mb-4">
                    <div class="card h-100 shadow-sm tour-card">
                        <img src="${t.imageUrl}" class="card-img-top" alt="Ảnh tour">
                        
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title">${t.tourName}</h5>
                            
                            <p class="card-text text-muted small">
                                <i class="bi bi-clock"></i> Thời gian: ${t.duration} <br>
                                <i class="bi bi-geo-alt"></i> Khởi hành: ${t.startLocation}
                            </p>
                            
                            <p class="card-text">${t.description}</p>
                            
                            <div class="mt-auto">
                                <hr>
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="price-tag">${t.price} VNĐ</span>
                                    <a href="booking?id=${t.tourId}" class="btn btn-primary">Đặt ngay</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
            </c:forEach> </div>
    </div>

    <footer class="bg-dark text-white text-center py-3 mt-5">
        <p class="mb-0">© 2026 Copyright by Kunlu - PRJ301 Project</p>
    </footer>

</body>
</html>