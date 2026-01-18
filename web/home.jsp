<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Dashboard Quản Lý</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f6f9; margin: 0; padding: 0; }
        
        /* Header Menu */
        .navbar { background-color: #343a40; overflow: hidden; padding: 15px 20px; color: white; display: flex; align-items: center; justify-content: space-between; }
        .navbar h2 { margin: 0; font-weight: normal; }
        .nav-links a { color: #ccc; text-decoration: none; margin-left: 20px; font-size: 16px; }
        .nav-links a:hover { color: white; }

        /* Container chính */
        .container { padding: 40px; max-width: 1000px; margin: auto; }
        
        /* Khu vực hiển thị thẻ (Cards) */
        .dashboard-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-top: 20px; }
        
        .card { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); text-align: center; transition: transform 0.2s; }
        .card:hover { transform: translateY(-5px); }
        .card h3 { margin: 0; color: #555; font-size: 16px; text-transform: uppercase; }
        .card .number { font-size: 48px; font-weight: bold; color: #007bff; margin: 10px 0; }
        .card .desc { color: #888; font-size: 14px; }

        /* Nút điều hướng lớn */
        .action-area { margin-top: 40px; text-align: center; }
        .btn-start { background-color: #28a745; color: white; padding: 15px 30px; text-decoration: none; border-radius: 5px; font-size: 18px; font-weight: bold; }
        .btn-start:hover { background-color: #218838; }
        
        footer { text-align: center; margin-top: 50px; color: #aaa; font-size: 12px; }
    </style>
</head>
<body>

    <div class="navbar">
        <h2>🛍️ Shop Manager</h2>
        <div class="nav-links">
            <a href="home">Trang chủ</a>
            <a href="products">Sản phẩm</a>
            <a href="#">Cài đặt</a>
            <a href="#">Đăng xuất</a>
        </div>
    </div>

    <div class="container">
        <h1>Xin chào, Quản trị viên!</h1>
        <p>Đây là bảng tổng quan tình hình cửa hàng của bạn hôm nay.</p>

        <div class="dashboard-grid">
            <div class="card">
                <h3>Tổng Sản Phẩm</h3>
                <div class="number">${pCount}</div>
                <div class="desc">Sản phẩm đang kinh doanh</div>
            </div>

            <div class="card">
                <h3>Danh Mục</h3>
                <div class="number">${cCount}</div>
                <div class="desc">Loại hàng hóa khác nhau</div>
            </div>

            <div class="card">
                <h3>Đơn Hàng Mới</h3>
                <div class="number" style="color: #dc3545;">0</div>
                <div class="desc">Chưa có đơn hàng nào</div>
            </div>
        </div>

        <div class="action-area">
            <a href="products" class="btn-start">Đi tới Quản Lý Sản Phẩm →</a>
        </div>
    </div>

    <footer>
        <p>Copyright &copy; 2026 PRJ301 Project. Powered by Java Servlet & JPA.</p>
    </footer>

</body>
</html>