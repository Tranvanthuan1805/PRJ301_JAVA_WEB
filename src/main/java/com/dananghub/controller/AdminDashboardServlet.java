package com.dananghub.controller;

import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        EntityManager em = null;
        try {
            em = JPAUtil.getEntityManager();

            // Count distinct customers who have placed orders
            Long totalUsers = (Long) em.createQuery(
                "SELECT COUNT(DISTINCT o.customer) FROM Order o"
            ).getSingleResult();
            
            Long totalTours = (Long) em.createQuery("SELECT COUNT(t) FROM Tour t WHERE t.isActive = true").getSingleResult();
            Long totalOrders = (Long) em.createQuery("SELECT COUNT(o) FROM Order o").getSingleResult();
            Long pendingOrders = (Long) em.createQuery("SELECT COUNT(o) FROM Order o WHERE o.orderStatus = 'Pending'").getSingleResult();

            Double totalRevenue = 0.0;
            try {
                Object rev = em.createQuery("SELECT COALESCE(SUM(o.totalAmount), 0) FROM Order o WHERE o.orderStatus = 'Completed'").getSingleResult();
                totalRevenue = ((Number) rev).doubleValue();
            } catch (Exception ignored) {}

            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("activeTours", totalTours);
            request.setAttribute("totalBookings", totalOrders);
            request.setAttribute("pendingRequests", pendingOrders);
            request.setAttribute("grossRevenue", totalRevenue);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("totalUsers", 0);
            request.setAttribute("activeTours", 0);
            request.setAttribute("totalBookings", 0);
            request.setAttribute("pendingRequests", 0);
            request.setAttribute("grossRevenue", 0);
        } finally {
            if (em != null) em.close();
        }

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
