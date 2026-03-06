package com.dananghub.controller.payment;

import com.dananghub.dao.SubscriptionDAO;
import com.dananghub.entity.ProviderSubscription;
import com.dananghub.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/billing-history")
public class BillingHistoryServlet extends HttpServlet {

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

        // Only providers have billing history
        if (!"PROVIDER".equalsIgnoreCase(user.getRoleName())) {
            response.sendRedirect("pricing");
            return;
        }

        List<ProviderSubscription> history = subscriptionDAO.findByProvider(user.getUserId());

        request.setAttribute("history", history);
        request.setAttribute("now", new java.util.Date());
        request.getRequestDispatcher("views/subscription/history.jsp").forward(request, response);
    }
}
