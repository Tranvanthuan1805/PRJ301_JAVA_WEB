package com.dananghub.controller;

import com.dananghub.dao.UserDAO;
import com.dananghub.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.MessageDigest;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Show forgot password form
        String step = request.getParameter("step");
        if ("reset".equals(step)) {
            // Show reset password form (after verification)
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("verify".equals(action)) {
            // Step 1: Verify username + email
            handleVerify(request, response);
        } else if ("reset".equals(action)) {
            // Step 2: Reset password
            handleReset(request, response);
        } else {
            handleVerify(request, response);
        }
    }

    private void handleVerify(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");

        if (username == null || username.trim().isEmpty() || email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và email.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.findByUsername(username.trim());

        if (user == null || user.getEmail() == null || !user.getEmail().equalsIgnoreCase(email.trim())) {
            request.setAttribute("error", "Thông tin không khớp. Vui lòng kiểm tra lại tên đăng nhập và email.");
            request.setAttribute("inputUsername", username);
            request.setAttribute("inputEmail", email);
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        // Verified! Allow password reset
        HttpSession session = request.getSession();
        session.setAttribute("resetUserId", user.getUserId());
        session.setAttribute("resetVerified", true);

        request.setAttribute("step", "reset");
        request.setAttribute("verifiedUser", user.getUsername());
        request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
    }

    private void handleReset(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Boolean verified = (Boolean) session.getAttribute("resetVerified");
        Integer userId = (Integer) session.getAttribute("resetUserId");

        if (verified == null || !verified || userId == null) {
            request.setAttribute("error", "Phiên xác thực đã hết hạn. Vui lòng thực hiện lại.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (newPassword == null || newPassword.length() < 6) {
            request.setAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự.");
            request.setAttribute("step", "reset");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.setAttribute("step", "reset");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.findById(userId);

        if (user == null) {
            request.setAttribute("error", "Không tìm thấy tài khoản.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        // Hash new password (SHA-256)
        String hashedPassword = hashPassword(newPassword);
        user.setPasswordHash(hashedPassword);

        if (userDAO.update(user)) {
            // Clear session reset data
            session.removeAttribute("resetUserId");
            session.removeAttribute("resetVerified");

            // Redirect to login with success message
            request.getSession().setAttribute("success", "Đổi mật khẩu thành công! Vui lòng đăng nhập lại.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra. Vui lòng thử lại.");
            request.setAttribute("step", "reset");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
}
