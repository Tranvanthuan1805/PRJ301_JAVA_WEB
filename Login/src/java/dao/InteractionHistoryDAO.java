package dao;

import model.InteractionHistory;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class InteractionHistoryDAO {
    private Connection connection;
    
    public InteractionHistoryDAO(Connection connection) {
        this.connection = connection;
    }
    
    public void addInteraction(InteractionHistory interaction) throws SQLException {
        String sql = "INSERT INTO InteractionHistory (customerId, action, createdAt) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, interaction.getCustomerId());
            stmt.setString(2, interaction.getAction());
            stmt.setTimestamp(3, Timestamp.valueOf(interaction.getCreatedAt()));
            
            stmt.executeUpdate();
            
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    interaction.setId(rs.getInt(1));
                }
            }
        }
    }
    
    public List<InteractionHistory> getInteractionsByCustomerId(int customerId) throws SQLException {
        List<InteractionHistory> interactions = new ArrayList<>();
        String sql = "SELECT * FROM InteractionHistory WHERE customerId = ? ORDER BY createdAt DESC";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    interactions.add(new InteractionHistory(
                        rs.getInt("id"),
                        rs.getInt("customerId"),
                        rs.getString("action"),
                        rs.getTimestamp("createdAt").toLocalDateTime()
                    ));
                }
            }
        }
        return interactions;
    }
    
    public List<InteractionHistory> getAllInteractions() throws SQLException {
        List<InteractionHistory> interactions = new ArrayList<>();
        String sql = "SELECT * FROM InteractionHistory ORDER BY createdAt DESC";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                interactions.add(new InteractionHistory(
                    rs.getInt("id"),
                    rs.getInt("customerId"),
                    rs.getString("action"),
                    rs.getTimestamp("createdAt").toLocalDateTime()
                ));
            }
        }
        return interactions;
    }
    
    public void deleteInteraction(int id) throws SQLException {
        String sql = "DELETE FROM InteractionHistory WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
    
    public List<InteractionHistory> getRecentInteractions(int customerId, int limit) throws SQLException {
        List<InteractionHistory> interactions = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM InteractionHistory WHERE customerId = ? ORDER BY createdAt DESC";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    interactions.add(new InteractionHistory(
                        rs.getInt("id"),
                        rs.getInt("customerId"),
                        rs.getString("action"),
                        rs.getTimestamp("createdAt").toLocalDateTime()
                    ));
                }
            }
        }
        return interactions;
    }
}