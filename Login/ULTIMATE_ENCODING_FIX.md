# ULTIMATE ENCODING FIX - Giải pháp cuối cùng

## Vấn đề
Tên tiếng Việt vẫn hiển thị sai trên web dù đã:
- ✅ Set UTF-8 trong JSP
- ✅ Set UTF-8 trong Servlet
- ✅ Tạo EncodingFilter
- ✅ Update JDBC URL với characterEncoding
- ✅ Recreate data trong database

## Nguyên nhân
Vấn đề là **SQL Server JDBC Driver** không tự động convert NVARCHAR sang UTF-8 đúng cách.

## Giải pháp CUỐI CÙNG

### Option 1: Thay đổi Database Collation (Khuyến nghị)

Thay đổi collation của database sang Vietnamese:

```sql
-- Backup database trước!
ALTER DATABASE AdminUser 
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

ALTER DATABASE AdminUser 
COLLATE Vietnamese_CI_AS;

ALTER DATABASE AdminUser 
SET MULTI_USER;
```

Sau đó recreate customers:
```bash
sqlcmd -S localhost -U sa -P 123456 -d AdminUser -i "Login\RECREATE_CUSTOMERS_UTF8.sql"
```

### Option 2: Sử dụng JDBC Driver mới nhất

Download và thay thế JDBC driver:
1. Download: `mssql-jdbc-12.6.0.jre8.jar` (latest)
2. Copy vào: `Login/web/WEB-INF/lib/`
3. Xóa driver cũ
4. Rebuild project

### Option 3: Thêm Properties vào Connection

Update `DBUtil.java`:

```java
private static final String URL =
    "jdbc:sqlserver://localhost:1433;" +
    "databaseName=AdminUser;" +
    "encrypt=true;" +
    "trustServerCertificate=true;" +
    "characterEncoding=UTF-8;" +
    "sendStringParametersAsUnicode=true;" +
    "useUnicode=true;";
```

### Option 4: Force UTF-8 trong ResultSet

Update `CustomerDAO.mapResultSetToCustomer()`:

```java
private Customer mapResultSetToCustomer(ResultSet rs) throws SQLException {
    Customer c = new Customer();
    c.setId(rs.getInt("id"));
    
    // Force UTF-8 conversion
    String fullName = rs.getString("full_name");
    if (fullName != null) {
        try {
            // Convert from Latin1 to UTF-8
            fullName = new String(fullName.getBytes("ISO-8859-1"), "UTF-8");
        } catch (Exception e) {
            // Keep original if conversion fails
        }
    }
    c.setFullName(fullName);
    
    c.setEmail(rs.getString("email"));
    c.setPhone(rs.getString("phone"));
    
    String address = rs.getString("address");
    if (address != null) {
        try {
            address = new String(address.getBytes("ISO-8859-1"), "UTF-8");
        } catch (Exception e) {
            // Keep original
        }
    }
    c.setAddress(address);
    
    c.setDateOfBirth(rs.getDate("date_of_birth"));
    c.setStatus(rs.getString("status"));
    c.setCreatedAt(rs.getTimestamp("created_at"));
    c.setUpdatedAt(rs.getTimestamp("updated_at"));
    return c;
}
```

## Cách test nhanh

### Test 1: Direct SQL Query
```sql
SELECT id, full_name, UNICODE(SUBSTRING(full_name, 1, 1)) as first_char_unicode
FROM Customers 
WHERE id = 1;
```

Nếu `first_char_unicode` = 78 (N) → Sai, phải là Unicode của "N" trong "Nguyễn"
Nếu `first_char_unicode` > 200 → Đúng, là ký tự tiếng Việt

### Test 2: Java Test
Tạo file test:

```java
public class TestEncoding {
    public static void main(String[] args) {
        String test = "Nguyễn Văn An";
        System.out.println("Original: " + test);
        
        try {
            byte[] bytes = test.getBytes("UTF-8");
            System.out.println("UTF-8 bytes: " + Arrays.toString(bytes));
            
            String fromLatin1 = new String(test.getBytes("ISO-8859-1"), "UTF-8");
            System.out.println("From Latin1: " + fromLatin1);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

## Recommended Solution (Làm theo thứ tự)

### Bước 1: Update DBUtil với full properties
```java
private static final String URL =
    "jdbc:sqlserver://localhost:1433;" +
    "databaseName=AdminUser;" +
    "encrypt=true;" +
    "trustServerCertificate=true;" +
    "characterEncoding=UTF-8;" +
    "sendStringParametersAsUnicode=true;" +
    "useUnicode=true;";
```

### Bước 2: Update CustomerDAO với encoding conversion
Thêm method helper:

```java
private String convertToUTF8(String input) {
    if (input == null) return null;
    try {
        return new String(input.getBytes("ISO-8859-1"), "UTF-8");
    } catch (Exception e) {
        return input;
    }
}
```

Sử dụng trong mapResultSetToCustomer:
```java
c.setFullName(convertToUTF8(rs.getString("full_name")));
c.setAddress(convertToUTF8(rs.getString("address")));
```

### Bước 3: Rebuild & Test
1. Clean and Build
2. Restart Tomcat
3. Test `/test-encoding`
4. Test `/admin/customers`

## Nếu vẫn không được

### Last Resort: Thay đổi cách lưu data

Thay vì dùng NVARCHAR, convert sang VARCHAR với UTF-8:

```sql
-- Alter table
ALTER TABLE Customers 
ALTER COLUMN full_name VARCHAR(100) COLLATE Vietnamese_CI_AS;

ALTER TABLE Customers 
ALTER COLUMN address VARCHAR(255) COLLATE Vietnamese_CI_AS;
```

Nhưng cách này KHÔNG khuyến nghị vì NVARCHAR là chuẩn cho Unicode.

## Expected Result

Sau khi apply solution, tên phải hiển thị:
- ✅ Nguyễn Văn An
- ✅ Trần Thị Bình
- ✅ Lê Hoàng Cường
- ✅ Phạm Thị Dung
- ✅ Hoàng Văn Em

KHÔNG phải:
- ❌ Nguyá».n VÄƒn An
- ❌ Tráº§n Thá»< BA¬nh
- ❌ LAª HoA ng CÆ°á»?ng

## Files cần update

1. `DBUtil.java` - Add full JDBC properties
2. `CustomerDAO.java` - Add encoding conversion
3. Rebuild project
4. Restart Tomcat

## Contact Support

Nếu sau tất cả các bước trên vẫn không được, vấn đề có thể là:
1. JDBC Driver version không tương thích
2. SQL Server version quá cũ
3. Windows locale settings

Cần kiểm tra:
- SQL Server version: `SELECT @@VERSION`
- JDBC Driver version: Check file name trong WEB-INF/lib
- Java version: `java -version`
