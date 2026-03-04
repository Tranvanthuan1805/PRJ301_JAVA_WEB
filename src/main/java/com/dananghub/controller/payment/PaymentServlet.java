package com.dananghub.controller.payment;

import com.dananghub.dao.SubscriptionDAO;
import com.dananghub.entity.SubscriptionPlan;
import com.dananghub.entity.PaymentTransaction;
import com.dananghub.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Date;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

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

        String planIdStr = request.getParameter("planId");
        if (planIdStr == null) {
            response.sendRedirect("pricing");
            return;
        }

        int planId = Integer.parseInt(planIdStr);
        SubscriptionPlan plan = subscriptionDAO.findPlanById(planId);
        if (plan == null) {
            response.sendRedirect("pricing");
            return;
        }

        String transCode = "PRJ" + System.currentTimeMillis() + "U" + user.getUserId();

        PaymentTransaction trans = new PaymentTransaction();
        trans.setUserId(user.getUserId());
        trans.setPlanId(plan.getPlanId());
        trans.setAmount(plan.getPrice());
        trans.setTransactionCode(transCode);
        trans.setStatus("Pending");
        trans.setCreatedDate(new Date());

        subscriptionDAO.createTransaction(trans);

        String bankAcc = "2806281106";
        String bankName = "MB";
        long amountInt = plan.getPrice() != null ? plan.getPrice().longValue() : 0L;
        String qrUrl = String.format("https://qr.sepay.vn/img?acc=%s&bank=%s&amount=%d&des=%s",
                bankAcc, bankName, amountInt, transCode);

        request.setAttribute("qrUrl", qrUrl);
        request.setAttribute("plan", plan);
        request.setAttribute("transCode", transCode);
        request.setAttribute("amount", amountInt);

        request.getRequestDispatcher("views/subscription/payment.jsp").forward(request, response);
    }
}
