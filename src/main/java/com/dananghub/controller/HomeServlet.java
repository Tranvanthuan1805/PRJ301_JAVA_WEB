package com.dananghub.controller;

import com.dananghub.dao.TourDAO;
import com.dananghub.entity.Tour;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private final TourDAO tourDAO = new TourDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            getServletContext().log("HomeServlet: Loading top 6 tours...");
            List<Tour> tours = tourDAO.findTop(6);
            getServletContext().log("HomeServlet: Found " + (tours != null ? tours.size() : "null") + " tours");
            if (tours != null && !tours.isEmpty()) {
                request.setAttribute("listTours", tours);
            }
        } catch (Exception e) {
            getServletContext().log("HomeServlet ERROR: " + e.getMessage(), e);
        }
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
