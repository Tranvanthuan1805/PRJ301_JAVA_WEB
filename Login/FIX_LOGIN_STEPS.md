# Các Bước Sửa Lỗi Login

## Vấn đề hiện tại
Form login hiển thị lỗi "Username phải 3-20 ký tự" ngay khi mở trang, chưa nhập gì.

## Giải pháp đã áp dụng
✅ Đã sửa `login.jsp` để không hiển thị lỗi khi chưa submit form

## Các bước thực hiện NGAY BÂY GIỜ:

### Bước 1: Stop Tomcat
1. Trong NetBeans, click tab **Services** (bên trái)
2. Mở rộng **Servers**
3. Click chuột phải vào **Apache Tomcat**
4. Chọn **Stop**

### Bước 2: Clean and Build
1. Click chuột phải vào project **Login**
2. Chọn **Clean and Build**
3. Đợi cho đến khi thấy "BUILD SUCCESSFUL"

### Bước 3: Run lại project
1. Click chuột phải vào project **Login**
2. Chọn **Run** (hoặc nhấn F6)
3. Đợi Tomcat khởi động

### Bước 4: Test login
1. Mở: `http://localhost:8080/Login/login.jsp`
2. Nhập:
   - Username: `an`
   - Password: `123456`
3. Click **Login**

## Nếu vẫn không được

### Kiểm tra Tomcat Console
Xem có dòng này không:
```
>>> Connected DB = AdminUser
LOGIN USER = an
>>> LOGIN MATCH OK for an
```

### Nếu thấy "LOGIN NOT MATCH"
Chạy lại SQL:
```bash
sqlcmd -S localhost -d AdminUser -E -i CREATE_SHORT_USERNAME.sql
```

### Nếu không thấy log gì cả
Servlet không được gọi → Kiểm tra URL:
- Đúng: `http://localhost:8080/Login/login.jsp`
- Sai: `http://localhost:8080/login.jsp`

## Test nhanh
Thử truy cập trực tiếp servlet:
```
http://localhost:8080/Login/login
```
Nếu redirect về login.jsp → Servlet hoạt động OK

## Tài khoản test
```
ADMIN:  admin1 / 123456
USER:   an / 123456
```
