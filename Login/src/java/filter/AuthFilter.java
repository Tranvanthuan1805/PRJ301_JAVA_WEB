package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.User;

@WebFilter(urlPatterns = {"/admin.jsp", "/user.jsp", "/admin/*", "/my-orders"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String contextPath = request.getContextPath();

        HttpSession session = request.getSession(false);
        User u = (session == null) ? null : (User) session.getAttribute("user");

        // Not logged in -> redirect to login
        if (u == null) {
            response.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        String path = request.getServletPath(); // e.g., /admin.jsp, /admin/orders, /my-orders

        // Admin-only paths: /admin.jsp and /admin/*
        boolean isAdminPath = "/admin.jsp".equals(path) || path.startsWith("/admin/");
        
        if (isAdminPath && !"ADMIN".equalsIgnoreCase(u.roleName)) {
            response.sendRedirect(contextPath + "/error.jsp");
            return;
        }

        // User paths: /my-orders (any logged-in user can access)
        // No additional check needed - already verified user is logged in

        chain.doFilter(req, res);
    }
}
