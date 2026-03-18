# Review: Realtime trong Giỏ Hàng & Booking

## 1. REALTIME HIỆN TẠI

### A. CartService - Xử Lý Realtime (Dòng 26-140)

#### **1.1 refreshPrices() - Cập nhật giá realtime (Dòng 26-42)**
```java
public List<CartItem> refreshPrices(List<CartItem> cart) {
    for (CartItem item : cart) {
        Tour currentTour = tourDAO.findById(item.getTour().getTourId());
        if (currentTour != null) {
            // Cập nhật giá mới từ DB
            item.getTour().setPrice(currentTour.getPrice());
            item.setTotalPrice(currentTour.getPrice() * item.getQuantity());
        }
    }
}
```
**Realtime thể hiện ở đâu:**
- ✅ Mỗi lần xem giỏ hàng, gọi `tourDAO.findById()` để lấy giá **mới nhất từ DB**
- ✅ So sánh với giá trong session, nếu khác thì cập nhật
- ✅ Tính lại `totalPrice = price * quantity`

**Dòng code realtime:**
- Dòng 31: `Tour currentTour = tourDAO.findById(item.getTour().getTourId());` → Truy vấn DB
- Dòng 33-34: Cập nhật giá mới

---

#### **1.2 validateAvailability() - Kiểm tra chỗ còn trống realtime (Dòng 48-67)**
```java
public List<CartItem> validateAvailability(List<CartItem> cart) {
    for (CartItem item : cart) {
        // Kiểm tra realtime từ DB
        boolean isAvailable = tourDAO.checkAvailability(
            item.getTour().getTourId(),
            item.getTravelDate(),
            item.getQuantity()
        );
        if (!isAvailable) {
            unavailableItems.add(item);
        }
    }
}
```
**Realtime thể hiện ở đâu:**
- ✅ Gọi `tourDAO.checkAvailability()` để kiểm tra **số chỗ còn trống theo ngày cụ thể**
- ✅ Truy vấn DB: `SELECT maxPeople, SUM(booked) WHERE date = ?`
- ✅ Tính: `available = maxPeople - booked`

**Dòng code realtime:**
- Dòng 57-62: `tourDAO.checkAvailability()` → Truy vấn DB realtime

---

#### **1.3 getCartDetail() - Lấy thông tin chi tiết giỏ hàng (Dòng 126-165)**
```java
public CartDetailDTO getCartDetail(List<CartItem> cart) {
    // Cập nhật giá realtime
    List<CartItem> updatedCart = refreshPrices(cart);
    
    // Kiểm tra availability realtime
    List<CartItem> unavailable = validateAvailability(updatedCart);
    
    // Trả về DTO với tất cả thông tin
    detail.setItems(updatedCart);
    detail.setTotal(calculateTotal(updatedCart));
    detail.setUnavailableItems(unavailable);
}
```
**Realtime thể hiện ở đâu:**
- ✅ Dòng 137: Gọi `refreshPrices()` → Cập nhật giá
- ✅ Dòng 140: Gọi `validateAvailability()` → Kiểm tra chỗ trống
- ✅ Dòng 143-145: Trả về DTO với dữ liệu mới nhất

---

### B. BookingServlet - Kiểm tra Realtime Khi Đặt Tour (Dòng 118-124)

```java
// 2. CHECK CAPACITY & AVAILABILITY (Overbooking fix)
boolean isAvailable = tourDAO.checkAvailability(tourId, travelDate, numberOfPeople);
if (!isAvailable) {
    session.setAttribute("error", "Tour này không còn đủ " + numberOfPeople + " chỗ...");
    response.sendRedirect(request.getContextPath() + "/booking?id=" + tourId);
    return;
}
```
**Realtime thể hiện ở đâu:**
- ✅ Dòng 118: Gọi `tourDAO.checkAvailability()` → Kiểm tra **realtime** trước khi tạo order
- ✅ Nếu hết chỗ → Từ chối đặt tour
- ✅ Nếu còn chỗ → Tạo order

---

### C. TourDAO - Truy Vấn DB Realtime (Dòng 97-113)

```java
public boolean checkAvailability(int tourId, Date travelDate, int requestedSlots) {
    Object[] result = (Object[]) em.createQuery(
        "SELECT t.maxPeople, COALESCE(SUM(b.quantity), 0) " +
        "FROM Tour t LEFT JOIN Booking b ON t.tourId = b.tour.tourId " +
        "AND b.bookingStatus = 'Confirmed' AND CAST(b.bookingDate AS date) = CAST(:date AS date) " +
        "WHERE t.tourId = :tid AND t.isActive = true " +
        "GROUP BY t.maxPeople")
        .setParameter("date", travelDate)
        .setParameter("tid", tourId)
        .getSingleResult();

    int max = ((Number) result[0]).intValue();
    int booked = ((Number) result[1]).intValue();
    return (max - booked) >= requestedSlots;
}
```
**Realtime thể hiện ở đâu:**
- ✅ Dòng 101-107: **Truy vấn DB realtime** để lấy:
  - `maxPeople` = số chỗ tối đa
  - `SUM(booked)` = số chỗ đã đặt (chỉ Confirmed)
