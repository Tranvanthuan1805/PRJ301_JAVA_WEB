package com.dananghub.dao;

import com.dananghub.entity.Customer;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import java.util.List;

public class CustomerDAO {

    // ==================== READ ====================

    public List<Customer> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM Customer c", Customer.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Customer> findAllPaginated(int offset, int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM Customer c ORDER BY c.customerId DESC", Customer.class)
                    .setFirstResult(offset)
                    .setMaxResults(limit)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public Customer findById(int customerId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Customer.class, customerId);
        } finally {
            em.close();
        }
    }

    public Customer findByEmail(String email) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT c FROM Customer c WHERE c.user.email = :email", Customer.class)
                .setParameter("email", email)
                .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public List<Customer> findActive() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT c FROM Customer c WHERE c.status = 'active'", Customer.class)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Customer> findByStatus(String status, int offset, int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT c FROM Customer c WHERE c.status = :status ORDER BY c.customerId DESC",
                Customer.class)
                .setParameter("status", status)
                .setFirstResult(offset)
                .setMaxResults(limit)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Customer> search(String keyword, int offset, int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT c FROM Customer c WHERE " +
                "LOWER(c.user.fullName) LIKE :kw OR LOWER(c.user.email) LIKE :kw OR LOWER(c.user.phoneNumber) LIKE :kw " +
                "ORDER BY c.customerId DESC",
                Customer.class)
                .setParameter("kw", "%" + keyword.toLowerCase() + "%")
                .setFirstResult(offset)
                .setMaxResults(limit)
                .getResultList();
        } finally {
            em.close();
        }
    }

    // ==================== COUNT ====================

    public long countAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(c) FROM Customer c", Long.class)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    public long countByStatus(String status) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT COUNT(c) FROM Customer c WHERE c.status = :status", Long.class)
                .setParameter("status", status)
                .getSingleResult();
        } finally {
            em.close();
        }
    }

    public long countSearch(String keyword) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT COUNT(c) FROM Customer c WHERE " +
                "LOWER(c.user.fullName) LIKE :kw OR LOWER(c.user.email) LIKE :kw OR LOWER(c.user.phoneNumber) LIKE :kw",
                Long.class)
                .setParameter("kw", "%" + keyword.toLowerCase() + "%")
                .getSingleResult();
        } finally {
            em.close();
        }
    }

    // ==================== WRITE ====================

    public boolean create(Customer customer) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(customer);
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

    public boolean update(Customer customer) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(customer);
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

    public boolean updateStatus(int customerId, String status) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Customer c = em.find(Customer.class, customerId);
            if (c != null) {
                c.setStatus(status);
                em.merge(c);
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

    public boolean delete(int customerId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Customer c = em.find(Customer.class, customerId);
            if (c != null) {
                em.remove(c);
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
