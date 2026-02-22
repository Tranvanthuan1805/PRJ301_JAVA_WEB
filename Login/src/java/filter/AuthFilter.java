package filter;

import model.User;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

@WebFilter(urlPatterns = {"/admin.jsp", "/user.jsp", "/admin/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI();

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

        String path = request.getServletPath(); // /admin.jsp hoặc /user.jsp

        if ("/admin.jsp".equals(path) && !"ADMIN".equalsIgnoreCase(u.getRole())) {
            response.sendRedirect("error.jsp");
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
