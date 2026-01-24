package controller;

import userDao.UserDAO;
import util.ValidateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect("register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirm  = request.getParameter("confirm");

        username = (username == null) ? "" : username.trim();
        password = (password == null) ? "" : password;
        confirm  = (confirm  == null) ? "" : confirm;

        // 1) Validate
        String uErr = ValidateUtil.username(username);
        if (uErr != null) {
            request.setAttribute("error", uErr);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        String pErr = ValidateUtil.password(password);
        if (pErr != null) {
            request.setAttribute("error", pErr);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        String cErr = ValidateUtil.confirmPassword(password, confirm);
        if (cErr != null) {
            request.setAttribute("error", cErr);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();

        // 2) Check tồn tại username
        if (dao.existsUsername(username)) {
            request.setAttribute("error", "Username đã tồn tại!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 3) Insert DB
        boolean ok = dao.registerUser(username, password);
        if (!ok) {
            request.setAttribute("error", "Đăng ký thất bại (lỗi DB)!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 4) Thành công → quay về login
        request.setAttribute("msg", "Đăng ký thành công! Hãy đăng nhập.");
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}
