package com.dananghub.controller;

import com.dananghub.dao.UserDAO;
import com.dananghub.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
        // Reload from DB for fresh data
        UserDAO userDAO = new UserDAO();
        User freshUser = userDAO.findById(user.getUserId());
        if (freshUser != null) {
            session.setAttribute("user", freshUser);
            request.setAttribute("profileUser", freshUser);
        } else {
            request.setAttribute("profileUser", user);
        }
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String dobStr = request.getParameter("dateOfBirth");

        if (fullName != null && !fullName.trim().isEmpty()) user.setFullName(fullName.trim());
        if (phone != null) user.setPhoneNumber(phone.trim());
        if (address != null) user.setAddress(address.trim());

        if (dobStr != null && !dobStr.trim().isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                user.setDateOfBirth(sdf.parse(dobStr.trim()));
            } catch (Exception ignored) {}
        }

        user.setUpdatedAt(new Date());

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
