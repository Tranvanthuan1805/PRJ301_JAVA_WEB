package com.dananghub.entity;

/**
 * ====================================================
 * MODULE 3: TOUR DU LICH - Le Quang Minh
 * ====================================================
 * Bang: TourSchedules
 * Chuc nang: Quan ly lich khoi hanh cu the cho tung tour
 *   - Tu dong dong/mo tour dua tren so cho trong va thoi gian
 *   - Moi tour co nhieu lich khoi hanh khac nhau
 *
 * Lien ket: Tours (1:N) -> TourSchedules
 *
 * TODO cho Minh:
 *   1. Tao TourScheduleDAO.java (CRUD + findByTourId + findAvailable)
 *   2. Them logic tu dong cap nhat Status khi AvailableSlots = 0 -> "Full"
 *   3. Them logic tu dong dong tour khi DepartureDate < NOW -> "Closed"
 *   4. Tich hop vao TourServlet.java de hien thi lich khoi hanh
 *   5. Cap nhat detail.jsp de hien thi danh sach lich khoi hanh
 * ====================================================
 */

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "TourSchedules")
public class TourSchedule implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ScheduleId")
    private int scheduleId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "TourId", nullable = false)
    private Tour tour;

    @Column(name = "DepartureDate", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date departureDate;

    @Column(name = "ReturnDate")
    @Temporal(TemporalType.DATE)
    private Date returnDate;

    @Column(name = "AvailableSlots", nullable = false)
    private int availableSlots;

    @Column(name = "Status", length = 20)
    private String status = "Open"; // Open, Closed, Full, Cancelled

    public TourSchedule() {}

    // TODO Minh: Them helper method kiem tra con cho khong
    public boolean hasAvailableSlots() {
        return availableSlots > 0 && "Open".equals(status);
    }

    // TODO Minh: Them helper method kiem tra da qua ngay khoi hanh chua
    public boolean isDeparted() {
        return departureDate != null && departureDate.before(new Date());
    }

    // Getters and Setters
    public int getScheduleId() { return scheduleId; }
    public void setScheduleId(int scheduleId) { this.scheduleId = scheduleId; }

    public Tour getTour() { return tour; }
    public void setTour(Tour tour) { this.tour = tour; }

    public Date getDepartureDate() { return departureDate; }
    public void setDepartureDate(Date departureDate) { this.departureDate = departureDate; }

    public Date getReturnDate() { return returnDate; }
    public void setReturnDate(Date returnDate) { this.returnDate = returnDate; }

    public int getAvailableSlots() { return availableSlots; }
    public void setAvailableSlots(int availableSlots) { this.availableSlots = availableSlots; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
