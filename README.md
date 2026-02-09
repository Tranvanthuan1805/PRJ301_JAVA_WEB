# Module: Dự báo nhu cầu bằng AI (AI Demand Forecasting)

## 1. Mục tiêu
Cung cấp dự báo kinh doanh thông minh cho các đối tác cao cấp. Sử dụng dữ liệu lịch sử và yếu tố mùa vụ để dự đoán doanh thu và đưa ra khuyến nghị hành động.

## 2. Các chức năng đã hoàn thành
- ✔ Biểu đồ dự báo doanh thu 12 tháng (Chart.js)
- ✔ Phân tích xu hướng mùa vụ (Jan - Dec)
- ✔ Đưa ra khuyến nghị tăng/giảm giá (AI Recommendations)
- ✔ Cảnh báo năng lực vận hành (Resource Warning)
- ✔ Servlet: `ForecastServlet.java`
- ✔ JSP: `forecast-dashboard.jsp`
- ✔ Integration: Gated access cho Pro users

## 3. Cấu trúc thư mục
- `src/main/java/controller/ForecastServlet.java`: Chứa thuật toán mô phỏng nhu cầu dựa trên các biến số mùa vụ.
- `src/main/webapp/views/ai-forecasting/forecast-dashboard.jsp`: Dashboard hiển thị biểu đồ và phân tích.

## 4. Luồng xử lý (Business Flow)
1. Servlet lấy dữ liệu doanh thu thực tế (hiện đang giả lập).
2. Áp dụng hệ số mùa vụ (Summer factor: 1.8x, Monsoon factor: 0.8x).
3. Trả về mảng JSON cho Chart.js vẽ biểu đồ.
4. Hiển thị "Confidence Score" dựa trên độ lệch chuẩn của dữ liệu.

## 5. Các chức năng CHƯA hoàn thành
- ❌ Kết nối với Python/TensorFlow API để dự báo thực tế.
- ❌ Tự động điều chỉnh giá tour dựa trên dự báo (Dynamic Pricing execution).
- ❌ Dự báo cho từng loại tour riêng biệt.

## 6. Hướng dẫn cho người phát triển tiếp
- Cần viết DAO để lấy dữ liệu thực từ bảng `Orders` trong 12 tháng qua.
- Tích hợp thêm dữ liệu thời tiết thực tế từ API bên ngoài.

## 7. Ghi chú kỹ thuật
- **Phụ thuộc**: Phụ thuộc vào Module Order Management và Subscription (để xác thực quyền).
- **Bảng DB chia sẻ**: `Orders`, `MonthlyRevenue`.
- **Dữ liệu AI**: Tiêu thụ dữ liệu từ toàn bộ hệ thống để tạo output.