# VietAir - Hệ thống quản lý tour du lịch

## 🔑 TÀI KHOẢN TEST

### Admin
- **Username**: `admin`
- **Password**: `123456`
- **Quyền**: Quản lý khách hàng, xem danh sách, thống kê

### User (10 tài khoản khách hàng)
Tất cả đều có password: `123456`

| Username | Họ tên | Trạng thái |
|----------|--------|------------|
| `nvan` | Nguyễn Văn An | active |
| `tbinh` | Trần Thị Bình | active |
| `lcuong` | Lê Văn Cường | inactive |
| `pdung` | Phạm Thị Dung | active |
| `hvem` | Hoàng Văn Em | banned |
| `vtphuong` | Vũ Thị Phương | active |
| `dvgiang` | Đặng Văn Giang | active |
| `bthoa` | Bùi Thị Hoa | inactive |
| `nvinh` | Ngô Văn Inh | active |
| `ttkim` | Trương Thị Kim | active |

---

## 📋 Mô tả dự án
Hệ thống quản lý tour du lịch Đà Nẵng với các chức năng:
- Đăng nhập/Đăng ký cho Admin và User
- Quản lý khách hàng (Admin)
- Xem và chỉnh sửa thông tin cá nhân (User)
- Lịch sử hoạt động của khách hàng
- Giao diện responsive và đẹp mắt

## 🛠️ Công nghệ sử dụng
- **Backend**: Java Servlet, JSP
- **Database**: SQL Server (AdminUser)
- **Frontend**: HTML, CSS, JavaScript, Bootstrap
- **Server**: Apache Tomcat
- **Build Tool**: Apache Ant

## 📁 Cấu trúc thư mục
```
Login/
├── src/java/
│   ├── controller/     # Servlets (Login, Register, Profile, AdminCustomer, Logout)
│   ├── dao/           # Data Access Objects (CustomerDAO, CustomerActivityDAO, UserDAO)
│   ├── model/         # Models (User, Customer, CustomerActivity)
│   ├── filter/        # Filters (AuthFilter, EncodingFilter)
│   └── util/          # Utilities (DBUtil, PasswordUtil, ValidateUtil)
├── web/
│   ├── admin/         # Admin pages (customers.jsp, customer-detail.jsp, tours.jsp)
│   ├── css/           # Stylesheets
│   ├── js/            # JavaScript files
│   ├── include/       # Shared components (header, footer, css-inline)
│   ├── jsp/           # Tour pages
│   ├── WEB-INF/       # Configuration (web.xml)
│   ├── index.jsp      # Trang chủ
│   ├── login.jsp      # Trang đăng nhập
│   ├── register.jsp   # Trang đăng ký
│   ├── profile.jsp    # Trang thông tin cá nhân
│   └── fix-vietnamese.jsp  # Tool fix encoding tiếng Việt
├── build.xml          # Ant build file
├── CLEAR_TOMCAT_CACHE.bat  # Script clear cache Tomcat
├── RESET_ADMIN_USER.sql    # Script reset admin password
└── README.md          # File này
```

## 🗄️ Database Schema

### Bảng Users
```sql
- UserId (INT, PK, IDENTITY)
- Username (NVARCHAR)
- PasswordHash (NVARCHAR) - SHA-256
- RoleId (INT, FK -> Roles)
- IsActive (BIT)
- CreatedAt (DATETIME)
```

### Bảng Customers
```sql
- id (INT, PK, IDENTITY)
- full_name (NVARCHAR)
- email (VARCHAR)
- phone (VARCHAR)
- address (NVARCHAR)
- date_of_birth (DATE)
- status (VARCHAR) - active/inactive/banned
- user_id (INT, FK -> Users)
- created_at (DATETIME)
- updated_at (DATETIME)
```

### Bảng CustomerActivity
```sql
- Id (INT, PK, IDENTITY)
- CustomerId (INT, FK -> Customers)
- ActionType (NVARCHAR)
- ActionDetails (NVARCHAR)
- CreatedAt (DATETIME)
```

## 🚀 Hướng dẫn cài đặt

### 1. Yêu cầu hệ thống
- JDK 8 trở lên
- Apache Tomcat 9.x hoặc 10.x
- SQL Server 2019 trở lên
- Apache Ant (để build project)

### 2. Cấu hình Database
1. Tạo database `AdminUser` trong SQL Server
2. Chạy script `RESET_ADMIN_USER.sql` để tạo cấu trúc bảng và dữ liệu mẫu
3. Kiểm tra connection string trong `src/java/util/DBUtil.java`:
```java
jdbc:sqlserver://localhost:1433;
databaseName=AdminUser;
encrypt=true;
trustServerCertificate=true;
sendStringParametersAsUnicode=true;
characterEncoding=UTF-8;
```

### 3. Build và Deploy
```bash
# Build project
ant clean
ant compile
ant dist

# Deploy
# Copy file Login.war từ thư mục dist/ vào thư mục webapps của Tomcat
# Hoặc deploy trực tiếp từ NetBeans
```

### 4. Chạy ứng dụng
1. Start Tomcat server
2. Truy cập: `http://localhost:8080/Login/`

## 👤 Tài khoản mặc định

Xem phần **TÀI KHOẢN TEST** ở đầu file để biết chi tiết tài khoản đăng nhập.

## 🔧 Troubleshooting

### Lỗi tiếng Việt bị hiển thị sai
1. Truy cập: `http://localhost:8080/Login/fix-vietnamese.jsp`
2. Trang sẽ tự động fix encoding cho database
3. Refresh lại trang profile

### Lỗi không kết nối được database
1. Kiểm tra SQL Server đang chạy
2. Kiểm tra username/password trong `DBUtil.java`
3. Kiểm tra database `AdminUser` đã tồn tại

### Clear cache Tomcat
Chạy file `CLEAR_TOMCAT_CACHE.bat` để xóa cache

## 📝 Chức năng chính

### Admin
- ✅ Đăng nhập với tài khoản admin
- ✅ Xem danh sách khách hàng
- ✅ Tìm kiếm và lọc khách hàng theo trạng thái
- ✅ Xem chi tiết thông tin khách hàng
- ✅ Quản lý trạng thái khách hàng (active/inactive/banned)

### User
- ✅ Đăng ký tài khoản mới
- ✅ Đăng nhập
- ✅ Xem thông tin cá nhân
- ✅ Chỉnh sửa thông tin cá nhân
- ✅ Xem lịch sử hoạt động
- ✅ Xem thống kê hoạt động

### Chung
- ✅ Header responsive với logo VietAir
- ✅ Hiển thị username khi đăng nhập
- ✅ Đăng xuất
- ✅ Encoding UTF-8 cho tiếng Việt

## 🎨 Giao diện
- Gradient màu xanh chủ đạo (#2c5aa0, #1e4070)
- Logo VietAir với icon máy bay
- Card design hiện đại
- Responsive layout
- Font Inter

## 📄 License
Educational project - PRJ301

## 👨‍💻 Author
Developed for PRJ301 course

---
**Note**: Đây là project học tập, không sử dụng cho mục đích thương mại.
