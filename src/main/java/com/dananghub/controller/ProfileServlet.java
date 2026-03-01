package com.dananghub.controller;

import com.dananghub.dao.UserDAO;
import com.dananghub.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        request.setAttribute("profileUser", user);
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Update user info
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phoneNumber");
        String address = request.getParameter("address");

        if (fullName != null) user.setFullName(fullName);
        if (phone != null) user.setPhoneNumber(phone);
        if (address != null) user.setAddress(address);

        UserDAO userDAO = new UserDAO();
        boolean updated = userDAO.update(user);

        if (updated) {
            session.setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/profile?success=1");
        } else {
            response.sendRedirect(request.getContextPath() + "/profile?error=1");
        }
    }
}
