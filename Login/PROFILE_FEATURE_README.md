# Profile Feature - User & Admin Access

## Tổng quan
Đã thêm tính năng Profile cho phép:
- **USER**: Xem và chỉnh sửa thông tin cá nhân của mình
- **ADMIN**: Xem toàn bộ thông tin khách hàng qua trang `/admin/customers`

## Files đã tạo/cập nhật

### 1. Backend Files

#### ProfileServlet.java
- **Path**: `Login/src/java/servlet/ProfileServlet.java`
- **Mapping**: `/profile`
- **Chức năng**:
  - GET: Hiển thị thông tin profile của user đang đăng nhập
  - POST: Cập nhật thông tin cá nhân
  - Tự động log activity khi update profile

#### CustomerDAO.java (Updated)
- **Method mới**: `getCustomerByEmail(String email)`
- **Chức năng**: Lấy thông tin customer dựa trên email

### 2. Frontend Files

#### profile.jsp
- **Path**: `Login/web/profile.jsp`
- **Chức năng**:
  - Hiển thị thông tin cá nhân chi tiết
  - Form chỉnh sửa thông tin (họ tên, SĐT, địa chỉ, ngày sinh)
  - Thống kê hoạt động (tổng hoạt động, đặt tour, tìm kiếm)
  - Timeline lịch sử hoạt động (20 hoạt động gần nhất)
- **Design**: Giống customer-detail.jsp nhưng chỉ cho phép user xem/sửa thông tin của mình

#### index.jsp (Updated)
- **Navigation**:
  - ADMIN: Trang chủ | Tours | Khách hàng | Lịch sử
  - USER: Trang chủ | Tours | Profile
  - Guest: Trang chủ | Tours | Khách hàng (redirect to login)
- **User Badge**: Hiển thị "ADMIN" hoặc "USER"

### 3. Database Files

#### INSERT_SAMPLE_DATA.sql
- **Path**: `Login/INSERT_SAMPLE_DATA.sql`
- **Nội dung**:
  - 10 khách hàng mẫu
  - Hoạt động cho 5 khách hàng đầu tiên
  - Các loại hoạt động: REGISTER, LOGIN, SEARCH, VIEW_TOUR, BOOKING, VIEW_HISTORY

## Cách sử dụng

### 1. Chạy SQL để thêm dữ liệu mẫu
```sql
-- Chạy file INSERT_SAMPLE_DATA.sql trong SQL Server Management Studio
-- File path: Login/INSERT_SAMPLE_DATA.sql
```

### 2. Tạo tài khoản Users tương ứng
Để đăng nhập được, cần tạo tài khoản trong bảng Users với email trùng với Customers:

```sql
-- Ví dụ tạo user cho customer
INSERT INTO Users (username, password, role_name)
VALUES 
('nguyenvanan@gmail.com', '123456', 'USER'),
('tranthibinh@gmail.com', '123456', 'USER'),
('lehoangcuong@gmail.com', '123456', 'USER');
```

**Lưu ý**: Password cần được hash nếu hệ thống sử dụng PasswordUtil

### 3. Đăng nhập và test

#### Test với USER:
1. Đăng nhập với email: `nguyenvanan@gmail.com`, password: `123456`
2. Click vào "Profile" trên navigation
3. Xem thông tin cá nhân
4. Chỉnh sửa thông tin (họ tên, SĐT, địa chỉ, ngày sinh)
5. Xem thống kê và lịch sử hoạt động

#### Test với ADMIN:
1. Đăng nhập với tài khoản ADMIN
2. Click vào "Khách hàng" trên navigation
3. Xem danh sách tất cả khách hàng
4. Click "Xem" để xem chi tiết từng khách hàng
5. Có thể chỉnh sửa thông tin và khóa/mở khóa tài khoản

## Phân quyền

### USER (role_name = 'USER')
- ✅ Xem thông tin cá nhân của mình (`/profile`)
- ✅ Chỉnh sửa thông tin cá nhân
- ✅ Xem lịch sử hoạt động của mình
- ❌ KHÔNG thể xem thông tin khách hàng khác
- ❌ KHÔNG thể truy cập `/admin/customers`

### ADMIN (role_name = 'ADMIN')
- ✅ Xem tất cả khách hàng (`/admin/customers`)
- ✅ Xem chi tiết từng khách hàng
- ✅ Chỉnh sửa thông tin khách hàng
- ✅ Khóa/mở khóa tài khoản khách hàng
- ✅ Xem lịch sử hoạt động của tất cả khách hàng
- ✅ Có thể truy cập `/profile` nếu muốn (nhưng thường dùng admin panel)

## Navigation Structure

