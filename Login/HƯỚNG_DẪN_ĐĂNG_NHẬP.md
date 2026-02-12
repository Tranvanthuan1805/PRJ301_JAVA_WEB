# Hướng Dẫn Đăng Nhập - Login System

## 📋 Tài Khoản Đã Tạo

### ADMIN (Quản trị viên)
```
Username: admin1
Password: 123456
Quyền truy cập: Quản lý khách hàng (/admin/customers)
```

### USER (Người dùng)
Tất cả mật khẩu đều là: `123456`

| Username | Tên Khách Hàng | Số Điện Thoại | Trạng Thái |
|----------|----------------|---------------|------------|
| an | Nguyễn Văn An | 0901234567 | active |
| binh | Trần Thị Bình | 0912345678 | active |
| cuong | Lê Hoàng Cường | 0923456789 | active |
| dung | Phạm Thị Dung | 0934567890 | active |
| em | Hoàng Văn Em | 0945678901 | inactive |
| phuong | Võ Thị Phương | 0956789012 | active |
| giang | Đặng Văn Giang | 0967890123 | active |
| hoa | Bùi Thị Hoa | 0978901234 | active |
| inh | Ngô Văn Inh | 0989012345 | active |
| kim | Dương Thị Kim | 0990123456 | active |

## 🚀 Cách Đăng Nhập

### Bước 1: Mở trang đăng nhập
```
http://localhost:8080/Login/login.jsp
```

### Bước 2: Nhập thông tin
- **Username**: Nhập một trong các username trên (ví dụ: `an`)
- **Password**: Nhập `123456`

### Bước 3: Nhấn nút "Login"

### Bước 4: Kiểm tra kết quả
- **ADMIN**: Sẽ chuyển đến `/admin/customers` (Danh sách khách hàng)
- **USER**: Sẽ chuyển đến `/user.jsp` (Trang người dùng)

## 🔧 Nếu Không Đăng Nhập Được

### Giải pháp 1: Clean and Build
1. Trong NetBeans, click chuột phải vào project "Login"
2. Chọn "Clean and Build"
3. Chờ build xong
4. Nhấn F6 để Run lại project
5. Thử đăng nhập lại

### Giải pháp 2: Xóa Cache Tomcat
1. Chạy file `CLEAR_TOMCAT_CACHE.bat`
2. Làm theo hướng dẫn trong file
3. Thử đăng nhập lại

### Giải pháp 3: Kiểm tra Database
Chạy file SQL để verify:
```bash
sqlcmd -S localhost -d AdminUser -E -i VERIFY_LOGIN_ACCOUNTS.sql
```

### Giải pháp 4: Tạo lại tài khoản
Chạy file SQL để tạo lại:
```bash
sqlcmd -S localhost -d AdminUser -E -i CREATE_SHORT_USERNAME.sql
```

## 📝 Lưu Ý Quan Trọng

### ✅ Đúng
- Username: `an` (ngắn gọn, chữ thường)
- Password: `123456` (đúng 6 ký tự)

### ❌ Sai
- Username: `nguyen.van.an@email.com` (quá dài, validation sẽ báo lỗi)
- Username: `An` (phân biệt hoa thường)
- Password: `123456 ` (có khoảng trắng)

## 🎯 Chức Năng Sau Khi Đăng Nhập

### ADMIN có thể:
- Xem danh sách tất cả khách hàng
- Tìm kiếm khách hàng theo tên, email, số điện thoại
- Lọc khách hàng theo trạng thái (active/inactive)
- Xem chi tiết thông tin khách hàng
- Chỉnh sửa thông tin khách hàng
- Khóa/Mở khóa tài khoản khách hàng
- Xem lịch sử hoạt động của khách hàng

### USER có thể:
- Xem trang chủ
- Xem danh sách tours
- Xem profile cá nhân (/profile)
- Chỉnh sửa thông tin cá nhân
- Xem lịch sử hoạt động của mình

## 🔍 Debug

### Kiểm tra Tomcat Console
Khi đăng nhập, console sẽ hiển thị:
```
>>> Connected DB = AdminUser
>>> JDBC URL = jdbc:sqlserver://localhost:1433;...
LOGIN USER = an
HASH = 8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92
>>> LOGIN MATCH OK for an
```

Nếu thấy `>>> LOGIN NOT MATCH!` → Kiểm tra lại database

### Kiểm tra Browser Console
Mở DevTools (F12) → Network tab
- Xem request POST đến `/Login/login`
- Kiểm tra status code (302 = redirect thành công)

## 📚 Tài Liệu Liên Quan

- `LOGIN_TROUBLESHOOTING.md` - Hướng dẫn khắc phục lỗi chi tiết
- `VERIFY_LOGIN_ACCOUNTS.sql` - Script kiểm tra tài khoản
- `CREATE_SHORT_USERNAME.sql` - Script tạo tài khoản
- `CLEAR_TOMCAT_CACHE.bat` - Script xóa cache Tomcat

## ✨ Tính Năng Đặc Biệt

### Encoding UTF-8
- Hỗ trợ tiếng Việt đầy đủ (có dấu)
- Tên khách hàng hiển thị đúng: "Nguyễn Văn An" (không bị lỗi font)

### Security
- Password được hash bằng SHA-256
- Session-based authentication
- Role-based access control (RBAC)
- AuthFilter bảo vệ các route /admin/*

### User Experience
- Validation form rõ ràng
- Error messages bằng tiếng Việt
- Redirect tự động theo role
- UI đẹp với Bootstrap 5 và gradient

## 🎉 Kết Luận

Hệ thống đăng nhập đã được setup hoàn chỉnh với:
- ✅ 1 tài khoản ADMIN
- ✅ 10 tài khoản USER
- ✅ Liên kết với 10 khách hàng
- ✅ Hỗ trợ tiếng Việt
- ✅ Bảo mật với SHA-256
- ✅ RBAC (Role-Based Access Control)

Chỉ cần Clean and Build, sau đó đăng nhập với `an` / `123456` là được!
