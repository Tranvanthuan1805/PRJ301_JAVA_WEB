package com.dananghub.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Static Resource Cache Filter — tells browsers to cache CSS, JS, images, and fonts
 * so they don't re-download on every page visit.
 */
@WebFilter(urlPatterns = {"/css/*", "/js/*", "/images/*", "/assets/*"})
public class CacheControlFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI().toLowerCase();

        // Images, fonts: cache for 7 days
        if (uri.endsWith(".png") || uri.endsWith(".jpg") || uri.endsWith(".jpeg")
                || uri.endsWith(".gif") || uri.endsWith(".webp") || uri.endsWith(".svg")
                || uri.endsWith(".ico") || uri.endsWith(".woff") || uri.endsWith(".woff2")
                || uri.endsWith(".ttf") || uri.endsWith(".mp4")) {
            response.setHeader("Cache-Control", "public, max-age=604800, immutable"); // 7 days
        }
        // CSS and JS: cache for 1 day
        else if (uri.endsWith(".css") || uri.endsWith(".js")) {
            response.setHeader("Cache-Control", "public, max-age=86400"); // 1 day
        }

        chain.doFilter(request, response);
    }
}
