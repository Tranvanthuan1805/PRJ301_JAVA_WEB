package dao;

import jakarta.persistence.EntityManager;
import java.util.List;
import model.Tour;

/**
 * TourDAO - Data Access Object for Tour operations
 * Used by Order Management to get tour information
 */
public class TourDAO {
    
    /**
     * Get tour by ID
     */
    public Tour getTourById(int tourId) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            return em.find(Tour.class, tourId);
        } finally {
            em.close();
        }
    }
    
    /**
     * Get all active tours
     */
    public List<Tour> getAllActiveTours() {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT t FROM Tour t WHERE t.isActive = true ORDER BY t.tourName";
            return em.createQuery(jpql, Tour.class).getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get all tours (including inactive)
     */
    public List<Tour> getAllTours() {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT t FROM Tour t ORDER BY t.tourName";
            return em.createQuery(jpql, Tour.class).getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Count total tours
     */
    public long countTours() {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT COUNT(t) FROM Tour t WHERE t.isActive = true";
            return (Long) em.createQuery(jpql).getSingleResult();
        } finally {
            em.close();
        }
    }
}
