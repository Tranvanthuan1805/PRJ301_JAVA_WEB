package com.dananghub.entity;

/**
 * ====================================================
 * MODULE 3: TOUR DU LICH - Le Quang Minh
 * ====================================================
 * Bang: TourPriceSeasons
 * Chuc nang: Dieu chinh gia tour linh hoat theo mua
 *   - Mua cao diem (Tet, He): PriceMultiplier = 1.5 (tang 50%)
 *   - Mua thap diem: PriceMultiplier = 0.8 (giam 20%)
 *   - Cung cap du lieu dau vao cho AI goi y tour
 *
 * Lien ket: Tours (1:N) -> TourPriceSeasons
 *
 * TODO cho Minh:
 *   1. Tao TourPriceSeasonDAO.java (CRUD + findByTourId + findActiveSeason)
 *   2. Them logic tinh gia theo mua: price * priceMultiplier
 *   3. Tich hop vao TourServlet.java: khi hien thi tour, tinh gia theo mua hien tai
 *   4. Cap nhat home.jsp va detail.jsp de hien thi gia mua
 *   5. Them trang admin quan ly mua gia
 * ====================================================
 */

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "TourPriceSeasons")
public class TourPriceSeason implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "SeasonId")
    private int seasonId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "TourId", nullable = false)
    private Tour tour;

    @Column(name = "SeasonName", nullable = false, length = 100)
    private String seasonName; // VD: "Tet Nguyen Dan", "He 2026", "Thap diem"

    @Column(name = "StartDate", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date startDate;

    @Column(name = "EndDate", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date endDate;

    @Column(name = "PriceMultiplier", nullable = false)
    private Double priceMultiplier; // VD: 1.5 (tang 50%), 0.8 (giam 20%)

    @Column(name = "IsActive")
    private boolean isActive = true;

    public TourPriceSeason() {
    }

    // TODO Minh: Tinh gia sau khi ap dung he so mua
    public double calculateSeasonalPrice(double basePrice) {
        return basePrice * priceMultiplier;
    }

    // TODO Minh: Kiem tra ngay hien tai co nam trong mua nay khong
    public boolean isCurrentlyActive() {
        Date now = new Date();
        return isActive && !now.before(startDate) && !now.after(endDate);
    }

    // Getters and Setters
    public int getSeasonId() {
        return seasonId;
    }

    public void setSeasonId(int seasonId) {
        this.seasonId = seasonId;
    }

    public Tour getTour() {
        return tour;
    }

    public void setTour(Tour tour) {
        this.tour = tour;
    }

    public String getSeasonName() {
        return seasonName;
    }

    public void setSeasonName(String seasonName) {
        this.seasonName = seasonName;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Double getPriceMultiplier() {
        return priceMultiplier;
    }

    public void setPriceMultiplier(Double priceMultiplier) {
        this.priceMultiplier = priceMultiplier;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
}
