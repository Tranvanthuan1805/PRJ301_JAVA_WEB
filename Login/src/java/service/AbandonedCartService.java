package service;

import dao.AbandonedCartDAO;
import dao.CartInteractionDAO;
import model.AbandonedCart;
import model.CartInteraction;
import model.CartItem;

import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Service xử lý abandoned cart tracking và analytics
 */
public class AbandonedCartService {
    
    private AbandonedCartDAO abandonedCartDAO;
    private CartInteractionDAO interactionDAO;
    
    public AbandonedCartService() {
        this.abandonedCartDAO = new AbandonedCartDAO();
        this.interactionDAO = new CartInteractionDAO();
    }
    
    /**
     * Track khi user thêm tour vào giỏ
     */
    public void trackAddToCart(HttpSession session, Integer userId, int tourId, int quantity) {
        String sessionId = session.getId();
        
        // Log interaction
        CartInteraction interaction = new CartInteraction(
            userId, sessionId, tourId, "ADD", quantity
        );
        interactionDAO.logInteraction(interaction);
    }
    
    /**
     * Track khi user xem giỏ hàng
     */
    public void trackViewCart(HttpSession session, Integer userId, int tourId) {
        String sessionId = session.getId();
        
        CartInteraction interaction = new CartInteraction(
            userId, sessionId, tourId, "VIEW", null
        );
        interactionDAO.logInteraction(interaction);
    }
    
    /**
     * Track khi user bắt đầu checkout
     */
    public void trackCheckoutStart(HttpSession session, Integer userId, List<CartItem> items) {
        String sessionId = session.getId();
        
        for (CartItem item : items) {
            CartInteraction interaction = new CartInteraction(
                userId, sessionId, item.getTourId(), "CHECKOUT_START", item.getQuantity()
            );
            interactionDAO.logInteraction(interaction);
        }
    }
    
    /**
     * Track khi user hoàn thành checkout
     */
    public void trackCheckoutComplete(HttpSession session, Integer userId, List<CartItem> items, int orderId) {
        String sessionId = session.getId();
        
        for (CartItem item : items) {
            CartInteraction interaction = new CartInteraction(
                userId, sessionId, item.getTourId(), "CHECKOUT_COMPLETE", item.getQuantity()
            );
            interactionDAO.logInteraction(interaction);
            
            // Mark abandoned carts as converted
            markAbandonedCartsAsConverted(userId, sessionId, item.getTourId(), orderId);
        }
    }
    
    /**
     * Track khi user xóa tour khỏi giỏ
     */
    public void trackRemoveFromCart(HttpSession session, Integer userId, int tourId) {
        String sessionId = session.getId();
        
        CartInteraction interaction = new CartInteraction(
            userId, sessionId, tourId, "REMOVE", null
        );
        interactionDAO.logInteraction(interaction);
    }
    
    /**
     * Snapshot giỏ hàng hiện tại thành abandoned cart records
     * Gọi khi user rời khỏi trang giỏ hàng mà không checkout
     */
    public void snapshotCartAsAbandoned(HttpSession session, Integer userId, List<CartItem> items) {
        if (items == null || items.isEmpty()) {
            return;
        }
        
        String sessionId = session.getId();
        LocalDateTime now = LocalDateTime.now();
        
        for (CartItem item : items) {
            AbandonedCart cart = new AbandonedCart();
            cart.setUserId(userId);
            cart.setSessionId(sessionId);
            cart.setTourId(item.getTourId());
            cart.setQuantity(item.getQuantity());
            cart.setAddedAt(item.getAddedAt() != null ? item.getAddedAt() : now);
            cart.setLastViewedAt(now);
            cart.setAbandonedAt(now);
            
            abandonedCartDAO.createAbandonedCart(cart);
        }
    }
    
    /**
     * Đánh dấu abandoned carts đã convert
     */
    private void markAbandonedCartsAsConverted(Integer userId, String sessionId, int tourId, int orderId) {
        // TODO: Implement query để tìm và update abandoned carts
        // Hiện tại chỉ là placeholder
    }
    
