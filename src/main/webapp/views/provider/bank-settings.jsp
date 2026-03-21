<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cài Đặt Ngân Hàng | EZTravel</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<style>
* {box-sizing:border-box}
body {font-family:'Plus Jakarta Sans',system-ui,sans-serif;background:#F4F5FA;color:#1B1F3B}

.dash-hero{margin-top:64px;background:linear-gradient(135deg,#0F172A,#1E293B 60%,#334155);padding:48px 0 80px;position:relative;overflow:hidden}
.dash-content{max-width:1200px;margin:0 auto;padding:0 30px;position:relative;z-index:2;display:flex;justify-content:space-between;align-items:center}
.dash-left h1{font-size:1.8rem;font-weight:900;color:#fff;margin-bottom:4px;display:flex;align-items:center;gap:10px}
.dash-left h1 i{color:#60A5FA}
.dash-left p{color:rgba(255,255,255,.5);font-size:.88rem}

.dash-right{display:flex;gap:10px}
.dash-btn{padding:12px 24px;border-radius:12px;font-weight:700;font-size:.85rem;font-family:inherit;text-decoration:none;display:flex;align-items:center;gap:8px;transition:.3s;border:none;cursor:pointer}
.dash-btn:hover{transform:translateY(-2px);box-shadow:0 8px 25px rgba(0,0,0,.2)}

.page-body{max-width:800px;margin: -45px auto 60px;padding:0 30px; position:relative; z-index:10}

.settings-card {background:#fff;padding:32px;border-radius:18px;box-shadow:0 6px 25px rgba(0,0,0,.04);border:1px solid #E8EAF0;}
.form-group {margin-bottom: 20px;}
.form-group label {display:block;font-weight:700;font-size:0.9rem;margin-bottom:8px;color:#1B1F3B;}
.form-control {width:100%;padding:14px 18px;border-radius:12px;border:1px solid #E8EAF0;font-family:inherit;font-size:0.95rem;transition:0.3s;}
.form-control:focus {outline:none;border-color:#3B82F6;box-shadow:0 0 0 3px rgba(59,130,246,0.1);}

.btn-submit {background:linear-gradient(135deg,#3B82F6,#60A5FA);color:#fff;border:none;padding:14px 28px;border-radius:12px;font-weight:800;font-size:1rem;cursor:pointer;width:100%;transition:0.3s;box-shadow:0 6px 20px rgba(59,130,246,.2);}
.btn-submit:hover {transform:translateY(-2px);box-shadow:0 10px 25px rgba(59,130,246,.3);}

.alert{padding:14px 20px;border-radius:14px;margin-bottom:20px;font-size:.88rem;font-weight:600;display:flex;align-items:center;gap:8px}
.alert-success{background:#ECFDF5;color:#059669;border:1px solid rgba(5,150,105,.15)}
.alert-error{background:#FEF2F2;color:#DC2626;border:1px solid rgba(220,38,38,.15)}

.form-info {margin-bottom:24px;padding:16px;background:rgba(59,130,246,0.05);border-radius:12px;border:1px solid rgba(59,130,246,0.1);color:#334155;font-size:0.9rem;line-height:1.5;}
.form-info i {color:#3B82F6;margin-right:6px;}

</style>
</head>
<body>
<jsp:include page="/common/_header.jsp" />

<div class="dash-hero">
    <div class="dash-content">
        <div class="dash-left">
            <h1><i class="fas fa-university"></i> Cài Đặt Ngân Hàng</h1>
            <p>Thiết lập thông tin nhận thanh toán cho <span style="color:#60A5FA;font-weight:800">${provider.businessName}</span></p>
        </div>
        <div class="dash-right">
            <a href="${pageContext.request.contextPath}/provider/dashboard" class="dash-btn" style="background:rgba(255,255,255,0.1);color:#fff;">
                <i class="fas fa-arrow-left"></i> Quay lại Dashboard
            </a>
        </div>
    </div>
</div>

<div class="page-body">
    <div class="settings-card">
        <div class="form-info">
            <i class="fas fa-info-circle"></i> 
            <strong>Thông báo quan trọng:</strong> 
            Tài khoản ngân hàng bạn cung cấp dưới đây sẽ được Admin kiểm duyệt và sử dụng để chuyển tiền hoa hồng (payout) sau khi các giao dịch được hoàn tất. Vui lòng nhập thông tin chính xác.
        </div>
        
        <form action="${pageContext.request.contextPath}/provider" method="POST">
            <input type="hidden" name="action" value="save-bank">
            
            <div class="form-group">
                <label>Ngân hàng nhận tiền (Vd: MB, Vietcombank, Techcombank, ...)</label>
                <input type="text" name="bankName" class="form-control" placeholder="Tên ngân hàng" value="${bankInfo.bankName}" required>
            </div>
            
            <div class="form-group">
                <label>Số tài khoản</label>
                <input type="text" name="accountNumber" class="form-control" placeholder="Số tài khoản ngân hàng" value="${bankInfo.accountNumber}" required>
            </div>
            
            <div class="form-group">
                <label>Tên chủ tài khoản (Viết chữ không dấu)</label>
                <input type="text" name="accountName" class="form-control" placeholder="NGUYEN VAN A" value="${bankInfo.accountName}" required>
            </div>
            
            <button type="submit" class="btn-submit">
                <i class="fas fa-save"></i> Lưu Cài Đặt Ngân Hàng
            </button>
        </form>
    </div>
</div>

<jsp:include page="/common/_footer.jsp" />
</body>
</html>
