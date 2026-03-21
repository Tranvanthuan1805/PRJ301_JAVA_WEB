package com.dananghub.controller;

import com.dananghub.entity.User;
import com.dananghub.realtime.ProviderNotificationBus;
import jakarta.servlet.AsyncContext;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

@WebServlet(urlPatterns = "/provider/events", asyncSupported = true)
public class ProviderEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // ── Chỉ admin ──────────────────────────────────────────────────────
        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;
        if (user == null || user.getRole() == null
                || !"ADMIN".equals(user.getRole().getRoleName())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // ── SSE headers ────────────────────────────────────────────────────
        response.setContentType("text/event-stream");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("X-Accel-Buffering", "no"); // tắt buffer nginx nếu có

        // ── Async context ──────────────────────────────────────────────────
        AsyncContext async = request.startAsync();
        async.setTimeout(0); // không timeout

        String clientId = UUID.randomUUID().toString();
        PrintWriter writer = response.getWriter();

        // Gửi comment keepalive ngay lập tức để browser biết kết nối sống
        writer.write(": connected\n\n");
        writer.flush();

        // ── Subscribe vào bus ──────────────────────────────────────────────
        ProviderNotificationBus.getInstance().subscribe(clientId, event -> {
            try {
                String json = String.format(
                        "{\"providerId\":%d,\"businessName\":\"%s\",\"providerType\":\"%s\",\"registeredAt\":\"%s\",\"pendingCount\":%d}",
                        event.providerId,
                        escapeJson(event.businessName),
                        escapeJson(event.providerType),
                        event.registeredAt,
                        event.pendingCount);
                writer.write("event: new-provider\n");
                writer.write("data: " + json + "\n\n");
                writer.flush();

                if (writer.checkError()) {
                    // Client đã ngắt kết nối
                    ProviderNotificationBus.getInstance().unsubscribe(clientId);
                    async.complete();
                }
            } catch (Exception e) {
                ProviderNotificationBus.getInstance().unsubscribe(clientId);
                async.complete();
            }
        });

        // Dọn dẹp khi request kết thúc (tab đóng, reload...)
        async.addListener(new jakarta.servlet.AsyncListener() {
            public void onComplete(jakarta.servlet.AsyncEvent e) {
                ProviderNotificationBus.getInstance().unsubscribe(clientId);
            }

            public void onTimeout(jakarta.servlet.AsyncEvent e) {
                ProviderNotificationBus.getInstance().unsubscribe(clientId);
            }

            public void onError(jakarta.servlet.AsyncEvent e) {
                ProviderNotificationBus.getInstance().unsubscribe(clientId);
            }

            public void onStartAsync(jakarta.servlet.AsyncEvent e) {
            }
        });
    }

    private String escapeJson(String s) {
        if (s == null)
            return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
