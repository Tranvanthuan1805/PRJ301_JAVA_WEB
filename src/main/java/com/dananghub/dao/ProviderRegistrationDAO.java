package com.dananghub.dao;

import com.dananghub.entity.ProviderRegistration;
import com.dananghub.entity.User;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.time.LocalDateTime;
import java.util.List;

/**
 * DAO xử lý CRUD cho bảng provider_registrations.
 * Dùng JPA/Hibernate, nhất quán với phần còn lại của project.
 */
public class ProviderRegistrationDAO {

    /**
     * Lưu đơn đăng ký mới vào DB.
     * 
     * @return id của bản ghi vừa tạo, hoặc -1 nếu lỗi
     */
    public int save(ProviderRegistration reg) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(reg);
            em.flush(); // để lấy id ngay sau persist
            tx.commit();
            return reg.getId();
        } catch (Exception e) {
            if (tx.isActive())
                tx.rollback();
            e.printStackTrace();
            return -1;
        } finally {
            em.close();
        }
    }

    /**
     * Lấy tất cả đơn, sắp xếp mới nhất trước.
     */
    public List<ProviderRegistration> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT r FROM ProviderRegistration r " +
                            "LEFT JOIN FETCH r.user " +
                            "ORDER BY r.createdAt DESC",
                    ProviderRegistration.class).getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Lấy đơn theo trạng thái (pending / approved / rejected).
     */
    public List<ProviderRegistration> findByStatus(String status) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT r FROM ProviderRegistration r " +
                            "LEFT JOIN FETCH r.user " +
                            "WHERE r.status = :status " +
                            "ORDER BY r.createdAt DESC",
                    ProviderRegistration.class).setParameter("status", status).getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Đếm số đơn đang chờ duyệt — dùng cho badge trên menu.
     */
    public long countPending() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT COUNT(r) FROM ProviderRegistration r WHERE r.status = 'pending'",
                    Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }

    /**
     * Tìm đơn theo id.
     */
    public ProviderRegistration findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // LEFT JOIN FETCH để tránh LazyInitializationException khi access user sau khi
            // EM đóng
            List<ProviderRegistration> result = em.createQuery(
                    "SELECT r FROM ProviderRegistration r LEFT JOIN FETCH r.user WHERE r.id = :id",
                    ProviderRegistration.class)
                    .setParameter("id", id)
                    .getResultList();
            return result.isEmpty() ? null : result.get(0);
        } finally {
            em.close();
        }
    }

    /**
     * Cập nhật trạng thái đơn (approve / reject).
     * 
     * @param id        id của đơn
     * @param status    "approved" hoặc "rejected"
     * @param adminNote lý do từ chối hoặc ghi chú
     * @param admin     user admin đang thực hiện
     */
    public boolean updateStatus(int id, String status, String adminNote, User admin) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ProviderRegistration reg = em.find(ProviderRegistration.class, id);
            if (reg == null)
                return false;

            reg.setStatus(status);
            reg.setAdminNote(adminNote);
            reg.setReviewedAt(LocalDateTime.now());
            reg.setReviewedBy(admin);
            em.merge(reg);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive())
                tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Kiểm tra user đã có đơn pending chưa (tránh spam).
     */
    public boolean hasPendingByUser(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Long count = em.createQuery(
                    "SELECT COUNT(r) FROM ProviderRegistration r " +
                            "WHERE r.user.userId = :uid AND r.status = 'pending'",
                    Long.class).setParameter("uid", userId).getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }
}
