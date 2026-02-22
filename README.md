# Module: Đăng ký thành viên và Thanh toán (Subscription & Payment)

## 1. Mục tiêu
Mô hình hóa doanh thu của nền tảng bằng các gói dịch vụ (Subscriptions) dành cho đối tác. Module này kiểm soát quyền truy cập vào các tính năng cao cấp như AI Intelligence.

## 2. Các chức năng đã hoàn thành
- ✔ Bảng giá đa tầng (Explorer, Professional, Elite)
- ✔ Mô phỏng thanh toán qua mã QR (Bank Transfer Simulation)
- ✔ Ghi nhận và quản lý kỳ hạn Subscription
- ✔ Phân quyền tính năng dựa trên Plan (Gated Access)
- ✔ Servlet: `PaymentServlet.java`
- ✔ JSP: `pricing.jsp`, `payment.jsp`
- ✔ DAO/Entity: `SubscriptionDAO.java`, `Subscription.java`

## 3. Cấu trúc thư mục
- `src/main/java/controller/PaymentServlet.java`: Xử lý chọn gói và xác thực thanh toán giả lập.
- `src/main/java/model/dao/SubscriptionDAO.java`: Kiểm tra trạng thái "Active" của gói dịch vụ.
- `src/main/webapp/views/subscription-payment/`: Giao diện thanh toán và bảng giá.

## 4. Luồng xử lý (Business Flow)
1. Đối tác vào `pricing.jsp` -> Chọn gói "Pro".
2. Hệ thống tạo QR code mô phỏng tại `payment.jsp`.
3. Khi nhấn "Confirm", `PaymentServlet` lưu bản ghi vào `ProviderSubscriptions` với hiệu lực 30 ngày.
4. Session cập nhật `user_plan = 'Professional'`, mở khóa menu "AI Forecast".

## 5. Các chức năng CHƯA hoàn thành
- ❌ Tích hợp API SePay thực tế để tự động xác nhận chuyển khoản.
- ❌ Tự động gia hạn (Auto-renewal).
- ❌ Quản lý lịch sử hóa đơn (Billing History).

## 6. Hướng dẫn cho người phát triển tiếp
- Cần bổ sung Webhook listener để nhận thông báo từ ngân hàng.
- Nâng cấp logic hết hạn gói để tự động hạ cấp (downgrade) tài khoản.

## 7. Ghi chú kỹ thuật
- **Phụ thuộc**: Độc lập, nhưng cung cấp quyền cho các module AI.
- **Bảng DB chia sẻ**: `ProviderSubscriptions`, `Users`.
- **Dữ liệu AI**: Kiểm soát lưu lượng truy cập Chatbot và Forecasting.