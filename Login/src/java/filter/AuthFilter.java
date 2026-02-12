package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.User;

@WebFilter(urlPatterns = {"/admin.jsp", "/user.jsp", "/admin/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);
        User u = (session == null) ? null : (User) session.getAttribute("user");

        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String path = request.getServletPath(); // /admin.jsp, /user.jsp, or /admin/*

        // Check if accessing admin resources
        if ((path.startsWith("/admin") || "/admin.jsp".equals(path)) 
            && !"ADMIN".equalsIgnoreCase(u.roleName)) {
            response.sendRedirect(request.getContextPath() + "/error.jsp");
            return;
        }

        chain.doFilter(req, res);
    }
}