    /**
     * Lấy abandoned carts cần gửi reminder
     */
    public List<AbandonedCart> getCartsForReminder() {
        return abandonedCartDAO.getAbandonedCartsForReminder();
    }
    
    /**
     * Gửi reminder cho abandoned cart
     * Trả về AI-generated message
     */
    public String generateReminderMessage(AbandonedCart cart) {
        StringBuilder message = new StringBuilder();
        
        message.append("Xin chào! 👋\n\n");
        message.append("Chúng tôi nhận thấy bạn đã quan tâm đến tour: ");
        message.append(cart.getTour().getName());
        message.append("\n\n");
        
        long hours = cart.getHoursSinceAbandoned();
        
        if (hours <= 48) {
            message.append("Tour này đang rất được ưa chuộng và có thể sẽ hết chỗ sớm. ");
            message.append("Đừng bỏ lỡ cơ hội trải nghiệm tuyệt vời này!\n\n");
        } else if (hours <= 72) {
            message.append("Chúng tôi có tin tốt cho bạn! ");
            message.append("Đặt tour ngay hôm nay để nhận ưu đãi đặc biệt 5%!\n\n");
        } else {
            message.append("Ưu đãi đặc biệt dành riêng cho bạn: GIẢM 10% ");
            message.append("khi đặt tour trong 24h tới!\n\n");
        }
        
        message.append("📍 Điểm đến: ").append(cart.getTour().getDestination()).append("\n");
        message.append("💰 Giá: ").append(String.format("%,.0f", cart.getTour().getPrice())).append(" ₫\n");
        message.append("🎫 Còn ").append(cart.getTour().getAvailableSlots()).append(" chỗ trống\n\n");
        message.append("Đặt ngay: [LINK]\n");
        
        return message.toString();
    }
    
    /**
     * Lấy AI recommendations dựa trên abandoned cart
     */
    public AIRecommendation getAIRecommendation(AbandonedCart cart) {
        AIRecommendation recommendation = new AIRecommendation();
        recommendation.cartId = cart.getId();
        recommendation.priority = cart.getPriorityLevel();
        recommendation.action = cart.getRecommendedAction();
        recommendation.message = generateReminderMessage(cart);
        recommendation.potentialValue = cart.getPotentialValue();
        recommendation.hoursSinceAbandoned = cart.getHoursSinceAbandoned();
        
        // Tính discount percentage dựa trên thời gian
        if (cart.getHoursSinceAbandoned() <= 48) {
            recommendation.suggestedDiscount = 0;
        } else if (cart.getHoursSinceAbandoned() <= 72) {
            recommendation.suggestedDiscount = 5;
        } else {
            recommendation.suggestedDiscount = 10;
        }
        
        return recommendation;
    }
    
    /**
     * Lấy statistics
     */
    public AbandonedCartDAO.AbandonedCartStats getStatistics() {
        return abandonedCartDAO.getStatistics();
    }
    
    /**
     * Lấy all abandoned carts cho admin
     */
    public List<AbandonedCart> getAllAbandonedCarts(int limit) {
        return abandonedCartDAO.getAllAbandonedCarts(limit);
    }
    
    /**
     * Inner class cho AI recommendations
     */
    public static class AIRecommendation {
        public int cartId;
        public String priority;
        public String action;
        public String message;
        public double potentialValue;
        public long hoursSinceAbandoned;
        public int suggestedDiscount;
        
        public String toJSON() {
            return String.format(
                "{\"cartId\":%d,\"priority\":\"%s\",\"action\":\"%s\",\"potentialValue\":%.2f," +
                "\"hoursSinceAbandoned\":%d,\"suggestedDiscount\":%d,\"message\":\"%s\"}",
                cartId, priority, action, potentialValue, hoursSinceAbandoned, 
                suggestedDiscount, message.replace("\n", "\\n").replace("\"", "\\\"")
            );
        }
    }
}
