# VietAir - Hệ thống Quản lý Tour Du lịch

## Giới thiệu
Web application quản lý và đặt tour du lịch với đầy đủ tính năng giỏ hàng, thanh toán, và quản lý đơn hàng. Hỗ trợ phân quyền Admin/User và phân tích dữ liệu lịch sử.

## Công nghệ
- **Backend:** Java Servlet, JSP, JDBC
- **Database:** SQL Server
- **Frontend:** HTML5, CSS3, JavaScript, Chart.js
- **Server:** Apache Tomcat 10.1
- **Architecture:** MVC Pattern (Model-View-Controller)

## Tính năng chính

### 🛒 User (Khách hàng)
- **Xem tours:**
  - Danh sách tours với phân trang
  - Tìm kiếm theo điểm đến
  - Lọc theo tháng, khoảng giá
  - Sắp xếp theo giá, ngày
  - Xem chi tiết tour với đầy đủ thông tin

- **Giỏ hàng:**
  - Thêm tour vào giỏ hàng
  - Cập nhật số lượng
  - Xóa tour khỏi giỏ
  - Tự động validate chỗ trống
  - Lưu giỏ hàng: 30 phút (chưa đăng nhập) hoặc vĩnh viễn (đã đăng nhập)

- **Đặt tour:**
  - Đặt ngay (Buy Now) - Chuyển thẳng đến thanh toán
  - Đặt qua giỏ hàng - Thêm nhiều tour cùng lúc
  - Form đầy đủ: Tên, Email, SĐT, Địa chỉ, Ghi chú
  - Chọn phương thức thanh toán

- **Quản lý đơn hàng:**
  - Xem danh sách đơn hàng của mình
  - Xem chi tiết từng đơn
  - Hủy đơn hàng (nếu chưa xác nhận)
  - Theo dõi trạng thái đơn

### 👨‍💼 Admin (Quản trị viên)
- **Quản lý tours:**
  - Thêm tour mới
  - Sửa thông tin tour
  - Xóa tour (tự động xóa các bản ghi liên quan)
  - Tìm kiếm, lọc, sắp xếp
  - Chỉ hiển thị tours sắp tới

- **Quản lý đơn hàng:**
  - Xem tất cả đơn hàng
  - Tìm kiếm theo mã đơn, tên khách hàng
  - Lọc theo trạng thái, phương thức thanh toán
  - Sửa thông tin đơn hàng (trừ mã vé)
  - Cập nhật trạng thái: Chờ xử lý → Đã xác nhận → Hoàn thành
  - Cập nhật trạng thái thanh toán
  - Xóa đơn hàng (cascade delete)

- **Phân tích dữ liệu:**
  - Biểu đồ lượt khách theo tháng
  - Biểu đồ giá trung bình theo tháng
  - Phân loại mùa cao điểm/thấp điểm
  - Bảng dữ liệu chi tiết
  - Thống kê tổng quan

## Cài đặt

### 1. Yêu cầu hệ thống
- JDK 11+
- Apache Tomcat 10.1+
- SQL Server 2019+
- NetBeans IDE (khuyến nghị)

### 2. Setup Database
Chạy các file SQL theo thứ tự trong SQL Server Management Studio:

```sql
-- Bước 1: Tạo database và tables
SETUP_DATABASE.sql

-- Bước 2: Import tours lịch sử (Optional - cho analytics)
ADD_450_TOURS_HISTORY.sql

-- Bước 3: Import tours mới (Required)
ADD_NEW_TOURS_2026.sql
```

### 3. Cấu hình Database Connection
File: `Login/src/java/util/DatabaseConnection.java`

```java
private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=TourManagement;encrypt=true;trustServerCertificate=true";
private static final String USERNAME = "sa";
private static final String PASSWORD = "123456";  // Thay đổi password của bạn
```

### 4. Build & Deploy
1. Mở project trong NetBeans
2. Clean and Build (Shift+F11)
3. Run (F6)
4. Tomcat sẽ tự động khởi động

### 5. Truy cập ứng dụng
```
http://localhost:8080/Login/
```

## Tài khoản mặc định

| Username | Password | Role  |
|----------|----------|-------|
| admin    | admin    | ADMIN |
| user     | user     | USER  |

## Cấu trúc Database

### Tables chính:
- **Users** - Tài khoản đăng nhập (admin/user)
- **Tours** - Thông tin tours (NVARCHAR cho tiếng Việt)
- **Cart** - Giỏ hàng của user đã đăng nhập
- **Orders** - Đơn hàng
- **OrderItems** - Chi tiết đơn hàng (tours trong đơn)
- **Payments** - Thông tin thanh toán

### Dữ liệu mẫu:
- 2 users (admin/user)
- 72 tours năm 2026
- 450 tours lịch sử 2020-2025 (optional)

## Kiến trúc hệ thống

