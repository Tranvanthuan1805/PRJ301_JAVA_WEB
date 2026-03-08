package com.dananghub.controller;

import com.dananghub.dao.TourDAO;
import com.dananghub.entity.Tour;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet cho 3D Tour Gallery - Xem tour bằng 3D carousel & Rubik cube
 */
@WebServlet("/tour-3d")
public class Tour3DServlet extends HttpServlet {

    private final TourDAO tourDAO = new TourDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Tour> tours = tourDAO.findAll();
        request.setAttribute("tours", tours);
        request.getRequestDispatcher("/views/tour-3d/gallery.jsp").forward(request, response);
    }
}
