package com.dananghub.dao;

/**
 * ====================================================
 * MODULE 3: TOUR DU LICH - Le Quang Minh
 * ====================================================
 * DAO cho bang TourPriceSeasons
 *
 * TODO cho Minh:
 *   1. Hoan thien cac method ben duoi
 *   2. Them logic tinh gia hien tai theo mua
 *   3. Tich hop vao TourServlet va TourDAO de tu dong ap dung gia mua
 * ====================================================
 */

import com.dananghub.entity.TourPriceSeason;
import jakarta.persistence.*;
import java.util.List;

public class TourPriceSeasonDAO {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("DaNangTravelHubPU");

    // TODO Minh: Lay tat ca mua gia cua 1 tour
    public List<TourPriceSeason> findByTourId(int tourId) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery(
                "SELECT s FROM TourPriceSeason s WHERE s.tour.tourId = :tid ORDER BY s.startDate ASC",
                TourPriceSeason.class
            ).setParameter("tid", tourId).getResultList();
        } finally {
            em.close();
        }
    }

    // TODO Minh: Tim mua dang hoat dong cho 1 tour (ngay hien tai nam trong khoang)
    public TourPriceSeason findActiveSeason(int tourId) {
        // TODO: SELECT ... WHERE tourId = ? AND isActive = true
        //       AND GETDATE() BETWEEN startDate AND endDate
        return null;
    }

    // TODO Minh: Tinh gia hien tai cua tour (basePrice * priceMultiplier)
    public double calculateCurrentPrice(int tourId, double basePrice) {
        TourPriceSeason season = findActiveSeason(tourId);
        if (season != null) {
            return basePrice * season.getPriceMultiplier();
        }
        return basePrice; // Tra ve gia goc neu khong co mua nao
    }

    // TODO Minh: Them mua gia moi
    public void insert(TourPriceSeason season) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(season);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}
