# Testing Guide - Profile Feature

## ✅ Setup Completed!

Database đã được setup thành công với:
- ✅ 10 Customers
- ✅ 41 Activities (cho 5 customers đầu)
- ✅ 10 Users (tất cả có password: 123456)

## Test Accounts

### USER Accounts (để test /profile)
| Email | Password | Customer Name | Status |
|-------|----------|---------------|--------|
| nguyenvanan@gmail.com | 123456 | Nguyễn Văn An | Active |
| tranthibinh@gmail.com | 123456 | Trần Thị Bình | Active |
| lehoangcuong@gmail.com | 123456 | Lê Hoàng Cường | Active |
| phamthidung@gmail.com | 123456 | Phạm Thị Dung | Active |
| hoangvanem@gmail.com | 123456 | Hoàng Văn Em | Inactive |

### ADMIN Account (để test /admin/customers)
Sử dụng tài khoản ADMIN hiện có của bạn

## Testing Steps

### 1. Test USER Profile Feature

1. **Đăng nhập với USER account**
   - URL: `http://localhost:8080/Login/login.jsp`
   - Email: `nguyenvanan@gmail.com`
   - Password: `123456`

2. **Kiểm tra Navigation**
   - Sau khi đăng nhập, navigation bar phải hiển thị:
     - Trang chủ | Tours | Profile | [USER] [Đăng xuất]
   - KHÔNG có "Khách hàng" và "Lịch sử"

3. **Truy cập Profile**
   - Click vào "Profile" trên navigation
   - URL: `http://localhost:8080/Login/profile`
   - Phải hiển thị:
     - ✅ Thông tin cá nhân (ID, họ tên, email, SĐT, địa chỉ, ngày sinh, trạng thái)
     - ✅ Form chỉnh sửa thông tin
     - ✅ Thống kê hoạt động (3 cards: Tổng hoạt động, Đặt tour, Tìm kiếm)
     - ✅ Timeline lịch sử hoạt động

4. **Test Edit Profile**
   - Thay đổi họ tên: "Nguyễn Văn An Updated"
   - Thay đổi SĐT: "0901234999"
   - Click "Lưu thay đổi"
   - Phải hiển thị alert success: "Cập nhật thông tin thành công!"
   - Thông tin phải được cập nhật

5. **Kiểm tra Activities**
   - Nguyễn Văn An phải có 10 activities
   - Trần Thị Bình phải có 10 activities
   - Lê Hoàng Cường phải có 8 activities
   - Phạm Thị Dung phải có 8 activities
   - Hoàng Văn Em phải có 5 activities

6. **Test Security**
   - USER KHÔNG thể truy cập `/admin/customers`
   - Nếu cố truy cập, phải redirect về login hoặc error page

### 2. Test ADMIN Customer Management

1. **Đăng nhập với ADMIN account**
   - Sử dụng tài khoản ADMIN hiện có

2. **Kiểm tra Navigation**
   - Navigation bar phải hiển thị:
     - Trang chủ | Tours | Khách hàng | Lịch sử | [ADMIN] [Đăng xuất]
   - KHÔNG có "Profile"

3. **Truy cập Customer Management**
   - Click vào "Khách hàng"
   - URL: `http://localhost:8080/Login/admin/customers`
   - Phải hiển thị danh sách 10 khách hàng

4. **Test Search**
   - Tìm kiếm: "Nguyễn" → phải ra 1 kết quả (Nguyễn Văn An)
   - Tìm kiếm: "0901234567" → phải ra 1 kết quả
   - Tìm kiếm: "gmail.com" → phải ra 10 kết quả

5. **Test Filter**
   - Lọc Status: "active" → phải ra 8 khách hàng
   - Lọc Status: "inactive" → phải ra 1 khách hàng (Hoàng Văn Em)
   - Lọc Status: "banned" → phải ra 1 khách hàng (Bùi Thị Hoa)

