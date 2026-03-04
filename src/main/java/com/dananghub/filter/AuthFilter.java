package com.dananghub.filter;

import com.dananghub.entity.User;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

/**
 * AuthFilter - Phân quyền truy cập
 * 
 * GUEST: Chỉ xem explore, không đặt tour
 * USER: Xem + đặt tour, xem đơn hàng
 * ADMIN: Quản lý tour, xem lịch sử, xem phân tích
 */
@WebFilter(urlPatterns = {
    "/admin.jsp", 
    "/admin/*", 
    "/user.jsp",
    "/booking",
    "/my-orders",
    "/profile"
})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String contextPath = request.getContextPath();

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        String username = (session != null) ? (String) session.getAttribute("username") : null;
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        String path = request.getServletPath();

        // Admin-only paths
        boolean isAdminPath = "/admin.jsp".equals(path) || path.startsWith("/admin/");
        
        // User-only paths (require login)
        boolean isUserPath = "/booking".equals(path) || 
                            "/my-orders".equals(path) || 
                            "/profile".equals(path) ||
                            "/user.jsp".equals(path);

        // Check if user is logged in
        if (user == null && username == null) {
            // Not logged in -> redirect to login with return URL
            String returnUrl = request.getRequestURI();
            String queryString = request.getQueryString();
            if (queryString != null) {
                returnUrl += "?" + queryString;
            }
            response.sendRedirect(contextPath + "/login.jsp?redirect=" + returnUrl);
            return;
        }

        // Check admin access
        if (isAdminPath) {
            boolean isAdmin = (user != null && "ADMIN".equalsIgnoreCase(user.getRoleName())) ||
                             "ADMIN".equalsIgnoreCase(role);
            
            if (!isAdmin) {
                response.sendRedirect(contextPath + "/error.jsp?msg=access_denied");
                return;
            }
        }

        // Check user access (USER or ADMIN can access)
        if (isUserPath) {
            boolean hasAccess = (user != null && 
                                ("USER".equalsIgnoreCase(user.getRoleName()) || 
                                 "ADMIN".equalsIgnoreCase(user.getRoleName()))) ||
                               ("USER".equalsIgnoreCase(role) || 
                                "ADMIN".equalsIgnoreCase(role));
            
            if (!hasAccess) {
                response.sendRedirect(contextPath + "/login.jsp?msg=login_required");
                return;
            }
        }

        chain.doFilter(req, res);
    }

}
