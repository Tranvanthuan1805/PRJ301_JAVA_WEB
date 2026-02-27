<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Nhận Đặt Tour | Da Nang Travel Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
    *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
    body{font-family:'Plus Jakarta Sans',system-ui,sans-serif;background:#F7F8FC;color:#1B1F3B;min-height:100vh;display:flex;flex-direction:column;-webkit-font-smoothing:antialiased}
    a{text-decoration:none;color:inherit;transition:.3s}

    /* Nav */
    .nav-top{position:fixed;top:0;left:0;right:0;z-index:1000;background:rgba(27,31,59,.95);backdrop-filter:blur(20px);padding:0 30px;border-bottom:1px solid rgba(255,255,255,.06)}
    .nav-inner{max-width:1280px;margin:0 auto;display:flex;align-items:center;justify-content:space-between;height:64px}
    .logo{font-size:1.2rem;font-weight:800;color:#fff;display:flex;align-items:center;gap:6px}
    .logo .a{color:#FF6F61}
    .btn-back{color:rgba(255,255,255,.7);font-weight:600;font-size:.85rem;display:flex;align-items:center;gap:6px}
    .btn-back:hover{color:#fff}

    /* Main */
    .booking-page{flex:1;display:flex;align-items:center;justify-content:center;padding:100px 20px 60px}
    .booking-card{background:#fff;border-radius:24px;box-shadow:0 20px 60px rgba(27,31,59,.1);border:1px solid #E8EAF0;max-width:900px;width:100%;display:grid;grid-template-columns:1fr 1fr;overflow:hidden;animation:slideUp .6s ease}
    @keyframes slideUp{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}

    /* Left - Tour Preview */
    .booking-preview{position:relative;overflow:hidden}
    .booking-preview img{width:100%;height:100%;object-fit:cover;min-height:450px}
    .booking-preview .overlay{position:absolute;inset:0;background:linear-gradient(180deg,transparent 40%,rgba(27,31,59,.85) 100%)}
    .booking-preview .info{position:absolute;bottom:30px;left:30px;right:30px;color:#fff}
    .booking-preview .info h2{font-size:1.5rem;font-weight:800;margin-bottom:8px}
    .booking-preview .info .tour-meta{display:flex;gap:16px;font-size:.82rem;color:rgba(255,255,255,.8)}
    .booking-preview .info .tour-meta i{color:#FF6F61;margin-right:4px}
    .booking-preview .price-tag{position:absolute;top:20px;right:20px;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;padding:10px 20px;border-radius:14px;font-weight:800;font-size:1.1rem;box-shadow:0 6px 20px rgba(255,111,97,.3)}

    /* Right - Form */
    .booking-form{padding:40px;display:flex;flex-direction:column;justify-content:center}
    .booking-form h3{font-size:1.5rem;font-weight:800;color:#1B1F3B;margin-bottom:6px}
    .booking-form .sub{color:#6B7194;font-size:.9rem;margin-bottom:30px}
    .form-group{margin-bottom:22px}
    .form-group label{display:block;font-size:.82rem;font-weight:700;color:#1B1F3B;margin-bottom:8px;text-transform:uppercase;letter-spacing:.5px}
    .form-group .input-wrap{position:relative}
    .form-group .input-wrap i{position:absolute;left:16px;top:50%;transform:translateY(-50%);color:#A0A5C3;font-size:.9rem}
    .form-group input,.form-group select{width:100%;padding:14px 16px 14px 46px;border:2px solid #E8EAF0;border-radius:14px;font-size:.95rem;font-family:inherit;transition:.3s;background:#F7F8FC;color:#1B1F3B}
    .form-group input:focus,.form-group select:focus{outline:none;border-color:#FF6F61;box-shadow:0 0 0 4px rgba(255,111,97,.1);background:#fff}

    /* Summary */
    .summary{background:#F7F8FC;border-radius:14px;padding:20px;margin-bottom:24px;border:1px solid #E8EAF0}
    .summary-row{display:flex;justify-content:space-between;align-items:center;padding:8px 0;font-size:.9rem;color:#6B7194}
    .summary-row.total{border-top:2px solid #E8EAF0;margin-top:8px;padding-top:14px}
    .summary-row.total span:last-child{font-size:1.3rem;font-weight:800;color:#FF6F61}

    .btn-submit{width:100%;padding:16px;background:linear-gradient(135deg,#FF6F61,#FF9A8B);color:#fff;border:none;border-radius:14px;font-weight:800;font-size:1rem;cursor:pointer;transition:.3s;font-family:inherit;display:flex;align-items:center;justify-content:center;gap:8px;box-shadow:0 6px 20px rgba(255,111,97,.25)}
    .btn-submit:hover{transform:translateY(-3px);box-shadow:0 12px 30px rgba(255,111,97,.4)}
    .btn-cancel{display:block;text-align:center;margin-top:14px;color:#6B7194;font-weight:600;font-size:.88rem}
    .btn-cancel:hover{color:#FF6F61}

    @media(max-width:768px){
        .booking-card{grid-template-columns:1fr}
        .booking-preview img{min-height:250px}
        .booking-form{padding:30px 20px}
    }
    </style>
</head>
<body>

<!-- Nav -->
<nav class="nav-top">
    <div class="nav-inner">
        <a href="${pageContext.request.contextPath}/" class="logo"><span class="a">🏖️</span> DN HUB</a>
        <a href="javascript:history.back()" class="btn-back"><i class="fas fa-arrow-left"></i> Quay lại</a>
    </div>
</nav>

<!-- Booking -->
<div class="booking-page">
    <div class="booking-card">
        <!-- Left Preview -->
        <div class="booking-preview">
            <img src="${tour.imageUrl}" alt="${tour.tourName}">
            <div class="overlay"></div>
            <div class="info">
                <h2>${tour.tourName}</h2>
                <div class="tour-meta">
                    <span><i class="fas fa-clock"></i> ${tour.duration}</span>
                    <span><i class="fas fa-map-marker-alt"></i> ${tour.startLocation}</span>
                </div>
            </div>
            <div class="price-tag"><fmt:formatNumber value="${tour.price}" type="number" groupingUsed="true"/>đ</div>
        </div>

        <!-- Right Form -->
        <div class="booking-form">
            <h3>Xác Nhận Đặt Tour</h3>
            <p class="sub">Điền thông tin để hoàn tất đặt chỗ</p>

            <form action="booking" method="POST" id="bookingForm">
                <input type="hidden" name="id" value="${tour.tourId}">

                <div class="form-group">
                    <label>Số lượng hành khách</label>
                    <div class="input-wrap">
                        <i class="fas fa-users"></i>
                        <input type="number" name="quantity" id="qty" value="1" min="1" max="50" required onchange="updateTotal()">
                    </div>
                </div>

                <div class="summary">
                    <div class="summary-row">
                        <span>Giá tour / người</span>
                        <span><fmt:formatNumber value="${tour.price}" type="number" groupingUsed="true"/>đ</span>
                    </div>
                    <div class="summary-row">
                        <span>Số lượng</span>
                        <span id="displayQty">1</span>
                    </div>
                    <div class="summary-row total">
                        <span>Tổng cộng</span>
                        <span id="totalPrice"><fmt:formatNumber value="${tour.price}" type="number" groupingUsed="true"/>đ</span>
                    </div>
                </div>

                <button type="submit" class="btn-submit">
                    <i class="fas fa-check-circle"></i> XÁC NHẬN ĐẶT VÉ
                </button>
                <a href="${pageContext.request.contextPath}/" class="btn-cancel">
                    <i class="fas fa-times-circle"></i> Hủy bỏ
                </a>
            </form>
        </div>
    </div>
</div>

<script>
var basePrice = ${tour.price};
function updateTotal() {
    var qty = parseInt(document.getElementById('qty').value) || 1;
    document.getElementById('displayQty').textContent = qty;
    var total = basePrice * qty;
    document.getElementById('totalPrice').textContent = total.toLocaleString('vi-VN') + 'đ';
}
</script>
</body>
</html>