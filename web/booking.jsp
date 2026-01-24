<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác Nhận Đặt Tour</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">Xác Nhận Đặt Tour</h4>
                    </div>
                    <div class="card-body">
                        <form action="booking" method="POST">
                            
                            <div class="text-center mb-4">
                                <img src="${tour.imageUrl}" class="img-fluid rounded mb-3" style="max-height: 200px;">
                                <h3>${tour.tourName}</h3>
                                <p class="text-muted">${tour.duration} | Khởi hành: ${tour.startLocation}</p>
                                <h4 class="text-danger fw-bold">Giá: ${tour.price} VNĐ/người</h4>
                            </div>

                            <hr>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Số lượng người đi:</label>
                                <input type="number" name="quantity" class="form-control" value="1" min="1" max="50" required>
                            </div>

                            <input type="hidden" name="id" value="${tour.tourId}">

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-success btn-lg">Xác Nhận Đặt Vé</button>
                                <a href="home" class="btn btn-outline-secondary">Hủy bỏ</a>
                            </div>
                            
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>