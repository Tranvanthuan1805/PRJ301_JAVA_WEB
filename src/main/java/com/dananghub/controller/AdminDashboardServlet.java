package com.dananghub.controller;

import com.dananghub.dao.ConsultationDAO;
import com.dananghub.dao.CouponDAO;
import com.dananghub.dao.TourDAO;
import com.dananghub.entity.Provider;
import com.dananghub.entity.User;
import com.dananghub.util.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check admin
        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;
        if (user == null || user.getRole() == null || !"ADMIN".equals(user.getRole().getRoleName())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "overview";

        switch (action) {
            case "approve-provider" -> approveProvider(request, response);
            case "reject-provider" -> rejectProvider(request, response);
            case "approve-tour" -> approveTour(request, response);
            case "reject-tour" -> rejectTour(request, response);
            default -> showDashboard(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @SuppressWarnings("unchecked")
    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // ═══ KPIs ═══
            Long totalUsers = (Long) em.createQuery("SELECT COUNT(u) FROM User u").getSingleResult();
            Long totalOrders = (Long) em.createQuery("SELECT COUNT(o) FROM Order o").getSingleResult();
            Long pendingOrders = (Long) em.createQuery("SELECT COUNT(o) FROM Order o WHERE o.orderStatus = 'Pending'").getSingleResult();
            Long confirmedOrders = (Long) em.createQuery("SELECT COUNT(o) FROM Order o WHERE o.orderStatus = 'Confirmed'").getSingleResult();
            Long completedOrders = (Long) em.createQuery("SELECT COUNT(o) FROM Order o WHERE o.orderStatus = 'Completed'").getSingleResult();
            Long cancelledOrders = (Long) em.createQuery("SELECT COUNT(o) FROM Order o WHERE o.orderStatus = 'Cancelled'").getSingleResult();

            TourDAO tourDAO = new TourDAO();
            long activeTours = tourDAO.findAll().size();
            long totalTours = tourDAO.findAllIncludeInactive().size();
            long pendingTours = tourDAO.findAllIncludeInactive().stream().filter(t -> !t.isActive()).count();

            Double totalRevenue = 0.0;
            try {
                Object rev = em.createQuery("SELECT COALESCE(SUM(o.totalAmount), 0) FROM Order o WHERE o.orderStatus IN ('Completed', 'Confirmed')").getSingleResult();
                totalRevenue = ((Number) rev).doubleValue();
            } catch (Exception ignored) {}

            // Consultation stats
            Long totalConsultations = 0L;
            Long newConsultations = 0L;
            try {
                totalConsultations = (Long) em.createQuery("SELECT COUNT(c) FROM Consultation c").getSingleResult();
                newConsultations = (Long) em.createQuery("SELECT COUNT(c) FROM Consultation c WHERE c.status = 'new'").getSingleResult();
            } catch (Exception ignored) {}

            // Providers
            Long totalProviders = 0L;
            Long pendingProviders = 0L;
            Long approvedProviders = 0L;
            try {
                totalProviders = (Long) em.createQuery("SELECT COUNT(p) FROM Provider p").getSingleResult();
                pendingProviders = (Long) em.createQuery("SELECT COUNT(p) FROM Provider p WHERE p.status = 'Pending'").getSingleResult();
                approvedProviders = (Long) em.createQuery("SELECT COUNT(p) FROM Provider p WHERE p.status = 'Approved'").getSingleResult();
            } catch (Exception ignored) {}

            // Pending providers list
            List<Provider> pendingProviderList = new ArrayList<>();
            try {
                pendingProviderList = em.createQuery("SELECT p FROM Provider p WHERE p.status = 'Pending' ORDER BY p.createdAt DESC", Provider.class).getResultList();
            } catch (Exception ignored) {}

            // Pending tours from providers
            List pendingTourList = new ArrayList();
            try {
                pendingTourList = em.createQuery("SELECT t FROM Tour t WHERE t.active = false ORDER BY t.createdAt DESC").getResultList();
            } catch (Exception ignored) {}

            // Reviews count
            Long totalReviews = 0L;
            try {
                totalReviews = (Long) em.createQuery("SELECT COUNT(r) FROM Review r").getSingleResult();
            } catch (Exception ignored) {}

            // Coupons
            Long totalCoupons = 0L;
            try {
                totalCoupons = (Long) em.createQuery("SELECT COUNT(c) FROM Coupon c").getSingleResult();
            } catch (Exception ignored) {}

            // Set all attributes
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("pendingOrders", pendingOrders);
            request.setAttribute("confirmedOrders", confirmedOrders);
            request.setAttribute("completedOrders", completedOrders);
            request.setAttribute("cancelledOrders", cancelledOrders);
            request.setAttribute("activeTours", activeTours);
            request.setAttribute("totalTours", totalTours);
            request.setAttribute("pendingTours", pendingTours);
            request.setAttribute("grossRevenue", totalRevenue);
            request.setAttribute("totalProviders", totalProviders);
            request.setAttribute("pendingProviders", pendingProviders);
            request.setAttribute("approvedProviders", approvedProviders);
            request.setAttribute("pendingProviderList", pendingProviderList);
            request.setAttribute("pendingTourList", pendingTourList);
            request.setAttribute("totalReviews", totalReviews);
            request.setAttribute("totalCoupons", totalCoupons);
            request.setAttribute("totalConsultations", totalConsultations);
            request.setAttribute("newConsultations", newConsultations);

            // ═══ SPA DATA: Lists for inline sections ═══
            try {
                List<?> customerList = em.createQuery("SELECT u FROM User u ORDER BY u.userId DESC").getResultList();
                request.setAttribute("customerList", customerList);
            } catch (Exception ignored) {}

            try {
                List<?> orderList = em.createQuery("SELECT o FROM Order o ORDER BY o.orderDate DESC").setMaxResults(50).getResultList();
                request.setAttribute("orderList", orderList);
            } catch (Exception ignored) {}

            List<?> tourList = tourDAO.findAllIncludeInactive();
            request.setAttribute("tourList", tourList);

            // Categories for SPA section
            try {
                List<?> categoryList = em.createQuery("SELECT c FROM Category c ORDER BY c.categoryName").getResultList();
                request.setAttribute("categoryList", categoryList);
            } catch (Exception ignored) {}

            // Consultation list for SPA section
            Long contactedConsultations = 0L;
            Long doneConsultations = 0L;
            try {
                ConsultationDAO consultDAO = new ConsultationDAO();
                List<?> consultationList = consultDAO.findAll();
                request.setAttribute("consultationList", consultationList);
                contactedConsultations = consultDAO.countByStatus("contacted");
                doneConsultations = consultDAO.countByStatus("done");
            } catch (Exception ignored) {}
            request.setAttribute("contactedConsultations", contactedConsultations);
            request.setAttribute("doneConsultations", doneConsultations);

            // Coupon list for SPA section
            try {
                CouponDAO couponDAO = new CouponDAO();
                List<?> couponList = couponDAO.findAll();
                request.setAttribute("couponList", couponList);
            } catch (Exception ignored) {}

            // All providers for SPA section
            try {
                List<?> providerList = em.createQuery("SELECT p FROM Provider p ORDER BY p.joinDate DESC").getResultList();
                request.setAttribute("providerList", providerList);
            } catch (Exception ignored) {}

            // Provider comparison data
            try {
                List<?> priceHistory = em.createQuery("SELECT ph FROM ProviderPriceHistory ph ORDER BY ph.changeDate DESC").setMaxResults(50).getResultList();
                request.setAttribute("priceHistory", priceHistory);
                // Provider ranking: avg price by provider
                List<?> providerAvgPrices = em.createQuery("SELECT ph.provider.businessName, AVG(ph.newPrice), COUNT(ph) FROM ProviderPriceHistory ph GROUP BY ph.provider.businessName ORDER BY AVG(ph.newPrice) ASC").getResultList();
                request.setAttribute("providerAvgPrices", providerAvgPrices);
                // Provider ranking: by rating
                List<?> providerRanking = em.createQuery("SELECT p FROM Provider p WHERE p.rating IS NOT NULL ORDER BY p.rating DESC").getResultList();
                request.setAttribute("providerRanking", providerRanking);
            } catch (Exception ignored) {}

            // ═══ CHATBOT ANALYTICS (real data) ═══
            try {
                com.dananghub.dao.ChatbotLogDAO chatbotDAO = new com.dananghub.dao.ChatbotLogDAO();
                long cbTotal = chatbotDAO.countAll();
                request.setAttribute("cbTotal", cbTotal);

                List<Object[]> cbCategories = chatbotDAO.getQuestionCountByCategory();
                request.setAttribute("cbCategories", cbCategories);

                List<Object[]> cbTopQuestions = chatbotDAO.getTopQuestions(10);
                request.setAttribute("cbTopQuestions", cbTopQuestions);

                List<com.dananghub.entity.ChatbotLog> cbRecent = chatbotDAO.getRecentQuestions(20);
                request.setAttribute("cbRecent", cbRecent);

                double cbAvgTime = chatbotDAO.getAvgResponseTime();
                request.setAttribute("cbAvgTime", cbAvgTime);
            } catch (Exception ignored) {
                request.setAttribute("cbTotal", 0L);
            }

            // AI DATA
            loadAIData(request, em);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }

    private void approveProvider(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Provider p = em.find(Provider.class, id);
            if (p != null) { p.setStatus("Approved"); p.setVerified(true); em.merge(p); }
            tx.commit();
        } catch (Exception e) { if (tx.isActive()) tx.rollback(); e.printStackTrace(); }
        finally { em.close(); }
        response.sendRedirect(request.getContextPath() + "/admin/dashboard?success=provider_approved&section=providers");
    }

    private void rejectProvider(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Provider p = em.find(Provider.class, id);
            if (p != null) { p.setStatus("Rejected"); em.merge(p); }
            tx.commit();
        } catch (Exception e) { if (tx.isActive()) tx.rollback(); e.printStackTrace(); }
        finally { em.close(); }
        response.sendRedirect(request.getContextPath() + "/admin/dashboard?success=provider_rejected&section=providers");
    }

    private void approveTour(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.createQuery("UPDATE Tour t SET t.active = true WHERE t.tourId = :id").setParameter("id", id).executeUpdate();
            tx.commit();
        } catch (Exception e) { if (tx.isActive()) tx.rollback(); e.printStackTrace(); }
        finally { em.close(); }
        response.sendRedirect(request.getContextPath() + "/admin/dashboard?success=tour_approved&section=tours-mgmt");
    }

    private void rejectTour(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.createQuery("DELETE FROM Tour t WHERE t.tourId = :id").setParameter("id", id).executeUpdate();
            tx.commit();
        } catch (Exception e) { if (tx.isActive()) tx.rollback(); e.printStackTrace(); }
        finally { em.close(); }
        response.sendRedirect(request.getContextPath() + "/admin/dashboard?success=tour_rejected&section=tours-mgmt");
    }

    @SuppressWarnings("unchecked")
    private void loadAIData(HttpServletRequest request, EntityManager em) {
        try {
            Query q1 = em.createNativeQuery(
                "SELECT \"MonthYear\", \"BookingRevenue\", \"FlightRevenue\", \"GuestCount\", \"SeasonType\" " +
                "FROM \"MonthlyTourismStats\" ORDER BY \"Id\" ASC");
            List<Object[]> stats = q1.getResultList();

            StringBuilder labels = new StringBuilder("[");
            StringBuilder bRev = new StringBuilder("[");
            StringBuilder fRev = new StringBuilder("[");
            StringBuilder guests = new StringBuilder("[");
            StringBuilder seasons = new StringBuilder("[");

            for (int i = 0; i < stats.size(); i++) {
                Object[] r = stats.get(i);
                if (i > 0) { labels.append(","); bRev.append(","); fRev.append(","); guests.append(","); seasons.append(","); }
                labels.append("\"").append(r[0]).append("\"");
                bRev.append(r[1]); fRev.append(r[2]); guests.append(r[3]);
                seasons.append("\"").append(r[4]).append("\"");
            }
            labels.append("]"); bRev.append("]"); fRev.append("]"); guests.append("]"); seasons.append("]");

            request.setAttribute("chartLabels", labels.toString());
            request.setAttribute("chartBookingRev", bRev.toString());
            request.setAttribute("chartFlightRev", fRev.toString());
            request.setAttribute("chartGuestCounts", guests.toString());
            request.setAttribute("chartSeasons", seasons.toString());
            request.setAttribute("totalDataPoints", stats.size());

            Query q2 = em.createNativeQuery(
                "SELECT \"TourName\", SUM(\"Revenue\") as tr, SUM(\"BookingCount\") as tb " +
                "FROM \"TourPerformance\" GROUP BY \"TourName\" ORDER BY tr DESC LIMIT 6");
            List<Object[]> tops = q2.getResultList();

            StringBuilder tNames = new StringBuilder("[");
            StringBuilder tRevs = new StringBuilder("[");
            StringBuilder tBooks = new StringBuilder("[");
            for (int i = 0; i < tops.size(); i++) {
                Object[] r = tops.get(i);
                if (i > 0) { tNames.append(","); tRevs.append(","); tBooks.append(","); }
                tNames.append("\"").append(r[0]).append("\"");
                tRevs.append(((Number) r[1]).doubleValue());
                tBooks.append(((Number) r[2]).longValue());
            }
            tNames.append("]"); tRevs.append("]"); tBooks.append("]");
            request.setAttribute("topTourNames", tNames.toString());
            request.setAttribute("topTourRevenues", tRevs.toString());
            request.setAttribute("topTourBookings", tBooks.toString());

            Query q3 = em.createNativeQuery(
                "SELECT EXTRACT(MONTH FROM \"Date\") as m, ROUND(CAST(AVG(\"Temp\") AS numeric),1), ROUND(CAST(AVG(\"Precipitation\") AS numeric),1) " +
                "FROM \"WeatherData\" GROUP BY m ORDER BY m");
            List<Object[]> wData = q3.getResultList();
            String[] mNames = {"","T1","T2","T3","T4","T5","T6","T7","T8","T9","T10","T11","T12"};
            StringBuilder wM = new StringBuilder("[");
            StringBuilder wT = new StringBuilder("[");
            StringBuilder wR = new StringBuilder("[");
            for (int i = 0; i < wData.size(); i++) {
                Object[] r = wData.get(i);
                int mi = ((Number) r[0]).intValue();
                if (i > 0) { wM.append(","); wT.append(","); wR.append(","); }
                wM.append("\"").append(mNames[mi]).append("\"");
                wT.append(r[1]); wR.append(r[2]);
            }
            wM.append("]"); wT.append("]"); wR.append("]");
            request.setAttribute("weatherMonths", wM.toString());
            request.setAttribute("weatherTemps", wT.toString());
            request.setAttribute("weatherRain", wR.toString());

            request.setAttribute("aiDataLoaded", true);
        } catch (Exception e) {
            getServletContext().log("AI data not loaded: " + e.getMessage());
            request.setAttribute("aiDataLoaded", false);
        }
    }
}
