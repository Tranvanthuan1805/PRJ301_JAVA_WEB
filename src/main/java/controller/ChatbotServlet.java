package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet("/ai/chat")
public class ChatbotServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userPlan = (String) session.getAttribute("user_plan");

        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // Access Control: PRO/ELITE ONLY
        if (userPlan == null || (!userPlan.equals("Professional") && !userPlan.equals("Elite"))) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            out.print("{\"error\": \"PRO_REQUIRED\", \"message\": \"AI Chatbot is reserved for Pro members.\"}");
            return;
        }

        String message = request.getParameter("message");
        String aiResponse = generateMockResponse(message);

        out.print("{\"response\": \"" + aiResponse + "\"}");
        out.flush();
    }

    private String generateMockResponse(String input) {
        if (input == null) return "How can I help you today?";
        input = input.toLowerCase();

        if (input.contains("revenue") || input.contains("sales")) {
            return "Based on current trends, your revenue is projected to grow by 12% next month. High season bookings are up for July.";
        } else if (input.contains("recommend") || input.contains("suggestion")) {
            return "I recommend increasing capacity for 'Ba Na Hills' tours as demand is outstripping supply for the upcoming weekend.";
        } else if (input.contains("weather")) {
            return "Da Nang weather looks clear for the next 5 days, perfect for outdoor snorkeling and hiking tours.";
        } else if (input.contains("cancel")) {
            return "Your cancellation rate is currently 4%. This is 2% lower than the regional average for Da Nang Hub.";
        } else {
            return "I've analyzed your data. Your business is currently performing in the 'Top 15%' of providers in the Da Nang area. What else would you like to know?";
        }
    }
}
