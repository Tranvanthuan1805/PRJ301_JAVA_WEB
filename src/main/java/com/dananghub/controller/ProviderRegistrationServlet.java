package com.dananghub.controller;

import com.dananghub.dao.ProviderRegistrationDAO;
import com.dananghub.entity.ProviderRegistration;
import com.dananghub.entity.User;
import com.dananghub.websocket.NotificationWebSocket;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet nhận POST AJAX từ form đăng ký NCC.
 * URL: POST /api/provider/register
 * Content-Type: application/json
 * Response: {"success": true/false, "message": "..."}
 */
@WebServlet("/api/provider/register")
public class ProviderRegistrationServlet extends HttpServlet {

    private final ProviderRegistrationDAO dao = new ProviderRegistrationDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Kiểm tra đăng nhập
            HttpSession session = request.getSession(false);
            User user = session != null ? (User) session.getAttribute("user") : null;
            if (user == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.print("{\"success\":false,\"message\":\"Vui lòng đăng nhập trước.\"}");
                return;
            }

            // Đọc JSON body
            StringBuilder sb = new StringBuilder();
            try (var reader = request.getReader()) {
                String line;
                while ((line = reader.readLine()) != null)
                    sb.append(line);
            }

            // Parse thủ công — tránh thêm dependency Gson chỉ để parse 4 field
            String body = sb.toString();
            String businessName = extractJson(body, "businessName");
            String category = extractJson(body, "category");
            String phone = extractJson(body, "phone");
            String description = extractJson(body, "description");

            // Validate server-side
            if (businessName == null || businessName.isBlank()) {
                out.print("{\"success\":false,\"message\":\"Tên doanh nghiệp không được để trống.\"}");
                return;
            }
            if (category == null || category.isBlank()) {
                out.print("{\"success\":false,\"message\":\"Vui lòng chọn loại hình.\"}");
                return;
            }
            if (phone == null || !phone.matches("^(0|\\+84)[0-9]{8,10}$")) {
                out.print("{\"success\":false,\"message\":\"Số điện thoại không hợp lệ.\"}");
                return;
            }
            if (businessName.length() > 255) {
                out.print("{\"success\":false,\"message\":\"Tên doanh nghiệp tối đa 255 ký tự.\"}");
                return;
            }

            // Kiểm tra đã có đơn pending chưa
            if (dao.hasPendingByUser(user.getUserId())) {
                out.print("{\"success\":false,\"message\":\"Bạn đã có đơn đang chờ xét duyệt.\"}");
                return;
            }

            // Tạo và lưu đơn
            ProviderRegistration reg = new ProviderRegistration();
            reg.setUser(user);
            reg.setBusinessName(businessName.trim());
            reg.setCategory(category.trim());
            reg.setPhone(phone.trim());
            reg.setDescription(description != null ? description.trim() : "");

            int newId = dao.save(reg);
            if (newId < 0) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"success\":false,\"message\":\"Lỗi hệ thống, vui lòng thử lại.\"}");
                return;
            }

            // Broadcast WebSocket đến admin
            long pendingCount = dao.countPending();
            NotificationWebSocket.broadcastNewProvider(pendingCount, businessName);

            out.print("{\"success\":true,\"message\":\"Đăng ký thành công! Vui lòng chờ admin xét duyệt.\"}");

        } catch (Exception e) {
            e.printStackTrace(); // log ra Tomcat console để debug
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\":false,\"message\":\"Lỗi server: " + e.getMessage().replace("\"", "'") + "\"}");
        }
    }

    /**
     * Trích xuất giá trị string từ JSON thô (không dùng thư viện).
     * Chỉ dùng cho JSON đơn giản, flat object.
     */
    private String extractJson(String json, String key) {
        String search = "\"" + key + "\"";
        int idx = json.indexOf(search);
        if (idx < 0)
            return null;
        int colon = json.indexOf(':', idx + search.length());
        if (colon < 0)
            return null;
        int start = json.indexOf('"', colon + 1);
        if (start < 0)
            return null;
        int end = json.indexOf('"', start + 1);
        // Xử lý escaped quote
        while (end > 0 && json.charAt(end - 1) == '\\') {
            end = json.indexOf('"', end + 1);
        }
        if (end < 0)
            return null;
        return json.substring(start + 1, end)
                .replace("\\\"", "\"")
                .replace("\\n", "\n")
                .replace("\\\\", "\\");
    }
}
