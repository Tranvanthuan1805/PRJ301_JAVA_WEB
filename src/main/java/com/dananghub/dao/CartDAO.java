package com.dananghub.dao;

/**
 * ====================================================
 * MODULE 4: GIO HANG & DAT TOUR - Le Van Dai
 * ====================================================
 * DAO cho bang Carts va CartItems
 *
 * TODO cho Dai:
 *   1. Hoan thien cac method ben duoi
 *   2. Them logic phat hien gio hang bi bo quen (AbandonedAt)
 *   3. Them method cap nhat gia realtime khi xem gio hang
 *   4. Them method chuyen doi gio hang thanh don dat tour (Converted)
 *   5. Tich hop vao BookingServlet.java
 *   6. Cap nhat cart.jsp de hien thi gio hang tu DB (khong chi session)
 * ====================================================
 */

import com.dananghub.entity.Cart;
import com.dananghub.entity.CartItem;
import jakarta.persistence.*;
import java.util.List;

public class CartDAO {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("DaNangTravelHubPU");

    // TODO Dai: Lay gio hang Active cua 1 khach hang
    public Cart findActiveCart(int customerId) {
        EntityManager em = emf.createEntityManager();
        try {
            List<Cart> carts = em.createQuery(
                "SELECT c FROM Cart c WHERE c.customerId = :cid AND c.status = 'Active'",
                Cart.class
            ).setParameter("cid", customerId).getResultList();
            return carts.isEmpty() ? null : carts.get(0);
        } finally {
            em.close();
        }
    }

    // TODO Dai: Tao gio hang moi
    public Cart createCart(int customerId, String sessionId) {
        // TODO: INSERT Carts (CustomerId, SessionId, Status='Active')
        return null;
    }

    // TODO Dai: Them tour vao gio hang
    public void addItem(int cartId, int tourId, String travelDate, int quantity, double unitPrice) {
        // TODO: INSERT CartItems (CartId, TourId, TravelDate, Quantity, UnitPrice)
        // Neu tour + travelDate da co trong gio thi UPDATE Quantity
    }

    // TODO Dai: Xoa item khoi gio hang
    public void removeItem(int cartItemId) {
        // TODO: DELETE CartItems WHERE CartItemId = ?
    }

    // TODO Dai: Lay tat ca items trong gio hang
    public List<CartItem> getCartItems(int cartId) {
        // TODO: SELECT CartItems JOIN Tours WHERE CartId = ?
        return null;
    }

    // TODO Dai: Cap nhat gia realtime (so sanh voi gia hien tai cua tour)
    public void refreshPrices(int cartId) {
        // TODO: UPDATE CartItems SET UnitPrice = Tours.Price (hoac SeasonalPrice)
        // WHERE CartId = ?
    }

    // TODO Dai: Chuyen gio hang thanh don dat tour
    public void convertToOrder(int cartId) {
        // TODO: UPDATE Carts SET Status = 'Converted'
    }

    // TODO Dai: Danh dau gio hang bi bo quen (goi tu cron job)
    public void markAbandoned(int hoursThreshold) {
        // TODO: UPDATE Carts SET Status='Abandoned', AbandonedAt=NOW
        // WHERE Status='Active' AND UpdatedAt < NOW - hoursThreshold
    }

    // TODO Dai: Lay danh sach gio hang bi bo quen (cho AI gui reminder)
    public List<Cart> getAbandonedCarts() {
        // TODO: SELECT Carts WHERE Status = 'Abandoned'
        return null;
    }
}
