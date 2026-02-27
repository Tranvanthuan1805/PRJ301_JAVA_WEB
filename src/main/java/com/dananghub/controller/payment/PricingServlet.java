package com.dananghub.controller.payment;

import com.dananghub.dao.SubscriptionDAO;
import com.dananghub.entity.SubscriptionPlan;
import com.dananghub.entity.ProviderSubscription;
import com.dananghub.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/pricing")
public class PricingServlet extends HttpServlet {

    private final SubscriptionDAO subscriptionDAO = new SubscriptionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<SubscriptionPlan> plans = subscriptionDAO.findAllPlans();

        request.setAttribute("plans", plans);

        request.getRequestDispatcher("views/subscription/pricing.jsp").forward(request, response);
    }
}
