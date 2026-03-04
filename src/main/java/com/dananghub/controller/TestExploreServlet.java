package com.dananghub.controller;

import com.dananghub.dao.TourDAO;
import com.dananghub.entity.Tour;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.List;

@WebServlet("/test-explore")
public class TestExploreServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<html><head><title>Test Explore</title></head><body>");
        out.println("<h1>Test Explore Servlet</h1>");
        
        try {
            TourDAO tourDAO = new TourDAO();
            List<Tour> allTours = tourDAO.findAll();
            
            out.println("<p>Total tours in database: " + allTours.size() + "</p>");
            
            // Filter by year 2026
            long tours2026 = allTours.stream()
                .filter(t -> {
                    if (t.getStartDate() != null) {
                        Calendar cal = Calendar.getInstance();
                        cal.setTime(t.getStartDate());
                        return cal.get(Calendar.YEAR) == 2026;
                    }
                    return false;
                })
                .count();
            
            out.println("<p>Tours in 2026: " + tours2026 + "</p>");
            
            out.println("<h2>Sample Tours (first 5):</h2>");
            out.println("<ul>");
            for (int i = 0; i < Math.min(5, allTours.size()); i++) {
                Tour t = allTours.get(i);
                out.println("<li>" + t.getId() + " - " + t.getName() + " - " + t.getPrice() + " - " + t.getStartDate() + "</li>");
            }
            out.println("</ul>");
            
        } catch (Exception e) {
            out.println("<p style='color:red'>ERROR: " + e.getMessage() + "</p>");
            out.println("<pre>");
            e.printStackTrace(out);
            out.println("</pre>");
        }
        
        out.println("</body></html>");
    }
}
