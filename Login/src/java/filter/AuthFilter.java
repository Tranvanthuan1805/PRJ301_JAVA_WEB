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

        String path = request.getServletPath();
        
        // DEBUG
        System.out.println(">>> AuthFilter: path=" + path);
        System.out.println(">>> AuthFilter: user=" + (u == null ? "null" : u.username));
        System.out.println(">>> AuthFilter: role=" + (u == null ? "null" : u.roleName));

        if (u == null) {
            System.out.println(">>> AuthFilter: No user in session, redirect to login");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // ADMIN can access everything
        if ("ADMIN".equalsIgnoreCase(u.roleName)) {
            System.out.println(">>> AuthFilter: ADMIN access granted");
            chain.doFilter(req, res);
            return;
        }

        // USER can only access /user.jsp
        if ("USER".equalsIgnoreCase(u.roleName)) {
            if (path.startsWith("/admin") || "/admin.jsp".equals(path)) {
                System.out.println(">>> AuthFilter: USER blocked from admin area");
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }
            System.out.println(">>> AuthFilter: USER access granted to " + path);
            chain.doFilter(req, res);
            return;
        }

        // Unknown role - deny access
        System.out.println(">>> AuthFilter: Unknown role, access denied");
        response.sendRedirect(request.getContextPath() + "/error.jsp");
    }
}
