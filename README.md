# Module: Quản lý Đơn hàng (Order Management)

## 1. Mục tiêu
Quản lý vòng đời của các giao dịch trên hệ thống, từ khi khách hàng đặt chỗ cho đến khi hoàn thành tour hoặc hủy đơn. Đây là module trung tâm để kiểm soát dòng tiền và xác nhận dịch vụ.

## 2. Các chức năng đã hoàn thành
- ✔ Theo dõi trạng thái đơn hàng (Pending, Confirmed, Completed, Cancelled)
- ✔ Xem chi tiết đơn hàng (Order Details) và các mục tour đi kèm
- ✔ Cập nhật trạng thái thủ công bởi Admin
- ✔ Ghi nhận xác thực thanh toán
- ✔ Servlet: `OrderServlet.java`
- ✔ JSP: `order-list.jsp`, `order-detail.jsp`
- ✔ DAO/Entity: `OrderDAO.java`, `Order.java`

## 3. Cấu trúc thư mục
- `src/main/java/controller/OrderServlet.java`: Quản lý danh sách giao dịch và quy trình xử lý đơn hàng.
- `src/main/java/model/entity/Order.java`: Chứa thông tin tổng quan (tổng tiền, khách hàng, ngày đặt).
- `src/main/java/model/dao/OrderDAO.java`: Truy vấn danh sách đơn hàng kèm tên khách hàng.
- `src/main/webapp/views/order-management/`: Giao diện quản trị giao dịch.

## 4. Luồng xử lý (Business Flow)
1. Admin truy cập Registry.
2. `OrderServlet` lấy dữ liệu JOIN từ `Orders` + `Users`.
3. Khi cập nhật trạng thái -> Servlet gọi `OrderDAO.updateOrderStatus()`.
4. Trạng thái "Completed" sẽ kích hoạt việc tính toán doanh thu trong tương lai.

## 5. Các chức năng CHƯA hoàn thành
- ❌ Tự động hoàn tiền (Refund handling) qua API ngân hàng.
- ❌ Xuất hóa đơn (Invoice PDF generation).
- ❌ Thông báo cho Provider khi có đơn hàng mới (Push Notifications).

## 6. Hướng dẫn cho người phát triển tiếp
- Cần kết nối với Module Subscription để trừ hoa hồng (commissions).
- Xây dựng logic tự động chuyển trạng thái "Completed" sau khi ngày tour kết thúc.

## 7. Ghi chú kỹ thuật
- **Phụ thuộc**: Nhận dữ liệu từ Module Cart & Booking.
- **Bảng DB chia sẻ**: `Orders`, `Bookings`.
- **Dữ liệu AI**: Cung cấp Volume giao dịch cho AI Forecasting.