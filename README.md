# Module: Chatbot Hỗ trợ Doanh nghiệp (AI Chatbot Assistant)

## 1. Mục tiêu
Cung cấp giao diện tương tác ngôn ngữ tự nhiên để đối tác truy vấn nhanh các báo cáo kinh doanh và nhận hỗ trợ ra quyết định mà không cần xem biểu đồ phức tạp.

## 2. Các chức năng đã hoàn thành
- ✔ Giao diện Chat nổi (Floating Chat UI)
- ✔ Xử lý câu hỏi về Doanh thu, Khuyến nghị và Thời tiết
- ✔ Phản hồi thời gian thực qua Fetch API
- ✔ Trạng thái Loading (Data analyzing)
- ✔ Servlet: `ChatbotServlet.java`
- ✔ JSP: `chatbot.jsp` (Include component)

## 3. Cấu trúc thư mục
- `src/main/java/controller/ChatbotServlet.java`: Phân tích từ khóa câu hỏi và trả về câu trả lời thông minh.
- `src/main/webapp/views/ai-chatbot/chatbot.jsp`: UI Component có thể nhúng vào bất kỳ trang nào.

## 4. Luồng xử lý (Business Flow)
1. User nhập "Hôm nay doanh thu thế nào?".
2. `chatbot.jsp` gửi POST request tới `/chat`.
3. Servlet phân tích từ khóa "doanh thu".
4. Phản hồi JSON: `{"response": "Dự báo tăng 12%..."}`.
5. UI hiển thị bóng hội thoại (chat bubble).

## 5. Các chức năng CHƯA hoàn thành
- ❌ Tích hợp OpenAI/Gemini API để trò chuyện tự do.
- ❌ Lưu lịch sử chat của User.
- ❌ Giọng nói (Text-to-Speech).

## 6. Hướng dẫn cho người phát triển tiếp
- Cần bổ sung logic phân tích SQL từ câu hỏi tự nhiên (Text-to-SQL).
- Nâng cấp UI để hỗ trợ đính kèm file báo cáo.

## 7. Ghi chú kỹ thuật
- **Phụ thuộc**: Phụ thuộc vào dữ liệu từ Module Order và Forecast.
- **Bảng DB chia sẻ**: `AILogs` (để lưu hội thoại).
- **Dữ liệu AI**: Cung cấp insight trực tiếp cho người dùng.