package dao;

import model.Tour;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.ArrayList;
import java.util.List;

/**
 * TourDAO - JPA Data Access Object for Tour operations
 * Works with TourManagement database (2020-2026 tours)
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
     * Get all 2026 tours (for Guest Explore)
     */
    public List<Tour> getAllActiveTours() {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT t FROM Tour t WHERE YEAR(t.startDate) = 2026 ORDER BY t.tourName";
            TypedQuery<Tour> query = em.createQuery(jpql, Tour.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get all tours with pagination
     */
    public List<Tour> getToursPaginated(int offset, int limit) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT t FROM Tour t WHERE YEAR(t.startDate) = 2026 ORDER BY t.tourName";
            TypedQuery<Tour> query = em.createQuery(jpql, Tour.class);
            query.setFirstResult(offset);
            query.setMaxResults(limit);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
    
    /**
     * Search tours by name or destination
     */
    public List<Tour> searchTours(String keyword) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT t FROM Tour t WHERE YEAR(t.startDate) = 2026 " +
                         "AND (LOWER(t.tourName) LIKE :keyword OR LOWER(t.startLocation) LIKE :keyword " +
                         "OR LOWER(t.description) LIKE :keyword) ORDER BY t.tourName";
            TypedQuery<Tour> query = em.createQuery(jpql, Tour.class);
            query.setParameter("keyword", "%" + keyword.toLowerCase() + "%");
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get tours with available slots
     */
    public List<Tour> getToursWithAvailableSlots() {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT t FROM Tour t WHERE YEAR(t.startDate) = 2026 " +
                         "AND (t.maxCapacity - t.currentCapacity) > 0 ORDER BY t.tourName";
            TypedQuery<Tour> query = em.createQuery(jpql, Tour.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get historical tours (before 2026) - for Admin
     */
    public List<Tour> getHistoricalTours() {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT t FROM Tour t WHERE YEAR(t.startDate) < 2026 ORDER BY t.startDate DESC";
            TypedQuery<Tour> query = em.createQuery(jpql, Tour.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get historical tours with pagination - for Admin
     */
    public List<Tour> getHistoricalToursPaginated(int offset, int limit) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT t FROM Tour t WHERE YEAR(t.startDate) < 2026 ORDER BY t.startDate DESC";
            TypedQuery<Tour> query = em.createQuery(jpql, Tour.class);
            query.setFirstResult(offset);
            query.setMaxResults(limit);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
    
    /**
     * Count total 2026 tours
     */
    public int countTours() {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT COUNT(t) FROM Tour t WHERE YEAR(t.startDate) = 2026";
            Long count = em.createQuery(jpql, Long.class).getSingleResult();
            return count.intValue();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }
    
    /**
     * Count historical tours
     */
    public int countHistoricalTours() {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT COUNT(t) FROM Tour t WHERE YEAR(t.startDate) < 2026";
            Long count = em.createQuery(jpql, Long.class).getSingleResult();
            return count.intValue();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }
    
    /**
     * Create new tour (Admin only)
     */
    public boolean createTour(Tour tour) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(tour);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    
    /**
     * Update tour (Admin only)
     */
    public boolean updateTour(Tour tour) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(tour);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    
    /**
     * Delete tour (Admin only)
     */
    public boolean deleteTour(int tourId) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            em.getTransaction().begin();
            Tour tour = em.find(Tour.class, tourId);
            if (tour != null) {
                em.remove(tour);
                em.getTransaction().commit();
                return true;
            }
            em.getTransaction().rollback();
            return false;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    
    /**
     * Get all tours (for Admin management)
     */
    public List<Tour> getAllTours() {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT t FROM Tour t ORDER BY t.startDate DESC";
            TypedQuery<Tour> query = em.createQuery(jpql, Tour.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get top booked tours - for Admin analytics
     */
    public List<Object[]> getTopBookedTours(int limit) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT t.tourName, t.currentCapacity, t.maxCapacity " +
                         "FROM Tour t WHERE t.currentCapacity > 0 " +
                         "ORDER BY t.currentCapacity DESC";
            TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
            query.setMaxResults(limit);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get least booked tours - for Admin analytics
     */
    public List<Object[]> getLeastBookedTours(int limit) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT t.tourName, t.currentCapacity, t.maxCapacity " +
                         "FROM Tour t ORDER BY t.currentCapacity ASC";
            TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
            query.setMaxResults(limit);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get occupancy rate statistics - for Admin analytics
     */
    public List<Object[]> getOccupancyRates() {
        EntityManager em = JPAContext.getEntityManager();
        try {
            String jpql = "SELECT t.tourName, t.currentCapacity, t.maxCapacity, " +
                         "(CAST(t.currentCapacity AS double) / t.maxCapacity * 100) as occupancyRate " +
                         "FROM Tour t WHERE t.maxCapacity > 0 " +
                         "ORDER BY occupancyRate DESC";
            TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
}
