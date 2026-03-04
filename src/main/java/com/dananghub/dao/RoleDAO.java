package com.dananghub.dao;

import com.dananghub.entity.Role;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import java.util.List;

public class RoleDAO {

    public List<Role> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT r FROM Role r ORDER BY r.roleId", Role.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public Role findById(int roleId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Role.class, roleId);
        } finally {
            em.close();
        }
    }

    public Role findByName(String roleName) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT r FROM Role r WHERE r.roleName = :name", Role.class)
                .setParameter("name", roleName)
                .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
}
