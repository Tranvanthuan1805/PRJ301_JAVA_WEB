package controller;

import dao.TourDAO;
import model.Tour;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DetailServlet", urlPatterns = {"/detail"})
public class DetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("home");
            return;
        }

        try {
            int tourId = Integer.parseInt(idParam);
            TourDAO dao = new TourDAO();
            Tour tour = dao.getTourById(tourId);

            if (tour == null) {
                // Tour not found
                request.setAttribute("error", "Tour không tồn tại!");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            request.setAttribute("tour", tour);
            
            // Cài đặt chỗ còn trống (Mock data, sau này lấy từ BookingDAO)
            request.setAttribute("remaining", tour.getMaxPeople()); 
            
            request.getRequestDispatcher("detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("home");
        }
    }
}
