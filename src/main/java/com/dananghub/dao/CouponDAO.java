package com.dananghub.dao;

import com.dananghub.entity.Coupon;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;

public class CouponDAO {

    /**
     * Tìm mã giảm giá theo code
     */
    public Coupon findByCode(String code) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT c FROM Coupon c WHERE UPPER(c.code) = :code",
                Coupon.class)
                .setParameter("code", code.toUpperCase().trim())
                .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * Tăng số lần sử dụng mã
     */
    public boolean incrementUsage(int couponId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            int updated = em.createQuery(
                "UPDATE Coupon c SET c.usedCount = c.usedCount + 1 WHERE c.couponId = :id")
                .setParameter("id", couponId)
                .executeUpdate();
            tx.commit();
            return updated > 0;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
}
