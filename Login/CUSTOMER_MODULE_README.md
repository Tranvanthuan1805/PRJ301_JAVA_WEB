# Customer Management Module - VietAir Style

## Tổng quan
Module Quản lý Khách hàng được xây dựng cho hệ thống Login với giao diện VietAir (giống TravelBooking project).

## Công nghệ
- **Backend**: Java Servlet + JSP + JDBC thuần (NO Spring, NO Hibernate)
- **Database**: SQL Server (AdminUser database)
- **UI**: VietAir style với blue gradient header, navigation menu
- **Icons**: Font Awesome 6.0

## Cấu trúc dự án

### 1. Database Schema
File: `Login/CUSTOMER_MANAGEMENT_SETUP.sql`

Bảng:
- `Customers`: Lưu thông tin khách hàng
- `CustomerActivities`: Lưu lịch sử hoạt động

### 2. Model Classes
- `Login/src/java/model/Customer.java` - Model khách hàng
- `Login/src/java/model/CustomerActivity.java` - Model hoạt động

### 3. DAO Classes (JDBC)
- `Login/src/java/dao/CustomerDAO.java` - CRUD operations cho Customer
  - getAllCustomers() - Lấy danh sách với pagination
  - searchCustomers() - Tìm kiếm theo tên/email/phone
  - filterByStatus() - Lọc theo trạng thái
  - getCustomerById() - Lấy chi tiết khách hàng
  - updateCustomer() - Cập nhật thông tin
  - updateCustomerStatus() - Khóa/mở khóa tài khoản
  
- `Login/src/java/dao/CustomerActivityDAO.java` - Operations cho Activity
  - getActivitiesByCustomerId() - Lấy lịch sử hoạt động
  - filterByActionType() - Lọc theo loại hoạt động
  - addActivity() - Thêm hoạt động mới

### 4. Servlet
- `Login/src/java/servlet/AdminCustomerServlet.java`
  - Mapped to: `/admin/customers`
  - Actions: list, view, update, updateStatus
  - Phân quyền: Chỉ ADMIN được truy cập

### 5. Filter
- `Login/src/java/filter/AuthFilter.java` (đã cập nhật)
  - Bảo vệ `/admin/*` routes
  - Chỉ cho phép ADMIN truy cập

### 6. JSP Pages
- `Login/web/admin/customers.jsp` - Danh sách khách hàng
  - Search theo tên/email/phone
  - Filter theo status (active/inactive/banned)
  - Pagination (10 items/page)
  - VietAir UI style
  
- `Login/web/admin/customer-detail.jsp` - Chi tiết khách hàng
  - Hiển thị thông tin đầy đủ
  - Form chỉnh sửa thông tin
  - Khóa/mở khóa tài khoản
  - Thống kê hoạt động
  - Timeline lịch sử hoạt động

### 7. Admin Dashboard
- `Login/web/admin.jsp` (đã cập nhật)
  - Thêm card "Quản lý Khách hàng"
  - Link đến `/admin/customers`

## Chức năng

### 1. Danh sách Khách hàng (`/admin/customers`)
- Hiển thị table với các cột: ID, Tên, Email, SĐT, Trạng thái, Ngày tạo
- Tìm kiếm theo tên, email, số điện thoại
- Lọc theo trạng thái (active/inactive/banned)
- Pagination (10 khách hàng/trang)
- Button "Xem" để xem chi tiết

### 2. Chi tiết Khách hàng (`/admin/customers?action=view&id=X`)
- **Thông tin cơ bản**: ID, Họ tên, Email, SĐT, Địa chỉ, Ngày sinh, Trạng thái
- **Form chỉnh sửa**: Cập nhật thông tin khách hàng
- **Khóa/Mở khóa**: Button để thay đổi trạng thái tài khoản
- **Thống kê**: Tổng hoạt động, Số lần đặt tour, Số lần tìm kiếm
- **Timeline**: Lịch sử hoạt động theo thời gian

### 3. Phân quyền (RBAC)
- **ADMIN**: 
  - Truy cập `/admin/customers`
  - Xem danh sách & chi tiết
  - Chỉnh sửa thông tin
  - Khóa/mở khóa tài khoản
  
