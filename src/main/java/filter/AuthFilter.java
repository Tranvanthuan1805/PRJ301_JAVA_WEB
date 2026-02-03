package filter;

import model.User;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI();

        // ✅ CHO QUA LOGIN / REGISTER / CSS / IMG
        if (uri.endsWith("login")
            || uri.endsWith("login.jsp")
            || uri.endsWith("register")
            || uri.endsWith("register.jsp")
            || uri.contains("/css/")
            || uri.contains("/images/")
            || uri.contains("/img/")) {

            chain.doFilter(req, res);
            return;
        }

        HttpSession session = request.getSession(false);
        User user = (session == null) ? null : (User) session.getAttribute("user");

        // ❌ chưa login
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // phân quyền
        if (uri.contains("admin") && !"ADMIN".equalsIgnoreCase(user.getRoleName())) {
            response.sendRedirect("error.jsp");
            return;
        }

        if (uri.contains("user") && !"USER".equalsIgnoreCase(user.getRoleName())) {
            response.sendRedirect("error.jsp");
            return;
        }

        chain.doFilter(req, res);
    }

}
