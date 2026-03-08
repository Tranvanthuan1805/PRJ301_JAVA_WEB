package com.dananghub.controller;

import com.dananghub.dao.ChatbotLogDAO;
import com.dananghub.entity.ChatbotLog;
import com.dananghub.entity.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/chatlog")
public class ChatLogServlet extends HttpServlet {

    private final ChatbotLogDAO chatbotLogDAO = new ChatbotLogDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        String question = request.getParameter("question");
        if (question == null || question.trim().isEmpty()) {
            response.setStatus(400);
            return;
        }

        question = question.trim();
        if (question.length() > 2000) question = question.substring(0, 2000);

        // Auto categorize
        String category = categorize(question);

        Integer userId = null;
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) userId = user.getUserId();
        }

        String sessionId = request.getSession().getId();

        ChatbotLog log = new ChatbotLog(userId, sessionId, question);
        log.setCategory(category);
        chatbotLogDAO.save(log);

        response.setStatus(200);
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write("{\"status\":\"ok\"}");
    }

    private String categorize(String msg) {
        String lower = msg.toLowerCase();
        if (lower.contains("giá") || lower.contains("bao nhiêu") || lower.contains("rẻ")) return "PRICE";
        if (lower.contains("hội an") || lower.contains("bà nà") || lower.contains("sơn trà") || lower.contains("mỹ khê") || lower.contains("địa điểm")) return "LOCATION";
        if (lower.contains("đặt tour") || lower.contains("book") || lower.contains("mua")) return "BOOKING";
        if (lower.contains("thanh toán") || lower.contains("hủy") || lower.contains("chính sách")) return "POLICY";
        if (lower.contains("gia đình") || lower.contains("trẻ em") || lower.contains("nhóm")) return "FAMILY";
        if (lower.contains("đơn hàng") || lower.contains("tra cứu") || lower.contains("trạng thái")) return "ORDER";
        if (lower.contains("phổ biến") || lower.contains("hot") || lower.contains("top") || lower.contains("gợi ý")) return "RECOMMEND";
        return "GENERAL";
    }
}
