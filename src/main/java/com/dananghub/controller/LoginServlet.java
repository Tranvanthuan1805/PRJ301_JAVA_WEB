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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        username = (username == null) ? "" : username.trim();
        password = (password == null) ? "" : password;

        if (username.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập tài khoản và mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        String hash = PasswordUtil.hashSHA256(password);
        User user = userDAO.findByUsernameAndPassword(username, hash);

        if (user == null) {
            request.setAttribute("error", "Sai tài khoản hoặc mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("user", user);
        session.setAttribute("username", user.getUsername());
        session.setAttribute("role", user.getRoleName());

        String ctx = request.getContextPath();
        String roleName = user.getRoleName();
        if ("ADMIN".equals(roleName)) {
            response.sendRedirect(ctx + "/admin/dashboard");
        } else if ("PROVIDER".equals(roleName)) {
            response.sendRedirect(ctx + "/provider/dashboard");
        } else {
            response.sendRedirect(ctx + "/home");
        }
    }
}
