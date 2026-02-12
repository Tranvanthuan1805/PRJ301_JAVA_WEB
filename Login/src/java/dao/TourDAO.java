package dao;

import model.Tour;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class TourDAO implements ITourDAO {
    private Connection connection;
    
    public TourDAO(Connection connection) {
        this.connection = connection;
    }
    
    // Helper method to extract Tour from ResultSet with proper Unicode support
    private Tour extractTourFromResultSet(ResultSet rs) throws SQLException {
        return new Tour(
            rs.getInt("id"),
            rs.getNString("name"),           // Use getNString for Unicode
            rs.getNString("destination"),    // Use getNString for Unicode
            rs.getDate("startDate").toLocalDate(),
            rs.getDate("endDate").toLocalDate(),
            rs.getDouble("price"),
            rs.getInt("maxCapacity"),
            rs.getInt("currentCapacity"),
            rs.getNString("description")     // Use getNString for Unicode
        );
    }
    
    @Override
    public void addTour(Tour tour) throws SQLException {
        String sql = "INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, tour.getName());
            stmt.setString(2, tour.getDestination());
            stmt.setDate(3, Date.valueOf(tour.getStartDate()));
            stmt.setDate(4, Date.valueOf(tour.getEndDate()));
            stmt.setDouble(5, tour.getPrice());
            stmt.setInt(6, tour.getMaxCapacity());
            stmt.setInt(7, tour.getCurrentCapacity());
            stmt.setString(8, tour.getDescription());
            
            stmt.executeUpdate();
            
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    tour.setId(rs.getInt(1));
                }
            }
        }
    }
    
    @Override
    public Tour getTourById(int id) throws SQLException {
        String sql = "SELECT * FROM Tours WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractTourFromResultSet(rs);
                }
            }
        }
        return null;
    }
    
    @Override
    public List<Tour> getAllTours() throws SQLException {
        List<Tour> tours = new ArrayList<>();
        // Chỉ lấy tours có startDate >= ngày hiện tại (tours mới)
        String sql = "SELECT * FROM Tours WHERE startDate >= CAST(GETDATE() AS DATE) ORDER BY startDate";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                tours.add(extractTourFromResultSet(rs));
            }
        }
        return tours;
    }
    
    @Override
    public void updateTour(Tour tour) throws SQLException {
        String sql = "UPDATE Tours SET name = ?, destination = ?, startDate = ?, endDate = ?, price = ?, maxCapacity = ?, currentCapacity = ?, description = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, tour.getName());
            stmt.setString(2, tour.getDestination());
            stmt.setDate(3, Date.valueOf(tour.getStartDate()));
            stmt.setDate(4, Date.valueOf(tour.getEndDate()));
            stmt.setDouble(5, tour.getPrice());
            stmt.setInt(6, tour.getMaxCapacity());
            stmt.setInt(7, tour.getCurrentCapacity());
            stmt.setString(8, tour.getDescription());
            stmt.setInt(9, tour.getId());
            
            stmt.executeUpdate();
        }
    }

    
    @Override
    public void deleteTour(int id) throws SQLException {
        String sql = "DELETE FROM Tours WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
    
    @Override
    public List<Tour> getAvailableTours() throws SQLException {
        List<Tour> tours = new ArrayList<>();
        String sql = "SELECT * FROM Tours WHERE currentCapacity < maxCapacity AND startDate > GETDATE() ORDER BY startDate";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                tours.add(extractTourFromResultSet(rs));
            }
        }
        return tours;
    }
    
    @Override
    public List<Tour> getToursByDestination(String destination) throws SQLException {
        List<Tour> tours = new ArrayList<>();
        String sql = "SELECT * FROM Tours WHERE destination LIKE ? ORDER BY startDate";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setNString(1, "%" + destination + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    tours.add(extractTourFromResultSet(rs));
                }
            }
        }
        return tours;
    }
    
    @Override
    public void updateTourCapacity(int tourId, int newCapacity) throws SQLException {
        String sql = "UPDATE Tours SET currentCapacity = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, newCapacity);
            stmt.setInt(2, tourId);
            stmt.executeUpdate();
        }
    }

    
    @Override
    public List<Tour> getPopularTours(int limit) throws SQLException {
        String sql = "SELECT TOP " + limit + " t.*, COUNT(b.id) as booking_count " +
                    "FROM Tours t " +
                    "LEFT JOIN Bookings b ON t.id = b.tourId " +
                    "WHERE t.currentCapacity < t.maxCapacity " +
                    "GROUP BY t.id, t.name, t.destination, t.startDate, t.endDate, t.price, t.maxCapacity, t.currentCapacity, t.description, t.createdAt, t.updatedAt " +
                    "ORDER BY booking_count DESC, t.currentCapacity DESC";
        
        List<Tour> tours = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                tours.add(extractTourFromResultSet(rs));
            }
        }
        return tours;
    }
    
    @Override
    public boolean checkAvailability(int tourId, LocalDate date, int quantity) throws SQLException {
        String sql = "SELECT maxCapacity, currentCapacity, startDate FROM Tours WHERE id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, tourId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int maxCapacity = rs.getInt("maxCapacity");
                    int currentCapacity = rs.getInt("currentCapacity");
                    LocalDate startDate = rs.getDate("startDate").toLocalDate();
                    
                    int availableSlots = maxCapacity - currentCapacity;
                    boolean hasEnoughSlots = availableSlots >= quantity;
                    boolean notExpired = !date.isBefore(LocalDate.now()) && !startDate.isBefore(date);
                    
                    return hasEnoughSlots && notExpired;
                }
            }
        }
        return false;
    }
    
    @Override
    public double getOccupancyRate(int tourId) throws SQLException {
        String sql = "SELECT maxCapacity, currentCapacity FROM Tours WHERE id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, tourId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int maxCapacity = rs.getInt("maxCapacity");
                    int currentCapacity = rs.getInt("currentCapacity");
                    
                    if (maxCapacity == 0) return 0;
                    return (double) currentCapacity / maxCapacity * 100;
                }
            }
        }
        return 0;
    }

    
    @Override
    public boolean checkAndUpdateStatus(int tourId) throws SQLException {
        Tour tour = getTourById(tourId);
        if (tour == null) return false;
        
        LocalDate today = LocalDate.now();
        boolean hasSlots = tour.getCurrentCapacity() < tour.getMaxCapacity();
        boolean notExpired = tour.getStartDate().isAfter(today) || tour.getStartDate().isEqual(today);
        
        return hasSlots && notExpired;
    }
    
    @Override
    public List<Tour> getFeaturedTours(int limit) throws SQLException {
        // Lấy tất cả tours (kể cả cũ) để hiển thị
        String sql = "SELECT TOP " + limit + " * FROM Tours " +
                    "ORDER BY price DESC, currentCapacity DESC";
        
        List<Tour> tours = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                tours.add(extractTourFromResultSet(rs));
            }
        }
        return tours;
    }
    
    @Override
    public List<Tour> getToursByMonth(int year, int month) throws SQLException {
        String sql = "SELECT * FROM Tours " +
                    "WHERE YEAR(startDate) = ? AND MONTH(startDate) = ? " +
                    "ORDER BY startDate";
        
        List<Tour> tours = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, year);
            stmt.setInt(2, month);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    tours.add(extractTourFromResultSet(rs));
                }
            }
        }
        return tours;
    }
    
    @Override
    public List<Tour> searchTours(String destination, Integer month, String priceRange) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT * FROM Tours WHERE startDate >= CAST(GETDATE() AS DATE)");
        List<Object> params = new ArrayList<>();
        
        // Filter by destination
        if (destination != null && !destination.trim().isEmpty()) {
            sql.append(" AND destination LIKE ?");
            params.add("%" + destination + "%");
        }
        
        // Filter by month
        if (month != null && month > 0 && month <= 12) {
            sql.append(" AND MONTH(startDate) = ?");
            params.add(month);
        }
        
        // Filter by price range
        if (priceRange != null && !priceRange.trim().isEmpty()) {
            switch (priceRange) {
                case "under5":
                    sql.append(" AND price < 5000000");
                    break;
                case "5to10":
                    sql.append(" AND price BETWEEN 5000000 AND 10000000");
                    break;
                case "10to20":
                    sql.append(" AND price BETWEEN 10000000 AND 20000000");
                    break;
                case "over20":
                    sql.append(" AND price > 20000000");
                    break;
            }
        }
        
        sql.append(" ORDER BY startDate");
        
        List<Tour> tours = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                if (param instanceof String) {
                    stmt.setString(i + 1, (String) param);
                } else if (param instanceof Integer) {
                    stmt.setInt(i + 1, (Integer) param);
                }
            }
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    tours.add(extractTourFromResultSet(rs));
                }
            }
        }
        return tours;
    }
    
    @Override
    public List<Tour> getAllToursIncludingPast() throws SQLException {
        List<Tour> tours = new ArrayList<>();
        // Lấy TẤT CẢ tours kể cả cũ (cho analytics/history)
        String sql = "SELECT * FROM Tours ORDER BY startDate DESC";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                tours.add(extractTourFromResultSet(rs));
            }
        }
        return tours;
    }

}
