package com.dananghub.websocket;

import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.logging.Logger;

/**
 * WebSocket endpoint cho thông báo realtime đến admin.
 * URL: ws://localhost:8080/ws/notifications
 *
 * Khi có đơn đăng ký NCC mới → ProviderRegistrationServlet gọi
 * NotificationWebSocket.broadcastNewProvider(count) → tất cả admin
 * đang online nhận được JSON event ngay lập tức.
 */
@ServerEndpoint("/ws/notifications")
public class NotificationWebSocket {

    private static final Logger log = Logger.getLogger(NotificationWebSocket.class.getName());

    // Thread-safe set lưu tất cả session đang kết nối
    private static final Set<Session> SESSIONS = new CopyOnWriteArraySet<>();

    @OnOpen
    public void onOpen(Session session) {
        SESSIONS.add(session);
        log.info("WS connected: " + session.getId() + " | total=" + SESSIONS.size());
    }

    @OnClose
    public void onClose(Session session) {
        SESSIONS.remove(session);
        log.info("WS closed: " + session.getId() + " | total=" + SESSIONS.size());
    }

    @OnError
    public void onError(Session session, Throwable t) {
        SESSIONS.remove(session);
        log.warning("WS error [" + session.getId() + "]: " + t.getMessage());
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        // Client không cần gửi gì, bỏ qua
    }

    /**
     * Broadcast đến tất cả admin đang online khi có đơn NCC mới.
     * 
     * @param pendingCount tổng số đơn đang chờ duyệt
     * @param businessName tên doanh nghiệp vừa đăng ký
     */
    public static void broadcastNewProvider(long pendingCount, String businessName) {
        // Escape tên để tránh JSON injection
        String safeName = businessName == null ? "" : businessName.replace("\\", "\\\\").replace("\"", "\\\"");

        String json = String.format(
                "{\"type\":\"NEW_PROVIDER\",\"count\":%d,\"businessName\":\"%s\"}",
                pendingCount, safeName);
        broadcast(json);
    }

    /**
     * Broadcast khi admin duyệt/từ chối đơn — cập nhật badge cho các admin khác.
     * 
     * @param pendingCount số đơn pending còn lại
     */
    public static void broadcastStatusUpdate(long pendingCount) {
        String json = String.format(
                "{\"type\":\"STATUS_UPDATE\",\"count\":%d}", pendingCount);
        broadcast(json);
    }

    // Gửi message đến tất cả session đang mở
    private static void broadcast(String message) {
        for (Session s : SESSIONS) {
            if (s.isOpen()) {
                try {
                    s.getBasicRemote().sendText(message);
                } catch (IOException e) {
                    log.warning("Broadcast failed to " + s.getId() + ": " + e.getMessage());
                    SESSIONS.remove(s);
                }
            }
        }
    }
}
