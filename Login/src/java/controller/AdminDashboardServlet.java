package controller;

import dao.CustomerDAO;
import dao.OrderDAO;
import dao.TourDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Order;
import model.Tour;

import java.io.IOException;
import java.text.NumberFormat;
import java.util.*;

/**
 * AdminDashboardServlet - Professional Admin Dashboard
 * Aggregates all business metrics for the admin overview
 */
@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Auth check
        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            OrderDAO orderDAO = new OrderDAO();
            TourDAO tourDAO = new TourDAO();
            CustomerDAO customerDAO = new CustomerDAO();

            // ========== KPI Cards ==========
            int totalOrders = (int) orderDAO.countAllOrders();
            double totalRevenue = orderDAO.getTotalRevenue();
            int totalTours = (int) tourDAO.countTours();
            int totalCustomers = customerDAO.getTotalCustomers();

            // Order status counts
            int pendingOrders = (int) orderDAO.countByStatus("Pending");
            int confirmedOrders = (int) orderDAO.countByStatus("Confirmed");
            int completedOrders = (int) orderDAO.countByStatus("Completed");
            int cancelledOrders = (int) orderDAO.countByStatus("Cancelled");

            // Customer status counts
            int activeCustomers = customerDAO.getCountByStatus("active");
            int inactiveCustomers = customerDAO.getCountByStatus("inactive");
            int bannedCustomers = customerDAO.getCountByStatus("banned");

            // Historical tours
            int historicalTours = (int) tourDAO.countHistoricalTours();

            // ========== Recent Orders (Latest 8) ==========
            List<Order> recentOrders = orderDAO.getRecentOrders(8);

            // ========== Top Tours ==========
            List<Object[]> topTours = tourDAO.getTopBookedTours(5);

            // ========== Format Revenue ==========
            NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
            String formattedRevenue = nf.format(totalRevenue);

            // ========== Occupancy rates ==========
            List<Object[]> occupancyRates = tourDAO.getOccupancyRates();

            // Calculate average occupancy
            double avgOccupancy = 0;
            if (occupancyRates != null && !occupancyRates.isEmpty()) {
                double totalOcc = 0;
                for (Object[] row : occupancyRates) {
                    int maxCap = ((Number) row[1]).intValue();
                    int curCap = ((Number) row[2]).intValue();
                    if (maxCap > 0) {
                        totalOcc += (double) curCap / maxCap * 100;
                    }
                }
                avgOccupancy = totalOcc / occupancyRates.size();
            }

            // Conversion rate (completed / total orders * 100)
            double conversionRate = totalOrders > 0 ? (double) completedOrders / totalOrders * 100 : 0;

            // ========== Set Attributes ==========
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("formattedRevenue", formattedRevenue);
            request.setAttribute("totalTours", totalTours);
            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("historicalTours", historicalTours);

            request.setAttribute("pendingOrders", pendingOrders);
            request.setAttribute("confirmedOrders", confirmedOrders);
            request.setAttribute("completedOrders", completedOrders);
            request.setAttribute("cancelledOrders", cancelledOrders);

            request.setAttribute("activeCustomers", activeCustomers);
            request.setAttribute("inactiveCustomers", inactiveCustomers);
            request.setAttribute("bannedCustomers", bannedCustomers);

            request.setAttribute("recentOrders", recentOrders);
            request.setAttribute("topTours", topTours);
            request.setAttribute("occupancyRates", occupancyRates);
            request.setAttribute("avgOccupancy", String.format("%.1f", avgOccupancy));
            request.setAttribute("conversionRate", String.format("%.1f", conversionRate));

            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi tải dashboard: " + e.getMessage());
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
        }
    }
}
