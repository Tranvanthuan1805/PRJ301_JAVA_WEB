package com.dananghub.controller;

import com.dananghub.dao.CartDAO;
import com.dananghub.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/api/cart/count")
public class CartCountServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        int count = 0;
        
        if (user != null) {
            try {
                CartDAO cartDAO = new CartDAO();
                count = cartDAO.countByUserId(user.getUserId());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        PrintWriter out = response.getWriter();
        out.print("{\"count\": " + count + "}");
        out.flush();
    }
}
