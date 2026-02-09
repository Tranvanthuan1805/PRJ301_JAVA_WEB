package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
/**
 * Basic Test Servlet - Minimal functionality test
 */
public class BasicTestServlet extends HttpServlet {
    
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
            out.println("<title>Basic Test - TourManager</title>");
            out.println("<style>");
            out.println("body { font-family: Arial, sans-serif; margin: 40px; background: #f8f9fa; }");
            out.println(".container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }");
            out.println("h1 { color: #007bff; text-align: center; }");
            out.println(".status { background: #d4edda; color: #155724; padding: 15px; border-radius: 5px; margin: 15px 0; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            
            out.println("<div class='container'>");
            out.println("<h1>🚀 Basic Test Servlet</h1>");
            
            out.println("<div class='status'>");
            out.println("✅ <strong>SUCCESS:</strong> Basic servlet is working correctly!");
            out.println("</div>");
            
            out.println("<p><strong>Server Info:</strong> " + getServletContext().getServerInfo() + "</p>");
            out.println("<p><strong>Context:</strong> " + request.getContextPath() + "</p>");
            out.println("<p><strong>Current Time:</strong> " + new java.util.Date() + "</p>");
            
            out.println("<hr>");
            out.println("<p><a href='" + request.getContextPath() + "/'>&larr; Back to Home</a></p>");
            out.println("</div>");
            
            out.println("</body>");
            out.println("</html>");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}