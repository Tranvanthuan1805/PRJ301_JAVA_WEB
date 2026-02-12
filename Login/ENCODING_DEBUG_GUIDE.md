# Hướng dẫn Debug Encoding

## Đã làm gì?

### 1. Tạo EncodingFilter ✅
- File: `Login/src/java/filter/EncodingFilter.java`
- Áp dụng UTF-8 cho TẤT CẢ requests và responses
- Chạy trước tất cả servlets

### 2. Cập nhật DBUtil ✅
- Thêm `characterEncoding=UTF-8` vào JDBC URL
- Thêm `sendStringParametersAsUnicode=true`

### 3. Tạo TestEncodingServlet ✅
- File: `Login/src/java/servlet/TestEncodingServlet.java`
- URL: `http://localhost:8080/Login/test-encoding`
- Test 3 scenarios:
  1. Hardcoded Vietnamese strings
  2. Data from database
  3. Encoding info

## Cách test

### Bước 1: Rebuild & Redeploy
```
1. Clean and Build project trong NetBeans
2. Restart Tomcat server
3. Deploy lại application
```

### Bước 2: Test Encoding
Mở browser và truy cập:
```
http://localhost:8080/Login/test-encoding
```

Kiểm tra:
- ✅ Test 1 (Hardcoded): Phải hiển thị đúng "Nguyễn Văn An"
- ✅ Test 2 (Database): Phải hiển thị đúng tên từ database
- ✅ Test 3 (Info): Phải show "UTF-8" cho tất cả

### Bước 3: Test Customer Management
```
http://localhost:8080/Login/admin/customers
```

Nếu vẫn lỗi, kiểm tra:
1. Browser encoding (phải là UTF-8)
2. Tomcat server.xml
3. Database collation

## Nếu vẫn lỗi

### Check 1: Browser Encoding
- Chrome: View → Encoding → Unicode (UTF-8)
- Firefox: View → Text Encoding → Unicode

### Check 2: Tomcat server.xml
Thêm `URIEncoding="UTF-8"` vào Connector:

```xml
<Connector port="8080" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443"
           URIEncoding="UTF-8" />
```

### Check 3: Database Collation
```sql
-- Check database collation
SELECT DATABASEPROPERTYEX('AdminUser', 'Collation');

-- Should be: SQL_Latin1_General_CP1_CI_AS or Vietnamese_CI_AS
```

### Check 4: JDBC Driver Version
Đảm bảo dùng JDBC driver mới nhất:
- `mssql-jdbc-12.2.0.jre8.jar` hoặc mới hơn

## Files đã tạo/sửa

### New Files
- ✅ `EncodingFilter.java` - UTF-8 filter cho tất cả requests
- ✅ `TestEncodingServlet.java` - Test encoding

### Updated Files
- ✅ `DBUtil.java` - Thêm encoding vào JDBC URL
- ✅ `AdminCustomerServlet.java` - Thêm encoding
- ✅ `ProfileServlet.java` - Thêm encoding
- ✅ `customers.jsp` - Thêm pageEncoding
- ✅ `customer-detail.jsp` - Thêm pageEncoding
- ✅ `profile.jsp` - Thêm pageEncoding

## Expected Results

### Test Encoding Page
```
Test 1: Hardcoded String
Nguyễn Văn An ✅
Trần Thị Bình ✅
Lê Hoàng Cường ✅

Test 2: From Database
ID | Full Name | Email
1  | Nguyễn Văn An | nguyenvanan@gmail.com ✅
2  | Trần Thị Bình | tranthibinh@gmail.com ✅
...

Test 3: Encoding Info
Request Encoding: UTF-8 ✅
Response Encoding: UTF-8 ✅
Response Content Type: text/html; charset=UTF-8 ✅
```

### Customer Management Page
- Tất cả tên phải hiển thị đúng tiếng Việt
- Không có ký tự lạ (Ä?, á», â€¦)

## Troubleshooting

### Vẫn thấy ký tự lạ?
1. Hard refresh browser (Ctrl+F5)
2. Clear browser cache
3. Restart Tomcat
4. Check console logs

### EncodingFilter không chạy?
Check console log phải thấy:
```
>>> EncodingFilter initialized - UTF-8 encoding will be applied to all requests
```

### Database vẫn lỗi?
Chạy lại:
```bash
sqlcmd -S localhost -U sa -P 123456 -d AdminUser -i "Login\FIX_ENCODING_DATABASE.sql"
```

## Next Steps

1. ✅ Rebuild project
2. ✅ Restart Tomcat
3. ✅ Test `/test-encoding`
4. ✅ Test `/admin/customers`
5. ✅ Test `/profile`

Nếu test-encoding page hiển thị đúng → Vấn đề đã fix!
