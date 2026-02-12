package servlet;

import dao.CustomerDAO;
import model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/test-encoding")
public class TestEncodingServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<title>Test Encoding</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>Test Vietnamese Encoding</h1>");
        
        // Test 1: Hardcoded Vietnamese
        out.println("<h2>Test 1: Hardcoded String</h2>");
        out.println("<p>Nguyễn Văn An</p>");
        out.println("<p>Trần Thị Bình</p>");
        out.println("<p>Lê Hoàng Cường</p>");
        
        // Test 2: From Database
        out.println("<h2>Test 2: From Database</h2>");
        try {
            CustomerDAO dao = new CustomerDAO();
            List<Customer> customers = dao.getAllCustomers(0, 5);
            
            out.println("<table border='1'>");
            out.println("<tr><th>ID</th><th>Full Name</th><th>Email</th></tr>");
            
            for (Customer c : customers) {
                out.println("<tr>");
                out.println("<td>" + c.getId() + "</td>");
                out.println("<td>" + c.getFullName() + "</td>");
                out.println("<td>" + c.getEmail() + "</td>");
                out.println("</tr>");
            }
            
            out.println("</table>");
            
        } catch (Exception e) {
            out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
        
        // Test 3: Character encoding info
        out.println("<h2>Test 3: Encoding Info</h2>");
        out.println("<p>Request Encoding: " + request.getCharacterEncoding() + "</p>");
        out.println("<p>Response Encoding: " + response.getCharacterEncoding() + "</p>");
        out.println("<p>Response Content Type: " + response.getContentType() + "</p>");
        
        out.println("</body>");
        out.println("</html>");
    }
}
