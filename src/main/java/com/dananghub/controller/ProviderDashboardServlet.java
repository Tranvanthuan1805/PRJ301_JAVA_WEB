package com.dananghub.controller;

import com.dananghub.entity.User;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/provider/dashboard")
public class ProviderDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (!"PROVIDER".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        User user = (User) session.getAttribute("user");
        int providerId = user.getUserId();

        EntityManager em = null;
        try {
            em = JPAUtil.getEntityManager();

            Long myTours = (Long) em.createQuery(
                "SELECT COUNT(t) FROM Tour t WHERE t.provider.providerId = :pid AND t.isActive = true")
                .setParameter("pid", providerId).getSingleResult();

            Long myBookings = (Long) em.createQuery(
                "SELECT COUNT(b) FROM Booking b WHERE b.tour.provider.providerId = :pid")
                .setParameter("pid", providerId).getSingleResult();

            Double myRevenue = 0.0;
            try {
                Object rev = em.createQuery(
                    "SELECT COALESCE(SUM(b.subTotal), 0) FROM Booking b WHERE b.tour.provider.providerId = :pid AND b.bookingStatus = 'Confirmed'")
                    .setParameter("pid", providerId).getSingleResult();
                myRevenue = ((Number) rev).doubleValue();
            } catch (Exception ignored) {}

            request.setAttribute("myTours", myTours);
            request.setAttribute("myBookings", myBookings);
            request.setAttribute("myRevenue", myRevenue);
            request.setAttribute("providerName", user.getFullName() != null ? user.getFullName() : user.getUsername());

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("myTours", 0);
            request.setAttribute("myBookings", 0);
            request.setAttribute("myRevenue", 0);
        } finally {
            if (em != null) em.close();
        }

        request.getRequestDispatcher("/provider/dashboard.jsp").forward(request, response);
    }
}
