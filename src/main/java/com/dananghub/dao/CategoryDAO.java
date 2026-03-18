package com.dananghub.dao;

import com.dananghub.entity.Category;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class CategoryDAO {

    public List<Category> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT DISTINCT c FROM Category c ORDER BY c.categoryName", Category.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public Category findById(int categoryId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Category.class, categoryId);
        } finally {
            em.close();
        }
    }
}
