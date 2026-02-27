package com.dananghub.filter;

import com.dananghub.entity.User;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

@WebFilter(urlPatterns = {"/admin.jsp", "/user.jsp", "/admin/*", "/my-orders"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String contextPath = request.getContextPath();

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        String path = request.getServletPath();

        if (user == null) {
            response.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        boolean isAdminPath = "/admin.jsp".equals(path) || path.startsWith("/admin/");

        if (isAdminPath && !"ADMIN".equalsIgnoreCase(user.getRoleName())) {
            response.sendRedirect(contextPath + "/error.jsp");
            return;
        }

        chain.doFilter(req, res);
    }
}
