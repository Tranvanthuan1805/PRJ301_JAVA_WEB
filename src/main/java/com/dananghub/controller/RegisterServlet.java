package com.dananghub.controller;

import com.dananghub.dao.UserDAO;
import com.dananghub.dao.RoleDAO;
import com.dananghub.entity.User;
import com.dananghub.entity.Role;
import com.dananghub.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Date;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final RoleDAO roleDAO = new RoleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        username = (username == null) ? "" : username.trim();
        email = (email == null) ? "" : email.trim();
        password = (password == null) ? "" : password;
        confirmPassword = (confirmPassword == null) ? "" : confirmPassword;

        if (username.length() < 3 || username.length() > 50) {
            request.setAttribute("error", "Tên đăng nhập phải từ 3-50 ký tự!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 6) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (userDAO.findByUsername(username) != null) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!email.isEmpty() && userDAO.findByEmail(email) != null) {
            request.setAttribute("error", "Email đã được sử dụng!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        Role customerRole = roleDAO.findByName("CUSTOMER");
        if (customerRole == null) {
            request.setAttribute("error", "Lỗi hệ thống: Role CUSTOMER không tồn tại!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setEmail(email.isEmpty() ? username + "@dananghub.com" : email);
        newUser.setPasswordHash(PasswordUtil.hashSHA256(password));
        newUser.setRole(customerRole);
        newUser.setActive(true);
        newUser.setCreatedAt(new Date());
        newUser.setUpdatedAt(new Date());

        boolean success = userDAO.create(newUser);

        if (success) {
            request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Đăng ký thất bại! Vui lòng thử lại.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
