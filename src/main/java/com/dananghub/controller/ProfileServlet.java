package com.dananghub.controller;

import com.dananghub.dao.UserDAO;
import com.dananghub.entity.User;
import com.dananghub.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
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
        if (phone != null) {
            String phoneTrimmed = phone.trim();
            if (!phoneTrimmed.isEmpty() && !ValidationUtil.isValidPhone(phoneTrimmed)) {
                request.setAttribute("profileUser", user);
                request.setAttribute("errorMessage", "Số điện thoại không hợp lệ (VD: 0901234567)");
                request.getRequestDispatcher("/profile.jsp").forward(request, response);
                return;
            }
            user.setPhoneNumber(phoneTrimmed);
        }
        if (address != null) user.setAddress(address.trim());

        if (dobStr != null && !dobStr.trim().isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date dob = sdf.parse(dobStr.trim());
                LocalDate dobLocal = dob.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
                if (!ValidationUtil.isValidDateOfBirth(dobLocal)) {
                    request.setAttribute("profileUser", user);
                    request.setAttribute("errorMessage", "Ngày sinh không hợp lệ, không được vượt quá ngày hiện tại.");
                    request.getRequestDispatcher("/profile.jsp").forward(request, response);
                    return;
                }
                user.setDateOfBirth(dob);
            } catch (Exception ignored) {}
        }

        user.setUpdatedAt(new Date());

        UserDAO userDAO = new UserDAO();
        boolean updated = userDAO.update(user);

        if (updated) {
            // Log profile update activity
            try {
                com.dananghub.dao.ActivityDAO actDAO = new com.dananghub.dao.ActivityDAO();
                com.dananghub.entity.CustomerActivity act = new com.dananghub.entity.CustomerActivity(
                    user.getUserId(), "UPDATE_PROFILE", "Cập nhật thông tin cá nhân"
                );
                actDAO.logActivity(act);
            } catch (Exception ignored) {}
            session.setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/profile?success=1");
        } else {
            response.sendRedirect(request.getContextPath() + "/profile?error=1");
        }
    }
}
