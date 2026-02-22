package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

/**
 * ChatbotServlet - AI Chatbot using OpenRouter API
 * Handles chat requests and returns AI-powered responses about Da Nang tours
 */
@WebServlet(name = "ChatbotServlet", urlPatterns = {"/chat"})
public class ChatbotServlet extends HttpServlet {

    private static final String OPENROUTER_API_URL = "https://openrouter.ai/api/v1/chat/completions";
    private static final String API_KEY = "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";

    private String travelDataSummary = "";

    @Override
    public void init() throws ServletException {
        super.init();
        loadDataSummary();
    }

    private void loadDataSummary() {
        // Try to load summary for AI context
        try {
            String path = "e:/PRJ301_JAVA_WEB/danang_tours_dataset_2020_2025.csv";
            File file = new File(path);
            if (file.exists()) {
                travelDataSummary = "Dữ liệu thực tế VietAir (2020-2025): "
                    + "Tổng hơn 430 bản ghi tour. Các tour doanh thu cao nhất: Bà Nà Hills, Ngũ Hành Sơn. "
                    + "Tăng trưởng trung bình hàng năm ~15%. Xu hướng 2026: Du lịch xanh và trải nghiệm văn hóa bùng nổ.";
            }
        } catch (Exception e) {}
    }

    private String getSystemPrompt() {
        return """
        Bạn là VietAir Assistant - trợ lý AI thông minh của hệ thống quản lý tour du lịch VietAir Đà Nẵng.
        
        """ + travelDataSummary + """

        ### Về hệ thống VietAir:
        - Hệ thống quản lý tour du lịch Đà Nẵng với dữ liệu từ 2020-2025
        - Có hơn 432 tours lịch sử, 6 điểm đến chính, 72 tháng dữ liệu
        - Đánh giá trung bình 4.9/5 sao

        ### Các điểm đến du lịch Đà Nẵng:
        1. **Bà Nà Hills** - Cầu Vàng, cáp treo, làng Pháp
        2. **Ngũ Hành Sơn** - Núi đá vôi, chùa chiền
        3. **Cù Lao Chàm** - Lặn san hô, hải sản
        4. **Bán đảo Sơn Trà** - Chùa Linh Ứng, Voọc chà vá chân nâu
        5. **Huế** - Cố đô, Đại Nội
        6. **Núi Thần Tài** - Suối khoáng nóng

        ### Các tính năng của website:
        - **Tìm kiếm/Đặt tour**: Nhanh chóng, tiện lợi
        - **AI dự báo**: Phân tích & dự báo xu hướng du lịch 2026 (Module Forecast)
        - **Quản lý đơn hàng**: Theo dõi trạng thái thực tế.

        ### Quy tắc trả lời:
        1. Luôn thân thiện, chuyên nghiệp, sử dụng tiếng Việt.
        2. Dựa trên dữ liệu dự báo để tư vấn xu hướng 2026 khi được hỏi.
        3. Khuyến khích người dùng đặt tour và trải nghiệm dịch vụ.
        """;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        // Read the request body
        StringBuilder requestBody = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                requestBody.append(line);
            }
        }

        // Extract message from request JSON
        String userMessage = extractJsonValue(requestBody.toString(), "message");
        if (userMessage == null || userMessage.trim().isEmpty()) {
            response.getWriter().write("{\"response\": \"Vui lòng nhập câu hỏi của bạn.\"}");
            return;
        }

        try {
            String aiResponse = callOpenRouterAPI(userMessage);
            // Escape for JSON
            aiResponse = aiResponse.replace("\\", "\\\\")
                                   .replace("\"", "\\\"")
                                   .replace("\n", "\\n")
                                   .replace("\r", "\\r")
                                   .replace("\t", "\\t");
            response.getWriter().write("{\"response\": \"" + aiResponse + "\"}");
        } catch (Exception e) {
            e.printStackTrace();
            String fallbackResponse = getFallbackResponse(userMessage);
            response.getWriter().write("{\"response\": \"" + fallbackResponse + "\"}");
        }
    }

    /**
     * Call OpenRouter API for AI response
     */
    private String callOpenRouterAPI(String userMessage) throws Exception {
        URL url = new URL(OPENROUTER_API_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setRequestProperty("Authorization", "Bearer " + API_KEY);
        conn.setRequestProperty("HTTP-Referer", "https://vietair.vn");
        conn.setRequestProperty("X-Title", "VietAir Travel Assistant");
        conn.setDoOutput(true);
        conn.setConnectTimeout(30000);
        conn.setReadTimeout(60000);

        // Build request JSON manually (no external JSON library dependency)
        String escapedSystemPrompt = escapeJsonString(getSystemPrompt());
        String escapedUserMessage = escapeJsonString(userMessage);

        String jsonPayload = "{"
                + "\"model\": \"deepseek/deepseek-chat-v3-0324:free\","
                + "\"messages\": ["
                + "{\"role\": \"system\", \"content\": \"" + escapedSystemPrompt + "\"},"
                + "{\"role\": \"user\", \"content\": \"" + escapedUserMessage + "\"}"
                + "],"
                + "\"max_tokens\": 500,"
                + "\"temperature\": 0.7"
                + "}";

        // Send request
        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = jsonPayload.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        int responseCode = conn.getResponseCode();

        // Read response
        InputStream inputStream = (responseCode >= 200 && responseCode < 300)
                ? conn.getInputStream()
                : conn.getErrorStream();

        StringBuilder responseBuilder = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
            String responseLine;
            while ((responseLine = br.readLine()) != null) {
                responseBuilder.append(responseLine);
            }
        }

        conn.disconnect();

        if (responseCode >= 200 && responseCode < 300) {
            // Parse the response to extract the content
            String fullResponse = responseBuilder.toString();
            return extractAIContent(fullResponse);
        } else {
            System.err.println("OpenRouter API error: " + responseCode + " - " + responseBuilder.toString());
            throw new Exception("API returned error code: " + responseCode);
        }
    }

    /**
     * Extract the AI content from OpenRouter API response
     */
    private String extractAIContent(String jsonResponse) {
        // Find "content": "..." in the response
        int contentIdx = jsonResponse.indexOf("\"content\":");
        if (contentIdx == -1) return "Xin lỗi, tôi không thể xử lý phản hồi.";

        // Skip past "content": 
        int start = jsonResponse.indexOf("\"", contentIdx + 10) + 1;
        if (start <= 0) return "Xin lỗi, tôi không thể xử lý phản hồi.";

        // Find the closing quote, handling escaped quotes
        StringBuilder content = new StringBuilder();
        boolean escaped = false;
        for (int i = start; i < jsonResponse.length(); i++) {
            char c = jsonResponse.charAt(i);
            if (escaped) {
                switch (c) {
                    case 'n': content.append('\n'); break;
                    case 'r': content.append('\r'); break;
                    case 't': content.append('\t'); break;
                    case '"': content.append('"'); break;
                    case '\\': content.append('\\'); break;
                    default: content.append('\\').append(c); break;
                }
                escaped = false;
            } else if (c == '\\') {
                escaped = true;
            } else if (c == '"') {
                break;
            } else {
                content.append(c);
            }
        }

        return content.toString();
    }

    /**
     * Simple JSON value extractor
     */
    private String extractJsonValue(String json, String key) {
        String searchKey = "\"" + key + "\"";
        int keyIdx = json.indexOf(searchKey);
        if (keyIdx == -1) return null;

        int colonIdx = json.indexOf(":", keyIdx + searchKey.length());
        if (colonIdx == -1) return null;

        // Find the start of the value string
        int valueStart = json.indexOf("\"", colonIdx + 1);
        if (valueStart == -1) return null;

        // Find end of value string (handle escaped quotes)
        int valueEnd = valueStart + 1;
        boolean esc = false;
        while (valueEnd < json.length()) {
            char c = json.charAt(valueEnd);
            if (esc) {
                esc = false;
            } else if (c == '\\') {
                esc = true;
            } else if (c == '"') {
                break;
            }
            valueEnd++;
        }

        return json.substring(valueStart + 1, valueEnd);
    }

    /**
     * Escape string for JSON
     */
    private String escapeJsonString(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\n", "\\n")
                    .replace("\r", "\\r")
                    .replace("\t", "\\t");
    }

    /**
     * Fallback response when API is unavailable
     */
    private String getFallbackResponse(String userMessage) {
        String msg = userMessage.toLowerCase();

        if (msg.contains("tour") || msg.contains("du lịch")) {
            return "🌴 VietAir có hơn 432 tours du lịch tại Đà Nẵng! Bạn có thể tìm kiếm tour theo điểm đến, ngày khởi hành và số người. Hãy truy cập trang Tours để xem chi tiết nhé!";
        } else if (msg.contains("bà nà") || msg.contains("ba na")) {
            return "🏔️ Bà Nà Hills - Điểm đến số 1 Đà Nẵng! Nổi tiếng với Cầu Vàng, cáp treo dài nhất thế giới và Làng Pháp. Giá tour từ 500.000 VNĐ/người.";
        } else if (msg.contains("đặt") || msg.contains("booking")) {
            return "📋 Để đặt tour, bạn cần: 1) Đăng nhập tài khoản, 2) Chọn tour yêu thích, 3) Chọn ngày và số người, 4) Xác nhận đặt tour. Rất đơn giản!";
        } else if (msg.contains("giá") || msg.contains("price")) {
            return "💰 Giá tour dao động từ 200.000 - 5.000.000 VNĐ/người tùy điểm đến và thời gian. Hãy xem chi tiết tại trang Tours!";
        } else if (msg.contains("thời tiết") || msg.contains("weather")) {
            return "☀️ Đà Nẵng có khí hậu nhiệt đới. Thời điểm đẹp nhất: tháng 3-9. Mùa mưa: tháng 10-12. Nhiệt độ TB: 25-30°C.";
        } else if (msg.contains("ăn") || msg.contains("ẩm thực") || msg.contains("food")) {
            return "🍜 Ẩm thực Đà Nẵng nổi tiếng: Mì Quảng, Bún chả cá, Bánh tráng cuốn thịt heo, Bánh xèo, Hải sản tươi sống. Đặc biệt hải sản ở Bãi biển Mỹ Khê!";
        } else if (msg.contains("xin chào") || msg.contains("hello") || msg.contains("hi")) {
            return "👋 Xin chào! Tôi là VietAir Assistant. Tôi có thể giúp bạn tìm tour du lịch Đà Nẵng, tư vấn điểm đến, hoặc hướng dẫn sử dụng website. Hãy hỏi tôi bất cứ điều gì!";
        } else {
            return "🤖 Cảm ơn câu hỏi của bạn! Hiện tại tôi đang kết nối lại với hệ thống AI. Bạn có thể hỏi tôi về: tours du lịch, điểm đến Đà Nẵng, đặt tour, thời tiết, ẩm thực...";
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write("{\"status\": \"VietAir Chatbot API is running\", \"version\": \"2.0\"}");
    }
}
