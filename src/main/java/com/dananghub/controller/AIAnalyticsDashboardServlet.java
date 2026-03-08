package com.dananghub.controller;

import com.dananghub.dao.ChatbotLogDAO;
import com.dananghub.entity.ChatbotLog;
import com.dananghub.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet cho AI Analytics Dashboard - Thống kê câu hỏi & phân tích hành vi
 */
@WebServlet("/admin/ai-analytics")
public class AIAnalyticsDashboardServlet extends HttpServlet {

    private final ChatbotLogDAO chatbotLogDAO = new ChatbotLogDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equalsIgnoreCase(user.getRoleName())) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        try {
            // Chatbot question stats
            long totalQuestions = chatbotLogDAO.countAll();
            double avgResponseTime = chatbotLogDAO.getAvgResponseTime();
            List<Object[]> categoryStats = chatbotLogDAO.getQuestionCountByCategory();
            List<Object[]> sentimentStats = chatbotLogDAO.getSentimentStats();
            List<ChatbotLog> recentQuestions = chatbotLogDAO.getRecentQuestions(10);
            List<Object[]> topQuestions = chatbotLogDAO.getTopQuestions(10);

            request.setAttribute("totalQuestions", totalQuestions);
            request.setAttribute("avgResponseTime", String.format("%.1fs", avgResponseTime / 1000));
            request.setAttribute("categoryStats", categoryStats);
            request.setAttribute("sentimentStats", sentimentStats);
            request.setAttribute("recentQuestions", recentQuestions);
            request.setAttribute("topQuestions", topQuestions);

        } catch (Exception e) {
            e.printStackTrace();
            // Dashboard will use fallback sample data from JSP
        }

        request.getRequestDispatcher("/views/admin/ai-analytics.jsp").forward(request, response);
    }
}
