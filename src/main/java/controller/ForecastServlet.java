package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet("/admin/forecast")
public class ForecastServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userPlan = (String) session.getAttribute("user_plan");

        // Access Control: PRO/ELITE ONLY
        if (userPlan == null || (!userPlan.equals("Professional") && !userPlan.equals("Elite"))) {
            request.setAttribute("error_title", "Subscription Required");
            request.setAttribute("error_message", "AI Forecasting is a premium feature available only for Professional and Elite partners.");
            request.getRequestDispatcher("/views/subscription-payment/pricing.jsp").forward(request, response);
            return;
        }

        // Generate Mock Forecast Data

        List<Map<String, Object>> forecastData = new ArrayList<>();
        String[] months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
        
        double currentRevenue = 12500;
        for (String month : months) {
            Map<String, Object> data = new HashMap<>();
            data.put("month", month);
            
            // Simulation logic: High season in summer (Jun-Aug)
            double seasonalFactor = 1.0;
            if (month.equals("Jun") || month.equals("Jul") || month.equals("Aug")) seasonalFactor = 1.8;
            if (month.equals("Nov") || month.equals("Dec")) seasonalFactor = 0.8;
            
            double predicted = (currentRevenue * seasonalFactor) + (Math.random() * 2000);
            data.put("revenue", predicted);
            data.put("growth", (Math.random() * 15) + 5);
            forecastData.add(data);
        }

        request.setAttribute("forecastData", forecastData);
        request.setAttribute("activePage", "forecast");
        request.getRequestDispatcher("/views/ai-forecasting/forecast-dashboard.jsp").forward(request, response);
    }
}
