package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.User;

@WebFilter(urlPatterns = {"/admin.jsp", "/user.jsp"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);
        User u = (session == null) ? null : (User) session.getAttribute("user");

        if (u == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String path = request.getServletPath(); // /admin.jsp hoặc /user.jsp

        if ("/admin.jsp".equals(path) && !"ADMIN".equalsIgnoreCase(u.roleName)) {
            response.sendRedirect("error.jsp");
            return;
        }

        chain.doFilter(req, res);
    }
}
