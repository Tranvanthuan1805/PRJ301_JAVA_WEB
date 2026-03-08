package com.dananghub.entity;

import jakarta.persistence.*;
import java.util.Date;

/**
 * Entity cho bảng TourFeedbacks - Feedback chi tiết sau khi khách hàng hoàn thành tour
 */
@Entity
@Table(name = "tour_feedbacks")
public class TourFeedback {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "feedback_id")
    private int feedbackId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "order_id", nullable = false)
    private Order order;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "tour_id", nullable = false)
    private Tour tour;

    // Rating theo từng tiêu chí (1-5)
    @Column(name = "overall_rating")
    private int overallRating;

    @Column(name = "guide_rating")
    private int guideRating;

    @Column(name = "transport_rating")
    private int transportRating;

    @Column(name = "food_rating")
    private int foodRating;

    @Column(name = "value_rating")
    private int valueRating;

    @Column(name = "comment", length = 2000)
    private String comment;

    @Column(name = "would_recommend")
    private boolean wouldRecommend;

    @Column(name = "improvement_suggestion", length = 1000)
    private String improvementSuggestion;

    @Column(name = "created_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "status", length = 20)
    private String status; // PENDING, APPROVED, HIDDEN

    public TourFeedback() {
        this.createdAt = new Date();
        this.status = "PENDING";
    }

    // Getters & Setters
    public int getFeedbackId() { return feedbackId; }
    public void setFeedbackId(int feedbackId) { this.feedbackId = feedbackId; }

    public Order getOrder() { return order; }
    public void setOrder(Order order) { this.order = order; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Tour getTour() { return tour; }
    public void setTour(Tour tour) { this.tour = tour; }

    public int getOverallRating() { return overallRating; }
    public void setOverallRating(int overallRating) { this.overallRating = overallRating; }

    public int getGuideRating() { return guideRating; }
    public void setGuideRating(int guideRating) { this.guideRating = guideRating; }

    public int getTransportRating() { return transportRating; }
    public void setTransportRating(int transportRating) { this.transportRating = transportRating; }

    public int getFoodRating() { return foodRating; }
    public void setFoodRating(int foodRating) { this.foodRating = foodRating; }

    public int getValueRating() { return valueRating; }
    public void setValueRating(int valueRating) { this.valueRating = valueRating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public boolean isWouldRecommend() { return wouldRecommend; }
    public void setWouldRecommend(boolean wouldRecommend) { this.wouldRecommend = wouldRecommend; }

    public String getImprovementSuggestion() { return improvementSuggestion; }
    public void setImprovementSuggestion(String improvementSuggestion) { this.improvementSuggestion = improvementSuggestion; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    // Helper: Average of all sub-ratings
    public double getAverageSubRating() {
        int count = 0;
        int total = 0;
        if (guideRating > 0) { total += guideRating; count++; }
        if (transportRating > 0) { total += transportRating; count++; }
        if (foodRating > 0) { total += foodRating; count++; }
        if (valueRating > 0) { total += valueRating; count++; }
        return count > 0 ? (double) total / count : overallRating;
    }
}
