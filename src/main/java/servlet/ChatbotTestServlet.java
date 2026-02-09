package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
/**
 * Chatbot Test Servlet - Test chatbot functionality
 */
public class ChatbotTestServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<title>Chatbot Test - TourManager</title>");
            out.println("<style>");
            out.println("body { font-family: Arial, sans-serif; margin: 40px; background: #f0f8ff; }");
            out.println("h1 { color: #6c5ce7; }");
            out.println(".info { background: #e3f2fd; padding: 20px; border-radius: 8px; margin: 20px 0; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            
            out.println("<h1>🤖 Chatbot Test Servlet</h1>");
            
            out.println("<div class='info'>");
            out.println("<strong>Status:</strong> Chatbot test servlet is running<br>");
            out.println("<strong>Purpose:</strong> Test chatbot integration and functionality<br>");
            out.println("<strong>Time:</strong> " + new java.util.Date());
            out.println("</div>");
            
            out.println("<p>This servlet can be used to test chatbot API endpoints and functionality.</p>");
            
            out.println("<p><a href='" + request.getContextPath() + "/'>&larr; Back to Home</a></p>");
            
            out.println("</body>");
            out.println("</html>");
        }
    }
}