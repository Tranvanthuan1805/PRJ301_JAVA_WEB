<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản lý sản phẩm | Shop Manager</title>
    <style>
        /* --- ĐỒNG BỘ CSS VỚI TRANG HOME --- */
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f6f9; margin: 0; padding: 0; color: #333; }
        
        /* Navbar (Giống Home) */
        .navbar { background-color: #343a40; padding: 15px 20px; color: white; display: flex; align-items: center; justify-content: space-between; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .navbar h2 { margin: 0; font-weight: normal; font-size: 20px; }
        .nav-links a { color: #ccc; text-decoration: none; margin-left: 20px; font-size: 15px; transition: color 0.3s; }
        .nav-links a:hover, .nav-links a.active { color: white; font-weight: bold; }

        /* Container chính */
        .container { padding: 30px; max-width: 1100px; margin: auto; }

        /* --- CSS RIÊNG CHO TRANG PRODUCT --- */
        
        /* 1. Layout chia 2 cột: Form bên trái, Bảng bên phải (hoặc trên dưới tùy màn hình) */
        .content-grid { display: grid; grid-template-columns: 350px 1fr; gap: 30px; margin-top: 20px; }
        
        /* 2. Form Card (Khung nhập liệu) */
        .form-card { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); height: fit-content; }
        .form-card h3 { margin-top: 0; color: #007bff; border-bottom: 2px solid #f1f1f1; padding-bottom: 10px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: 500; }
        .form-group input, .form-group select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        
        /* Nút bấm trong Form */
        .btn-submit { background-color: #28a745; color: white; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer; width: 100%; font-size: 16px; margin-top: 10px; }
        .btn-submit:hover { background-color: #218838; }
        .btn-cancel { display: block; text-align: center; margin-top: 10px; color: #dc3545; text-decoration: none; font-size: 14px; }

        /* 3. Phần Danh sách & Tìm kiếm */
        .list-section { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        
        .search-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .search-bar form { display: flex; gap: 10px; }
        .search-bar input { padding: 8px; border: 1px solid #ddd; border-radius: 4px; width: 200px; }
        .btn-search { background-color: #007bff; color: white; border: none; padding: 8px 15px; border-radius: 4px; cursor: pointer; }

        /* Bảng dữ liệu */
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background-color: #f8f9fa; font-weight: 600; color: #555; }
        tr:hover { background-color: #f1f1f1; }
        
        /* Nút hành động trong bảng */
        .action-links a { text-decoration: none; font-size: 14px; margin-right: 10px; padding: 5px 10px; border-radius: 3px; }
        .btn-edit { background-color: #e2e6ea; color: #0056b3; }
        .btn-edit:hover { background-color: #dbe2ef; }
        .btn-delete { background-color: #f8d7da; color: #721c24; }
        .btn-delete:hover { background-color: #f5c6cb; }

    </style>
</head>
<body>

    <div class="navbar">
        <h2>🛍️ Shop Manager</h2>
        <div class="nav-links">
            <a href="home">Trang chủ</a> <a href="products" class="active">Sản phẩm</a> <a href="#">Cài đặt</a>
            <a href="#">Đăng xuất</a>
        </div>
    </div>

    <div class="container">
        
        <div class="content-grid">
            
            <div class="form-card">
                <h3>${productEdit != null ? "✏️ Cập Nhật" : "➕ Thêm Mới"}</h3>
                
                <form action="products" method="POST">
                    <input type="hidden" name="id" value="${productEdit.id}"/>

                    <div class="form-group">
                        <label>Tên Sản Phẩm:</label>
                        <input type="text" name="name" value="${productEdit.name}" placeholder="Nhập tên..." required/>
                    </div>
                    
                    <div class="form-group">
                        <label>Giá Tiền (VND):</label>
                        <input type="number" name="price" value="${productEdit.price}" placeholder="0" required/>
                    </div>
                    
                    <div class="form-group">
                        <label>Danh Mục:</label>
                        <select name="categoryId">
                            <c:forEach items="${categories}" var="c">
                                <option value="${c.id}" ${productEdit.category.id == c.id ? 'selected' : ''}>
                                    ${c.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <button type="submit" class="btn-submit">
                        ${productEdit != null ? "Lưu Thay Đổi" : "Thêm Ngay"}
                    </button>
                    
                    <c:if test="${productEdit != null}">
                        <a href="products" class="btn-cancel">Hủy bỏ & Quay lại thêm mới</a>
                    </c:if>
                </form>
            </div>

            <div class="list-section">
                
                <div class="search-bar">
                    <h3 style="margin: 0; color: #555;">Danh Sách Sản Phẩm</h3>
                    <form action="products" method="GET">
                        <input type="text" name="search" placeholder="Tìm tên sản phẩm..." value="${searchKeyword}"/>
                        <button type="submit" class="btn-search">Tìm</button>
                        <a href="products" style="margin-left: 5px; padding: 8px; color: #666; text-decoration: none;">Reset</a>
                    </form>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th style="width: 50px;">ID</th>
                            <th>Tên Sản Phẩm</th>
                            <th>Danh Mục</th>
                            <th>Giá (VND)</th>
                            <th style="width: 120px;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${data}" var="p">
                            <tr>
                                <td>#${p.id}</td>
                                <td style="font-weight: 500;">${p.name}</td>
                                <td>
                                    <span style="background: #e9ecef; padding: 3px 8px; border-radius: 10px; font-size: 12px;">
                                        ${p.category.name}
                                    </span>
                                </td>
                                <td><fmt:formatNumber value="${p.price}" pattern="#,###"/></td>
                                <td class="action-links">
                                    <a href="products?action=edit&id=${p.id}" class="btn-edit">Sửa</a>
                                    <a href="products?action=delete&id=${p.id}" class="btn-delete" onclick="return confirm('Bạn có chắc muốn xóa ${p.name}?');">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty data}">
                            <tr>
                                <td colspan="5" style="text-align: center; padding: 30px; color: #888;">
                                    Không tìm thấy sản phẩm nào.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

        </div> </div>

</body>
</html>