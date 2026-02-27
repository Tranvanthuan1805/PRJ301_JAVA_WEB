package com.dananghub.dao;

import com.dananghub.entity.Provider;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.List;

public class ProviderDAO {

    public List<Provider> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT p FROM Provider p", Provider.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public Provider findById(int providerId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Provider.class, providerId);
        } finally {
            em.close();
        }
    }

    public List<Provider> findActive() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT p FROM Provider p WHERE p.isActive = true", Provider.class)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public boolean create(Provider provider) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(provider);
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

    public boolean update(Provider provider) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(provider);
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

    public boolean delete(int providerId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Provider p = em.find(Provider.class, providerId);
            if (p != null) {
                em.remove(p);
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
