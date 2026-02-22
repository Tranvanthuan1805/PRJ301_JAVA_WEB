package controller.payment;

import dao.SubscriptionDAO;
import model.ProviderSubscription;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/history")
public class BillingHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        SubscriptionDAO dao = new SubscriptionDAO();
        List<ProviderSubscription> history = dao.getSubscriptionHistory(user.getUserId());
        
        request.setAttribute("history", history);
        request.setAttribute("now", new java.util.Date());
        request.getRequestDispatcher("views/subscription/history.jsp").forward(request, response);
    }
}
