# HƯỚNG DẪN CÀI ĐẶT & SỬ DỤNG AI MODULE - EZTRAVEL

## 1. Giới thiệu
Hệ thống EzTravel tích hợp AI (Trí tuệ nhân tạo) để tối ưu hóa trải nghiệm người dùng và hỗ trợ quản trị viên:
- **EzTravel AI Chatbot**: Trợ lý tư vấn du lịch 24/7.
- **AI Analytics Dashboard**: Phân tích dự báo doanh thu và xu hướng du lịch.

## 2. Thư viện & Công nghệ sử dụng
- **Backend**: Java Servlet (Jakarta EE).
- **AI Engine**: Groq Cloud API (Llama 3.3 70B Versatile).
- **Network**: `HttpURLConnection`, `JPA (Hibernate)` để lưu log Chat.
- **Frontend**: JavaScript (Ajax Fetch API), Chart.js (cho dashboard).

## 3. Cách cài đặt & Chạy module AI
1. **API Key**: Đảm bảo biến môi trường `GROQ_API_KEY` đã được thiết lập hoặc sử dụng key mặc định trong `AIChatServlet.java`.
2. **Cấu hình Servlet**: Module AI chạy tại endpoint `/ai/chat`.
3. **Database**: Chạy tập lệnh SQL trong thư mục `3_Database` để tạo bảng `ChatbotLog` và `AILog` giúp lưu trữ lịch sử.
4. **Deploy**: Build dự án bằng Maven (`mvn clean package`) và deploy vào Tomcat 10.

## 4. Video mô tả Flow
(Video minh họa đính kèm hoặc link Youtube: [Insert Link Here])
- **Flow Chatbot**: User gửi tin nhắn -> Servlet gọi Groq API -> Trả phản hồi tiếng Việt -> Lưu log vào DB.
- **Flow Analytics**: Admin truy cập Dashboard -> Hệ thống tổng hợp data từ Tour/Booking -> AI phân tích xu hướng -> Hiển thị biểu đồ.

## 5. Dataset & Kết quả Test
- **Dataset**: Sử dụng dữ liệu lịch sử Booking và Tour trong hệ thống.
- **Kết quả**: Chatbot phản hồi đúng ngữ cảnh du lịch Đà Nẵng với độ trễ < 2s. Dashboard hiển thị chính xác các tour "hot".
