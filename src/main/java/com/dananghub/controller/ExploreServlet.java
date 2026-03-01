package com.dananghub.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * ExploreServlet - Redirects to TourServlet
 * The old JDBC-based explore page is replaced by the JPA-based TourServlet
 */
@WebServlet("/explore")
public class ExploreServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to TourServlet which handles everything via JPA
        response.sendRedirect(request.getContextPath() + "/tour");
    }
}
