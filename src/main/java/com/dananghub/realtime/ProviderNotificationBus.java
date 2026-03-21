package com.dananghub.realtime;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Consumer;

/**
 * Singleton bus trung gian: ProviderServlet publish sự kiện,
 * ProviderEventServlet (SSE) subscribe và đẩy xuống browser admin.
 */
public class ProviderNotificationBus {

    public static final class ProviderEvent {
        public final int providerId;
        public final String businessName;
        public final String providerType;
        public final String registeredAt; // ISO-8601
        public final int pendingCount; // tổng số đang chờ duyệt

        public ProviderEvent(int providerId, String businessName,
                String providerType, String registeredAt, int pendingCount) {
            this.providerId = providerId;
            this.businessName = businessName;
            this.providerType = providerType;
            this.registeredAt = registeredAt;
            this.pendingCount = pendingCount;
        }
    }

    // ── Singleton ──────────────────────────────────────────────────────────
    private static final ProviderNotificationBus INSTANCE = new ProviderNotificationBus();

    private ProviderNotificationBus() {
    }

    public static ProviderNotificationBus getInstance() {
        return INSTANCE;
    }

    // ── Subscribers: clientId → callback ───────────────────────────────────
    private final Map<String, Consumer<ProviderEvent>> subscribers = new ConcurrentHashMap<>();

    public void subscribe(String clientId, Consumer<ProviderEvent> callback) {
        subscribers.put(clientId, callback);
    }

    public void unsubscribe(String clientId) {
        subscribers.remove(clientId);
    }

    /** Gọi từ ProviderServlet sau khi INSERT thành công */
    public void publish(ProviderEvent event) {
        subscribers.values().forEach(cb -> {
            try {
                cb.accept(event);
            } catch (Exception ignored) {
            }
        });
    }
}
