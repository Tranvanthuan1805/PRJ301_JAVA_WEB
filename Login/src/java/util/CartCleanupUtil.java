package util;

import dao.CartDAO;
import dao.TourDAO;
import model.CartItem;
import model.Tour;

import java.util.List;

/**
 * Utility để làm sạch giỏ hàng
 * Xóa các items không hợp lệ (tour đã xóa, hết chỗ, etc.)
 */
public class CartCleanupUtil {
    
    private static final CartDAO cartDAO = new CartDAO();
    private static final TourDAO tourDAO = new TourDAO();
    
    /**
     * Làm sạch giỏ hàng của một user cụ thể
     * @param userId User ID
     * @return Số lượng items đã bị xóa
     */
    public static int cleanupUserCart(int userId) {
        List<CartItem> items = cartDAO.getCartItems(userId);
        int removedCount = 0;
        
        for (CartItem item : items) {
            Tour tour = item.getTour();
            
            // Tour không tồn tại hoặc đã hết chỗ
            if (tour == null || !tour.isAvailable()) {
                cartDAO.removeFromCart(userId, item.getTourId());
                removedCount++;
                continue;
            }
            
            // Số lượng vượt quá chỗ còn trống
            int availableSlots = tour.getAvailableSlots();
            if (item.getQuantity() > availableSlots) {
                if (availableSlots > 0) {
                    // Điều chỉnh số lượng
                    cartDAO.updateQuantity(userId, item.getTourId(), availableSlots);
                } else {
                    // Xóa hoàn toàn
                    cartDAO.removeFromCart(userId, item.getTourId());
                    removedCount++;
                }
            }
        }
        
        return removedCount;
    }
    
    /**
     * Làm sạch tất cả giỏ hàng trong hệ thống
     * Có thể chạy định kỳ bằng scheduled task
     * @return Tổng số items đã bị xóa
     */
    public static int cleanupAllCarts() {
        // TODO: Implement khi có danh sách tất cả users
        // Hiện tại chỉ cleanup khi user truy cập giỏ hàng
        return 0;
    }
    
    /**
     * Kiểm tra xem một tour có trong giỏ hàng của bất kỳ user nào không
     * Hữu ích khi xóa tour để thông báo cho users
     * @param tourId Tour ID
     * @return true nếu tour đang có trong giỏ hàng
     */
    public static boolean isTourInAnyCart(int tourId) {
        // TODO: Implement query để check
        return false;
    }
}
