package controller;

import dao.TourDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * AdminTourAnalyticsServlet - View tour analytics and statistics
 * Admin only
 */
@WebServlet("/admin/tour-analytics")
public class AdminTourAnalyticsServlet extends HttpServlet {
    
    private TourDAO tourDAO;
    
    @Override
    public void init() throws ServletException {
        tourDAO = new TourDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check admin authentication
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        
        if (username == null || !"ADMIN".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Get analytics data
        List<Object[]> topBookedTours = tourDAO.getTopBookedTours(10);
        List<Object[]> leastBookedTours = tourDAO.getLeastBookedTours(10);
        List<Object[]> occupancyRates = tourDAO.getOccupancyRates();
        
        // Set attributes
        request.setAttribute("topBookedTours", topBookedTours);
        request.setAttribute("leastBookedTours", leastBookedTours);
        request.setAttribute("occupancyRates", occupancyRates);
        
        // Forward to analytics page
        request.getRequestDispatcher("/admin/tour-analytics.jsp").forward(request, response);
    }
}
