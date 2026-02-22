package controller.payment;

import com.google.gson.Gson;
import dao.SubscriptionDAO;
import model.SePayTransaction;
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
            // 0. Authenticate (Check API Key)
            String authHeader = request.getHeader("Authorization");
            if (authHeader == null || !authHeader.startsWith("Apikey " + SEPAY_API_KEY)) {
                response.setStatus(401); // Unauthorized
                out.print("{\"success\": false, \"message\": \"Unauthorized\"}");
                return;
            }

            // 1. Read JSON Body
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            char[] charBuffer = new char[1024];
            int bytesRead = -1;
            while ((bytesRead = reader.read(charBuffer)) > 0) {
                sb.append(charBuffer, 0, bytesRead);
            }
            String jsonBody = sb.toString();

            // 2. Parse JSON
            Gson gson = new Gson();
            SePayTransaction sepayTrans = gson.fromJson(jsonBody, SePayTransaction.class);

            // 3. Process
            SubscriptionDAO dao = new SubscriptionDAO();
            
            // Save raw log first
            dao.saveSePayTransaction(sepayTrans);
            
            // Activate logic
            boolean success = dao.processPayment(sepayTrans);

            if (success) {
                out.print("{\"success\": true, \"message\": \"Payment processed\"}");
            } else {
                // Return success=true anyway to tell SePay we got it, unless it's a fatal error
                // Usually webhooks expect 200 OK if received.
                out.print("{\"success\": false, \"message\": \"Payment verification failed or duplicate\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            out.print("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }
}
