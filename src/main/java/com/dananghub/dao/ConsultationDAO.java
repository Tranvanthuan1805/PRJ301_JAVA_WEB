package com.dananghub.dao;

import com.dananghub.entity.Consultation;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.List;

public class ConsultationDAO {

    public void save(Consultation c) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(c);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public List<Consultation> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM Consultation c ORDER BY c.createdAt DESC", Consultation.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Consultation> findByStatus(String status) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM Consultation c WHERE c.status = :status ORDER BY c.createdAt DESC", Consultation.class)
                    .setParameter("status", status)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public Consultation findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Consultation.class, id);
        } finally {
            em.close();
        }
    }

    public void updateStatus(int id, String status, String note) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Consultation c = em.find(Consultation.class, id);
            if (c != null) {
                c.setStatus(status);
                if (note != null) c.setAdminNote(note);
                em.merge(c);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public long countByStatus(String status) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(c) FROM Consultation c WHERE c.status = :status", Long.class)
                    .setParameter("status", status)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    public long countAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(c) FROM Consultation c", Long.class)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }
}
