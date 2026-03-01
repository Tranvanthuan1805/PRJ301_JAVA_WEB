# ✅ Checklist: Kiểm tra Setup Tính năng NCC

## 1. Database Setup ✓

### Kiểm tra Tables
Chạy query sau trong SQL Server Management Studio:
```sql
USE DaNangTravelHub;

-- Kiểm tra table Providers có tồn tại không
SELECT COUNT(*) as TotalProviders FROM Providers;

-- Kiểm tra dữ liệu mẫu
SELECT 
    ProviderId,
    BusinessName,
    ProviderType,
    Rating,
    IsActive,
    IsVerified
FROM Providers
ORDER BY Rating DESC;

-- Kiểm tra ProviderPriceHistory
SELECT COUNT(*) as TotalPriceHistory FROM ProviderPriceHistory;

-- Kiểm tra ProviderRegistrations
SELECT COUNT(*) as TotalRegistrations FROM ProviderRegistrations;
```

### Kết quả mong đợi:
- ✅ Providers: 10 records
- ✅ ProviderPriceHistory: 15+ records
- ✅ ProviderRegistrations: 10 records

---

## 2. JPA Configuration ✓

### Kiểm tra persistence.xml
File: `src/main/resources/META-INF/persistence.xml`

Đảm bảo có:
```xml
<persistence-unit name="DaNangTravelHubPU">
    <class>com.dananghub.entity.Provider</class>
    <class>com.dananghub.entity.ProviderPriceHistory</class>
    <class>com.dananghub.entity.ProviderRegistration</class>
    
    <properties>
        <property name="jakarta.persistence.jdbc.url" 
                  value="jdbc:sqlserver://localhost:1433;databaseName=DaNangTravelHub;encrypt=false"/>
        <property name="jakarta.persistence.jdbc.user" value="sa"/>
        <property name="jakarta.persistence.jdbc.password" value="your_password"/>
    </properties>
</persistence-unit>
```

---

## 3. Entity Classes ✓

### Kiểm tra các Entity đã tạo:
- ✅ `src/main/java/com/dananghub/entity/Provider.java`
- ✅ `src/main/java/com/dananghub/entity/ProviderPriceHistory.java`
- ✅ `src/main/java/com/dananghub/entity/ProviderRegistration.java`

---

## 4. DAO Layer ✓

### Kiểm tra ProviderDAO:
File: `src/main/java/com/dananghub/dao/ProviderDAO.java`

Các phương thức:
- ✅ `findAllActive()` - Lấy tất cả providers
- ✅ `findByType(String)` - Lọc theo loại
- ✅ `searchByName(String)` - Tìm kiếm
- ✅ `findById(int)` - Lấy chi tiết
- ✅ `getPriceHistory(int)` - Lịch sử giá
- ✅ `findByIds(List<Integer>)` - So sánh
- ✅ `getTopRated(int)` - Top providers

---

## 5. Controller (Servlet) ✓

### Kiểm tra ProviderManagementServlet:
File: `src/main/java/com/dananghub/controller/ProviderManagementServlet.java`

Annotation:
```java
@WebServlet("/admin/providers")
```

Các action:
- ✅ `list` - Danh sách
- ✅ `detail` - Chi tiết
- ✅ `comparison` - So sánh
- ✅ `search` - Tìm kiếm

---

## 6. Filter Configuration ✓

### Kiểm tra AuthFilter:
File: `src/main/java/com/dananghub/filter/AuthFilter.java`

Đảm bảo có đoạn code này:
```java
// Cho phép truy cập công khai vào trang Providers (NCC)
if (uri.contains("/admin/providers") || path.startsWith("/admin/providers")) {
    chain.doFilter(req, res);
    return;
}
```

---

## 7. View (JSP) ✓

### Kiểm tra các file JSP:
- ✅ `src/main/webapp/views/provider-management/provider-list.jsp`
- ✅ `src/main/webapp/views/provider-management/provider-detail.jsp`
- ✅ `src/main/webapp/views/provider-management/provider-comparison.jsp`
- ✅ `src/main/webapp/views/provider-management/provider-comparison-select.jsp`

---

## 8. Navigation Menu ✓

### Kiểm tra _header.jsp:
File: `src/main/webapp/common/_header.jsp`

Đảm bảo có menu NCC:
```html
<li class="nav-dropdown">
    <a href="${pageContext.request.contextPath}/admin/providers">
        <i class="fas fa-building"></i> NCC
    </a>
    <div class="nav-dropdown-menu">
        <!-- Dropdown items -->
    </div>
</li>
```

---

## 9. Test Access 🧪

### Bước 1: Restart Server
```bash
# Stop Tomcat
# Start Tomcat
```

### Bước 2: Test Page
Truy cập: `http://localhost:8080/your-context/test-provider-access.jsp`

Kết quả mong đợi:
- ✅ Trang load thành công
- ✅ Hiển thị thông tin request
- ✅ Có các test links

### Bước 3: Test Provider List
Click vào "Danh sách NCC" hoặc truy cập:
`http://localhost:8080/your-context/admin/providers`

Kết quả mong đợi:
- ✅ KHÔNG redirect đến login
- ✅ Hiển thị danh sách 10 providers
- ✅ Có thanh tìm kiếm và filter

### Bước 4: Test Menu
1. Vào trang chủ
2. Click menu "NCC" trên navigation bar
3. Kết quả mong đợi:
   - ✅ Hiển thị dropdown menu
   - ✅ Có 5 options
   - ✅ Click vào không bị redirect

---

## 10. Troubleshooting 🔧

### Vấn đề 1: Vẫn redirect đến login
**Giải pháp:**
1. Kiểm tra AuthFilter có được compile lại không
2. Restart server
3. Clear browser cache
4. Kiểm tra URL có đúng context path không

### Vấn đề 2: 404 Not Found
**Giải pháp:**
1. Kiểm tra servlet mapping: `@WebServlet("/admin/providers")`
2. Kiểm tra context path
3. Kiểm tra server có deploy đúng không

### Vấn đề 3: Không có dữ liệu
**Giải pháp:**
1. Chạy lại script: `database/INSERT_SAMPLE_PROVIDERS.sql`
2. Kiểm tra database connection trong persistence.xml
3. Kiểm tra JPAUtil có hoạt động không

### Vấn đề 4: NullPointerException
**Giải pháp:**
1. Kiểm tra EntityManager có được tạo đúng không
2. Kiểm tra persistence.xml có đúng database name không
3. Kiểm tra SQL Server có đang chạy không

---

## 11. Debug Commands 🐛

### Thêm log vào AuthFilter:
```java
System.out.println("=== AuthFilter Debug ===");
System.out.println("URI: " + uri);
System.out.println("Path: " + path);
System.out.println("Contains /admin/providers: " + uri.contains("/admin/providers"));
System.out.println("Starts with /admin/providers: " + path.startsWith("/admin/providers"));
System.out.println("========================");
```

### Thêm log vào ProviderManagementServlet:
```java
System.out.println("=== ProviderManagementServlet ===");
System.out.println("Action: " + action);
System.out.println("Type: " + type);
System.out.println("=================================");
```

---

## ✅ Hoàn thành!

Nếu tất cả các bước trên đều pass, tính năng NCC đã sẵn sàng sử dụng!

### Các URL chính:
- Danh sách: `/admin/providers`
- Chi tiết: `/admin/providers?action=detail&id=1`
- So sánh: `/admin/providers?action=comparison`
- Khách sạn: `/admin/providers?type=Hotel`
- Tour: `/admin/providers?type=TourOperator`
- Vận chuyển: `/admin/providers?type=Transport`
