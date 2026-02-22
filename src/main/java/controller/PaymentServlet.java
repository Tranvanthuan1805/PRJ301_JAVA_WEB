package controller;

import model.entity.dao.SubscriptionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Calendar;
import model.entity.Subscription;
import model.entity.User;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {
    private SubscriptionDAO subDAO = new SubscriptionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String plan = request.getParameter("plan");
        String price = request.getParameter("price");
        
        if (plan == null) {
            response.sendRedirect(request.getContextPath() + "/views/subscription-payment/pricing.jsp");
            return;
        }

        request.setAttribute("plan", plan);
        request.setAttribute("price", price);
        request.getRequestDispatcher("/views/subscription-payment/payment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String planName = request.getParameter("plan");
        
        // Mocking SePay/Payment Verification
        boolean paymentSuccess = true; // Simulated success

        if (paymentSuccess) {
            Subscription sub = new Subscription();
            sub.setProviderId(user.getUserId());
            sub.setPlanName(planName);
            
            Timestamp now = new Timestamp(System.currentTimeMillis());
            sub.setStartDate(now);
            
            Calendar cal = Calendar.getInstance();
            cal.setTime(now);
            cal.add(Calendar.MONTH, 1); // 1 month plan
            sub.setEndDate(new Timestamp(cal.getTimeInMillis()));
            
            sub.setActive(true);
            
            subDAO.createSubscription(sub);
            session.setAttribute("user_plan", planName); // Cache plan in session
            
            response.sendRedirect(request.getContextPath() + "/views/cart-booking/confirmation.jsp?status=sub_success");
        } else {
            request.setAttribute("error", "Payment verification failed. Please try again.");
            request.getRequestDispatcher("/views/subscription-payment/payment.jsp").forward(request, response);
        }
    }
}
