package filter;

import model.User;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

@WebFilter(urlPatterns = {"/admin.jsp", "/user.jsp", "/admin/*", "/my-orders"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String contextPath = request.getContextPath();

        String uri = request.getRequestURI();

        String path = request.getServletPath();
        
        // DEBUG
        System.out.println(">>> AuthFilter: path=" + path);
        System.out.println(">>> AuthFilter: user=" + (u == null ? "null" : u.username));
        System.out.println(">>> AuthFilter: role=" + (u == null ? "null" : u.roleName));

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
