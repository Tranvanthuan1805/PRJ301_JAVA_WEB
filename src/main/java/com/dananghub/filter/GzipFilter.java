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
@WebFilter(urlPatterns = "/*")
public class GzipFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String ae = request.getHeader("Accept-Encoding");

        // Only compress if client supports gzip and it's not a binary resource
        if (ae != null && ae.contains("gzip")) {
            String uri = request.getRequestURI().toLowerCase();
            // Skip binary files (images, videos, fonts)
            if (!uri.endsWith(".png") && !uri.endsWith(".jpg") && !uri.endsWith(".jpeg")
                    && !uri.endsWith(".gif") && !uri.endsWith(".mp4") && !uri.endsWith(".webp")
                    && !uri.endsWith(".woff") && !uri.endsWith(".woff2") && !uri.endsWith(".ttf")
                    && !uri.endsWith(".ico") && !uri.endsWith(".pdf") && !uri.endsWith(".zip")) {

                GzipResponseWrapper wrappedResponse = new GzipResponseWrapper(response);
                try {
                    chain.doFilter(request, wrappedResponse);
                    wrappedResponse.finish();
                } catch (Exception e) {
                    // On error, fall through without compression
                    if (!response.isCommitted()) {
                        chain.doFilter(request, response);
                    }
                }
                return;
            }
        }

        chain.doFilter(request, response);
    }
}
