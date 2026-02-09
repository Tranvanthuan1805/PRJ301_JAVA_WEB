# Module: Giỏ hàng và Đặt chỗ (Cart & Booking)

## 1. Mục tiêu
Xử lý quy trình đặt tour của khách hàng, duy trì trạng thái giỏ hàng trong phiên (session) và tiến hành đặt chỗ (booking) sau khi kiểm tra tính khả dụng.

## 2. Các chức năng đã hoàn thành
- ✔ Thêm tour vào giỏ hàng (Session-based Cart)
- ✔ Kiểm tra slot trống theo thời gian thực (Real-time slot validation)
- ✔ Quản lý số lượng và ngày khởi hành (Travel Date)
- ✔ Quy trình Checkout cơ bản
- ✔ Servlet: `CartServlet.java`, `CheckoutServlet.java`
- ✔ JSP: `cart.jsp`, `confirmation.jsp`
- ✔ DAO/Entity: `BookingDAO.java`, `Cart.java`, `CartItem.java`

## 3. Cấu trúc thư mục
- `src/main/java/controller/CartServlet.java`: Quản lý thêm/xóa/sửa tour trong giỏ hàng (session).
- `src/main/java/controller/CheckoutServlet.java`: Chuyển đổi dữ liệu giỏ hàng thành bản ghi `Orders` và `Bookings` trong DB.
- `src/main/java/model/entity/CartItem.java`: Đối tượng đại diện cho một tour đã chọn, kèm số khách và ngày đi.
- `src/main/webapp/views/cart-booking/`: Giao diện giỏ hàng và thanh toán.

## 4. Luồng xử lý (Business Flow)
1. Khách hàng chọn tour và ngày đi -> Gửi tới `CartServlet?action=add`.
2. Servlet gọi `TourDAO.checkAvailability()`. Nếu OK -> Lưu vào `session.getAttribute("cart_obj")`.
3. Khi Checkout -> `CheckoutServlet` tạo 1 `Order` mới, sau đó duyệt Cart để tạo nhiều `Booking` (line items) tương ứng.
4. Xóa session cart và chuyển tới `confirmation.jsp`.

## 5. Các chức năng CHƯA hoàn thành
- ❌ Lưu giỏ hàng vào DB (Abandoned Cart) để nhắc nhở khách hàng.
- ❌ Áp dụng Mã giảm giá (Promo Code).
- ❌ Thay đổi ngày đi ngay trong giỏ hàng.

## 6. Hướng dẫn cho người phát triển tiếp
- Tích hợp Module Payment (/payment) vào cuối quy trình Checkout.
- Bổ sung validation số lượng khách không vượt quá `MaxPeople`.

## 7. Ghi chú kỹ thuật
- **Phụ thuộc**: Phụ thuộc cực lớn vào Module Quản lý Tour.
- **Bảng DB chia sẻ**: `Orders`, `Bookings`, `Tours`.
- **Dữ liệu AI**: Cung cấp dữ liệu Giỏ hàng bị bỏ rơi (Abandoned Carts) cho AI Marketing.