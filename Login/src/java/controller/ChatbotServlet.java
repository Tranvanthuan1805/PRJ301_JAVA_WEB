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

    // System prompt to guide the AI about the website context
    private static final String SYSTEM_PROMPT = """
        Bạn là VietAir Assistant - trợ lý AI thông minh của hệ thống quản lý tour du lịch VietAir Đà Nẵng.

        ### Về hệ thống VietAir:
        - Hệ thống quản lý tour du lịch Đà Nẵng với dữ liệu từ 2020-2025
        - Có hơn 432 tours lịch sử, 6 điểm đến chính, 72 tháng dữ liệu
        - Đánh giá trung bình 4.9/5 sao

        ### Các điểm đến du lịch Đà Nẵng:
        1. **Bà Nà Hills** - Khu du lịch nổi tiếng với Cầu Vàng, cáp treo, làng Pháp
        2. **Ngũ Hành Sơn** - Danh thắng 5 ngọn núi đá vôi, chùa chiền cổ kính
        3. **Cù Lao Chàm** - Đảo biển UNESCO, lặn ngắm san hô, hải sản tươi sống
        4. **Bán đảo Sơn Trà** - Rừng nguyên sinh, chùa Linh Ứng, đỉnh Bàn Cờ
        5. **Huế** - Cố đô với Đại Nội, lăng tẩm, sông Hương
        6. **Núi Thần Tài** - Suối khoáng nóng, công viên nước

        ### Các tính năng của website:
        - **Tìm kiếm tour**: Theo điểm đến, ngày, số người
        - **Đặt tour**: Đăng ký và đặt tour trực tuyến
        - **Quản lý khách hàng**: Profile, lịch sử đặt tour
        - **Quản lý đơn hàng**: Theo dõi trạng thái booking
        - **Quản lý nhà cung cấp**: Khách sạn, hãng hàng không
        - **Thanh toán & Subscription**: Gói dịch vụ cho đối tác
        - **AI dự báo**: Phân tích xu hướng du lịch

        ### Quy tắc trả lời:
        1. Luôn trả lời bằng tiếng Việt, thân thiện và chuyên nghiệp
        2. Tập trung vào thông tin về Đà Nẵng và các tour du lịch
        3. Có thể gợi ý tour phù hợp dựa trên yêu cầu của khách
        4. Cung cấp thông tin hữu ích về thời tiết, ẩm thực, văn hóa Đà Nẵng
        5. Hướng dẫn sử dụng các tính năng của website khi được hỏi
        6. Trả lời ngắn gọn, rõ ràng (tối đa 200 từ)
        7. Sử dụng emoji phù hợp để làm sinh động câu trả lời
        """;

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
        String escapedSystemPrompt = escapeJsonString(SYSTEM_PROMPT);
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
