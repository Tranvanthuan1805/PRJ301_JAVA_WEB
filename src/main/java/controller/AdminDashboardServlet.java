package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Prepare mock stats for demonstration
        request.setAttribute("totalBookings", 128);
        request.setAttribute("grossRevenue", 25400.50);
        request.setAttribute("activeTours", 14);
        request.setAttribute("pendingRequests", 5);
        
        request.setAttribute("activePage", "dashboard");
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
