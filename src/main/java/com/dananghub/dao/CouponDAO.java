package com.dananghub.dao;

import com.dananghub.entity.Coupon;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import java.util.ArrayList;
import java.util.List;

public class CouponDAO {

    public Coupon findByCode(String code) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT c FROM Coupon c WHERE UPPER(c.code) = :code", Coupon.class)
                .setParameter("code", code.toUpperCase().trim())
                .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally { em.close(); }
    }

    public List<Coupon> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM Coupon c ORDER BY c.couponId DESC", Coupon.class).getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally { em.close(); }
    }

    public Coupon findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Coupon.class, id);
        } finally { em.close(); }
    }

    public boolean save(Coupon coupon) {
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
        } finally { em.close(); }
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
        } finally { em.close(); }
    }

    public boolean delete(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Coupon c = em.find(Coupon.class, id);
            if (c != null) em.remove(c);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        } finally { em.close(); }
    }

    public boolean incrementUsage(int couponId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.createQuery("UPDATE Coupon c SET c.usedCount = c.usedCount + 1 WHERE c.couponId = :id")
                .setParameter("id", couponId).executeUpdate();
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        } finally { em.close(); }
    }
}
