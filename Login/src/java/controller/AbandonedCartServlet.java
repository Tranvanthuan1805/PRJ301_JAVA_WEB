package controller;

import dao.AbandonedCartDAO;
import model.AbandonedCart;
import model.User;
import service.AbandonedCartService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet để xem và quản lý abandoned carts (Admin only)
 */
@WebServlet(name = "AbandonedCartServlet", urlPatterns = {"/admin/abandoned-carts", "/admin/abandoned-carts/*"})
public class AbandonedCartServlet extends HttpServlet {
    
    private AbandonedCartService abandonedCartService;
    
    @Override
    public void init() throws ServletException {
        abandonedCartService = new AbandonedCartService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check admin permission
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Hiển thị dashboard
            showDashboard(request, response);
        } else if (pathInfo.equals("/api/stats")) {
            // API: Statistics
            getStatistics(request, response);
        } else if (pathInfo.equals("/api/list")) {
            // API: List abandoned carts
            getAbandonedCartsList(request, response);
        } else if (pathInfo.equals("/api/recommendations")) {
            // API: AI Recommendations
            getAIRecommendations(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    /**
     * Hiển thị dashboard
     */
    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy statistics
        AbandonedCartDAO.AbandonedCartStats stats = abandonedCartService.getStatistics();
        
        // Lấy abandoned carts
        List<AbandonedCart> carts = abandonedCartService.getAllAbandonedCarts(50);
        
        request.setAttribute("stats", stats);
        request.setAttribute("abandonedCarts", carts);
        
        request.getRequestDispatcher("/jsp/admin/abandoned-carts.jsp").forward(request, response);
    }
    
    /**
     * API: Get statistics
     */
    private void getStatistics(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        AbandonedCartDAO.AbandonedCartStats stats = abandonedCartService.getStatistics();
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        // Manual JSON building
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"totalAbandoned\":").append(stats.totalAbandoned).append(",");
        json.append("\"totalConverted\":").append(stats.totalConverted).append(",");
        json.append("\"totalReminderSent\":").append(stats.totalReminderSent).append(",");
        json.append("\"avgHoursAbandoned\":").append(stats.avgHoursAbandoned).append(",");
        json.append("\"conversionRate\":").append(stats.conversionRate);
        json.append("}");
        
        out.print(json.toString());
        out.flush();
    }
    
    /**
     * API: Get abandoned carts list
     */
    private void getAbandonedCartsList(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        int limit = 50;
        String limitParam = request.getParameter("limit");
        if (limitParam != null) {
            try {
                limit = Integer.parseInt(limitParam);
            } catch (NumberFormatException e) {
                // Use default
            }
        }
        
        List<AbandonedCart> carts = abandonedCartService.getAllAbandonedCarts(limit);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        out.print("[");
        for (int i = 0; i < carts.size(); i++) {
            AbandonedCart cart = carts.get(i);
            if (i > 0) out.print(",");
            out.print("{");
            out.print("\"id\":" + cart.getId() + ",");
            out.print("\"tourId\":" + cart.getTourId() + ",");
            out.print("\"quantity\":" + cart.getQuantity() + ",");
            out.print("\"priority\":\"" + cart.getPriorityLevel() + "\",");
            out.print("\"hoursSinceAbandoned\":" + cart.getHoursSinceAbandoned());
            out.print("}");
        }
        out.print("]");
        out.flush();
    }
    
    /**
     * API: Get AI recommendations
     */
    private void getAIRecommendations(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        List<AbandonedCart> carts = abandonedCartService.getCartsForReminder();
        List<AbandonedCartService.AIRecommendation> recommendations = new ArrayList<>();
        
        for (AbandonedCart cart : carts) {
            AbandonedCartService.AIRecommendation recommendation = 
                abandonedCartService.getAIRecommendation(cart);
            recommendations.add(recommendation);
        }
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        out.print("[");
        for (int i = 0; i < recommendations.size(); i++) {
            if (i > 0) out.print(",");
            out.print(recommendations.get(i).toJSON());
        }
        out.print("]");
        out.flush();
    }
}
