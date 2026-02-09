# Module: Quản lý Khách hàng (Customer Management)

## 1. Mục tiêu
Quản lý hồ sơ khách hàng, theo dõi hành vi đặt chỗ và cung cấp các chỉ số CRM (Customer Relationship Management) để cá nhân hóa dịch vụ.

## 2. Các chức năng đã hoàn thành
- ✔ Danh sách khách hàng với các chỉ số chi tiêu (Lifetime Spend)
- ✔ Xem chi tiết hồ sơ khách hàng (Customer Detail)
- ✔ Ghi nhận lịch sử đặt chỗ gần nhất
- ✔ Phân loại khách hàng theo giá trị (Loyalty Tiering)
- ✔ Servlet: `CustomerServlet.java`
- ✔ JSP: `customer-list.jsp`, `customer-detail.jsp`
- ✔ DAO/Entity: `CustomerDAO.java`, `Customer.java` (kế thừa từ `User.java`)

## 3. Cấu trúc thư mục
- `src/main/java/controller/CustomerServlet.java`: Xử lý hiển thị danh sách và chi tiết khách hàng.
- `src/main/java/model/entity/Customer.java`: Mở rộng thực thể `User` với các trường `totalSpent`, `totalOrders`.
- `src/main/java/model/dao/CustomerDAO.java`: Sử dụng sub-queries để tính toán các chỉ số CRM theo thời gian thực.
- `src/main/webapp/views/customer-management/`: Giao diện quản trị khách hàng.

## 4. Luồng xử lý (Business Flow)
1. Admin click "View Profile" trên danh sách khách hàng.
2. Request gửi tới `CustomerServlet?action=view&id=...`.
3. Servlet gọi `CustomerDAO.getCustomerById()` - hàm này thực hiện JOIN và sub-select để lấy thống kê chi tiêu.
4. Servlet trả về `customer-detail.jsp` với thuộc tính `customer`.

## 5. Các chức năng CHƯA hoàn thành
- ❌ Chức năng Banned/Unbanned trực tiếp từ giao diện.
- ❌ Gửi Mã giảm giá (Discount Codes) qua Email cho khách hàng thân thiết.
- ❌ Phân tích hành vi log-in thất bại (Security Audit).

## 6. Hướng dẫn cho người phát triển tiếp
- Tích hợp thêm bảng `Preferences` để khách hàng chọn sở thích du lịch.
- Cải thiện API dự đoán "Predicted Booking Window" bằng AI.

## 7. Ghi chú kỹ thuật
- **Phụ thuộc**: Phụ thuộc vào Module Quản lý Đơn hàng để tính `totalSpent`.
- **Bảng DB chia sẻ**: `Users`, `Orders`.
- **Dữ liệu AI**: Cung cấp Preferred Category và chi tiêu cho AI Forecasting.