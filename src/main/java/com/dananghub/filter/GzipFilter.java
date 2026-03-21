package com.dananghub.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * GZIP Compression Filter — compresses text responses (HTML, CSS, JS, JSON)
 * to reduce transfer size by 60-80%. This dramatically improves page load time.
 */
@WebFilter(urlPatterns = "/*", asyncSupported = true)
public class GzipFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        // GzipFilter tạm thời disabled — gây lỗi encoding UTF-8 tiếng Việt
        chain.doFilter(req, res);
    }
}