### MVC Pattern
```
├── Model (model/)
│   ├── User.java
│   ├── Tour.java
│   ├── CartItem.java
│   ├── Order.java
│   ├── OrderItem.java
│   └── Payment.java
│
├── View (web/)
│   ├── jsp/ (User pages)
│   │   ├── tour-list.jsp
│   │   ├── tour-view.jsp
│   │   ├── cart.jsp
│   │   ├── checkout.jsp
│   │   └── orders.jsp
│   └── admin/ (Admin pages)
│       ├── tours.jsp
│       ├── orders.jsp
│       ├── order-edit.jsp
│       └── history.jsp
│
└── Controller (controller/)
    ├── LoginServlet.java
    ├── RegisterServlet.java
    ├── TourServlet.java
    ├── CartServlet.java
    ├── CheckoutServlet.java
    ├── OrderServlet.java
    ├── AdminTourServlet.java
    └── AdminOrderServlet.java
```

### Service Layer
```
service/
├── CartService.java       - Quản lý giỏ hàng (session + database)
├── OrderService.java      - Xử lý đơn hàng và thanh toán
└── TourService.java       - Business logic cho tours
```

### DAO Layer
```
dao/
├── UserDAO.java
├── TourDAO.java
├── CartDAO.java
├── OrderDAO.java
└── PaymentDAO.java
```

## Tính năng nổi bật

✅ **Giỏ hàng thông minh:**
- Session-based cho guest user
- Database-based cho logged-in user
- Auto-migrate khi đăng nhập
- Validate real-time chỗ trống

✅ **Đặt tour linh hoạt:**
- Buy Now: Đặt ngay 1 tour
- Cart: Thêm nhiều tour, checkout cùng lúc

✅ **Quản lý đơn hàng đầy đủ:**
- User: Xem, hủy đơn
- Admin: CRUD đầy đủ, cập nhật trạng thái

✅ **Phân quyền chặt chẽ:**
- AuthFilter kiểm tra quyền truy cập
- Admin/User có giao diện riêng

✅ **Hỗ trợ Unicode:**
- NVARCHAR trong database
- setNString/getNString trong JDBC

✅ **Responsive design:**
- Tương thích mobile/tablet/desktop

✅ **Analytics:**
- Chart.js visualization
- Phân tích theo tháng, mùa

## Luồng hoạt động

### User đặt tour:
1. Xem danh sách tours → Chọn tour
2. **Option 1 - Đặt ngay:**
   - Nhấn "Đặt tour ngay"
   - Điền thông tin → Thanh toán → Hoàn tất
3. **Option 2 - Qua giỏ hàng:**
   - Thêm vào giỏ hàng
   - Tiếp tục mua sắm hoặc checkout
   - Điền thông tin → Thanh toán → Hoàn tất

### Admin quản lý:
1. Đăng nhập admin
2. Quản lý tours: Thêm/Sửa/Xóa
3. Quản lý đơn hàng: Xem/Sửa/Xóa/Cập nhật trạng thái
4. Xem analytics: Biểu đồ, thống kê

## Session & Cache

### Session timeout:
- **Thời gian:** 30 phút (cấu hình trong web.xml)
- **Giỏ hàng guest:** Mất sau 30 phút không hoạt động
- **Giỏ hàng user:** Lưu vĩnh viễn trong database

### Browser cache:
- Khi admin xóa/sửa tour, user cần refresh (Ctrl+Shift+R)
- Hoặc mở Incognito mode để thấy thay đổi ngay

## Xử lý lỗi thường gặp

### 1. Lỗi kết nối database
```
Kiểm tra:
- SQL Server đang chạy
- Database TourManagement đã tạo
- Username/password đúng
- Port 1433 không bị block
```

### 2. Tours không hiển thị
```
Kiểm tra:
- Đã chạy ADD_NEW_TOURS_2026.sql chưa
- Tours có startDate >= hôm nay
- Browser cache (Ctrl+Shift+R)
```

### 3. Giỏ hàng mất
```
Nguyên nhân:
- Session timeout (30 phút)
- Đóng browser (nếu chưa đăng nhập)

Giải pháp:
- Đăng nhập để lưu giỏ hàng vĩnh viễn
```

### 4. Sau khi sửa Java code
```
Bắt buộc:
- Clean and Build (Shift+F11)
- Restart Tomcat trong NetBeans
```

## Files quan trọng

### Database:
- `SETUP_DATABASE.sql` - Tạo database, tables, users
- `ADD_450_TOURS_HISTORY.sql` - 450 tours lịch sử (optional)
- `ADD_NEW_TOURS_2026.sql` - 72 tours mới (required)

### Configuration:
- `web.xml` - Servlet mapping, session config
- `DatabaseConnection.java` - Database connection

### Utilities:
- `CLEAR_TOMCAT_CACHE.bat` - Clear Tomcat cache

## Lưu ý quan trọng

⚠️ **Database:**
- Phải dùng NVARCHAR cho tiếng Việt
- Dùng setNString/getNString trong JDBC
- Cascade delete: Xóa tour → xóa cart items

⚠️ **Session:**
- Timeout: 30 phút
- Giỏ hàng guest: Lưu trong session
- Giỏ hàng user: Lưu trong database

⚠️ **Cache:**
- Admin thay đổi → User cần hard refresh
- Hoặc dùng Incognito mode

⚠️ **Deployment:**
- Sửa Java code → Phải restart Tomcat
- Sửa JSP → Chỉ cần refresh browser

## Tác giả
VietAir Tour Management System

## License
Educational Project - For Learning Purposes
