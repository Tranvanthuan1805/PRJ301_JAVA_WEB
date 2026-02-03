package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import model.Tour;
import dao.TourDAO;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        TourDAO tourDAO = new TourDAO();
        List<Tour> listTours = tourDAO.getAllTours();
        
        // Fallback mock data if DB is empty (for demo purposes if someone clones without DB)
        if (listTours.isEmpty()) {
             // Optional: You could log this or leave it empty.
             // For now, let's just pass the empty list so the JSP handles it (shows "No tours found")
        }

        request.setAttribute("listTours", listTours);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
