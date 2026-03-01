package com.dananghub.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.logging.Logger;

/**
 * ====================================================
 * MODULE 1: QUAN TRI NHA CUNG CAP - Le Phuoc Sang
 * ====================================================
 * Servlet xu ly cac request lien quan den so sanh gia
 * UPDATED: Redirect to new provider management system
 * ====================================================
 */
@WebServlet("/price-comparison")
public class PriceComparisonServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(PriceComparisonServlet.class.getName());

    @Override
    public void init() throws ServletException {
        super.init();
        logger.info("PriceComparisonServlet initialized - Redirecting to new provider system");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Redirect to new provider management system
        String contextPath = request.getContextPath();
        response.sendRedirect(contextPath + "/providers");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
