# VietAir - Hệ thống Quản lý Tour Du lịch

## Giới thiệu
Web application quản lý và đặt tour du lịch Đà Nẵng với phân quyền Admin/User và phân tích dữ liệu.

## Công nghệ
- **Backend:** Java Servlet, JSP
- **Database:** SQL Server (504 tours)
- **Frontend:** HTML5, CSS3, JavaScript, Chart.js
- **Server:** Apache Tomcat 10.1

## Tính năng

### User
- Xem danh sách tours (12 tours/trang)
- Tìm kiếm, lọc tours
- Đặt tour với form đầy đủ (tên, email, SĐT, địa chỉ, số người)

### Admin
- CRUD tours (Thêm, Sửa, Xóa)
- Quản lý đơn hàng:
  - Xem tất cả đơn hàng
  - Tìm kiếm theo mã đơn hoặc tên khách hàng
  - Cập nhật trạng thái đơn hàng (Chờ xử lý, Đã xác nhận, Hoàn thành, Đã hủy)
- Xem analytics:
  - Biểu đồ lượt khách theo tháng
  - Biểu đồ giá trung bình
  - Top 5 tháng cao điểm
  - Bảng dữ liệu chi tiết

## Cài đặt

### 1. Setup Database
```sql
-- Chạy file trong SQL Server Management Studio
SETUP_DATABASE.sql           -- Tạo database, tables, users, customers
ADD_450_TOURS_HISTORY.sql    -- 450 tours lịch sử (2020-2025) - Optional
ADD_NEW_TOURS_2026.sql       -- 72 tours mới (2026) - Required
```

### 2. Cấu hình Database Connection
File: `Login/src/java/util/DatabaseConnection.java`
```java
URL = "jdbc:sqlserver://localhost:1433;databaseName=TourManagement;..."
USERNAME = "sa"
PASSWORD = "123456"  // Đổi password của bạn
```

### 3. Build & Deploy
1. Mở NetBeans
2. Clean and Build (Shift+F11)
3. Run (F6)

### 4. Truy cập
```
http://localhost:8080/Login/
```

## Tài khoản mặc định
- **Admin:** admin / admin
- **User:** user / user

## Cấu trúc Database
- **Users** - Tài khoản (admin/user)
- **Tours** - Thông tin tours (NVARCHAR cho tiếng Việt)
- **Customers** - Khách hàng
- **Bookings** - Đơn đặt tour
- **InteractionHistory** - Lịch sử hành động

## Dữ liệu
- 20 customers mẫu
- 2 users (admin/user)
- 72 tours năm 2026 (từ ADD_NEW_TOURS_2026.sql)
- 450 tours lịch sử 2020-2025 (từ ADD_450_TOURS_HISTORY.sql - optional)

## Tính năng nổi bật
✅ Hỗ trợ Unicode (tiếng Việt)  
✅ Phân trang tours  
✅ Phân quyền Admin/User  
✅ Analytics với Chart.js  
✅ Booking với form đầy đủ  
✅ Responsive design

## Files quan trọng
- `SETUP_DATABASE.sql` - Tạo database và tables
- `ADD_450_TOURS_HISTORY.sql` - Import tours lịch sử
- `ADD_NEW_TOURS_2026.sql` - Import tours mới
- `CLEAR_TOMCAT_CACHE.bat` - Clear cache khi cần

## Lưu ý
- Database phải dùng NVARCHAR cho tiếng Việt
- TourDAO dùng `getNString()` để đọc Unicode
- Tours page chỉ hiển thị tours tương lai (2026+)
- History page hiển thị tất cả tours (analytics)
- **Sau khi xóa tours ở Admin**: User cần hard refresh (Ctrl+Shift+R) để xóa cache trình duyệt
- **Sau khi sửa Java code**: Phải restart Tomcat trong NetBeans

## Xử lý vấn đề đồng bộ Admin-User
Khi admin xóa tours nhưng user vẫn thấy:
1. **Nguyên nhân**: Browser cache
2. **Giải pháp**:
   - User: Nhấn `Ctrl + Shift + R` (hard refresh)
   - Hoặc: Xóa cache trình duyệt
   - Hoặc: Mở Incognito/Private mode
3. **Kiểm tra database**: Chạy `CHECK_ALL_TOURS_2026.sql` để xác nhận tours đã xóa
