package com.dananghub.controller;

import com.dananghub.dao.SubscriptionDAO;
import com.dananghub.entity.SubscriptionPlan;
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

        try {
            List<SubscriptionPlan> plans = subscriptionDAO.findAllPlans();
            request.setAttribute("plans", plans);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi tải gói VIP: " + e.getMessage());
        }

        // Check login status
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        request.setAttribute("isLoggedIn", user != null);

        request.getRequestDispatcher("/views/subscription/pricing.jsp").forward(request, response);
    }
}
