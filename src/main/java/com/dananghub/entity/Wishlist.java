package com.dananghub.entity;

import jakarta.persistence.*;
import java.util.Date;

/**
 * Entity cho bảng Wishlists - Lưu danh sách tour yêu thích của khách hàng
 */
@Entity
@Table(name = "wishlists")
public class Wishlist {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "wishlist_id")
    private int wishlistId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "tour_id", nullable = false)
    private Tour tour;

    @Column(name = "added_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedAt;

    @Column(name = "note", length = 500)
    private String note;

    public Wishlist() {
        this.addedAt = new Date();
    }

    public Wishlist(User user, Tour tour) {
        this.user = user;
        this.tour = tour;
        this.addedAt = new Date();
    }

    // Getters & Setters
    public int getWishlistId() { return wishlistId; }
    public void setWishlistId(int wishlistId) { this.wishlistId = wishlistId; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Tour getTour() { return tour; }
    public void setTour(Tour tour) { this.tour = tour; }

    public Date getAddedAt() { return addedAt; }
    public void setAddedAt(Date addedAt) { this.addedAt = addedAt; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
}
