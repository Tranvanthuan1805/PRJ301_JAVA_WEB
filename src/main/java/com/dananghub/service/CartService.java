package com.dananghub.service;

import com.dananghub.dao.TourDAO;
import com.dananghub.dao.BookingDAO;
import com.dananghub.entity.CartItem;
import com.dananghub.entity.Tour;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Service xử lý realtime giỏ hàng
 * - Cập nhật giá realtime
 * - Kiểm tra availability realtime
 * - Validate giỏ hàng
 */
public class CartService {

    private final TourDAO tourDAO = new TourDAO();
    private final BookingDAO bookingDAO = new BookingDAO();

    /**
     * Cập nhật giá realtime cho tất cả item trong giỏ
     * So sánh với giá hiện tại trong DB
     */
    public List<CartItem> refreshPrices(List<CartItem> cart) {
        if (cart == null || cart.isEmpty()) {
            return cart;
        }

        List<CartItem> updatedCart = new ArrayList<>();
        for (CartItem item : cart) {
            Tour currentTour = tourDAO.findById(item.getTour().getTourId());
            if (currentTour != null) {
                // Cập nhật giá mới
                item.getTour().setPrice(currentTour.getPrice());
                item.setTotalPrice(currentTour.getPrice() * item.getQuantity());
                updatedCart.add(item);
            }
        }
        return updatedCart;
    }

    /**
     * Kiểm tra availability realtime cho tất cả item
     * Trả về danh sách item không còn đủ chỗ
     */
    public List<CartItem> validateAvailability(List<CartItem> cart) {
        List<CartItem> unavailableItems = new ArrayList<>();

        if (cart == null || cart.isEmpty()) {
            return unavailableItems;
        }

        for (CartItem item : cart) {
            Date travelDate = item.getTravelDate() != null ? item.getTravelDate() : new Date();
            boolean isAvailable = tourDAO.checkAvailability(
                item.getTour().getTourId(),
                travelDate,
                item.getQuantity()
            );

            if (!isAvailable) {
                unavailableItems.add(item);
            }
        }

        return unavailableItems;
    }

    /**
     * Lấy số chỗ còn trống realtime cho 1 tour
     */
    public int getAvailableSlots(int tourId, Date travelDate) {
        if (travelDate == null) {
            travelDate = new Date();
        }
        return tourDAO.getAvailableSlots(tourId, travelDate);
    }

    /**
     * Tính tổng tiền giỏ hàng
     */
    public double calculateTotal(List<CartItem> cart) {
        if (cart == null || cart.isEmpty()) {
            return 0;
        }
        return cart.stream().mapToDouble(CartItem::getTotalPrice).sum();
    }

    /**
     * Validate giỏ hàng trước khi checkout
     * Trả về error message nếu có vấn đề
     */
    public String validateCart(List<CartItem> cart) {
        if (cart == null || cart.isEmpty()) {
            return "Giỏ hàng trống";
        }

        // Kiểm tra availability
        List<CartItem> unavailable = validateAvailability(cart);
        if (!unavailable.isEmpty()) {
            StringBuilder msg = new StringBuilder("Các tour sau không còn đủ chỗ: ");
            for (CartItem item : unavailable) {
                int available = getAvailableSlots(item.getTour().getTourId(), item.getTravelDate());
                msg.append(item.getTour().getTourName())
                   .append(" (còn ").append(available).append(" chỗ), ");
            }
            return msg.toString();
        }

        // Kiểm tra tour còn active không
        for (CartItem item : cart) {
            Tour tour = tourDAO.findById(item.getTour().getTourId());
            if (tour == null || !tour.isActive()) {
                return "Tour " + item.getTour().getTourName() + " không còn hoạt động";
            }
        }

        return null; // Không có lỗi
    }

    /**
     * Lấy thông tin chi tiết giỏ hàng (kèm giá realtime, availability)
     */
    public CartDetailDTO getCartDetail(List<CartItem> cart) {
        CartDetailDTO detail = new CartDetailDTO();

        if (cart == null || cart.isEmpty()) {
            detail.setItems(new ArrayList<>());
            detail.setTotal(0);
            detail.setItemCount(0);
            return detail;
        }

        // Cập nhật giá realtime
        List<CartItem> updatedCart = refreshPrices(cart);

        // Kiểm tra availability
        List<CartItem> unavailable = validateAvailability(updatedCart);

        detail.setItems(updatedCart);
        detail.setTotal(calculateTotal(updatedCart));
        detail.setItemCount(updatedCart.size());
        detail.setUnavailableCount(unavailable.size());
        detail.setUnavailableItems(unavailable);

        return detail;
    }

    /**
     * DTO chứa thông tin chi tiết giỏ hàng
     */
    public static class CartDetailDTO {
        private List<CartItem> items;
        private double total;
        private int itemCount;
        private int unavailableCount;
        private List<CartItem> unavailableItems;

        public List<CartItem> getItems() { return items; }
        public void setItems(List<CartItem> items) { this.items = items; }

        public double getTotal() { return total; }
        public void setTotal(double total) { this.total = total; }

        public int getItemCount() { return itemCount; }
        public void setItemCount(int itemCount) { this.itemCount = itemCount; }

        public int getUnavailableCount() { return unavailableCount; }
        public void setUnavailableCount(int unavailableCount) { this.unavailableCount = unavailableCount; }

        public List<CartItem> getUnavailableItems() { return unavailableItems; }
        public void setUnavailableItems(List<CartItem> unavailableItems) { this.unavailableItems = unavailableItems; }
    }
}
