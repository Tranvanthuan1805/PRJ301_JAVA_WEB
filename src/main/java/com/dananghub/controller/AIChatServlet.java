package com.dananghub.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

@WebServlet("/ai/chat")
public class AIChatServlet extends HttpServlet {

    private static final String API_KEY = "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";
    private static final String API_URL = "https://api.groq.com/openai/v1/chat/completions";
    private static final String MODEL = "llama-3.3-70b-versatile";

    private static final String SYSTEM_PROMPT =
        "Bạn là EzTravel AI — trợ lý du lịch thông minh của eztravel, chuyên tư vấn du lịch Đà Nẵng. "
        + "Trả lời bằng tiếng Việt, thân thiện, chuyên nghiệp, tối đa 200 từ. "
        + "Bạn biết rõ các điểm đến: Bà Nà Hills, Cầu Vàng, Cầu Rồng, Biển Mỹ Khê, Sơn Trà, Ngũ Hành Sơn, Hội An, Chùa Linh Ứng, Cù Lao Chàm. "
        + "Tư vấn tour phù hợp ngân sách, gợi ý lịch trình, so sánh giá. "
        + "Khi người dùng muốn đặt tour, hướng dẫn họ gõ 'đặt tour'. "
        + "Dùng emoji phù hợp và markdown **bold** để nhấn mạnh. "
        + "Nếu hỏi ngoài du lịch Đà Nẵng, nhẹ nhàng chuyển hướng về du lịch.";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        try {
            String userMessage = request.getParameter("message");

            if (userMessage == null || userMessage.trim().isEmpty()) {
                out.write("{\"response\":\"Vui long nhap tin nhan.\"}");
                return;
            }

            userMessage = userMessage.trim();

            // Tao JSON request cho Groq
            String escapedSystem = jsonEscape(SYSTEM_PROMPT);
            String escapedUser = jsonEscape(userMessage);

            String body = "{\"model\":\"" + MODEL + "\","
                + "\"messages\":["
                + "{\"role\":\"system\",\"content\":\"" + escapedSystem + "\"},"
                + "{\"role\":\"user\",\"content\":\"" + escapedUser + "\"}"
                + "],"
                + "\"temperature\":0.7,"
                + "\"max_tokens\":500,"
                + "\"stream\":false}";

            // Goi API
            URL url = new URL(API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            conn.setRequestProperty("Authorization", "Bearer " + API_KEY);
            conn.setDoOutput(true);
            conn.setConnectTimeout(15000);
            conn.setReadTimeout(30000);

            byte[] bodyBytes = body.getBytes(StandardCharsets.UTF_8);

            try (OutputStream os = conn.getOutputStream()) {
                os.write(bodyBytes);
                os.flush();
            }

            int status = conn.getResponseCode();
            InputStream is = null;
            try {
                is = (status >= 200 && status < 300) ? conn.getInputStream() : conn.getErrorStream();
            } catch (IOException e) {
                is = conn.getErrorStream();
            }

            String responseStr = "";
            if (is != null) {
                StringBuilder sb = new StringBuilder();
                try (BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
                    String line;
                    while ((line = br.readLine()) != null) {
                        sb.append(line);
                    }
                }
                responseStr = sb.toString();
            }

            conn.disconnect();

            if (status >= 200 && status < 300) {
                // Lay content tu response
                String content = extractContent(responseStr);
                out.write("{\"response\":\"" + jsonEscape(content) + "\"}");
            } else {
                System.err.println("[AIChatServlet] Groq error " + status + ": " + responseStr);
                out.write("{\"response\":\"⚠️ AI tam thoi khong kha dung (loi " + status + "). Thu lai sau!\"}");
            }

        } catch (Throwable t) {
            t.printStackTrace();
            out.write("{\"response\":\"⚠️ Loi he thong: " + jsonEscape(String.valueOf(t.getMessage())) + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write("{\"status\":\"ok\",\"engine\":\"Groq " + MODEL + "\"}");
    }

    private String extractContent(String json) {
        // Tim "choices" -> "content"
        int ci = json.indexOf("\"choices\"");
        if (ci == -1) return "Khong the xu ly phan hoi.";

        String sub = json.substring(ci);
        int cIdx = sub.indexOf("\"content\"");
        if (cIdx == -1) return "Khong the xu ly phan hoi.";

        // Tim : sau content
        int colon = sub.indexOf(":", cIdx + 9);
        if (colon == -1) return "Khong the xu ly phan hoi.";

        // Tim opening quote
        int start = colon + 1;
        while (start < sub.length() && (sub.charAt(start) == ' ' || sub.charAt(start) == '\t')) start++;
        if (start >= sub.length() || sub.charAt(start) != '"') return "Khong the xu ly phan hoi.";

        start++; // skip "
        StringBuilder result = new StringBuilder();
        boolean esc = false;
        for (int i = start; i < sub.length(); i++) {
            char c = sub.charAt(i);
            if (esc) {
                switch (c) {
                    case 'n': result.append('\n'); break;
                    case 'r': result.append('\r'); break;
                    case 't': result.append('\t'); break;
                    case '"': result.append('"'); break;
                    case '\\': result.append('\\'); break;
                    case '/': result.append('/'); break;
                    case 'u':
                        if (i + 4 < sub.length()) {
                            try {
                                String hex = sub.substring(i + 1, i + 5);
                                result.append((char) Integer.parseInt(hex, 16));
                                i += 4;
                            } catch (Exception e) {
                                result.append("\\u");
                            }
                        }
                        break;
                    default: result.append(c);
                }
                esc = false;
            } else if (c == '\\') {
                esc = true;
            } else if (c == '"') {
                break;
            } else {
                result.append(c);
            }
        }
        return result.toString();
    }

    private String jsonEscape(String s) {
        if (s == null) return "";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            switch (c) {
                case '"': sb.append("\\\""); break;
                case '\\': sb.append("\\\\"); break;
                case '\n': sb.append("\\n"); break;
                case '\r': sb.append("\\r"); break;
                case '\t': sb.append("\\t"); break;
                default:
                    if (c < 0x20) {
                        sb.append(String.format("\\u%04x", (int) c));
                    } else {
                        sb.append(c);
                    }
            }
        }
        return sb.toString();
    }
}
