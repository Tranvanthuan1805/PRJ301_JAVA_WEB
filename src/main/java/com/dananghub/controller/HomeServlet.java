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
            getServletContext().log("HomeServlet: Loading tours from database...");
            List<Tour> tours = tourDAO.findAll();
            getServletContext().log("HomeServlet: Found " + (tours != null ? tours.size() : "null") + " tours");
            if (tours != null && !tours.isEmpty()) {
                if (tours.size() > 6) {
                    tours = tours.subList(0, 6);
                }
                request.setAttribute("listTours", tours);
                getServletContext().log("HomeServlet: Set listTours with " + tours.size() + " tours");
            } else {
                getServletContext().log("HomeServlet: No tours found in database!");
            }
        } catch (Exception e) {
            getServletContext().log("HomeServlet ERROR: " + e.getMessage(), e);
        }
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