- ✅ Dòng 110-111: Tính `available = max - booked`
- ✅ Dòng 112: Kiểm tra `available >= requestedSlots`

---

## 2. REALTIME vs KHÔNG REALTIME - KHÁC GÌ?

### **Realtime (Hiện Tại):**
```
User xem giỏ hàng
    ↓
CartService.getCartDetail()
    ↓
refreshPrices() → Truy vấn DB lấy giá mới
validateAvailability() → Truy vấn DB kiểm tra chỗ trống
    ↓
Hiển thị giỏ hàng với:
- Giá mới nhất (nếu admin thay đổi)
- Chỗ trống mới nhất (nếu có booking khác)
- Cảnh báo nếu tour hết chỗ
```

### **Không Realtime (Nếu không có CartService):**
```
User xem giỏ hàng
    ↓
Lấy dữ liệu từ session (lưu lúc thêm vào giỏ)
    ↓
Hiển thị giỏ hàng với:
- Giá cũ (không cập nhật)
- Chỗ trống cũ (không kiểm tra)
- Có thể cho checkout dù tour đã hết chỗ
```

### **Ví Dụ Cụ Thể:**

| Tình Huống | Realtime | Không Realtime |
|-----------|---------|---------------|
| Admin thay giá tour từ 500k → 600k | Giỏ hàng cập nhật 600k | Vẫn hiển thị 500k |
| Tour có 10 chỗ, user thêm 5 chỗ vào giỏ | Kiểm tra: còn 5 chỗ | Không kiểm tra |
| Người khác đặt 5 chỗ, tour còn 0 chỗ | Cảnh báo: hết chỗ | Cho checkout dù hết chỗ |
| User checkout | Kiểm tra lại trước tạo order | Tạo order ngay (có thể fail) |

---

## 3. LUỒNG REALTIME CHI TIẾT

### **Khi User Xem Giỏ Hàng:**
```
GET /cart
    ↓
CartServlet.showCart()
    ↓
session.getAttribute("cart") → Lấy từ session
    ↓
CartService.getCartDetail(cart)
    ├─ refreshPrices(cart)
    │  └─ tourDAO.findById() × N → Truy vấn DB N lần
    │     (N = số item trong giỏ)
    │
    └─ validateAvailability(cart)
       └─ tourDAO.checkAvailability() × N → Truy vấn DB N lần
          (Kiểm tra chỗ trống theo ngày)
    ↓
Hiển thị cart.jsp với dữ liệu mới nhất
```

### **Khi User Đặt Tour (Booking):**
```
POST /booking
    ↓
BookingServlet.doPost()
    ↓
tourDAO.checkAvailability(tourId, travelDate, numberOfPeople)
    ├─ Truy vấn DB: SELECT maxPeople, SUM(booked)
    └─ Kiểm tra: available >= numberOfPeople?
    ↓
Nếu còn chỗ:
    ├─ OrderDAO.create() → Tạo order
    ├─ BookingDAO.create() → Tạo booking
    └─ Hiển thị QR thanh toán
    ↓
Nếu hết chỗ:
    └─ Hiển thị lỗi + Redirect
```

---

## 4. ĐIỂM REALTIME TRONG CODE

| Điểm | Nơi | Dòng | Mô Tả |
|-----|-----|-----|-------|
| **Cập nhật giá** | CartService.refreshPrices() | 31 | `tourDAO.findById()` |
| **Kiểm tra chỗ trống** | CartService.validateAvailability() | 57-62 | `tourDAO.checkAvailability()` |
| **Lấy chi tiết giỏ** | CartService.getCartDetail() | 137, 140 | Gọi 2 method trên |
| **Kiểm tra trước đặt** | BookingServlet.doPost() | 118 | `tourDAO.checkAvailability()` |
| **Truy vấn DB** | TourDAO.checkAvailability() | 101-107 | SQL query realtime |

---

## 5. HIỆU SUẤT REALTIME

### **Vấn Đề Hiện Tại:**
- ❌ Mỗi lần xem giỏ hàng → Truy vấn DB N lần (N = số item)
- ❌ Nếu giỏ có 10 item → 10 lần `findById()` + 10 lần `checkAvailability()`
- ❌ Có thể chậm nếu DB lớn

### **Cải Thiện:**
- ✅ Cache giá tour (TTL 5 phút)
- ✅ Batch query: `findByIds()` thay vì loop `findById()`
- ✅ Chỉ kiểm tra availability khi checkout, không phải mỗi lần xem

---

## 6. KẾT LUẬN

**Realtime hiện tại:**
- ✅ Cập nhật giá realtime từ DB
- ✅ Kiểm tra chỗ trống realtime theo ngày
- ✅ Kiểm tra trước khi tạo order (chống overbooking)
- ⚠️ Hiệu suất có thể cải thiện bằng cache

**Không realtime:**
- ❌ Giá cũ từ session
- ❌ Chỗ trống cũ từ session
- ❌ Có thể tạo order dù tour hết chỗ
