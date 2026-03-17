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
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String roleName = user.getRoleName();
        // Allow CUSTOMER to access if they are an approved provider (check below)

            int providerId = user.getUserId();

            EntityManager em = null;
            try {
                em = JPAUtil.getEntityManager();
                
                // 1. Kiểm tra status của Provider
                com.dananghub.entity.Provider provider = em.find(com.dananghub.entity.Provider.class, providerId);
                if (provider == null || (!"Approved".equals(provider.getStatus()) && !"Active".equals(provider.getStatus()))) {
                    response.sendRedirect(request.getContextPath() + "/provider");
                    return;
                }
                
                request.setAttribute("provider", provider);

                // 2. Thống kê Tours
                java.util.List<com.dananghub.entity.Tour> tours = em.createQuery(
                    "SELECT t FROM Tour t WHERE t.provider.providerId = :pid ORDER BY t.createdAt DESC", com.dananghub.entity.Tour.class)
                    .setParameter("pid", providerId)
                    .getResultList();
                
                long pendingCount = tours.stream().filter(t -> !t.isActive()).count();
                long activeCount = tours.stream().filter(t -> t.isActive()).count();

                request.setAttribute("tours", tours);
                request.setAttribute("pendingCount", pendingCount);
                request.setAttribute("activeCount", activeCount);

                // 3. Doanh thu & Booking
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

                request.setAttribute("myBookings", myBookings);
                request.setAttribute("myRevenue", myRevenue);
                request.setAttribute("providerName", user.getFullName() != null ? user.getFullName() : user.getUsername());

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("pendingCount", 0);
                request.setAttribute("activeCount", 0);
                request.setAttribute("myBookings", 0);
                request.setAttribute("myRevenue", 0);
            } finally {
                if (em != null) em.close();
            }

        request.getRequestDispatcher("/provider/dashboard.jsp").forward(request, response);
    }
}