### Guest (Chưa đăng nhập)
```
Trang chủ | Tours | Khách hàng (→ login) | [Đăng Nhập] [Đăng Ký]
```

### USER (Đã đăng nhập)
```
Trang chủ | Tours | Profile | [USER] [Đăng xuất]
```

### ADMIN (Đã đăng nhập)
```
Trang chủ | Tours | Khách hàng | Lịch sử | [ADMIN] [Đăng xuất]
```

## Dữ liệu mẫu

### 10 Khách hàng
1. Nguyễn Văn An - nguyenvanan@gmail.com - 0901234567 - Active
2. Trần Thị Bình - tranthibinh@gmail.com - 0912345678 - Active
3. Lê Hoàng Cường - lehoangcuong@gmail.com - 0923456789 - Active
4. Phạm Thị Dung - phamthidung@gmail.com - 0934567890 - Active
5. Hoàng Văn Em - hoangvanem@gmail.com - 0945678901 - Inactive
6. Võ Thị Phương - vothiphuong@gmail.com - 0956789012 - Active
7. Đặng Văn Giang - dangvangiang@gmail.com - 0967890123 - Active
8. Bùi Thị Hoa - buithihoa@gmail.com - 0978901234 - Banned
9. Ngô Văn Inh - ngovaninh@gmail.com - 0989012345 - Active
10. Dương Thị Kim - duongthikim@gmail.com - 0990123456 - Active

### Hoạt động mẫu
- Customer 1 (Nguyễn Văn An): 10 hoạt động (đăng ký, đăng nhập, tìm kiếm, đặt tour)
- Customer 2 (Trần Thị Bình): 10 hoạt động (2 lần đặt tour)
- Customer 3 (Lê Hoàng Cường): 8 hoạt động (đặt tour Huế)
- Customer 4 (Phạm Thị Dung): 8 hoạt động (đặt tour Núi Thần Tài)
- Customer 5 (Hoàng Văn Em): 5 hoạt động (chưa đặt tour)

## Security

### AuthFilter
- Tự động redirect về `/login.jsp` nếu chưa đăng nhập
- Kiểm tra session và user object

### ProfileServlet
- Chỉ cho phép user xem thông tin của chính mình
- Lấy email từ session user, không cho phép truyền customerId qua parameter
- Tự động log mọi thay đổi vào CustomerActivities

### AdminCustomerServlet
- Chỉ ADMIN mới truy cập được
- Có thể xem/sửa thông tin tất cả khách hàng

## UI/UX Features

### Profile Page
- ✅ Header navigation giống homepage (64px height, 1:1 ratio)
- ✅ Hero section với gradient xanh
- ✅ 2-column layout: Info bên trái, Form + Activities bên phải
- ✅ Thống kê hoạt động với 3 cards
- ✅ Timeline lịch sử hoạt động với icon và màu sắc
- ✅ Form chỉnh sửa với validation
- ✅ Alert messages cho success/error
- ✅ Responsive design

### Admin Customer Management
- ✅ Danh sách tất cả khách hàng với pagination
- ✅ Tìm kiếm theo tên, email, SĐT
- ✅ Lọc theo trạng thái (Active/Inactive/Banned)
- ✅ Chi tiết khách hàng với đầy đủ thông tin
- ✅ Khóa/mở khóa tài khoản
- ✅ Xem lịch sử hoạt động chi tiết

## Testing Checklist

- [ ] Chạy INSERT_SAMPLE_DATA.sql thành công
- [ ] Tạo tài khoản Users cho customers
- [ ] Đăng nhập với USER account
- [ ] Truy cập /profile và xem thông tin
- [ ] Chỉnh sửa thông tin và lưu thành công
- [ ] Xem thống kê và lịch sử hoạt động
- [ ] Đăng nhập với ADMIN account
- [ ] Truy cập /admin/customers
- [ ] Tìm kiếm và lọc khách hàng
- [ ] Xem chi tiết và chỉnh sửa thông tin khách hàng
- [ ] Khóa/mở khóa tài khoản
- [ ] Kiểm tra navigation khác nhau cho USER vs ADMIN
- [ ] Kiểm tra user badge hiển thị đúng

## Notes

1. **Email matching**: Email trong bảng Users phải trùng với email trong bảng Customers để profile hoạt động
2. **Password**: Nếu sử dụng PasswordUtil, cần hash password trước khi insert
3. **Session**: Profile servlet lấy thông tin từ session user, không từ parameter
4. **Activity logging**: Mọi thay đổi đều được log vào CustomerActivities
5. **Navigation**: USER không thấy "Khách hàng" và "Lịch sử", chỉ thấy "Profile"
