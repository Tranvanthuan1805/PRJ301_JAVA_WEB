package com.dananghub.dao;

import com.dananghub.entity.Coupon;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import java.util.List;

public class CouponDAO {

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

    public Coupon findById(int couponId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Coupon.class, couponId);
        } finally {
            em.close();
        }
    }

    public List<Coupon> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT c FROM Coupon c ORDER BY c.createdAt DESC",
                Coupon.class)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public boolean create(Coupon coupon) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(coupon);
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

    public boolean update(Coupon coupon) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(coupon);
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

    public boolean delete(int couponId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Coupon coupon = em.find(Coupon.class, couponId);
            if (coupon != null) {
                em.remove(coupon);
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

    public boolean incrementUsage(int couponId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Coupon coupon = em.find(Coupon.class, couponId);
            if (coupon != null) {
                coupon.setUsedCount(coupon.getUsedCount() + 1);
                em.merge(coupon);
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
}
