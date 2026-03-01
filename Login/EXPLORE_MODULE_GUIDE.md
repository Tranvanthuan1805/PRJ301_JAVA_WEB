# 🗺️ Module Khám Phá Tour - Hướng Dẫn Sử Dụng

## 📋 Tổng Quan

Module **Khám Phá Tour** cho phép Guest (khách chưa đăng nhập) xem và tìm kiếm các tour du lịch năm 2026 tại Đà Nẵng.

## ✨ Tính Năng Đã Triển Khai

### 1️⃣ Guest - Khám Phá Tours

#### 🔍 Tìm Kiếm
- Tìm theo tên tour
- Tìm theo địa điểm
- Tìm theo mô tả tour

#### 📊 Bộ Lọc
- **Lọc theo chỗ trống**: Chỉ hiển thị tour còn chỗ
- **Sắp xếp**:
  - A → Z (mặc định)
  - Z → A
  - Giá thấp → cao
  - Giá cao → thấp

#### 📄 Phân Trang
- Hiển thị 12 tour/trang
- Điều hướng trang trước/sau
- Hiển thị số trang hiện tại và tổng số trang
- Hiển thị tổng số tour tìm thấy

#### 🎨 Hiển Thị Tour
- **Grid Layout**: Hiển thị dạng lưới responsive
- **Thông tin tour**:
  - Tên tour
  - Địa điểm xuất phát
  - Mô tả ngắn
  - Giá tour (định dạng VND)
  - Số chỗ còn trống
  - Hình ảnh (nếu có)

#### 🚫 Giới Hạn Guest
- Guest chỉ được **XEM** tour
- **KHÔNG** được đặt tour
- Cần đăng nhập để đặt tour

## 📁 Cấu Trúc File

```
Login/
├── src/java/controller/
│   └── ExploreServlet.java          # Servlet xử lý khám phá tour
├── src/java/dao/
│   └── TourDAO.java                 # DAO truy vấn tour (đã có)
├── src/java/model/
│   └── Tour.java                    # Model Tour (đã có)
└── web/
    ├── explore.jsp                  # Trang khám phá tour
    ├── include/
    │   └── header.jsp               # Header (đã cập nhật)
    └── index.jsp                    # Trang chủ (đã cập nhật)
```

## 🔗 URL và Routing

### URL Chính
```
http://localhost:8080/Login/explore
```

### URL với Tham Số
```
# Tìm kiếm
/explore?search=Hội An

# Lọc tour còn chỗ
/explore?available=true

# Sắp xếp A-Z
/explore?sort=name_asc

# Sắp xếp Z-A
/explore?sort=name_desc

# Sắp xếp giá thấp → cao
/explore?sort=price_asc

# Sắp xếp giá cao → thấp
/explore?sort=price_desc

# Phân trang
/explore?page=2

# Kết hợp nhiều tham số
/explore?search=Hội An&available=true&sort=price_asc&page=1
```

## 🎯 Luồng Hoạt Động

### 1. Guest Truy Cập Trang Khám Phá
```
Guest → Click "Khám phá" → ExploreServlet → explore.jsp
```

### 2. Guest Tìm Kiếm Tour
```
Guest → Nhập từ khóa → Click "Tìm kiếm" → ExploreServlet (filter) → explore.jsp
```

### 3. Guest Lọc Tour
```
Guest → Chọn "Còn chỗ trống" → Click "Tìm kiếm" → ExploreServlet (filter) → explore.jsp
```

### 4. Guest Sắp Xếp Tour
```
Guest → Chọn "A → Z" → Click "Tìm kiếm" → ExploreServlet (sort) → explore.jsp
```

### 5. Guest Xem Trang Khác
```
Guest → Click "Sau →" → ExploreServlet (page=2) → explore.jsp
```

## 💻 Code Chính

### ExploreServlet.java
```java
@WebServlet("/explore")
public class ExploreServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        // 1. Lấy tham số
        String search = request.getParameter("search");
        String availableOnly = request.getParameter("available");
        String sortBy = request.getParameter("sort");
        int page = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");
        
        // 2. Lấy tất cả tour
        List<Tour> allTours = tourDAO.getAllActiveTours();
        
        // 3. Áp dụng filter
        if (search != null) {
            allTours = allTours.stream()
                .filter(t -> t.getTourName().toLowerCase().contains(search.toLowerCase()))
                .collect(Collectors.toList());
        }
        
        if ("true".equals(availableOnly)) {
            allTours = allTours.stream()
                .filter(t -> t.getMaxPeople() > 0)
                .collect(Collectors.toList());
        }
        
        // 4. Áp dụng sorting
        if ("name_asc".equals(sortBy)) {
            allTours.sort((t1, t2) -> t1.getTourName().compareToIgnoreCase(t2.getTourName()));
        }
        
        // 5. Phân trang
        int pageSize = 12;
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, allTours.size());
        List<Tour> tours = allTours.subList(startIndex, endIndex);
        
        // 6. Forward
        request.setAttribute("tours", tours);
        request.getRequestDispatcher("/explore.jsp").forward(request, response);
    }
}
```

