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
import java.util.*;
import java.util.stream.Collectors;

/**
 * ForecastingServlet - AI-powered travel trend forecasting
 * Uses OpenRouter API to analyze historical CSV data and predict future trends
 */
@WebServlet(name = "ForecastingServlet", urlPatterns = {"/admin/forecast"})
public class ForecastingServlet extends HttpServlet {

    private static final String API_KEY = "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";
    private static final String OPENROUTER_URL = "https://openrouter.ai/api/v1/chat/completions";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Load data from CSV
        List<Map<String, String>> historicalData = loadHistoricalData(request);
        
        // Group data for AI analysis (summary)
        String summaryData = summarizeDataForAI(historicalData);
        
        request.setAttribute("historicalData", historicalData);
        request.setAttribute("summaryData", summaryData);
        
        request.getRequestDispatcher("/admin/forecast.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String action = request.getParameter("action");
        if ("analyze".equals(action)) {
            List<Map<String, String>> historicalData = loadHistoricalData(request);
            String summaryData = summarizeDataForAI(historicalData);
            
            try {
                String aiAnalysis = callOpenRouterForForecasting(summaryData);
                response.getWriter().write("{\"analysis\": \"" + escapeJson(aiAnalysis) + "\"}");
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().write("{\"error\": \"Không thể kết nối với AI Engine.\"}");
            }
        }
    }

    private List<Map<String, String>> loadHistoricalData(HttpServletRequest request) {
        List<Map<String, String>> data = new ArrayList<>();
        String csvPath = request.getServletContext().getRealPath("/") + "../../danang_tours_dataset_2020_2025.csv";
        
        // Fallback for different environments
        File csvFile = new File(csvPath);
        if (!csvFile.exists()) {
            csvPath = "e:/PRJ301_JAVA_WEB/danang_tours_dataset_2020_2025.csv";
        }

        try (BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(csvPath), "UTF-8"))) {
            String line;
            String[] headers = null;
            while ((line = br.readLine()) != null) {
                if (headers == null) {
                    headers = line.split(",");
                    continue;
                }
                String[] values = line.split(",");
                Map<String, String> row = new HashMap<>();
                for (int i = 0; i < Math.min(headers.length, values.length); i++) {
                    row.put(headers[i], values[i]);
                }
                data.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }

    private String summarizeDataForAI(List<Map<String, String>> data) {
        // Summarize by year and tour type to stay within token limits
        Map<String, Double> yearlyRevenue = new TreeMap<>();
        for (Map<String, String> row : data) {
            String date = row.get("Tháng/Năm");
            if (date == null) continue;
            String year = date.split("/")[1];
            double rev = 0;
            try {
                rev = Double.parseDouble(row.get("Doanh thu Tour (Triệu VNĐ)"));
            } catch (Exception e) {}
            yearlyRevenue.put(year, yearlyRevenue.getOrDefault(year, 0.0) + rev);
        }

        StringBuilder summary = new StringBuilder("Dữ liệu doanh thu du lịch Đà Nẵng (Triệu VNĐ):\n");
        yearlyRevenue.forEach((year, rev) -> summary.append(year).append(": ").append(String.format("%.2f", rev)).append("\n"));
        
        summary.append("\nCác tour phổ biến nhất: Bà Nà Hills, Ngũ Hành Sơn, Cù Lao Chàm, Sơn Trà, Huế, Núi Thần Tài.");
        return summary.toString();
    }

    private String callOpenRouterForForecasting(String summaryData) throws Exception {
        URL url = new URL(OPENROUTER_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Authorization", "Bearer " + API_KEY);
        conn.setDoOutput(true);

        String prompt = "Dựa trên dữ liệu du lịch Đà Nẵng sau đây, hãy sử dụng tư duy phân tích mạng nơ-ron để dự báo xu hướng du lịch năm 2026. Phân tích về: 1. Doanh thu dự kiến, 2. Tour nào sẽ bùng nổ, 3. Khuyên doanh nghiệp nên đầu tư vào đâu. Hãy trả lời bằng tiếng Việt, ngắn gọn, chuyên nghiệp.\n\n" + summaryData;

        String jsonInputString = "{"
                + "\"model\": \"deepseek/deepseek-chat-v3-0324:free\","
                + "\"messages\": [{\"role\": \"user\", \"content\": \"" + prompt.replace("\n", "\\n").replace("\"", "\\\"") + "\"}]"
                + "}";

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = jsonInputString.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        StringBuilder response = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
            String responseLine;
            while ((responseLine = br.readLine()) != null) {
                response.append(responseLine.trim());
            }
        }

        // Simple JSON extraction for content
        String resp = response.toString();
        int start = resp.indexOf("\"content\":\"") + 11;
        int end = resp.indexOf("\"", start);
        return resp.substring(start, end).replace("\\n", "\n");
    }

    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }
}