- **USER/CUSTOMER**: 
  - KHÔNG được truy cập `/admin/*`
  - Redirect về error.jsp nếu cố truy cập

## Giao diện UI

### VietAir Style
- **Header**: Blue gradient (#2c5aa0 to #1e4070)
- **Logo**: Plane icon + "VietAir" text
- **Navigation**: Horizontal menu với hover effects
- **Cards**: White background, rounded corners, subtle shadows
- **Buttons**: Gradient backgrounds, smooth transitions
- **Table**: Blue gradient header, hover effects on rows
- **Status badges**: Color-coded (green/yellow/red)
- **Timeline**: Left border with dots, card-style items

### Màu sắc chính
- Primary: #2c5aa0 (blue)
- Primary Dark: #1e4070
- Accent: #00d4aa (teal)
- Success: #28a745 (green)
- Warning: #ffc107 (yellow)
- Danger: #dc3545 (red)
- Background: #f7fafc (light gray)

## Cài đặt và Chạy

### 1. Setup Database
```sql
-- Chạy file Login/CUSTOMER_MANAGEMENT_SETUP.sql
-- Tạo bảng Customers và CustomerActivities
```

### 2. Cấu hình Database Connection
File: `Login/src/java/util/DBUtil.java`
```java
private static final String URL = 
    "jdbc:sqlserver://localhost:1433;databaseName=AdminUser;...";
private static final String USER = "sa";
private static final String PASS = "123456";
```

### 3. Build và Deploy
```bash
# Sử dụng NetBeans hoặc Ant
ant -f Login clean dist
# Deploy file Login/dist/Login.war lên Tomcat
```

### 4. Truy cập
- Login: `http://localhost:8080/Login/login.jsp`
- Admin Dashboard: `http://localhost:8080/Login/admin.jsp`
- Customer Management: `http://localhost:8080/Login/admin/customers`

## Flow sử dụng

1. **Đăng nhập** với tài khoản ADMIN
2. Vào **admin.jsp** (Dashboard)
3. Click card **"Quản lý Khách hàng"**
4. Xem danh sách, tìm kiếm, lọc khách hàng
5. Click **"Xem"** để xem chi tiết
6. Chỉnh sửa thông tin hoặc khóa/mở khóa tài khoản

## UTF-8 Encoding

### Database
- Sử dụng `NVARCHAR` cho các trường tiếng Việt
- Collation: `Vietnamese_CI_AS`

### JDBC
- `ResultSet.getNString()` để đọc NVARCHAR
- `PreparedStatement.setString()` tự động xử lý

### JSP
- `<%@ page contentType="text/html;charset=UTF-8" %>`
- `request.setCharacterEncoding("UTF-8")` trong servlet

## Testing

### Test Cases
1. **List customers**: Truy cập `/admin/customers` - hiển thị danh sách
2. **Search**: Nhập keyword - tìm thấy khách hàng phù hợp
3. **Filter**: Chọn status - lọc theo trạng thái
4. **Pagination**: Click số trang - chuyển trang đúng
5. **View detail**: Click "Xem" - hiển thị chi tiết
6. **Update info**: Sửa thông tin - lưu thành công
7. **Lock account**: Click "Khóa" - status chuyển sang banned
8. **Unlock account**: Click "Mở khóa" - status chuyển sang active
9. **Authorization**: Login USER - không truy cập được `/admin/customers`

## Mở rộng

### Tính năng có thể thêm
1. Export danh sách khách hàng ra Excel/CSV
2. Import khách hàng từ file
3. Gửi email thông báo khi khóa tài khoản
4. Thống kê chi tiết hơn (biểu đồ, báo cáo)
5. Lọc theo khoảng thời gian
6. Sắp xếp theo các cột khác nhau
7. Bulk actions (khóa nhiều tài khoản cùng lúc)

## Lưu ý
- Module này KHÔNG sử dụng Spring hay Hibernate
- Sử dụng JDBC thuần để kết nối database
- Giao diện theo đúng VietAir style của TravelBooking
- Phân quyền RBAC: chỉ ADMIN được truy cập
- UTF-8 encoding cho tiếng Việt

## Tác giả
Senior Java Web Developer
Date: 2026-02-12
