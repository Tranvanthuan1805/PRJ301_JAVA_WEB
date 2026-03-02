package com.dananghub.controller;

import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/analytics")
public class AdminAnalyticsServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // 1. Lấy dữ liệu cho Chart thực tế
            Query q1 = em.createNativeQuery("SELECT \"MonthYear\", \"GuestCount\", \"BookingRevenue\" FROM \"MonthlyTourismStats\" ORDER BY \"Id\" ASC");
            List<Object[]> tourismStats = q1.getResultList();
            
            // 2. Lấy dữ liệu thời tiết trung bình theo tháng để làm Input cho AI
            Query q2 = em.createNativeQuery(
                "SELECT EXTRACT(MONTH FROM \"Date\") as m, AVG(\"Temp\"), AVG(\"Precipitation\") " +
                "FROM \"WeatherData\" GROUP BY m ORDER BY m"
            );
            List<Object[]> weatherAverages = q2.getResultList();

            // 3. Lấy dữ liệu hiệu suất Tour để AI gợi ý Tour bán chạy
            Query q3 = em.createNativeQuery(
                "SELECT \"MonthYear\", \"TourName\", \"BookingCount\" FROM \"TourPerformance\" ORDER BY \"Id\" ASC"
            );
            List<Object[]> tourPerformanceData = q3.getResultList();

            request.setAttribute("tourismStats", tourismStats);
            request.setAttribute("weatherAverages", weatherAverages);
            request.setAttribute("tourPerformanceData", tourPerformanceData);
            
            request.getRequestDispatcher("/views/admin/analytics-ai.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500);
        } finally {
            em.close();
        }
    }
}
