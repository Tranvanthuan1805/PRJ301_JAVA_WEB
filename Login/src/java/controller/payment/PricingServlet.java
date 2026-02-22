package controller.payment;

import dao.SubscriptionDAO;
import model.SubscriptionPlan;
import model.ProviderSubscription;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/pricing")
public class PricingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Check Login
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // If not logged in or not Provider (optional check), redirect? 
        // For now, assume filter handles login, but we need User object.
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        SubscriptionDAO dao = new SubscriptionDAO();

        // 2. Get All Plans
        List<SubscriptionPlan> plans = dao.getAllPlans();
        
        // 3. Get Current Subscription (to disable button)
        ProviderSubscription currentSub = dao.getCurrentSubscription(user.userId);

        request.setAttribute("plans", plans);
        request.setAttribute("currentSub", currentSub);

        // 4. Forward
        request.getRequestDispatcher("views/subscription/pricing.jsp").forward(request, response);
    }
}
