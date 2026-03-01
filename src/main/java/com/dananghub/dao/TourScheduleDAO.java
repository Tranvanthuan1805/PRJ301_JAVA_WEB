package com.dananghub.dao;

/**
 * ====================================================
 * MODULE 3: TOUR DU LICH - Le Quang Minh
 * ====================================================
 * DAO cho bang TourSchedules
 *
 * TODO cho Minh:
 *   1. Hoan thien cac method ben duoi
 *   2. Them logic tu dong dong tour khi het cho (Status = Full)
 *   3. Them logic tu dong dong tour khi qua ngay khoi hanh (Status = Closed)
 *   4. Tich hop vao TourServlet de hien thi lich khoi hanh tren trang chi tiet
 * ====================================================
 */

import com.dananghub.entity.TourSchedule;
import jakarta.persistence.*;
import java.util.List;

public class TourScheduleDAO {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("DaNangTravelHubPU");

    // TODO Minh: Lay tat ca lich khoi hanh cua 1 tour
    public List<TourSchedule> findByTourId(int tourId) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery(
                "SELECT s FROM TourSchedule s WHERE s.tour.tourId = :tid ORDER BY s.departureDate ASC",
                TourSchedule.class
            ).setParameter("tid", tourId).getResultList();
        } finally {
            em.close();
        }
    }

    // TODO Minh: Lay cac lich con cho trong (Status = Open)
    public List<TourSchedule> findAvailable(int tourId) {
        // TODO: SELECT ... WHERE tourId = ? AND status = 'Open' AND departureDate > NOW
        return null;
    }

    // TODO Minh: Them lich khoi hanh moi
    public void insert(TourSchedule schedule) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(schedule);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    // TODO Minh: Cap nhat so cho khi co dat tour
    public void updateSlots(int scheduleId, int bookedQuantity) {
        // TODO: UPDATE AvailableSlots = AvailableSlots - bookedQuantity
        // Neu AvailableSlots = 0 thi SET Status = 'Full'
    }

    // TODO Minh: Tu dong dong cac tour da qua ngay khoi hanh
    public void closeExpiredSchedules() {
        // TODO: UPDATE Status = 'Closed' WHERE DepartureDate < GETDATE() AND Status = 'Open'
    }
}
