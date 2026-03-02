package com.dananghub.controller.payment;

import com.google.gson.Gson;
import com.dananghub.dao.SubscriptionDAO;
import com.dananghub.entity.SepayTransaction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/sepay-webhook")
public class SePayWebhookServlet extends HttpServlet {

    private static final String SEPAY_API_KEY = "OT78QUVEB9RZ2PFMTP26ALWBZRYKNJDYF4G8WCNZV5ARC1D3QJADEWXZIOXCVI1A";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String authHeader = request.getHeader("Authorization");
            if (authHeader == null || !authHeader.startsWith("Apikey " + SEPAY_API_KEY)) {
                response.setStatus(401);
                out.print("{\"success\": false, \"message\": \"Unauthorized\"}");
                return;
            }

            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            char[] charBuffer = new char[1024];
            int bytesRead;
            while ((bytesRead = reader.read(charBuffer)) > 0) {
                sb.append(charBuffer, 0, bytesRead);
            }

            Gson gson = new Gson();
            SepayTransaction sepayTrans = gson.fromJson(sb.toString(), SepayTransaction.class);

            SubscriptionDAO dao = new SubscriptionDAO();
            dao.saveSepayTransaction(sepayTrans);
            
            String content = sepayTrans.getContent() != null ? sepayTrans.getContent().toUpperCase() : "";
            
            String resultStatus = "success";
            String reason = "Payment processed";

            if (content.contains("ORD")) {
                com.dananghub.dao.OrderDAO orderDao = new com.dananghub.dao.OrderDAO();
                String orderResult = orderDao.processOrderPayment(sepayTrans);
                if (!"SUCCESS".equals(orderResult)) {
                    resultStatus = "error";
                    reason = orderResult;
                }
            } else {
                boolean subSuccess = dao.processPayment(sepayTrans);
                if (!subSuccess) {
                    resultStatus = "error";
                    reason = "Subscription verification failed";
                }
            }

            if ("success".equals(resultStatus)) {
                out.print("{\"success\": true, \"message\": \"Payment processed\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"" + reason.replace("\"", "'") + "\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            out.print("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }
}
