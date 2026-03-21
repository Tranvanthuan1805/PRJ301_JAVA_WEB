package com.dananghub.filter;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;

@WebFilter(urlPatterns = { "/*" }, asyncSupported = true)
public class EncodingFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain) throws IOException, ServletException {

        // Chỉ set request encoding — KHÔNG động vào response
        // JSP tự set Content-Type qua <%@ page contentType="text/html;charset=UTF-8" %>
        request.setCharacterEncoding("UTF-8");
        chain.doFilter(request, response);
    }
}
