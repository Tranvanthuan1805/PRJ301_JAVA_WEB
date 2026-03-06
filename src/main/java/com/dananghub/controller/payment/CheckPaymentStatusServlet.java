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

        Map<String, String> result = new HashMap<>();
        if (trans != null) {
            result.put("status", trans.getStatus());
            if ("Paid".equalsIgnoreCase(trans.getStatus())) {
                if (code.startsWith("PRJ")) {
                    HttpSession session = request.getSession();
                    User user = (User) session.getAttribute("user");
                    if (user != null) {
                        session.setAttribute("user_plan", "Active");
                    }
                }
                if (code.startsWith("ORD")) {
                    result.put("redirectUrl", "my-orders");
                }
            }
        } else {
            result.put("status", "NOT_FOUND");
        }

        out.print(new Gson().toJson(result));
    }
}
