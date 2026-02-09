package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
/**
 * Deployment Test Servlet - Basic functionality test
 */
public class DeploymentTestServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang='vi'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            out.println("<title>✅ Deployment Test Success</title>");
            out.println("<style>");
            out.println("body { font-family: Arial, sans-serif; margin: 40px; background: #f0f8ff; }");
            out.println(".success { background: #d4edda; color: #155724; padding: 20px; border-radius: 8px; margin: 20px 0; }");
            out.println(".info { background: #d1ecf1; color: #0c5460; padding: 15px; border-radius: 8px; margin: 15px 0; }");
            out.println("h1 { color: #28a745; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            
            out.println("<h1>🎉 Deployment Test Servlet - SUCCESS!</h1>");
            
            out.println("<div class='success'>");
            out.println("<strong>✅ SERVLET WORKING!</strong><br>");
            out.println("DeploymentTestServlet đã được load và chạy thành công.");
            out.println("</div>");
            
            out.println("<div class='info'>");
            out.println("<strong>📊 System Information:</strong><br>");
            out.println("Server: " + getServletContext().getServerInfo() + "<br>");
            out.println("Context Path: " + request.getContextPath() + "<br>");
            out.println("Servlet Name: " + getServletName() + "<br>");
            out.println("Request Method: " + request.getMethod() + "<br>");
            out.println("Time: " + new java.util.Date() + "<br>");
            out.println("</div>");
            
            out.println("<div class='info'>");
            out.println("<strong>🔗 Test Links:</strong><br>");
            out.println("<a href='" + request.getContextPath() + "/test-basic.jsp'>Basic JSP Test</a> | ");
            out.println("<a href='" + request.getContextPath() + "/simple-index.jsp'>Dashboard</a> | ");
            out.println("<a href='" + request.getContextPath() + "/basic-test'>Basic Servlet Test</a>");
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
    
    @Override
    public String getServletInfo() {
        return "Deployment Test Servlet for TourManager";
    }
}