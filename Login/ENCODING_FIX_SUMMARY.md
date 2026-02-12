# ✅ Đã sửa lỗi Encoding

## Vấn đề
- Phông chữ tiếng Việt hiển thị sai ký tự (Ä?, á», â€¦)
- Tên khách hàng trong database bị lỗi encoding

## Đã sửa

### 1. JSP Files - Thêm encoding ✅
- `customers.jsp` - Thêm `pageEncoding="UTF-8"` và `response.setCharacterEncoding("UTF-8")`
- `customer-detail.jsp` - Thêm encoding
- `profile.jsp` - Thêm encoding

### 2. Servlet Files - Thêm encoding ✅
- `AdminCustomerServlet.java` - Thêm encoding trong doGet và doPost
- `ProfileServlet.java` - Thêm encoding trong doGet và doPost

```java
// Set encoding
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");
```

### 3. Database - Vấn đề còn tồn tại ⚠️
Tên trong database vẫn bị lỗi vì khi insert không dùng N prefix cho NVARCHAR.

## Giải pháp cho Database

### Option 1: Chạy lại SQL với N prefix (Khuyến nghị)
File `COMPLETE_SETUP_WITH_DATA.sql` đã có N prefix đúng rồi, nhưng có thể data đã bị lỗi khi insert.

Chạy lại để fix:

```sql
-- Xóa data cũ
DELETE FROM CustomerActivities;
DELETE FROM Customers;

-- Insert lại với N prefix
INSERT INTO Customers (id, full_name, email, phone, address, date_of_birth, status, created_at, updated_at)
VALUES 
(1, N'Nguyễn Văn An', 'nguyenvanan@gmail.com', '0901234567', N'123 Lê Lợi, Hải Châu, Đà Nẵng', '1990-05-15', 'active', DATEADD(day, -30, GETDATE()), GETDATE());
-- ... (các dòng khác)
```

### Option 2: Update trực tiếp (Nhanh hơn)
```sql
UPDATE Customers SET full_name = N'Nguyễn Văn An' WHERE id = 1;
UPDATE Customers SET full_name = N'Trần Thị Bình' WHERE id = 2;
UPDATE Customers SET full_name = N'Lê Hoàng Cường' WHERE id = 3;
UPDATE Customers SET full_name = N'Phạm Thị Dung' WHERE id = 4;
UPDATE Customers SET full_name = N'Hoàng Văn Em' WHERE id = 5;
UPDATE Customers SET full_name = N'Võ Thị Phương' WHERE id = 6;
UPDATE Customers SET full_name = N'Đặng Văn Giang' WHERE id = 7;
UPDATE Customers SET full_name = N'Bùi Thị Hoa' WHERE id = 8;
UPDATE Customers SET full_name = N'Ngô Văn Inh' WHERE id = 9;
UPDATE Customers SET full_name = N'Dương Thị Kim' WHERE id = 10;

UPDATE Customers SET address = N'123 Lê Lợi, Hải Châu, Đà Nẵng' WHERE id = 1;
UPDATE Customers SET address = N'456 Trần Phú, Sơn Trà, Đà Nẵng' WHERE id = 2;
UPDATE Customers SET address = N'789 Nguyễn Văn Linh, Thanh Khê, Đà Nẵng' WHERE id = 3;
UPDATE Customers SET address = N'321 Hoàng Diệu, Hải Châu, Đà Nẵng' WHERE id = 4;
UPDATE Customers SET address = N'654 Điện Biên Phủ, Thanh Khê, Đà Nẵng' WHERE id = 5;
UPDATE Customers SET address = N'987 Phan Châu Trinh, Hải Châu, Đà Nẵng' WHERE id = 6;
UPDATE Customers SET address = N'147 Lê Duẩn, Thanh Khê, Đà Nẵng' WHERE id = 7;
UPDATE Customers SET address = N'258 Hùng Vương, Hải Châu, Đà Nẵng' WHERE id = 8;
UPDATE Customers SET address = N'369 Ông Ích Khiêm, Hải Châu, Đà Nẵng' WHERE id = 9;
UPDATE Customers SET address = N'741 Núi Thành, Hải Châu, Đà Nẵng' WHERE id = 10;
```

## Tài khoản đăng nhập

✅ Đã tạo 10 Users, tất cả có password: **123456**

| Email | Password | Role | Status |
|-------|----------|------|--------|
| nguyenvanan@gmail.com | 123456 | USER | Active |
| tranthibinh@gmail.com | 123456 | USER | Active |
| lehoangcuong@gmail.com | 123456 | USER | Active |
| phamthidung@gmail.com | 123456 | USER | Active |
| hoangvanem@gmail.com | 123456 | USER | Active |
| vothiphuong@gmail.com | 123456 | USER | Active |
| dangvangiang@gmail.com | 123456 | USER | Active |
| buithihoa@gmail.com | 123456 | USER | Active |
| ngovaninh@gmail.com | 123456 | USER | Active |
| duongthikim@gmail.com | 123456 | USER | Active |

## Test ngay

1. **Rebuild project** để apply encoding changes
2. **Redeploy** lên Tomcat
3. **Đăng nhập** với: `nguyenvanan@gmail.com` / `123456`
4. **Kiểm tra** tiếng Việt hiển thị đúng

## Lưu ý

- Encoding phải được set ở 3 nơi: JSP (pageEncoding), Servlet (request/response), Database (NVARCHAR + N prefix)
- Nếu vẫn lỗi font, check Tomcat server.xml có `URIEncoding="UTF-8"` chưa
- Browser phải support UTF-8 (tất cả browser hiện đại đều support)
