package service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.List;
import model.ChatMessage;

/**
 * Service goi Groq API (tuong thich OpenAI format)
 * Su dung java.net.http.HttpClient (Java 11+)
 */
public class GrokApiService {

    // === CAU HINH API ===
    private static final String API_KEY = "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";
    private static final String API_URL = "https://api.groq.com/openai/v1/chat/completions";
    private static final String MODEL = "llama-3.3-70b-versatile";

    // System prompt — nhan cach cua Finer AI
    private static final String SYSTEM_PROMPT =
        "Ban la Finer AI, tro ly hen ho vui ve, thong minh, hai huoc. "
        + "Giup user tim nguoi yeu, goi y profile, tu van chat, match-making. "
        + "Luon tra loi bang tieng Viet, vui tuoi, ho tro dating app Finer. "
        + "Tra loi ngan gon (toi da 200 tu), khong dung markdown, chi plain text. "
        + "Dung emoji phu hop de tao cam giac than thien.";

    // HttpClient dung chung (thread-safe)
    private static final HttpClient httpClient = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(15))
            .build();

    /**
     * Goi API voi lich su chat
     * @param history danh sach tin nhan truoc do
     * @param userMessage tin nhan moi cua user
     * @return cau tra loi cua AI
     */
    public static String chat(List<ChatMessage> history, String userMessage) throws Exception {
        // Xay dung mang messages JSON
        StringBuilder messages = new StringBuilder();
        messages.append("[");

        // 1. System prompt (luon o dau)
        messages.append("{\"role\":\"system\",\"content\":").append(toJson(SYSTEM_PROMPT)).append("}");

        // 2. Lich su chat (toi da 10 tin gan nhat de tiet kiem token)
        if (history != null) {
            int start = Math.max(0, history.size() - 10);
            for (int i = start; i < history.size(); i++) {
                ChatMessage msg = history.get(i);
                messages.append(",{\"role\":\"").append(msg.getRole())
                        .append("\",\"content\":").append(toJson(msg.getContent())).append("}");
            }
        }

        // 3. Tin nhan hien tai cua user
        messages.append(",{\"role\":\"user\",\"content\":").append(toJson(userMessage)).append("}");
        messages.append("]");

        // Tao request body
        String requestBody = "{"
                + "\"model\":\"" + MODEL + "\","
                + "\"messages\":" + messages.toString() + ","
                + "\"temperature\":0.8,"
                + "\"max_tokens\":500,"
                + "\"stream\":false"
                + "}";

        // Tao HTTP request
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(API_URL))
                .header("Content-Type", "application/json; charset=UTF-8")
                .header("Authorization", "Bearer " + API_KEY)
                .POST(HttpRequest.BodyPublishers.ofString(requestBody, StandardCharsets.UTF_8))
                .timeout(Duration.ofSeconds(30))
                .build();

        // Gui request
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

        int statusCode = response.statusCode();
        String body = response.body();

        if (statusCode < 200 || statusCode >= 300) {
            System.err.println("[GrokApiService] API Error " + statusCode + ": " + body);
            // Thu lay error message
            String errMsg = extractField(body, "message");
            throw new RuntimeException(errMsg != null ? errMsg : "API loi " + statusCode);
        }

        // Parse response: lay choices[0].message.content
        String content = extractAssistantContent(body);
        if (content == null || content.isEmpty()) {
            throw new RuntimeException("API tra ve response rong");
        }

        return content;
    }

    // === JSON HELPERS (khong can thu vien ngoai) ===

    /**
     * Escape string thanh JSON string value (co dau ngoac kep)
     */
    private static String toJson(String s) {
        if (s == null) return "null";
        StringBuilder sb = new StringBuilder("\"");
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
        sb.append("\"");
        return sb.toString();
    }

    /**
     * Lay gia tri "content" tu trong block "choices" cua response
     */
    private static String extractAssistantContent(String json) {
        // Tim "choices" roi tim "content" trong do
        int choicesIdx = json.indexOf("\"choices\"");
        if (choicesIdx == -1) return null;

        String sub = json.substring(choicesIdx);
        int contentIdx = sub.indexOf("\"content\"");
        if (contentIdx == -1) return null;

        // Tim dau : sau "content"
        int colon = sub.indexOf(":", contentIdx + 9);
        if (colon == -1) return null;

        // Skip whitespace
        int start = colon + 1;
        while (start < sub.length() && Character.isWhitespace(sub.charAt(start))) start++;
        if (start >= sub.length() || sub.charAt(start) != '"') return null;

        // Parse JSON string value
        start++; // bo qua dau "
        StringBuilder result = new StringBuilder();
        boolean escaped = false;
        for (int i = start; i < sub.length(); i++) {
            char c = sub.charAt(i);
            if (escaped) {
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
                                result.append((char) Integer.parseInt(sub.substring(i + 1, i + 5), 16));
                                i += 4;
                            } catch (NumberFormatException e) { result.append("\\u"); }
                        }
                        break;
                    default: result.append(c);
                }
                escaped = false;
            } else if (c == '\\') {
                escaped = true;
            } else if (c == '"') {
                break;
            } else {
                result.append(c);
            }
        }
        return result.toString();
    }

    /**
     * Lay 1 field string tu JSON (don gian, khong can lib)
     */
    private static String extractField(String json, String field) {
        String key = "\"" + field + "\"";
        int idx = json.indexOf(key);
        if (idx == -1) return null;

        int colon = json.indexOf(":", idx + key.length());
        if (colon == -1) return null;

        int start = json.indexOf("\"", colon + 1);
        if (start == -1) return null;
        start++;

        int end = start;
        boolean esc = false;
        while (end < json.length()) {
            if (esc) { esc = false; end++; continue; }
            if (json.charAt(end) == '\\') { esc = true; end++; continue; }
            if (json.charAt(end) == '"') break;
            end++;
        }
        return json.substring(start, end);
    }
}
