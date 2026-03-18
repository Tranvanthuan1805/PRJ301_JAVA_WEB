package com.dananghub.controller;

import com.dananghub.dao.UserDAO;
import com.dananghub.entity.User;
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

        try {
            String hash = PasswordUtil.hashSHA256(password);
            System.out.println(">>> LOGIN: username=" + username + ", hash=" + hash);

            User user = userDAO.findByUsernameAndPassword(username, hash);

            if (user == null) {
                // Debug: try to find user by username only
                User byName = userDAO.findByUsername(username);
                if (byName == null) {
                    System.out.println(">>> LOGIN FAIL: User '" + username + "' NOT FOUND in database");
                    request.setAttribute("error", "Tài khoản '" + username + "' không tồn tại trong hệ thống!");
                } else {
                    System.out.println(">>> LOGIN FAIL: User found but password mismatch. DB hash: " + byName.getPasswordHash());
                    System.out.println(">>> LOGIN FAIL: Input hash: " + hash);
                    request.setAttribute("error", "Sai mật khẩu! (User tồn tại nhưng hash không khớp)");
                }
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            System.out.println(">>> LOGIN SUCCESS: " + user);

            // Check if user is deactivated by admin
            if (!user.isActive()) {
                System.out.println(">>> LOGIN BLOCKED: User '" + username + "' is deactivated");
                request.setAttribute("error", "Tài khoản của bạn đã bị vô hiệu hóa. Vui lòng liên hệ admin!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRoleName());

            // Log login activity
            try {
                com.dananghub.dao.ActivityDAO actDAO = new com.dananghub.dao.ActivityDAO();
                com.dananghub.entity.CustomerActivity act = new com.dananghub.entity.CustomerActivity(
                    user.getUserId(), "LOGIN", "Đăng nhập thành công"
                );
                actDAO.logActivity(act);
            } catch (Exception ignored) {}

            String ctx = request.getContextPath();
            String roleName = user.getRoleName();
            if ("ADMIN".equals(roleName)) {
                response.sendRedirect(ctx + "/home");
            } else if ("PROVIDER".equals(roleName)) {
                response.sendRedirect(ctx + "/provider/dashboard");
            } else {
                response.sendRedirect(ctx + "/home");
            }
        } catch (Exception e) {
            e.printStackTrace();
            Throwable root = e;
            while (root.getCause() != null) root = root.getCause();
            String errorMsg = "Lỗi DB: " + root.getClass().getSimpleName() + " - " + root.getMessage();
            System.err.println(">>> LOGIN ERROR: " + errorMsg);
            request.setAttribute("error", errorMsg);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
