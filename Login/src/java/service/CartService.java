package service;

import dao.CartDAO;
import dao.TourDAO;
import model.CartItem;
import model.Tour;

import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Service quản lý giỏ hàng
 * - Session-based cho user chưa đăng nhập
 * - Database-based cho user đã đăng nhập
 */
public class CartService {
    
    private static final String SESSION_CART_KEY = "sessionCart";
    private CartDAO cartDAO;
    private TourDAO tourDAO;
    
    public CartService() {
        this.cartDAO = new CartDAO();
        this.tourDAO = new TourDAO();
    }
    
    /**
     * Thêm tour vào giỏ hàng
     * @param session HTTP Session
     * @param userId User ID (null nếu chưa đăng nhập)
     * @param tourId Tour ID
     * @param quantity Số lượng
     * @return true nếu thành công
     */
    public boolean addToCart(HttpSession session, Integer userId, int tourId, int quantity) {
        try {
            System.out.println("=== CartService.addToCart() ===");
            System.out.println("userId: " + userId + ", tourId: " + tourId + ", quantity: " + quantity);
            
            // Validate tour tồn tại và còn chỗ
            Tour tour = tourDAO.getTourById(tourId);
            System.out.println("Tour found: " + (tour != null ? tour.getName() : "null"));
            
            if (tour == null) {
                System.out.println("ERROR: Tour not found");
                return false;
            }
            
            // Kiểm tra tour còn available không
            System.out.println("Tour available: " + tour.isAvailable());
            if (!tour.isAvailable()) {
                System.out.println("ERROR: Tour not available");
                return false;
            }
            
            // Kiểm tra số lượng yêu cầu có hợp lệ không
            System.out.println("Check availability for quantity: " + quantity);
            if (!tour.checkAvailability(quantity)) {
                System.out.println("ERROR: Not enough slots");
                return false;
            }
            
            boolean success;
            if (userId != null) {
                // User đã đăng nhập - lưu vào database
                System.out.println("Adding to database for user: " + userId);
                success = cartDAO.addToCart(userId, tourId, quantity);
                System.out.println("Database add result: " + success);
            } else {
                // User chưa đăng nhập - lưu vào session
                System.out.println("Adding to session cart");
                success = addToSessionCart(session, tourId, quantity);
                System.out.println("Session add result: " + success);
            }
            
            System.out.println("Final result: " + success);
            return success;
        } catch (SQLException e) {
            System.out.println("SQLException in addToCart: " + e.getMessage());
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            System.out.println("Exception in addToCart: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Kiểm tra xem có thể thêm tour vào giỏ không
     * @return String error message, null nếu OK
     */
    public String validateAddToCart(int tourId, int quantity) {
        try {
            Tour tour = tourDAO.getTourById(tourId);
            
            if (tour == null) {
                return "Tour không tồn tại";
            }
            
            if (!tour.isAvailable()) {
                return "Tour đã hết chỗ";
            }
            
            int availableSlots = tour.getAvailableSlots();
            if (quantity > availableSlots) {
                return "Chỉ còn " + availableSlots + " chỗ trống. Vui lòng giảm số lượng.";
            }
            
            if (quantity <= 0) {
                return "Số lượng phải lớn hơn 0";
            }
            
            return null; // OK
        } catch (SQLException e) {
            e.printStackTrace();
            return "Lỗi hệ thống. Vui lòng thử lại.";
        }
    }
    
    /**
     * Lấy danh sách items trong giỏ hàng
     * Tự động validate và cập nhật theo thời gian thực
     * @return CartValidationResult chứa items và thông báo
     */
    public CartValidationResult getCartItemsWithValidation(HttpSession session, Integer userId) {
        List<CartItem> items;
        List<String> warnings = new ArrayList<>();
        List<String> removedItems = new ArrayList<>();
        
        if (userId != null) {
            // User đã đăng nhập - lấy từ database
            items = cartDAO.getCartItems(userId);
            // Validate và cleanup database cart
            validateAndCleanupDatabaseCart(userId, items, warnings, removedItems);
        } else {
            // User chưa đăng nhập - lấy từ session
            items = getSessionCartItems(session);
            // Validate và cleanup session cart
            validateAndCleanupSessionCart(session, items, warnings, removedItems);
        }
        
        return new CartValidationResult(items, warnings, removedItems);
    }
    
    /**
     * Lấy danh sách items trong giỏ hàng (backward compatibility)
     */
    public List<CartItem> getCartItems(HttpSession session, Integer userId) {
        return getCartItemsWithValidation(session, userId).getItems();
    }
    
    /**
     * Validate giỏ hàng và xóa các items không hợp lệ
     * - Tour đã bị xóa
     * - Tour đã hết chỗ
     * - Số lượng vượt quá chỗ còn trống
     */
    private void validateAndCleanupDatabaseCart(int userId, List<CartItem> items, 
                                                List<String> warnings, List<String> removedItems) {
        List<CartItem> toRemove = new ArrayList<>();
        
        for (CartItem item : items) {
            Tour tour = item.getTour();
            
            // Tour đã bị xóa hoặc không tồn tại
            if (tour == null) {
                cartDAO.removeFromCart(userId, item.getTourId());
                toRemove.add(item);
                removedItems.add("Tour ID " + item.getTourId() + " không còn tồn tại");
                continue;
            }
            
            // Tour đã hết chỗ - xóa khỏi giỏ
            if (!tour.isAvailable()) {
                cartDAO.removeFromCart(userId, item.getTourId());
                toRemove.add(item);
                removedItems.add(tour.getName() + " đã hết chỗ");
                continue;
            }
            
            // Số lượng vượt quá chỗ còn trống - tự động điều chỉnh
            int availableSlots = tour.getAvailableSlots();
            if (item.getQuantity() > availableSlots) {
                if (availableSlots > 0) {
                    // Còn chỗ nhưng không đủ - giảm quantity
                    cartDAO.updateQuantity(userId, item.getTourId(), availableSlots);
                    item.setQuantity(availableSlots);
                    warnings.add(tour.getName() + ": Số lượng đã được điều chỉnh từ " + 
                               item.getQuantity() + " xuống " + availableSlots + " (chỗ còn trống)");
                } else {
                    // Hết chỗ hoàn toàn - xóa
                    cartDAO.removeFromCart(userId, item.getTourId());
                    toRemove.add(item);
                    removedItems.add(tour.getName() + " đã hết chỗ");
                }
            }
        }
        
        // Xóa items khỏi list
        items.removeAll(toRemove);
    }
    
    /**
     * Validate session cart và xóa các items không hợp lệ
     */
    private void validateAndCleanupSessionCart(HttpSession session, List<CartItem> items,
                                               List<String> warnings, List<String> removedItems) {
        Map<Integer, Integer> cart = getSessionCart(session);
        List<CartItem> toRemove = new ArrayList<>();
        
        for (CartItem item : items) {
            Tour tour = item.getTour();
            
            // Tour đã bị xóa hoặc không tồn tại
            if (tour == null) {
                cart.remove(item.getTourId());
                toRemove.add(item);
                removedItems.add("Tour ID " + item.getTourId() + " không còn tồn tại");
                continue;
            }
            
            // Tour đã hết chỗ
            if (!tour.isAvailable()) {
                cart.remove(item.getTourId());
                toRemove.add(item);
                removedItems.add(tour.getName() + " đã hết chỗ");
                continue;
            }
            
            // Số lượng vượt quá chỗ còn trống
            int availableSlots = tour.getAvailableSlots();
            if (item.getQuantity() > availableSlots) {
                if (availableSlots > 0) {
                    // Còn chỗ nhưng không đủ - giảm quantity
                    cart.put(item.getTourId(), availableSlots);
                    item.setQuantity(availableSlots);
                    warnings.add(tour.getName() + ": Số lượng đã được điều chỉnh từ " + 
                               item.getQuantity() + " xuống " + availableSlots + " (chỗ còn trống)");
                } else {
                    // Hết chỗ hoàn toàn - xóa
                    cart.remove(item.getTourId());
                    toRemove.add(item);
                    removedItems.add(tour.getName() + " đã hết chỗ");
                }
            }
        }
        
        // Xóa items khỏi list
        items.removeAll(toRemove);
    }
    
    /**
     * Inner class để chứa kết quả validation
     */
    public static class CartValidationResult {
        private final List<CartItem> items;
        private final List<String> warnings;
        private final List<String> removedItems;
        
        public CartValidationResult(List<CartItem> items, List<String> warnings, List<String> removedItems) {
            this.items = items;
            this.warnings = warnings;
            this.removedItems = removedItems;
        }
        
        public List<CartItem> getItems() { return items; }
        public List<String> getWarnings() { return warnings; }
        public List<String> getRemovedItems() { return removedItems; }
        public boolean hasWarnings() { return !warnings.isEmpty(); }
        public boolean hasRemovedItems() { return !removedItems.isEmpty(); }
    }
    
    /**
     * Cập nhật số lượng
     */
    public boolean updateQuantity(HttpSession session, Integer userId, int tourId, int quantity) {
        if (userId != null) {
            return cartDAO.updateQuantity(userId, tourId, quantity);
        } else {
            return updateSessionCartQuantity(session, tourId, quantity);
        }
    }
    
    /**
     * Xóa item khỏi giỏ hàng
     */
    public boolean removeFromCart(HttpSession session, Integer userId, int tourId) {
        if (userId != null) {
            return cartDAO.removeFromCart(userId, tourId);
        } else {
            return removeFromSessionCart(session, tourId);
        }
    }
    
    /**
     * Xóa toàn bộ giỏ hàng
     */
    public boolean clearCart(HttpSession session, Integer userId) {
        if (userId != null) {
            return cartDAO.clearCart(userId);
        } else {
            session.removeAttribute(SESSION_CART_KEY);
            return true;
        }
    }
    
    /**
     * Đếm số items trong giỏ
     */
    public int getCartItemCount(HttpSession session, Integer userId) {
        if (userId != null) {
            return cartDAO.getCartItemCount(userId);
        } else {
            Map<Integer, Integer> sessionCart = getSessionCart(session);
            return sessionCart.size();
        }
    }
    
    /**
     * Tính tổng giá trị giỏ hàng
     */
    public double getCartTotal(HttpSession session, Integer userId) {
        List<CartItem> items = getCartItems(session, userId);
        return items.stream()
                   .mapToDouble(CartItem::getSubtotal)
                   .sum();
    }
    
    /**
     * Migrate giỏ hàng từ session sang database khi user đăng nhập
     */
    public void migrateSessionCartToDatabase(HttpSession session, int userId) {
        Map<Integer, Integer> sessionCart = getSessionCart(session);
        
        if (sessionCart.isEmpty()) {
            return;
        }
        
        // Chuyển từng item từ session sang database
        for (Map.Entry<Integer, Integer> entry : sessionCart.entrySet()) {
            int tourId = entry.getKey();
            int quantity = entry.getValue();
            cartDAO.addToCart(userId, tourId, quantity);
        }
        
        // Xóa session cart sau khi migrate
        session.removeAttribute(SESSION_CART_KEY);
    }
    
    // ========== PRIVATE METHODS - SESSION CART ==========
    
    /**
     * Lấy session cart (Map<TourId, Quantity>)
     */
    @SuppressWarnings("unchecked")
    private Map<Integer, Integer> getSessionCart(HttpSession session) {
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute(SESSION_CART_KEY);
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute(SESSION_CART_KEY, cart);
        }
        return cart;
    }
    
    /**
     * Thêm vào session cart
     */
    private boolean addToSessionCart(HttpSession session, int tourId, int quantity) {
        Map<Integer, Integer> cart = getSessionCart(session);
        cart.merge(tourId, quantity, Integer::sum);
        return true;
    }
    
    /**
     * Lấy session cart items với thông tin tour đầy đủ
     */
    private List<CartItem> getSessionCartItems(HttpSession session) {
        Map<Integer, Integer> cart = getSessionCart(session);
        List<CartItem> items = new ArrayList<>();
        
        try {
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                int tourId = entry.getKey();
                int quantity = entry.getValue();
                
                Tour tour = tourDAO.getTourById(tourId);
                if (tour != null) {
                    CartItem item = new CartItem();
                    item.setTourId(tourId);
                    item.setQuantity(quantity);
                    item.setTour(tour);
                    item.setAddedAt(LocalDateTime.now());
                    items.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return items;
    }
    
    /**
     * Cập nhật quantity trong session cart
     */
    private boolean updateSessionCartQuantity(HttpSession session, int tourId, int quantity) {
        Map<Integer, Integer> cart = getSessionCart(session);
        
        if (quantity <= 0) {
            cart.remove(tourId);
        } else {
            cart.put(tourId, quantity);
        }
        
        return true;
    }
    
    /**
     * Xóa item khỏi session cart
     */
    private boolean removeFromSessionCart(HttpSession session, int tourId) {
        Map<Integer, Integer> cart = getSessionCart(session);
        cart.remove(tourId);
        return true;
    }
}
