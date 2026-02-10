package servlet;

import dao.UserDAO;
import util.ValidateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Trim username
        username = (username == null) ? "" : username.trim();
        password = (password == null) ? "" : password;
        confirmPassword = (confirmPassword == null) ? "" : confirmPassword;

        // Validate username
        String uErr = ValidateUtil.username(username);
        if (uErr != null) {
            request.setAttribute("error", uErr);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validate password
        String pErr = ValidateUtil.password(password);
        if (pErr != null) {
            request.setAttribute("error", pErr);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Check password match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Check if username exists
        UserDAO userDAO = new UserDAO();
        if (userDAO.existsUsername(username)) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Register user
        boolean success = userDAO.registerUser(username, password);

        if (success) {
            request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Đăng ký thất bại! Vui lòng thử lại.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
