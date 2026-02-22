# Module: Quản lý Nhà cung cấp (Provider Management)

## 1. Mục tiêu
Module này quản lý danh sách các đối tác (Khách sạn, Hãng hàng không, Đơn vị vận chuyển) trong hệ thống Da Nang Travel Hub. Nó cho phép Admin theo dõi hiệu suất, xác minh đối tác và so sánh giá cả để tối ưu hóa lợi nhuận.

## 2. Các chức năng đã hoàn thành
- ✔ Quản lý danh sách đối tác (CRUD)
- ✔ Xác minh đối tác (Verification Status)
- ✔ So sánh giá (Price Comparison Tool)
- ✔ Thống kê số lượng tour của từng đối tác
- ✔ Servlet: `ProviderServlet.java`
- ✔ JSP: `provider-list.jsp`, `price-comparison.jsp`
- ✔ DAO/Entity: `ProviderDAO.java`, `Provider.java`

## 3. Cấu trúc thư mục
- `src/main/java/controller/ProviderServlet.java`: Điều phối luồng xử lý CRUD và so sánh giá.
- `src/main/java/model/entity/Provider.java`: Định nghĩa thông tin nhà cung cấp (tên, giấy phép, rating, loại hình).
- `src/main/java/model/dao/ProviderDAO.java`: Thực hiện truy vấn SQL (CRUD, thống kê).
- `src/main/webapp/views/provider-management/`: Chứa các giao diện hiển thị.

## 4. Luồng xử lý (Business Flow)
1. Người dùng truy cập `/admin/providers`.
2. `ProviderServlet` nhận request, gọi `ProviderDAO.getAllProviders()`.
3. `ProviderDAO` lấy dữ liệu từ bảng `Providers` và map vào danh sách `Provider` entity.
4. Servlet chuyển tiếp (forward) dữ liệu sang `provider-list.jsp` để hiển thị.

## 5. Các chức năng CHƯA hoàn thành
- ❌ Tự động gửi Email thông báo khi đối tác được xác minh.
- ❌ Validation biểu mẫu đăng ký đối tác (yêu cầu regex cho Business License).
- ❌ UI/UX: Biểu đồ xu hướng giá trong trang so sánh cần kết nối API thực tế.

## 6. Hướng dẫn cho người phát triển tiếp
- Cần bổ sung logic upload ảnh giấy phép kinh doanh.
- Bổ sung bảng `ProviderReviews` để khách hàng đánh giá đối tác.
- Cải thiện logic AI so sánh giá dựa trên dữ liệu lịch sử.

## 7. Ghi chú kỹ thuật
- **Phụ thuộc**: Module này là nền tảng cho Module Quản lý Tour.
- **Bảng DB chia sẻ**: `Users` (mỗi Provider là một User với Role cụ thể).
- **Dữ liệu AI**: Cung cấp Rating và Performance data cho AI Forecasting.
