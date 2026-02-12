package controller.payment;

import com.google.gson.Gson;
import dao.SubscriptionDAO;
import model.PaymentTransaction;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/check-payment")
public class CheckPaymentStatusServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        String code = request.getParameter("code");
        
        if (code == null) {
            out.print("{\"status\": \"ERROR\"}");
            return;
        }
        
        SubscriptionDAO dao = new SubscriptionDAO();
        PaymentTransaction trans = dao.getTransactionByCode(code);
        
        Map<String, String> result = new HashMap<>();
        
        if (trans != null) {
            result.put("status", trans.getStatus()); // "Pending" or "Paid"
            
            // If paid, we might want to refresh session user plan? 
            // The client will redirect to success page, then user continues.
            // But session update usually happens on next request or here if we access session.
            if ("Paid".equalsIgnoreCase(trans.getStatus())) {
                HttpSession session = request.getSession();
                User user = (User) session.getAttribute("user");
                if (user != null) {
                    // Update session attribute to indicate PRO status
                    // user.setRoleName("PROVIDER_PRO"); // Or similar logic if you use Roles for this
                    // Or set a specific attribute
                    session.setAttribute("user_plan", "Active"); // Simplified
                }
            }
        } else {
            result.put("status", "NOT_FOUND");
        }
        
        Gson gson = new Gson();
        out.print(gson.toJson(result));
    }
}
