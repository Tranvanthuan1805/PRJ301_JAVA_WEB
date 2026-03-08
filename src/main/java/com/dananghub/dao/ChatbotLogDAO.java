package com.dananghub.dao;

import com.dananghub.entity.ChatbotLog;
import com.dananghub.util.JPAUtil;
import jakarta.persistence.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * DAO cho ChatbotLog - Thống kê câu hỏi chatbot & phân tích hành vi
 */
public class ChatbotLogDAO {

    private static final Logger logger = Logger.getLogger(ChatbotLogDAO.class.getName());

    // Lưu log câu hỏi
    public boolean save(ChatbotLog log) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(log);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            logger.log(Level.SEVERE, "Error saving chatbot log", e);
            return false;
        } finally {
            em.close();
        }
    }

    // Lấy lịch sử chat theo user
    public List<ChatbotLog> findByUserId(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT c FROM ChatbotLog c WHERE c.userId = :uid ORDER BY c.createdAt DESC",
                ChatbotLog.class
            ).setParameter("uid", userId).getResultList();
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error finding logs by user", e);
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    // Thống kê số câu hỏi theo ngày (30 ngày gần nhất)
    public List<Object[]> getQuestionCountByDay(int days) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT FUNCTION('DATE', c.createdAt), COUNT(c) FROM ChatbotLog c " +
                "WHERE c.createdAt >= FUNCTION('DATEADD', 'DAY', -" + days + ", CURRENT_TIMESTAMP) " +
                "GROUP BY FUNCTION('DATE', c.createdAt) ORDER BY FUNCTION('DATE', c.createdAt)",
                Object[].class
            ).getResultList();
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error getting question count by day", e);
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    // Thống kê câu hỏi theo category
    public List<Object[]> getQuestionCountByCategory() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT c.category, COUNT(c) FROM ChatbotLog c WHERE c.category IS NOT NULL GROUP BY c.category ORDER BY COUNT(c) DESC",
                Object[].class
            ).getResultList();
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error getting question count by category", e);
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    // Thống kê sentiment
    public List<Object[]> getSentimentStats() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT c.sentiment, COUNT(c) FROM ChatbotLog c WHERE c.sentiment IS NOT NULL GROUP BY c.sentiment",
                Object[].class
            ).getResultList();
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error getting sentiment stats", e);
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    // Tổng số câu hỏi
    public long countAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(c) FROM ChatbotLog c", Long.class).getSingleResult();
        } catch (Exception e) { return 0; }
        finally { em.close(); }
    }

    // Thời gian phản hồi trung bình
    public double getAvgResponseTime() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Double avg = em.createQuery(
                "SELECT AVG(c.responseTimeMs) FROM ChatbotLog c WHERE c.responseTimeMs > 0",
                Double.class
            ).getSingleResult();
            return avg != null ? avg : 0;
        } catch (Exception e) { return 0; }
        finally { em.close(); }
    }

    // Câu hỏi gần đây nhất
    public List<ChatbotLog> getRecentQuestions(int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT c FROM ChatbotLog c ORDER BY c.createdAt DESC", ChatbotLog.class
            ).setMaxResults(limit).getResultList();
        } catch (Exception e) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    // Top câu hỏi phổ biến (keyword extraction đơn giản)
    public List<Object[]> getTopQuestions(int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT c.question, COUNT(c) FROM ChatbotLog c GROUP BY c.question ORDER BY COUNT(c) DESC",
                Object[].class
            ).setMaxResults(limit).getResultList();
        } catch (Exception e) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
}
