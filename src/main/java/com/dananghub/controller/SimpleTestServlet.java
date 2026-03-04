package com.dananghub.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/simple-test")
public class SimpleTestServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<html><body>");
        out.println("<h1>Simple Test Servlet Works!</h1>");
        out.println("<p>If you see this, servlets are working.</p>");
        out.println("<p><a href='" + request.getContextPath() + "/explore'>Try Explore</a></p>");
        out.println("</body></html>");
    }
}
