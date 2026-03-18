package controller;

import userDao.UserDAO;
import model.User;
import util.ValidateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // ✅ tránh null
        username = (username == null) ? "" : username.trim();
        password = (password == null) ? "" : password;

        System.out.println("LOGIN USER = " + username);
        System.out.println("HASH = " + util.PasswordUtil.sha256(password));

        // Validate
        String uErr = ValidateUtil.username(username);
        String pErr = ValidateUtil.password(password);

        if (uErr != null || pErr != null) {
            request.setAttribute("error", (uErr != null) ? uErr : pErr);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Check DB
        User u = new UserDAO().checklogin(username, password);

        if (u == null) {
            request.setAttribute("error", "Sai tài khoản hoặc mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Save session
        HttpSession session = request.getSession(true);
        session.setAttribute("user", u);
        session.setAttribute("username", u.getUsername());
        session.setAttribute("role", u.getRole());

        // Log LOGIN activity
        try {
            dao.CustomerDAO customerDAO = new dao.CustomerDAO();
            model.Customer customer = customerDAO.getCustomerByUserId(u.getUserId());
            if (customer != null) {
                dao.CustomerActivityDAO activityDAO = new dao.CustomerActivityDAO();
                model.CustomerActivity activity = new model.CustomerActivity();
                activity.setCustomerId(customer.getId());
                activity.setActionType("LOGIN");
                activity.setDescription("Đăng nhập vào hệ thống");
                activityDAO.addActivity(activity);
            }
        } catch (Exception e) {
            System.out.println(">>> Login activity log failed: " + e.getMessage());
        }

        // Redirect về trang chủ (cả Admin và User)
        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect("login.jsp");
    }
}
