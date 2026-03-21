<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cài Đặt Ngân Hàng | Provider Dashboard</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Playfair+Display:wght@700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
    *{margin:0;padding:0;box-sizing:border-box}
    body{font-family:'Inter',system-ui,sans-serif;background:#0F172A;color:#E2E8F0;-webkit-font-smoothing:antialiased;min-height:100vh}

    /* Sidebar */
    .sidebar{position:fixed;left:0;top:0;width:260px;height:100vh;background:#0B1120;border-right:1px solid rgba(255,255,255,.06);padding:24px 16px;display:flex;flex-direction:column;z-index:100}
    .sidebar .logo{font-family:'Playfair Display',serif;font-size:1.4rem;font-weight:800;color:#fff;padding:0 12px 24px;border-bottom:1px solid rgba(255,255,255,.06);margin-bottom:16px}
    .sidebar .logo .a{color:#60A5FA}
    .sidebar nav{flex:1}
    .sidebar nav a{display:flex;align-items:center;gap:12px;padding:11px 16px;border-radius:10px;color:rgba(255,255,255,.5);font-size:.88rem;font-weight:500;transition:.3s;margin-bottom:2px;text-decoration:none}
    .sidebar nav a:hover{color:#fff;background:rgba(255,255,255,.06)}
    .sidebar nav a.active{color:#fff;background:rgba(59,130,246,.15);border:1px solid rgba(59,130,246,.2)}
    .sidebar nav a.active i{color:#60A5FA}
    .sidebar nav a i{width:20px;text-align:center;font-size:.85rem}
    .sidebar .user-box{padding:16px;border-top:1px solid rgba(255,255,255,.06);display:flex;align-items:center;gap:12px}
    .sidebar .user-box .avatar{width:38px;height:38px;border-radius:10px;background:linear-gradient(135deg,#3B82F6,#60A5FA);display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;font-size:.85rem}
    .sidebar .user-box .uname{font-size:.85rem;color:#fff;font-weight:600}
    .sidebar .user-box .urole{font-size:.72rem;color:rgba(255,255,255,.4)}

    /* Main */
    .main{margin-left:260px;padding:32px 40px;min-height:100vh}
    .page-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:32px}
    .page-header h1{font-size:1.8rem;font-weight:800;color:#fff}
    .page-header p{color:rgba(255,255,255,.5);font-size:.9rem;margin-top:4px}
    
    .card{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:32px;margin-bottom:24px;max-width:700px}
    .card h3{font-size:1.1rem;font-weight:700;color:#fff;margin-bottom:20px;display:flex;align-items:center;gap:10px}
    .card h3 i{color:#60A5FA;}

    .form-group{margin-bottom:24px}
    .form-group label{display:block;font-size:.875rem;font-weight:600;color:rgba(255,255,255,.7);margin-bottom:8px}
    .form-control{width:100%;padding:12px 16px;background:rgba(0,0,0,.2);border:1px solid rgba(255,255,255,.1);border-radius:10px;color:#fff;font-family:inherit;font-size:.95rem;transition:.3s}
    .form-control:focus{outline:none;border-color:#3B82F6;box-shadow:0 0 0 2px rgba(59,130,246,.2)}
    
    .btn-submit{background:#3B82F6;color:#fff;border:none;padding:14px 24px;border-radius:10px;font-weight:600;font-size:1rem;cursor:pointer;width:100%;transition:.3s;display:flex;align-items:center;justify-content:center;gap:10px}
    .btn-submit:hover{background:#2563EB;transform:translateY(-1px);box-shadow:0 4px 16px rgba(59,130,246,.3)}

    .alert{padding:16px;border-radius:10px;margin-bottom:24px;font-size:.9rem;font-weight:500;display:flex;align-items:flex-start;gap:12px}
    .alert i {margin-top:2px;font-size:1.1rem}
    .alert-info{background:rgba(59,130,246,.1);color:#60A5FA;border:1px solid rgba(59,130,246,.2)}
    
    @media(max-width:768px){.main{margin-left:0;padding:16px}.sidebar{display:none}}
    </style>
</head>
<body>

<!-- Sidebar -->
<aside class="sidebar">
    <div class="logo"><img src="${pageContext.request.contextPath}/images/logo.png" style="width:36px;height:36px;border-radius:50%;display:inline-block;vertical-align:middle;margin-right:8px"><span style="vertical-align:middle"><span class="a">ez</span>travel</span></div>
    <nav>
        <a href="${pageContext.request.contextPath}/provider/dashboard"><i class="fas fa-chart-pie"></i> Tổng Quan</a>
        <a href="${pageContext.request.contextPath}/provider/dashboard#tours-section"><i class="fas fa-map-marked-alt"></i> Tours Của Tôi</a>
        <a href="${pageContext.request.contextPath}/my-orders"><i class="fas fa-shopping-bag"></i> Đơn Đặt</a>
        <a href="${pageContext.request.contextPath}/provider?action=bank-settings" class="active"><i class="fas fa-university"></i> Cài Đặt NH</a>
        <a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user-cog"></i> Hồ Sơ</a>
    </nav>
    <div class="user-box">
        <div class="avatar">${sessionScope.user.username.substring(0,1).toUpperCase()}</div>
        <div>
            <div class="uname">${sessionScope.user.username}</div>
            <div class="urole">Nhà Cung Cấp</div>
        </div>
    </div>
</aside>

<!-- Main Content -->
<main class="main">
    <header class="page-header">
        <div>
            <h1>Cài Đặt Ngân Hàng</h1>
            <p>Thiết lập tài khoản nhận thanh toán hoa hồng cho <strong>${provider.businessName}</strong></p>
        </div>
    </header>

    <div class="card">
        <div class="alert alert-info">
            <i class="fas fa-info-circle"></i> 
            <div>
                <strong style="display:block;margin-bottom:4px;color:#fff">Lưu ý quan trọng:</strong> 
                Tài khoản ngân hàng bạn cung cấp ở đây sẽ được Admin hệ thống sử dụng để Payout (chuyển doanh thu bán Tour) cho bạn định kỳ sau khi trừ đi chiết khấu hoa hồng. Hãy nhập thật chính xác thông tin.
            </div>
        </div>
        
        <form action="${pageContext.request.contextPath}/provider" method="POST">
            <input type="hidden" name="action" value="save-bank">
            
            <div class="form-group">
                <label>Ngân hàng nhận tiền (Vd: MB Bank, Vietcombank, Techcombank...)</label>
                <input type="text" name="bankName" class="form-control" placeholder="Tên ngân hàng" value="${bankInfo.bankName}" required>
            </div>
            
            <div class="form-group">
                <label>Số tài khoản</label>
                <input type="text" name="accountNumber" class="form-control" placeholder="Nhập số tài khoản" value="${bankInfo.accountNumber}" required>
            </div>
            
            <div class="form-group">
                <label>Tên chủ tài khoản (Viết hoa không dấu)</label>
                <input type="text" name="accountName" class="form-control" placeholder="VD: NGUYEN VAN A" value="${bankInfo.accountName}" required>
            </div>
            
            <button type="submit" class="btn-submit">
                <i class="fas fa-save"></i> <span>Lưu Mặc Định Thẻ</span>
            </button>
        </form>
    </div>
</main>

</body>
</html>
