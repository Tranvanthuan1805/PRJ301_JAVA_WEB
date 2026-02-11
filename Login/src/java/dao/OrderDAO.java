package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Order;
import model.OrderDetailDTO;
import model.Tour;

/**
 * OrderDAO - Data Access Object for Order operations
 * Handles all database operations related to orders
 */
public class OrderDAO {
    
    // ==================== READ Operations ====================
    
    /**
     * Get all orders, sorted by date descending
     */
    public List<Order> getAllOrders() {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT o FROM Order o ORDER BY o.orderDate DESC";
            return em.createQuery(jpql, Order.class).getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get order by ID
     */
    public Order getOrderById(int orderId) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            return em.find(Order.class, orderId);
        } finally {
            em.close();
        }
    }
    
    /**
     * Get all orders for a specific user
     */
    public List<Order> getOrdersByUserId(int userId) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT o FROM Order o WHERE o.userId = :uid ORDER BY o.orderDate DESC";
            return em.createQuery(jpql, Order.class)
                     .setParameter("uid", userId)
                     .getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get orders filtered by status
     */
    public List<Order> getOrdersByStatus(String status) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT o FROM Order o WHERE o.status = :status ORDER BY o.orderDate DESC";
            return em.createQuery(jpql, Order.class)
                     .setParameter("status", status)
                     .getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get orders for a specific tour (for Provider integration)
     */
    public List<Order> getOrdersByTourId(int tourId) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT o FROM Order o WHERE o.tourId = :tid ORDER BY o.orderDate DESC";
            return em.createQuery(jpql, Order.class)
                     .setParameter("tid", tourId)
                     .getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get recent orders with limit
     */
    public List<Order> getRecentOrders(int limit) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT o FROM Order o ORDER BY o.orderDate DESC";
            return em.createQuery(jpql, Order.class)
                     .setMaxResults(limit)
                     .getResultList();
        } finally {
            em.close();
        }
    }
    
    // ==================== WRITE Operations ====================
    
    /**
     * Insert a new order
     */
    public boolean insertOrder(Order order) {
        EntityManager em = JPAContext.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(order);
            trans.commit();
            return true;
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    
    /**
     * Update order status
     */
    public boolean updateOrderStatus(int orderId, String newStatus) {
        EntityManager em = JPAContext.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            
            Order order = em.find(Order.class, orderId);
            if (order == null) {
                trans.rollback();
                return false;
            }
            
            order.setStatus(newStatus);
            order.setUpdatedAt(new Date());
            em.merge(order);
            
            trans.commit();
            System.out.println(">>> OrderDAO: Updated order " + orderId + " to status " + newStatus);
            return true;
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    
    /**
     * Update payment status
     */
    public boolean updatePaymentStatus(int orderId, String paymentStatus) {
        EntityManager em = JPAContext.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            
            Order order = em.find(Order.class, orderId);
            if (order == null) {
                trans.rollback();
                return false;
            }
            
            order.setPaymentStatus(paymentStatus);
            order.setUpdatedAt(new Date());
            em.merge(order);
            
            trans.commit();
            return true;
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    
    /**
     * Cancel an order with reason
     */
    public boolean cancelOrder(int orderId, String reason) {
        EntityManager em = JPAContext.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            
            Order order = em.find(Order.class, orderId);
            if (order == null) {
                trans.rollback();
                return false;
            }
            
            // Check if order can be cancelled
            if (!order.canCancel()) {
                trans.rollback();
                System.out.println(">>> OrderDAO: Order " + orderId + " cannot be cancelled (status: " + order.getStatus() + ")");
                return false;
            }
            
            order.setStatus("Cancelled");
            order.setCancelReason(reason);
            order.setUpdatedAt(new Date());
            
            // If was paid, mark as refunded
            if ("Paid".equalsIgnoreCase(order.getPaymentStatus())) {
                order.setPaymentStatus("Refunded");
            }
            
            em.merge(order);
            trans.commit();
            System.out.println(">>> OrderDAO: Cancelled order " + orderId);
            return true;
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    
    // ==================== Statistics Operations ====================
    
    /**
     * Count orders by status
     */
    public long countByStatus(String status) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT COUNT(o) FROM Order o WHERE o.status = :status";
            return (Long) em.createQuery(jpql)
                            .setParameter("status", status)
                            .getSingleResult();
        } finally {
            em.close();
        }
    }
    
    /**
     * Count all orders
     */
    public long countAllOrders() {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT COUNT(o) FROM Order o";
            return (Long) em.createQuery(jpql).getSingleResult();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get total revenue (sum of completed orders)
     */
    public double getTotalRevenue() {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT COALESCE(SUM(o.totalPrice), 0) FROM Order o WHERE o.status = 'Completed'";
            Object result = em.createQuery(jpql).getSingleResult();
            return result == null ? 0.0 : ((Number) result).doubleValue();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get revenue within date range
     */
    public double getRevenueByDateRange(Date fromDate, Date toDate) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT COALESCE(SUM(o.totalPrice), 0) FROM Order o " +
                          "WHERE o.status = 'Completed' AND o.orderDate BETWEEN :from AND :to";
            Object result = em.createQuery(jpql)
                              .setParameter("from", fromDate)
                              .setParameter("to", toDate)
                              .getSingleResult();
            return result == null ? 0.0 : ((Number) result).doubleValue();
        } finally {
            em.close();
        }
    }
    
    // ==================== DTO Operations ====================
    
    /**
     * Get order detail with tour and user info
     */
    public OrderDetailDTO getOrderDetailById(int orderId) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            Order order = em.find(Order.class, orderId);
            if (order == null) return null;
            
            Tour tour = em.find(Tour.class, order.getTourId());
            
            // Get username from Users table (native query)
            String sql = "SELECT Username FROM Users WHERE UserId = ?";
            Object username = em.createNativeQuery(sql)
                                .setParameter(1, order.getUserId())
                                .getSingleResult();
            
            return new OrderDetailDTO(order, tour, username.toString());
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }
    
    /**
     * Get all orders with tour and user details
     */
    public List<OrderDetailDTO> getAllOrderDetails() {
        EntityManager em = JPAContext.getEntityManager();
        List<OrderDetailDTO> result = new ArrayList<>();
        try {
            List<Order> orders = getAllOrders();
            
            for (Order order : orders) {
                Tour tour = em.find(Tour.class, order.getTourId());
                
                String sql = "SELECT Username FROM Users WHERE UserId = ?";
                Object username = em.createNativeQuery(sql)
                                    .setParameter(1, order.getUserId())
                                    .getSingleResult();
                
                result.add(new OrderDetailDTO(order, tour, username.toString()));
            }
            
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return result;
        } finally {
            em.close();
        }
    }
    
    /**
     * Get order details for a specific user
     */
    public List<OrderDetailDTO> getOrderDetailsByUserId(int userId) {
        EntityManager em = JPAContext.getEntityManager();
        List<OrderDetailDTO> result = new ArrayList<>();
        try {
            List<Order> orders = getOrdersByUserId(userId);
            
            // Get username once
            String sql = "SELECT Username FROM Users WHERE UserId = ?";
            Object username = em.createNativeQuery(sql)
                                .setParameter(1, userId)
                                .getSingleResult();
            String usernameStr = username.toString();
            
            for (Order order : orders) {
                Tour tour = em.find(Tour.class, order.getTourId());
                result.add(new OrderDetailDTO(order, tour, usernameStr));
            }
            
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return result;
        } finally {
            em.close();
        }
    }
}