## 🎨 Giao Diện

### Màu Sắc
- **Primary**: `#667eea` (Tím)
- **Secondary**: `#764ba2` (Tím đậm)
- **Success**: `#16a34a` (Xanh lá)
- **Danger**: `#dc2626` (Đỏ)
- **Background**: `#f5f7fa` (Xám nhạt)

### Responsive
- **Desktop**: Grid 3-4 cột
- **Tablet**: Grid 2 cột
- **Mobile**: Grid 1 cột

## 🧪 Test Cases

### Test 1: Xem Tất Cả Tour
```
URL: /explore
Expected: Hiển thị tất cả tour active, sắp xếp A-Z
```

### Test 2: Tìm Kiếm Tour
```
URL: /explore?search=Hội An
Expected: Chỉ hiển thị tour có "Hội An" trong tên/địa điểm/mô tả
```

### Test 3: Lọc Tour Còn Chỗ
```
URL: /explore?available=true
Expected: Chỉ hiển thị tour có maxPeople > 0
```

### Test 4: Sắp Xếp A-Z
```
URL: /explore?sort=name_asc
Expected: Tour sắp xếp theo tên A → Z
```

### Test 5: Sắp Xếp Giá
```
URL: /explore?sort=price_asc
Expected: Tour sắp xếp theo giá thấp → cao
```

### Test 6: Phân Trang
```
URL: /explore?page=2
Expected: Hiển thị tour từ 13-24
```

### Test 7: Kết Hợp Filter
```
URL: /explore?search=Đà Nẵng&available=true&sort=price_asc
Expected: Tour có "Đà Nẵng", còn chỗ, sắp xếp theo giá
```

## 🚀 Triển Khai

### Bước 1: Build Project
```bash
cd Login
ant clean
ant build
```

### Bước 2: Deploy
```bash
# Copy WAR file to Tomcat
copy dist\Login.war "C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\"
```

### Bước 3: Khởi Động Tomcat
```bash
cd "C:\Program Files\Apache Software Foundation\Tomcat 10.1\bin"
startup.bat
```

### Bước 4: Truy Cập
```
http://localhost:8080/Login/explore
```

## 📝 Lưu Ý

1. **Guest không được đặt tour**: Module này chỉ cho phép xem, không có nút "Đặt tour"
2. **Chỉ hiển thị tour active**: Tour có `isActive = true`
3. **Phân trang mặc định**: 12 tour/trang
4. **Sắp xếp mặc định**: A → Z
5. **Responsive**: Tự động điều chỉnh theo màn hình

## 🔄 Tích Hợp với Module Khác

### Tích Hợp với Login
```
Guest xem tour → Click "Đặt tour" → Redirect to /login.jsp
```

### Tích Hợp với Booking
```
User đăng nhập → Xem tour → Click "Đặt tour" → BookingServlet
```

## 📊 Database

Module này sử dụng bảng `Tours` hiện có:
```sql
SELECT * FROM Tours WHERE IsActive = 1 ORDER BY TourName
```

Không cần tạo bảng mới.

## ✅ Checklist Hoàn Thành

- [x] Servlet ExploreServlet
- [x] JSP explore.jsp
- [x] Tìm kiếm tour
- [x] Lọc tour còn chỗ
- [x] Sắp xếp A-Z
- [x] Phân trang
- [x] Responsive design
- [x] Cập nhật header navigation
- [x] Cập nhật index.jsp
- [x] Guest không được đặt tour

## 🎉 Kết Quả

Module Khám Phá Tour đã hoàn thành với đầy đủ tính năng:
- ✅ Guest xem danh sách tour
- ✅ Tìm kiếm theo tên
- ✅ Lọc tour còn chỗ
- ✅ Sắp xếp A-Z
- ✅ Phân trang
- ✅ Responsive
- ✅ Guest chỉ xem, không đặt tour
