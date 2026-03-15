package com.dananghub.controller;

import com.dananghub.dao.TourDAO;
import com.dananghub.entity.Tour;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet cho 3D Tour Module:
 *   - /tour-3d          -> Gallery tất cả tours dạng 3D
 *   - /tour-3d?id=X     -> Viewer 3D 360° cho 1 tour cụ thể
 */
@WebServlet("/tour-3d")
public class Tour3DServlet extends HttpServlet {

    private final TourDAO tourDAO = new TourDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            // ═══ SINGLE TOUR 3D VIEWER ═══
            try {
                int tourId = Integer.parseInt(idParam);
                Tour tour = tourDAO.findById(tourId);

                if (tour == null || !tour.isActive()) {
                    response.sendRedirect(request.getContextPath() + "/tour");
                    return;
                }

                request.setAttribute("tour", tour);
                request.getRequestDispatcher("/views/provider/tour-3d-view.jsp")
                       .forward(request, response);

            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/tour");
            }
        } else {
            // ═══ 3D GALLERY (ALL TOURS) ═══
            List<Tour> tours = tourDAO.findAll();
            request.setAttribute("tours", tours);
            request.getRequestDispatcher("/views/tour-3d/gallery.jsp").forward(request, response);
        }
    }
}
