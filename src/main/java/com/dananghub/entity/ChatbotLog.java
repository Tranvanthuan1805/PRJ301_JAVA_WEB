package com.dananghub.entity;

import jakarta.persistence.*;
import java.util.Date;

/**
 * Entity cho bảng ChatbotLogs - Lưu log các câu hỏi chatbot AI để thống kê & phân tích
 */
@Entity
@Table(name = "chatbot_logs")
public class ChatbotLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "log_id")
    private int logId;

    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "session_id", length = 100)
    private String sessionId;

    @Column(name = "question", length = 2000, nullable = false)
    private String question;

    @Column(name = "answer", length = 5000)
    private String answer;

    @Column(name = "category", length = 50)
    private String category; // BOOKING, TOUR_INFO, PRICE, GENERAL, COMPLAINT

    @Column(name = "sentiment", length = 20)
    private String sentiment; // POSITIVE, NEUTRAL, NEGATIVE

    @Column(name = "response_time_ms")
    private long responseTimeMs;

    @Column(name = "created_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    public ChatbotLog() {
        this.createdAt = new Date();
    }

    public ChatbotLog(Integer userId, String sessionId, String question) {
        this.userId = userId;
        this.sessionId = sessionId;
        this.question = question;
        this.createdAt = new Date();
    }

    // Getters & Setters
    public int getLogId() { return logId; }
    public void setLogId(int logId) { this.logId = logId; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public String getSessionId() { return sessionId; }
    public void setSessionId(String sessionId) { this.sessionId = sessionId; }

    public String getQuestion() { return question; }
    public void setQuestion(String question) { this.question = question; }

    public String getAnswer() { return answer; }
    public void setAnswer(String answer) { this.answer = answer; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getSentiment() { return sentiment; }
    public void setSentiment(String sentiment) { this.sentiment = sentiment; }

    public long getResponseTimeMs() { return responseTimeMs; }
    public void setResponseTimeMs(long responseTimeMs) { this.responseTimeMs = responseTimeMs; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
