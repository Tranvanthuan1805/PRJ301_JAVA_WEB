package com.dananghub.controller.payment;

import com.google.gson.Gson;
import com.dananghub.dao.SubscriptionDAO;
import com.dananghub.entity.PaymentTransaction;
import com.dananghub.entity.User;

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
        PaymentTransaction trans = dao.findTransactionByCode(code);

        Map<String, Object> result = new HashMap<>();
        if (trans != null) {
            result.put("status", trans.getStatus());
            result.put("transactionCode", trans.getTransactionCode());

            // Determine payment type
            if (trans.getTransactionCode().startsWith("ORD")) {
                result.put("type", "order");
                result.put("orderId", trans.getOrderId());
            } else if (trans.getTransactionCode().startsWith("PRJ")) {
                result.put("type", "subscription");
                result.put("planId", trans.getPlanId());
            }

            if ("Paid".equalsIgnoreCase(trans.getStatus())) {
                HttpSession session = request.getSession();
                User user = (User) session.getAttribute("user");
                if (user != null && trans.getTransactionCode().startsWith("PRJ")) {
                    session.setAttribute("user_plan", "Active");
                }
            }
        } else {
            result.put("status", "NOT_FOUND");
        }

        out.print(new Gson().toJson(result));
    }
}
