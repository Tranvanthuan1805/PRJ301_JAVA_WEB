package com.dananghub.filter;

import com.dananghub.entity.User;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

@WebFilter(urlPatterns = { "/admin.jsp", "/user.jsp", "/admin/*", "/my-orders" })
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res,
            FilterChain chain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String contextPath = request.getContextPath();

        String path = request.getServletPath();

        // ✅ CÔNG KHAI: Cho phép truy cập trang NCC (Providers) mà không cần đăng nhập
        // Tất cả các URL dưới /admin/providers đều công khai
        if (path.startsWith("/admin/providers")) {
            chain.doFilter(req, res);
            return;
        }

        // Kiểm tra session và user
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // Nếu chưa đăng nhập, redirect đến login
        if (user == null) {
            response.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        // Kiểm tra quyền admin cho các trang admin khác
        boolean isAdminPath = "/admin.jsp".equals(path)
                || (path.startsWith("/admin/") && !path.startsWith("/admin/providers"));

        if (isAdminPath && !"ADMIN".equalsIgnoreCase(user.getRoleName())) {
            response.sendRedirect(contextPath + "/error.jsp");
            return;
        }

        chain.doFilter(req, res);
    }
}
