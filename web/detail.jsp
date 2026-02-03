<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${tour.tourName} | Travel Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .tour-image {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 10px;
        }
        .text-justify {
            text-align: justify;
        }
    </style>
</head>
<body class="bg-light">

    <nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="home">TRAVEL BOOKING</a>
            <div class="ms-auto">
                <a href="home" class="btn btn-outline-light btn-sm">
                    <i class="bi bi-arrow-left"></i> Quay lại danh sách
                </a>
            </div>
        </div>
    </nav>

    <div class="bg-white py-2 border-bottom shadow-sm">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0 small">
                    <li class="breadcrumb-item"><a href="home" class="text-decoration-none">Trang chủ</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Chi tiết tour</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="container mt-4 mb-5">
        
        <div class="row mb-3 align-items-end">
            <div class="col-md-8">
                <h2 class="fw-bold text-primary mb-1">${tour.tourName}</h2>
                <p class="text-muted mb-0"><i class="bi bi-geo-alt-fill"></i> Khởi hành từ: <strong>${tour.startLocation}</strong></p>
            </div>
            <div class="col-md-4 text-md-end">
                <p class="text-muted mb-0 text-decoration-line-through small">
                    <fmt:formatNumber value="${tour.price * 1.2}" type="currency" currencySymbol="₫"/>
                </p>
                <h3 class="text-danger fw-bold">
                    <fmt:formatNumber value="${tour.price}" type="currency" currencySymbol="₫"/>
                    <span class="fs-6 text-dark fw-normal">/khách</span>
                </h3>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-8">
                <div class="mb-4 position-relative">
                    <img src="${tour.imageUrl}" class="tour-image shadow-sm" alt="${tour.tourName}">
                    <span class="position-absolute top-0 end-0 badge bg-warning text-dark m-3 px-3 py-2 shadow-sm">Hot Trend</span>
                </div>

                <ul class="nav nav-tabs mb-3" id="myTab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active fw-bold" id="desc-tab" data-bs-toggle="tab" data-bs-target="#desc" type="button">Giới thiệu</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link fw-bold" id="schedule-tab" data-bs-toggle="tab" data-bs-target="#schedule" type="button">Lịch trình</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link fw-bold" id="policy-tab" data-bs-toggle="tab" data-bs-target="#policy" type="button">Chính sách</button>
                    </li>
                </ul>

                <div class="tab-content p-4 border rounded shadow-sm bg-white text-justify" id="myTabContent">
                    
                    <div class="tab-pane fade show active" id="desc" role="tabpanel">
                        <c:choose>
                            <c:when test="${not empty tour.description}">
                                ${tour.description}
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-4 text-muted">
                                    <i class="bi bi-pencil-square fs-1"></i>
                                    <p class="mt-2">Thông tin giới thiệu đang được cập nhật.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="tab-pane fade" id="schedule" role="tabpanel">
                        <c:choose>
                            <c:when test="${not empty tour.itinerary}">
                                ${tour.itinerary}
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-4 text-muted">
                                    <i class="bi bi-calendar-range fs-1"></i>
                                    <p class="mt-2">Lịch trình chi tiết đang được cập nhật.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="tab-pane fade" id="policy" role="tabpanel">
                         <div class="text-center py-4 text-muted">
                            <i class="bi bi-file-earmark-text fs-1"></i>
                            <p class="mt-2">Thông tin chính sách đang được cập nhật.</p>
                        </div>
                    </div>
                    
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card shadow border-0 mb-4 sticky-top" style="top: 80px; z-index: 100;">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0 fw-bold"><i class="bi bi-info-circle"></i> THÔNG TIN TOUR</h5>
                    </div>
                    <div class="card-body">
                        <ul class="list-group list-group-flush mb-4">
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <span><i class="bi bi-clock"></i> Thời gian:</span>
                                <span class="fw-bold">${tour.duration}</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <span><i class="bi bi-calendar-check"></i> Khởi hành:</span>
                                <span class="fw-bold">Hàng ngày</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <span><i class="bi bi-bus-front"></i> Phương tiện:</span>
                                <span class="fw-bold">
                                    ${not empty tour.transport ? tour.transport : "Đang cập nhật"}
                                </span>
                            </li>
                            
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <span><i class="bi bi-ticket-perforated"></i> Tình trạng:</span>

                                <c:choose>
                                    <c:when test="${remaining > 0}">
                                        <span class="badge bg-success">Còn ${remaining} chỗ</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">HẾT CHỖ (SOLD OUT)</span>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                        </ul>

                        <div class="d-grid gap-2">
                            <c:choose>
                                <%-- TRƯỜNG HỢP CÒN CHỖ --%>
                                <c:when test="${remaining > 0}">
                                    <a href="booking?id=${tour.tourId}" class="btn btn-danger btn-lg fw-bold py-3 shadow-sm">
                                        ĐẶT TOUR NGAY
                                    </a>
                                </c:when>

                                <%-- TRƯỜNG HỢP HẾT CHỖ --%>
                                <c:otherwise>
                                    <button class="btn btn-secondary btn-lg fw-bold py-3" disabled>
                                        TẠM HẾT VÉ
                                    </button>
                                </c:otherwise>
                            </c:choose>

                            <a href="#" class="btn btn-outline-primary fw-bold">
                                <i class="bi bi-telephone-fill"></i> Liên hệ chờ vé
                            </a>
                        </div>
                    </div>
                    <div class="card-footer bg-light text-center text-muted small">
                        Hỗ trợ khách hàng 24/7
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>