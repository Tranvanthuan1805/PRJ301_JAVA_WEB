package com.dananghub.controller;
import com.dananghub.dao.TourDAO;
import com.dananghub.dao.CategoryDAO;
import com.dananghub.dao.ProviderDAO;
import com.dananghub.entity.Tour;
import com.dananghub.entity.Category;
import com.dananghub.entity.User;
import com.dananghub.entity.Provider;

import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/admin/tours")
public class AdminTourServlet extends HttpServlet {

    private TourDAO tourDAO;
    private CategoryDAO categoryDAO;
    private ProviderDAO providerDAO;

    @Override
    public void init() throws ServletException {
        tourDAO = new TourDAO();
        categoryDAO = new CategoryDAO();
        providerDAO = new ProviderDAO();
    }

    private boolean checkAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;
        if (user == null || user.getRole() == null || !"ADMIN".equals(user.getRole().getRoleName())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return false;
        }
        return true;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!checkAdmin(request, response)) return;

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "add" -> showForm(request, response, null);
                case "edit" -> {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Tour tour = tourDAO.findById(id);
                    showForm(request, response, tour);
                }
                case "delete" -> deleteTour(request, response);
                case "view" -> viewTour(request, response);
                case "history" -> showHistory(request, response);
                case "analytics" -> showAnalytics(request, response);
                default -> listTours(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!checkAdmin(request, response)) return;
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        try {
            if ("create".equals(action)) {
                createTour(request, response);
            } else if ("update".equals(action)) {
                updateTour(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error: " + e.getMessage(), e);
        }
    }

    private void listTours(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int page = 1, perPage = 10;
        try { page = Math.max(1, Integer.parseInt(request.getParameter("page"))); } catch (Exception e) {}

        String search = request.getParameter("search");
        String sortBy = request.getParameter("sortBy");
        String filterStatus = request.getParameter("status");

        List<Tour> allTours = tourDAO.findAllIncludeInactive();

        // Search
        if (search != null && !search.trim().isEmpty()) {
            final String q = search.toLowerCase();
            allTours = allTours.stream()
                .filter(t -> t.getTourName().toLowerCase().contains(q) ||
                             (t.getDestination() != null && t.getDestination().toLowerCase().contains(q)))
                .collect(Collectors.toList());
            request.setAttribute("search", search);
        }

        // Status filter: active / inactive / full
        if (filterStatus != null && !filterStatus.isEmpty()) {
            switch (filterStatus) {
                case "active" -> allTours = allTours.stream().filter(Tour::isActive).collect(Collectors.toList());
                case "inactive" -> allTours = allTours.stream().filter(t -> !t.isActive()).collect(Collectors.toList());
            }
            request.setAttribute("filterStatus", filterStatus);
        }

        // Sort
        if (sortBy != null && !sortBy.isEmpty()) {
            switch (sortBy) {
                case "name_asc" -> allTours.sort((a, b) -> a.getTourName().compareToIgnoreCase(b.getTourName()));
                case "name_desc" -> allTours.sort((a, b) -> b.getTourName().compareToIgnoreCase(a.getTourName()));
                case "price_asc" -> allTours.sort(Comparator.comparingDouble(Tour::getPrice));
                case "price_desc" -> allTours.sort((a, b) -> Double.compare(b.getPrice(), a.getPrice()));
                case "newest" -> allTours.sort((a, b) -> {
                    if (b.getCreatedAt() == null) return -1;
                    if (a.getCreatedAt() == null) return 1;
                    return b.getCreatedAt().compareTo(a.getCreatedAt());
                });
            }
            request.setAttribute("sortBy", sortBy);
        }

        int total = allTours.size();
        int totalPages = (int) Math.ceil((double) total / perPage);
        page = Math.min(page, Math.max(1, totalPages));
        int start = (page - 1) * perPage;
        int end = Math.min(start + perPage, total);
        List<Tour> tours = start < total ? allTours.subList(start, end) : List.of();

        List<Category> categories = categoryDAO.findAll();

        request.setAttribute("tours", tours);
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalTours", total);
        request.setAttribute("activeTours", allTours.stream().filter(Tour::isActive).count());

        // Load Dashboard KPI data (inline)
        loadDashboardData(request);

        // Load AI Analytics data for Neural Network tab
        loadAIData(request);

        request.getRequestDispatcher("/admin/tours.jsp").forward(request, response);
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response, Tour tour)
            throws ServletException, IOException {
        List<Category> categories = categoryDAO.findAll();
        request.setAttribute("categories", categories);
        request.setAttribute("providers", providerDAO.findAllActive());
        if (tour != null) {
            request.setAttribute("tour", tour);
            request.setAttribute("editMode", true);
        }
        request.getRequestDispatcher("/admin/tour-form.jsp").forward(request, response);
    }

    private void viewTour(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        response.sendRedirect(request.getContextPath() + "/tour?action=view&id=" + id);
    }

    private void createTour(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        Tour tour = new Tour();
        populateTour(tour, request);
        tour.setActive(true);
        tour.setCreatedAt(new Date());

        boolean ok = tourDAO.create(tour);
        if (ok) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard?success=created");
        } else {
            request.setAttribute("error", "Không thể tạo tour. Kiểm tra lại dữ liệu.");
            showForm(request, response, null);
        }
    }

    private void updateTour(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("tourId"));
        Tour tour = tourDAO.findById(id);
        if (tour != null) {
            populateTour(tour, request);
            tour.setUpdatedAt(new Date());
            String isActive = request.getParameter("isActive");
            tour.setActive("true".equals(isActive) || "on".equals(isActive));
            tourDAO.update(tour);
        }
        response.sendRedirect(request.getContextPath() + "/admin/dashboard?success=updated");
    }

    private void deleteTour(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Tour tour = tourDAO.findById(id);
        if (tour != null) {
            tour.setActive(false);
            tour.setUpdatedAt(new Date());
            tourDAO.update(tour);
        }
        response.sendRedirect(request.getContextPath() + "/admin/dashboard?success=deleted");
    }

    private void showHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1, perPage = 10;
        try { page = Math.max(1, Integer.parseInt(request.getParameter("page"))); } catch (Exception e) {}
        String search = request.getParameter("search");

        List<Tour> allTours = tourDAO.findAllIncludeInactive().stream()
            .filter(t -> !t.isActive())
            .collect(Collectors.toList());

        if (search != null && !search.trim().isEmpty()) {
            final String q = search.toLowerCase();
            allTours = allTours.stream()
                .filter(t -> t.getTourName().toLowerCase().contains(q))
                .collect(Collectors.toList());
            request.setAttribute("search", search);
        }

        int total = allTours.size();
        int totalPages = (int) Math.ceil((double) total / perPage);
        page = Math.min(page, Math.max(1, totalPages));
        int start = (page - 1) * perPage;
        int end = Math.min(start + perPage, total);
        List<Tour> tours = start < total ? allTours.subList(start, end) : List.of();

        request.setAttribute("tours", tours);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalTours", total);
        request.getRequestDispatcher("/admin/tour-history.jsp").forward(request, response);
    }

    private void showAnalytics(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Tour> allTours = tourDAO.findAllIncludeInactive();

        long active = allTours.stream().filter(Tour::isActive).count();
        long inactive = allTours.size() - active;
        double avgPrice = allTours.stream().mapToDouble(Tour::getPrice).average().orElse(0);
        int totalCapacity = allTours.stream().mapToInt(Tour::getMaxPeople).sum();

        request.setAttribute("totalTours", allTours.size());
        request.setAttribute("activeTours", active);
        request.setAttribute("inactiveTours", inactive);
        request.setAttribute("avgPrice", avgPrice);
        request.setAttribute("totalCapacity", totalCapacity);
        request.setAttribute("tours", allTours);
        request.getRequestDispatcher("/admin/tour-analytics.jsp").forward(request, response);
    }

    private void populateTour(Tour tour, HttpServletRequest request) {
        tour.setTourName(request.getParameter("tourName"));
        tour.setShortDesc(request.getParameter("shortDesc"));
        tour.setDescription(request.getParameter("description"));
        tour.setDuration(request.getParameter("duration"));
        tour.setTransport(request.getParameter("transport"));
        tour.setStartLocation(request.getParameter("startLocation"));
        tour.setDestination(request.getParameter("destination"));
        tour.setImageUrl(request.getParameter("imageUrl"));
        tour.setItinerary(request.getParameter("itinerary"));

        try { tour.setPrice(Double.parseDouble(request.getParameter("price"))); } catch (Exception e) {}
        try { tour.setMaxPeople(Integer.parseInt(request.getParameter("maxPeople"))); } catch (Exception e) {}

        // Parse startDate and endDate
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
        try {
            String sd = request.getParameter("startDate");
            if (sd != null && !sd.isEmpty()) tour.setStartDate(sdf.parse(sd));
        } catch (Exception e) {}
        try {
            String ed = request.getParameter("endDate");
            if (ed != null && !ed.isEmpty()) tour.setEndDate(sdf.parse(ed));
        } catch (Exception e) {}

        String categoryId = request.getParameter("categoryId");
        if (categoryId != null && !categoryId.isEmpty()) {
            Category cat = categoryDAO.findById(Integer.parseInt(categoryId));
            tour.setCategory(cat);
        }

        // Provider - load from DB properly
        String providerIdStr = request.getParameter("providerId");
        if (providerIdStr != null && !providerIdStr.isEmpty()) {
            Provider p = providerDAO.findById(Integer.parseInt(providerIdStr));
            if (p != null) tour.setProvider(p);
        }
        // Fallback: if still no provider, get first from DB
        if (tour.getProvider() == null) {
            var providers = providerDAO.findAllActive();
            if (!providers.isEmpty()) {
                tour.setProvider(providers.get(0));
            }
        }
    }

    @SuppressWarnings("unchecked")
    private void loadDashboardData(HttpServletRequest request) {
        EntityManager em = null;
        try {
            em = JPAUtil.getEntityManager();

            // User count
            Long totalUsers = (Long) em.createQuery("SELECT COUNT(u) FROM User u").getSingleResult();
            request.setAttribute("totalUsers", totalUsers);

            // Order counts
            Long totalOrders = (Long) em.createQuery("SELECT COUNT(o) FROM Order o").getSingleResult();
            Long pendingOrders = (Long) em.createQuery("SELECT COUNT(o) FROM Order o WHERE o.orderStatus = 'Pending'").getSingleResult();
            Long confirmedOrders = (Long) em.createQuery("SELECT COUNT(o) FROM Order o WHERE o.orderStatus = 'Confirmed'").getSingleResult();
            Long completedOrders = (Long) em.createQuery("SELECT COUNT(o) FROM Order o WHERE o.orderStatus = 'Completed'").getSingleResult();
            Long cancelledOrders = (Long) em.createQuery("SELECT COUNT(o) FROM Order o WHERE o.orderStatus = 'Cancelled'").getSingleResult();
            request.setAttribute("totalBookings", totalOrders);
            request.setAttribute("pendingRequests", pendingOrders);
            request.setAttribute("confirmedOrders", confirmedOrders);
            request.setAttribute("completedOrders", completedOrders);
            request.setAttribute("cancelledOrders", cancelledOrders);

            // Revenue
            Double totalRevenue = 0.0;
            try {
                Object rev = em.createQuery("SELECT COALESCE(SUM(o.totalAmount), 0) FROM Order o WHERE o.orderStatus = 'Completed'").getSingleResult();
                totalRevenue = ((Number) rev).doubleValue();
            } catch (Exception ignored) {}
            request.setAttribute("grossRevenue", totalRevenue);

            request.setAttribute("dashboardLoaded", true);
        } catch (Exception e) {
            getServletContext().log("Dashboard data not loaded: " + e.getMessage());
            request.setAttribute("dashboardLoaded", false);
        } finally {
            if (em != null) em.close();
        }
    }

    @SuppressWarnings("unchecked")
    private void loadAIData(HttpServletRequest request) {
        EntityManager em = null;
        try {
            em = JPAUtil.getEntityManager();

            // 1. Monthly Tourism Stats
            Query q1 = em.createNativeQuery(
                "SELECT \"MonthYear\", \"BookingRevenue\", \"FlightRevenue\", \"GuestCount\", \"SeasonType\" " +
                "FROM \"MonthlyTourismStats\" ORDER BY \"Id\" ASC"
            );
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

            // 2. Top Tours
            Query q2 = em.createNativeQuery(
                "SELECT \"TourName\", SUM(\"Revenue\") as tr, SUM(\"BookingCount\") as tb " +
                "FROM \"TourPerformance\" GROUP BY \"TourName\" ORDER BY tr DESC LIMIT 6"
            );
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

            // 3. Weather
            Query q3 = em.createNativeQuery(
                "SELECT EXTRACT(MONTH FROM \"Date\") as m, ROUND(CAST(AVG(\"Temp\") AS numeric),1), ROUND(CAST(AVG(\"Precipitation\") AS numeric),1) " +
                "FROM \"WeatherData\" GROUP BY m ORDER BY m"
            );
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
        } finally {
            if (em != null) em.close();
        }
    }
}
