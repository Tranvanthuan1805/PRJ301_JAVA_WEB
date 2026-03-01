package com.dananghub.dao;

import com.dananghub.entity.ProviderRegistration;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;

/**
 * DAO cho quản lý đơn đăng ký làm NCC
 */
public class ProviderRegistrationDAO {

    /**
     * Lưu đơn đăng ký mới
     */
    public ProviderRegistration save(ProviderRegistration registration) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(registration);
            tx.commit();
            return registration;
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    /**
     * Lấy tất cả đơn đăng ký
     */
    public List<ProviderRegistration> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<ProviderRegistration> query = em.createQuery(
                    "SELECT pr FROM ProviderRegistration pr ORDER BY pr.submittedDate DESC",
                    ProviderRegistration.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Lấy đơn đăng ký theo trạng thái
     */
    public List<ProviderRegistration> findByStatus(String status) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<ProviderRegistration> query = em.createQuery(
                    "SELECT pr FROM ProviderRegistration pr WHERE pr.status = :status ORDER BY pr.submittedDate DESC",
                    ProviderRegistration.class);
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Lấy đơn đăng ký theo ID
     */
    public ProviderRegistration findById(int registrationId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(ProviderRegistration.class, registrationId);
        } finally {
            em.close();
        }
    }

    /**
     * Kiểm tra email đã đăng ký chưa
     */
    public boolean isEmailRegistered(String email) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(pr) FROM ProviderRegistration pr WHERE pr.email = :email AND pr.status = 'Pending'",
                    Long.class);
            query.setParameter("email", email);
            return query.getSingleResult() > 0;
        } finally {
            em.close();
        }
    }

    /**
     * Cập nhật trạng thái đơn đăng ký
     */
    public void updateStatus(int registrationId, String status, Integer reviewedBy, String rejectionReason) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ProviderRegistration registration = em.find(ProviderRegistration.class, registrationId);
            if (registration != null) {
                registration.setStatus(status);
                registration.setReviewedBy(reviewedBy);
                registration.setRejectionReason(rejectionReason);
                registration.setReviewedDate(java.time.LocalDateTime.now());
                em.merge(registration);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }
}
