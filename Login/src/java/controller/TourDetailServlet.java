package controller;

import dao.TourDAO;
import model.Tour;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * TourDetailServlet - Display tour details
 * Allows both guests and logged-in users to view tour details
 * Only logged-in users can book tours
 */
@WebServlet("/tour-detail")
public class TourDetailServlet extends HttpServlet {
    
    private TourDAO tourDAO;
    
    @Override
    public void init() throws ServletException {
        tourDAO = new TourDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String tourIdParam = request.getParameter("id");
        
        if (tourIdParam == null || tourIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/explore");
            return;
        }
        
        try {
            int tourId = Integer.parseInt(tourIdParam);
            Tour tour = tourDAO.getTourById(tourId);
            
            if (tour == null) {
                request.getSession().setAttribute("error", "Tour không tồn tại");
                response.sendRedirect(request.getContextPath() + "/explore");
                return;
            }
            
            request.setAttribute("tour", tour);
            request.getRequestDispatcher("/jsp/tour-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/explore");
        }
    }
}
