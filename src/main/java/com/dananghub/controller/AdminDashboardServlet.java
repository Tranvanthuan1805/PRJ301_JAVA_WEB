package com.dananghub.controller;

import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

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

            // Basic stats
            Long totalUsers = (Long) em.createQuery("SELECT COUNT(u) FROM User u").getSingleResult();
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

            // === AI ANALYTICS DATA ===
            try {
                // 1. Monthly Tourism Stats (5 years)
                Query q1 = em.createNativeQuery(
                    "SELECT \"MonthYear\", \"BookingRevenue\", \"FlightRevenue\", \"GuestCount\", \"SeasonType\" " +
                    "FROM \"MonthlyTourismStats\" ORDER BY \"Id\" ASC"
                );
                List<Object[]> tourismStats = q1.getResultList();

                // Build JSON arrays for charts
                StringBuilder labels = new StringBuilder("[");
                StringBuilder bookingRev = new StringBuilder("[");
                StringBuilder flightRev = new StringBuilder("[");
                StringBuilder guestCounts = new StringBuilder("[");
                StringBuilder seasons = new StringBuilder("[");

                for (int i = 0; i < tourismStats.size(); i++) {
                    Object[] row = tourismStats.get(i);
                    if (i > 0) { labels.append(","); bookingRev.append(","); flightRev.append(","); guestCounts.append(","); seasons.append(","); }
                    labels.append("\"").append(row[0]).append("\"");
                    bookingRev.append(row[1]);
                    flightRev.append(row[2]);
                    guestCounts.append(row[3]);
                    seasons.append("\"").append(row[4]).append("\"");
                }
                labels.append("]"); bookingRev.append("]"); flightRev.append("]"); guestCounts.append("]"); seasons.append("]");

                request.setAttribute("chartLabels", labels.toString());
                request.setAttribute("chartBookingRev", bookingRev.toString());
                request.setAttribute("chartFlightRev", flightRev.toString());
                request.setAttribute("chartGuestCounts", guestCounts.toString());
                request.setAttribute("chartSeasons", seasons.toString());
                request.setAttribute("totalDataPoints", tourismStats.size());

                // 2. Top performing tours
                Query q2 = em.createNativeQuery(
                    "SELECT \"TourName\", SUM(\"Revenue\") as total_rev, SUM(\"BookingCount\") as total_bookings " +
                    "FROM \"TourPerformance\" GROUP BY \"TourName\" ORDER BY total_rev DESC LIMIT 6"
                );
                List<Object[]> topTours = q2.getResultList();

                StringBuilder tourNames = new StringBuilder("[");
                StringBuilder tourRevenues = new StringBuilder("[");
                StringBuilder tourBookings = new StringBuilder("[");

                for (int i = 0; i < topTours.size(); i++) {
                    Object[] row = topTours.get(i);
                    if (i > 0) { tourNames.append(","); tourRevenues.append(","); tourBookings.append(","); }
                    tourNames.append("\"").append(row[0]).append("\"");
                    tourRevenues.append(((Number) row[1]).doubleValue());
                    tourBookings.append(((Number) row[2]).longValue());
                }
                tourNames.append("]"); tourRevenues.append("]"); tourBookings.append("]");

                request.setAttribute("topTourNames", tourNames.toString());
                request.setAttribute("topTourRevenues", tourRevenues.toString());
                request.setAttribute("topTourBookings", tourBookings.toString());

                // 3. Weather averages by month
                Query q3 = em.createNativeQuery(
                    "SELECT EXTRACT(MONTH FROM \"Date\") as m, ROUND(CAST(AVG(\"Temp\") AS numeric), 1), ROUND(CAST(AVG(\"Precipitation\") AS numeric), 1), ROUND(CAST(AVG(\"Humidity\") AS numeric), 0) " +
                    "FROM \"WeatherData\" GROUP BY m ORDER BY m"
                );
                List<Object[]> weatherAvg = q3.getResultList();

                StringBuilder weatherMonths = new StringBuilder("[");
                StringBuilder weatherTemps = new StringBuilder("[");
                StringBuilder weatherRain = new StringBuilder("[");

                String[] monthNames = {"", "T1", "T2", "T3", "T4", "T5", "T6", "T7", "T8", "T9", "T10", "T11", "T12"};
                for (int i = 0; i < weatherAvg.size(); i++) {
                    Object[] row = weatherAvg.get(i);
                    int monthIdx = ((Number) row[0]).intValue();
                    if (i > 0) { weatherMonths.append(","); weatherTemps.append(","); weatherRain.append(","); }
                    weatherMonths.append("\"").append(monthNames[monthIdx]).append("\"");
                    weatherTemps.append(row[1]);
                    weatherRain.append(row[2]);
                }
                weatherMonths.append("]"); weatherTemps.append("]"); weatherRain.append("]");

                request.setAttribute("weatherMonths", weatherMonths.toString());
                request.setAttribute("weatherTemps", weatherTemps.toString());
                request.setAttribute("weatherRain", weatherRain.toString());

                request.setAttribute("aiDataLoaded", true);
            } catch (Exception aiEx) {
                getServletContext().log("AI Analytics data not available: " + aiEx.getMessage());
                request.setAttribute("aiDataLoaded", false);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("totalUsers", 0);
            request.setAttribute("activeTours", 0);
            request.setAttribute("totalBookings", 0);
            request.setAttribute("pendingRequests", 0);
            request.setAttribute("grossRevenue", 0);
            request.setAttribute("aiDataLoaded", false);
        } finally {
            if (em != null) em.close();
        }

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}

