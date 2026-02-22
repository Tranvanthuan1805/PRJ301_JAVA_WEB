package controller.payment;

import dao.SubscriptionDAO;
import model.SubscriptionPlan;
import model.PaymentTransaction;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Date;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

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
        SubscriptionDAO dao = new SubscriptionDAO();
        SubscriptionPlan plan = dao.getPlanById(planId);

        if (plan == null) {
            response.sendRedirect("pricing");
            return;
        }

        // 1. Create Transaction Code (e.g. PRJ1699999U123)
        // Ensure it's unique enough or random. Use 'U' instead of '_' to avoid bank apps stripping it.
        String transCode = "PRJ" + System.currentTimeMillis() + "U" + user.userId;

        // 2. Create Pending Transaction Record
        PaymentTransaction trans = new PaymentTransaction();
        trans.setUserId(user.userId);
        trans.setPlanId(plan.getPlanId());
        trans.setAmount(plan.getPrice());
        trans.setTransactionCode(transCode);
        trans.setStatus("Pending");
        trans.setCreatedDate(new Date());
        
        dao.createTransaction(trans);

        // 3. Generate SePay QR URL
        // https://qr.sepay.vn/img?acc=YOUR_ACC&bank=YOUR_BANK&amount=50000&des=PRJ301_101
        String bankAcc = "2806281106"; 
        String bankName = "MB"; // e.g. MB, VCB
        
        // Assuming Price is double, cast to int/long for cleaner URL if needed
        long amountInt = (long) plan.getPrice();
        
        String qrUrl = String.format("https://qr.sepay.vn/img?acc=%s&bank=%s&amount=%d&des=%s",
                bankAcc, bankName, amountInt, transCode);

        // 4. Pass data to JSP
        request.setAttribute("qrUrl", qrUrl);
        request.setAttribute("plan", plan);
        request.setAttribute("transCode", transCode);
        request.setAttribute("amount", amountInt); // Display formatted

        request.getRequestDispatcher("views/subscription/payment.jsp").forward(request, response);
    }
}
