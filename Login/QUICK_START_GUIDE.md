# Quick Start Guide - Customer Management Module

## Bước 1: Setup Database

### Chạy SQL Script
```sql
-- Mở SQL Server Management Studio
-- Kết nối đến database AdminUser
-- Chạy file: Login/CUSTOMER_MANAGEMENT_SETUP.sql
```

Script sẽ tạo:
- Bảng `Customers` (thông tin khách hàng)
- Bảng `CustomerActivities` (lịch sử hoạt động)
- Sample data (5 khách hàng mẫu với activities)

### Kiểm tra
```sql
SELECT * FROM Customers;
SELECT * FROM CustomerActivities;
```

## Bước 2: Cấu hình Database Connection

File: `Login/src/java/util/DBUtil.java`

Kiểm tra và cập nhật nếu cần:
```java
private static final String URL = 
    "jdbc:sqlserver://localhost:1433;databaseName=AdminUser;encrypt=true;trustServerCertificate=true;";
private static final String USER = "sa";
private static final String PASS = "123456"; // Thay bằng password của bạn
```

## Bước 3: Build Project

### Sử dụng NetBeans
1. Mở project `Login` trong NetBeans
2. Right-click project → Clean and Build
3. Kiểm tra không có lỗi compile

### Sử dụng Command Line
```bash
cd Login
ant clean dist
```

## Bước 4: Deploy

### NetBeans
1. Right-click project → Run
2. NetBeans tự động deploy lên Tomcat

### Manual Deploy
1. Copy file `Login/dist/Login.war`
2. Paste vào `Tomcat/webapps/`
3. Start Tomcat
4. Tomcat tự động extract WAR file

## Bước 5: Truy cập và Test

### 1. Login
URL: `http://localhost:8080/Login/login.jsp`

Tài khoản ADMIN (từ database hiện tại):
- Username: (kiểm tra trong bảng Users)
- Password: (password đã hash)

### 2. Admin Dashboard
Sau khi login thành công → redirect đến `admin.jsp`

Bạn sẽ thấy 3 cards:
- **Quản lý Khách hàng** ← Click vào đây
- Quản lý Users (disabled)
- Thống kê (disabled)

### 3. Customer Management
URL: `http://localhost:8080/Login/admin/customers`

**Test các chức năng:**

#### a) Xem danh sách
- Hiển thị 5 khách hàng mẫu
- Có pagination nếu > 10 khách hàng

#### b) Tìm kiếm
- Nhập "Nguyễn" vào ô tìm kiếm
- Click "Tìm kiếm"
- Kết quả: Hiển thị khách hàng có tên chứa "Nguyễn"

#### c) Lọc theo trạng thái
- Chọn "Active" trong dropdown
- Click "Tìm kiếm"
- Kết quả: Chỉ hiển thị khách hàng active

#### d) Xem chi tiết
- Click button "Xem" ở bất kỳ khách hàng nào
- Hiển thị trang chi tiết với:
  - Thông tin cơ bản (bên trái)
  - Form chỉnh sửa (bên phải)
  - Thống kê hoạt động
  - Timeline lịch sử

#### e) Chỉnh sửa thông tin
- Sửa tên, email, phone, địa chỉ
- Click "Lưu thay đổi"
- Thông báo: "Cập nhật thông tin thành công!"

#### f) Khóa tài khoản
- Click button "Khóa tài khoản"
- Confirm dialog
- Status chuyển sang "banned"
- Thông báo: "Cập nhật trạng thái thành công!"

#### g) Mở khóa tài khoản
- Với tài khoản đã bị khóa
- Click button "Mở khóa"
- Status chuyển sang "active"

## Bước 6: Kiểm tra Phân quyền

### Test với USER role
1. Logout khỏi ADMIN
2. Login với tài khoản USER
3. Thử truy cập: `http://localhost:8080/Login/admin/customers`
4. Kết quả: Redirect về `error.jsp` (không có quyền)

### Test với chưa login
1. Logout
2. Truy cập trực tiếp: `http://localhost:8080/Login/admin/customers`
3. Kết quả: Redirect về `login.jsp`

## Troubleshooting

### Lỗi: Cannot connect to database
**Nguyên nhân**: Database connection sai

**Giải pháp**:
1. Kiểm tra SQL Server đang chạy
2. Kiểm tra database name: `AdminUser`
3. Kiểm tra username/password trong `DBUtil.java`
4. Kiểm tra port: 1433 (default)

### Lỗi: ClassNotFoundException SQLServerDriver
**Nguyên nhân**: Thiếu JDBC driver

**Giải pháp**:
1. Download `mssql-jdbc-12.2.0.jre8.jar`
2. Copy vào `Login/web/WEB-INF/lib/`
3. Rebuild project

### Lỗi: 404 Not Found
**Nguyên nhân**: Servlet mapping sai hoặc chưa deploy

**Giải pháp**:
1. Kiểm tra `@WebServlet("/admin/customers")` trong servlet
2. Rebuild và redeploy
3. Restart Tomcat

### Lỗi: Tiếng Việt bị lỗi font
**Nguyên nhân**: UTF-8 encoding chưa đúng

**Giải pháp**:
1. Kiểm tra JSP có `<%@ page contentType="text/html;charset=UTF-8" %>`
2. Kiểm tra database dùng `NVARCHAR` cho tiếng Việt
3. Thêm `request.setCharacterEncoding("UTF-8")` trong servlet

### Lỗi: Access Denied (403)
**Nguyên nhân**: Không có quyền ADMIN

**Giải pháp**:
1. Kiểm tra role trong session: `user.roleName`
2. Đảm bảo login với tài khoản ADMIN
3. Kiểm tra `AuthFilter` đang hoạt động

## Cấu trúc URL

| URL | Mô tả | Quyền |
|-----|-------|-------|
| `/login.jsp` | Trang đăng nhập | Public |
| `/admin.jsp` | Admin dashboard | ADMIN only |
| `/admin/customers` | Danh sách khách hàng | ADMIN only |
| `/admin/customers?action=view&id=X` | Chi tiết khách hàng | ADMIN only |
| `/logout` | Đăng xuất | Authenticated |

## Sample Data

Database đã có 5 khách hàng mẫu:
1. Nguyễn Văn An - active
2. Trần Thị Bình - active
3. Lê Văn Cường - inactive
4. Phạm Thị Dung - active
5. Hoàng Văn Em - banned

Mỗi khách hàng có 3-5 activities mẫu (SEARCH, BOOKING, CANCEL, LOGIN)

## Next Steps

Sau khi module chạy thành công:
1. Thêm khách hàng thật vào database
2. Tích hợp với module đặt tour (nếu có)
3. Thêm tính năng export/import
4. Thêm thống kê chi tiết hơn
5. Thêm email notification

## Support

Nếu gặp vấn đề:
1. Kiểm tra console log (Tomcat/logs/catalina.out)
2. Kiểm tra browser console (F12)
3. Đọc lại README.md
4. Kiểm tra database connection

---

**Chúc bạn thành công!** 🚀