6. **Test View Detail**
   - Click "Xem" ở Nguyễn Văn An
   - Phải hiển thị đầy đủ thông tin + 10 activities
   - Có thể chỉnh sửa thông tin
   - Có nút "Khóa tài khoản" (vì status = active)

7. **Test Lock/Unlock**
   - Click "Khóa tài khoản" ở Nguyễn Văn An
   - Status phải chuyển thành "banned"
   - Nút phải đổi thành "Mở khóa"
   - Click "Mở khóa" → status phải về "active"

### 3. Test Navigation Differences

#### Guest (Chưa đăng nhập)
```
Trang chủ | Tours | Khách hàng (→ login) | [Đăng Nhập] [Đăng Ký]
```

#### USER (Đã đăng nhập)
```
Trang chủ | Tours | Profile | [USER] [Đăng xuất]
```

#### ADMIN (Đã đăng nhập)
```
Trang chủ | Tours | Khách hàng | Lịch sử | [ADMIN] [Đăng xuất]
```

## Expected Results

### Profile Page (USER)
- ✅ Header height: 64px (giống homepage)
- ✅ Hero section với gradient xanh
- ✅ 2-column layout
- ✅ Thông tin cá nhân bên trái
- ✅ Form edit + Activities bên phải
- ✅ 3 stat cards (Tổng hoạt động, Đặt tour, Tìm kiếm)
- ✅ Timeline với icon và màu sắc
- ✅ Alert messages

### Customer Management (ADMIN)
- ✅ Danh sách 10 khách hàng
- ✅ Search và filter hoạt động
- ✅ Pagination (nếu > 10 khách hàng)
- ✅ Chi tiết khách hàng với activities
- ✅ Khóa/mở khóa tài khoản
- ✅ Chỉnh sửa thông tin

## Troubleshooting

### Lỗi: "Không tìm thấy thông tin khách hàng"
- **Nguyên nhân**: Email trong Users không trùng với email trong Customers
- **Giải pháp**: Kiểm tra lại database, đảm bảo email khớp nhau

### Lỗi: Login failed
- **Nguyên nhân**: Password không đúng hoặc chưa hash
- **Giải pháp**: Password phải là "123456" (đã hash thành SHA-256)

### Lỗi: Cannot access /profile
- **Nguyên nhân**: Chưa đăng nhập hoặc session hết hạn
- **Giải pháp**: Đăng nhập lại

### Lỗi: USER có thể truy cập /admin/customers
- **Nguyên nhân**: AuthFilter chưa được cấu hình đúng
- **Giải pháp**: Kiểm tra web.xml và AuthFilter.java

## Database Queries for Verification

### Kiểm tra Customers
```sql
SELECT * FROM Customers;
```

### Kiểm tra Users
```sql
SELECT u.UserId, u.Username, r.RoleName, u.IsActive 
FROM Users u 
JOIN Roles r ON u.RoleId = r.RoleId
WHERE u.Username LIKE '%@gmail.com';
```

### Kiểm tra Activities
```sql
SELECT c.full_name, COUNT(*) as activity_count
FROM CustomerActivities ca
JOIN Customers c ON ca.customer_id = c.id
GROUP BY c.full_name
ORDER BY activity_count DESC;
```

### Kiểm tra email matching
```sql
SELECT 
    u.Username as UserEmail,
    c.email as CustomerEmail,
    CASE WHEN u.Username = c.email THEN 'MATCH' ELSE 'NOT MATCH' END as Status
FROM Users u
LEFT JOIN Customers c ON u.Username = c.email
WHERE u.Username LIKE '%@gmail.com';
```

## Next Steps

1. ✅ Deploy application to Tomcat
2. ✅ Test với USER account
3. ✅ Test với ADMIN account
4. ✅ Verify navigation differences
5. ✅ Test security (USER không thể access admin pages)
6. ✅ Test edit profile functionality
7. ✅ Test customer management (ADMIN only)

## Notes

- Tất cả passwords đều là: **123456**
- Database: **AdminUser**
- Server: **localhost:1433**
- User: **sa**
- Password: **123456**
