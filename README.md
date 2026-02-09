# Module: Quản lý Tour (Tour Management)

## 1. Mục tiêu
Module cốt lõi của hệ thống, quản lý toàn bộ vòng đời của một sản phẩm du lịch (Tour). Đảm bảo thông tin tour luôn chính xác, hấp dẫn và tự động kiểm soát tình trạng còn chỗ (availability).

## 2. Các chức năng đã hoàn thành
- ✔ Quản lý danh mục tour (CRUD)
- ✔ Tự động đóng/mở tour dựa trên ngày và số lượng slot trống
- ✔ Liên kết Tour với Nhà cung cấp (Provider)
- ✔ Giao diện Inventory Card với thanh trạng thái lấp đầy (Occupancy)
- ✔ Servlet: `TourServlet.java`
- ✔ JSP: `tour-list.jsp`, `tour-form.jsp`
- ✔ DAO/Entity: `TourDAO.java`, `Tour.java`

## 3. Cấu trúc thư mục
- `src/main/java/controller/TourServlet.java`: Xử lý logic nghiệp vụ thêm/sửa/xóa và lọc tour.
- `src/main/java/model/entity/Tour.java`: Chứa thông tin chi tiết tour (giá, lịch trình, ảnh, độ dài).
- `src/main/java/model/dao/TourDAO.java`: Chứa hàm `checkAvailability()` cực kỳ quan trọng để kiểm tra slot.
- `src/main/webapp/views/tour-management/`: Giao diện quản lý kho tour.

## 4. Luồng xử lý (Business Flow)
1. DB kiểm tra trạng thái: `TourDAO.checkAvailability(tourId, date, quantity)`.
2. Logic: Nếu (MaxPeople - Số khách đã đặt) >= quantity thì cho phép đặt.
3. Servlet cập nhật `IsActive` dựa trên kết quả kiểm tra.
4. Hiển thị badge trạng thái màu xanh (Active) hoặc đỏ (Paused) trên JSP.

## 5. Các chức năng CHƯA hoàn thành
- ❌ Tích hợp Google Maps để hiển thị vị trí bắt đầu tour.
- ❌ Hỗ trợ đa ngôn ngữ (Tiếng Anh/Tiếng Việt) cho mô tả tour.
- ❌ Batch Update (Cập nhật giá hàng loạt).

## 6. Hướng dẫn cho người phát triển tiếp
- Cần xây dựng trang `tour-detail.jsp` cho khách hàng xem chi tiết.
- Bổ sung bảng `TourImages` cho phép upload nhiều ảnh.
- Cải thiện logic AI để tự động điều chỉnh giá tour (Dynamic Pricing).

## 7. Ghi chú kỹ thuật
- **Phụ thuộc**: Phụ thuộc vào Module Provider Management.
- **Bảng DB chia sẻ**: `Tours`, `Bookings`.
- **Dữ liệu AI**: Cung cấp Occupancy rate cho AI Forecasting.