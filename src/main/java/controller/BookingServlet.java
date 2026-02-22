package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.entity.Tour;
import model.entity.dao.TourDAO;

@WebServlet("/customer/book")
public class BookingServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tourIdStr = request.getParameter("tourId");
        if (tourIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        int tourId = Integer.parseInt(tourIdStr);
        TourDAO tourDAO = new TourDAO();
        Tour tour = tourDAO.getTourById(tourId);

        if (tour == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Tour not found");
            return;
        }

        request.setAttribute("tour", tour);
        request.setAttribute("step", 1); // Start at step 1
        request.getRequestDispatcher("/customer/booking_flow.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String stepStr = request.getParameter("step");
        int step = Integer.parseInt(stepStr != null ? stepStr : "1");
        
        // Handle logic for each step (simulated for now)
        if (step == 1) {
            // Validate Date & Quantity
            request.setAttribute("step", 2);
        } else if (step == 2) {
            // Save Contact Info in Session
            request.setAttribute("step", 3);
        } else if (step == 3) {
            // Finalize Order
            response.sendRedirect(request.getContextPath() + "/views/cart-booking/confirmation.jsp");
            return;
        }
        
        int tourId = Integer.parseInt(request.getParameter("tourId"));
        TourDAO tourDAO = new TourDAO();
        request.setAttribute("tour", tourDAO.getTourById(tourId));
        request.getRequestDispatcher("/customer/booking_flow.jsp").forward(request, response);
    }
}
