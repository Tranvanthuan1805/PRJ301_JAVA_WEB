package com.dananghub.dao;

import com.dananghub.dto.OrderDetailDTO;
import com.dananghub.entity.Order;
import com.dananghub.entity.Tour;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderDAO {

    // ==================== READ ====================

    public List<Order> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT o FROM Order o ORDER BY o.orderDate DESC", Order.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public Order findById(int orderId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Order.class, orderId);
        } finally {
            em.close();
        }
    }

    public List<Order> findByCustomer(int customerId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT o FROM Order o WHERE o.customer.userId = :cid ORDER BY o.orderDate DESC",
                Order.class)
                .setParameter("cid", customerId)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Order> findByStatus(String status) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT o FROM Order o WHERE o.orderStatus = :status ORDER BY o.orderDate DESC",
                Order.class)
                .setParameter("status", status)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Order> findByTour(int tourId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT DISTINCT o FROM Order o JOIN o.bookings b WHERE b.tour.tourId = :tid ORDER BY o.orderDate DESC",
                Order.class)
                .setParameter("tid", tourId)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Order> findRecent(int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT o FROM Order o ORDER BY o.orderDate DESC", Order.class)
                    .setMaxResults(limit)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    // ==================== WRITE ====================

    public int create(Order order) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(order);
            tx.commit();
            return order.getOrderId();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return -1;
        } finally {
            em.close();
        }
    }

    public boolean update(Order order) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(order);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean updateStatus(int orderId, String status) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Order order = em.find(Order.class, orderId);
            if (order != null) {
                order.setOrderStatus(status);
                order.setUpdatedAt(new Date());
                em.merge(order);
                tx.commit();
                return true;
            }
            tx.rollback();
            return false;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean updatePaymentStatus(int orderId, String paymentStatus) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Order order = em.find(Order.class, orderId);
            if (order != null) {
                order.setPaymentStatus(paymentStatus);
                order.setUpdatedAt(new Date());
                em.merge(order);
                tx.commit();
                return true;
            }
            tx.rollback();
            return false;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean cancelOrder(int orderId, String reason) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Order order = em.find(Order.class, orderId);
            if (order != null && order.canCancel()) {
                order.setOrderStatus("Cancelled");
                order.setCancelReason(reason);
                order.setUpdatedAt(new Date());
                if ("Paid".equalsIgnoreCase(order.getPaymentStatus())) {
                    order.setPaymentStatus("Refunded");
                }
                em.merge(order);
                tx.commit();
                return true;
            }
            if (tx.isActive()) tx.rollback();
            return false;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // ==================== STATISTICS ====================

    public long countByStatus(String status) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT COUNT(o) FROM Order o WHERE o.orderStatus = :status", Long.class)
                .setParameter("status", status)
                .getSingleResult();
        } finally {
            em.close();
        }
    }

    public long countAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(o) FROM Order o", Long.class)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    public double getTotalRevenue() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Double result = em.createQuery(
                "SELECT COALESCE(SUM(o.totalAmount), 0) FROM Order o WHERE o.orderStatus = 'Completed'",
                Double.class)
                .getSingleResult();
            return result != null ? result : 0.0;
        } finally {
            em.close();
        }
    }

    public double getRevenueByDateRange(Date fromDate, Date toDate) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Object result = em.createQuery(
                "SELECT COALESCE(SUM(o.totalAmount), 0) FROM Order o " +
                "WHERE o.orderStatus = 'Completed' AND o.orderDate BETWEEN :from AND :to")
                .setParameter("from", fromDate)
                .setParameter("to", toDate)
                .getSingleResult();
            return result == null ? 0.0 : ((Number) result).doubleValue();
        } finally {
            em.close();
        }
    }

    // ==================== DTO Operations ====================

    public OrderDetailDTO getOrderDetail(int orderId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Order order = em.find(Order.class, orderId);
            if (order == null) return null;

            // Lay tour tu booking dau tien
            Tour tour = null;
            if (order.getBookings() != null && !order.getBookings().isEmpty()) {
                tour = order.getBookings().get(0).getTour();
            }
            String username = order.getCustomer() != null ? order.getCustomer().getUsername() : "";
            return new OrderDetailDTO(order, tour, username);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    public List<OrderDetailDTO> getAllOrderDetails() {
        List<OrderDetailDTO> result = new ArrayList<>();
        EntityManager em = JPAUtil.getEntityManager();
        try {
            List<Order> orders = em.createQuery(
                "SELECT o FROM Order o ORDER BY o.orderDate DESC", Order.class)
                .getResultList();

            for (Order order : orders) {
                Tour tour = null;
                if (order.getBookings() != null && !order.getBookings().isEmpty()) {
                    tour = order.getBookings().get(0).getTour();
                }
                String username = order.getCustomer() != null ? order.getCustomer().getUsername() : "";
                result.add(new OrderDetailDTO(order, tour, username));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return result;
    }

    public List<OrderDetailDTO> getOrderDetailsByCustomer(int customerId) {
        List<OrderDetailDTO> result = new ArrayList<>();
        EntityManager em = JPAUtil.getEntityManager();
        try {
            List<Order> orders = em.createQuery(
                "SELECT o FROM Order o WHERE o.customer.userId = :cid ORDER BY o.orderDate DESC",
                Order.class)
                .setParameter("cid", customerId)
                .getResultList();

            String username = "";
            if (!orders.isEmpty() && orders.get(0).getCustomer() != null) {
                username = orders.get(0).getCustomer().getUsername();
            }

            for (Order order : orders) {
                Tour tour = null;
                if (order.getBookings() != null && !order.getBookings().isEmpty()) {
                    tour = order.getBookings().get(0).getTour();
                }
                result.add(new OrderDetailDTO(order, tour, username));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return result;
    }
}
