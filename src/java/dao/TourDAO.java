package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import java.util.List;
import model.Tour;

// Dòng này quan trọng: implements ITourDAO
public class TourDAO implements ITourDAO {

    @Override
    public List<Tour> getAllTours() {
        EntityManager em = JPAContext.getEntityManager();
        try {
            // JPQL: Chọn Object Tour
            return em.createQuery("SELECT t FROM Tour t", Tour.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Tour getTourById(int id) {
        EntityManager em = JPAContext.getEntityManager();
        try {
            return em.find(Tour.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public long countTours() {
        EntityManager em = JPAContext.getEntityManager();
        try {
            return (long) em.createQuery("SELECT COUNT(t) FROM Tour t").getSingleResult();
        } finally {
            em.close();
        }
    }

    // --- CÁC HÀM THÊM/SỬA/XÓA (Viết luôn cho đủ bộ) ---

    @Override
    public void insertTour(Tour t) {
        EntityManager em = JPAContext.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(t); // persist = insert
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
        } finally {
            em.close();
        }
    }

    @Override
    public void updateTour(Tour t) {
        EntityManager em = JPAContext.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(t); // merge = update
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
        } finally {
            em.close();
        }
    }

    @Override
    public void deleteTour(int id) {
        EntityManager em = JPAContext.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Tour t = em.find(Tour.class, id);
            if (t != null) {
                em.remove(t); // remove = delete
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
        } finally {
            em.close();
        }
    }
    
    @Override
    public List<Tour> searchTours(String keyword) {
        EntityManager em = JPAContext.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            // Tìm tour có tên chứa từ khóa (LIKE)
            String jpql = "SELECT t FROM Tour t WHERE t.tourName LIKE :kw";
            Query query = em.createQuery(jpql);
            query.setParameter("kw", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}