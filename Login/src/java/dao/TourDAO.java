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
                    return new Tour(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("destination"),
                        rs.getDate("startDate").toLocalDate(),
                        rs.getDate("endDate").toLocalDate(),
                        rs.getDouble("price"),
                        rs.getInt("maxCapacity"),
                        rs.getInt("currentCapacity"),
                        rs.getString("description")
                    );
                }
            }
        }
        return null;
    }
    
    @Override
    public List<Tour> getAllTours() throws SQLException {
        List<Tour> tours = new ArrayList<>();
        String sql = "SELECT * FROM Tours ORDER BY startDate";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                tours.add(new Tour(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("destination"),
                    rs.getDate("startDate").toLocalDate(),
                    rs.getDate("endDate").toLocalDate(),
                    rs.getDouble("price"),
                    rs.getInt("maxCapacity"),
                    rs.getInt("currentCapacity"),
                    rs.getString("description")
                ));
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
                tours.add(new Tour(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("destination"),
                    rs.getDate("startDate").toLocalDate(),
                    rs.getDate("endDate").toLocalDate(),
                    rs.getDouble("price"),
                    rs.getInt("maxCapacity"),
                    rs.getInt("currentCapacity"),
                    rs.getString("description")
                ));
            }
        }
        return tours;
    }
    
    @Override
    public List<Tour> getToursByDestination(String destination) throws SQLException {
        List<Tour> tours = new ArrayList<>();
        String sql = "SELECT * FROM Tours WHERE destination LIKE ? ORDER BY startDate";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "%" + destination + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    tours.add(new Tour(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("destination"),
                        rs.getDate("startDate").toLocalDate(),
                        rs.getDate("endDate").toLocalDate(),
                        rs.getDouble("price"),
                        rs.getInt("maxCapacity"),
                        rs.getInt("currentCapacity"),
                        rs.getString("description")
                    ));
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
                tours.add(new Tour(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("destination"),
                    rs.getDate("startDate").toLocalDate(),
                    rs.getDate("endDate").toLocalDate(),
                    rs.getDouble("price"),
                    rs.getInt("maxCapacity"),
                    rs.getInt("currentCapacity"),
                    rs.getString("description")
                ));
            }
        }
        return tours;
    }
    
    /**
     * Kiểm tra availability của tour - CỰC KỲ QUAN TRỌNG
     * Logic: (MaxPeople - Số khách đã đặt) >= quantity
     * @param tourId ID của tour
     * @param date Ngày khởi hành
     * @param quantity Số lượng người muốn đặt
     * @return true nếu còn đủ chỗ, false nếu không
     */
    public boolean checkAvailability(int tourId, LocalDate date, int quantity) throws SQLException {
        String sql = "SELECT maxCapacity, currentCapacity, startDate FROM Tours WHERE id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, tourId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int maxCapacity = rs.getInt("maxCapacity");
                    int currentCapacity = rs.getInt("currentCapacity");
                    LocalDate startDate = rs.getDate("startDate").toLocalDate();
                    
                    // Kiểm tra còn đủ slot không
                    int availableSlots = maxCapacity - currentCapacity;
                    boolean hasEnoughSlots = availableSlots >= quantity;
                    
                    // Kiểm tra ngày chưa quá hạn
                    boolean notExpired = !date.isBefore(LocalDate.now()) && !startDate.isBefore(date);
                    
                    return hasEnoughSlots && notExpired;
                }
            }
        }
        return false;
    }
    
    /**
     * Lấy occupancy rate (tỷ lệ lấp đầy) của tour
     * @param tourId ID của tour
     * @return Tỷ lệ % (0-100)
     */
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
    
    /**
     * Kiểm tra và cập nhật trạng thái Active/Paused của tour
     * @param tourId ID của tour
     * @return true nếu Active, false nếu Paused
     */
    public boolean checkAndUpdateStatus(int tourId) throws SQLException {
        Tour tour = getTourById(tourId);
        if (tour == null) return false;
        
        LocalDate today = LocalDate.now();
        boolean hasSlots = tour.getCurrentCapacity() < tour.getMaxCapacity();
        boolean notExpired = tour.getStartDate().isAfter(today) || tour.getStartDate().isEqual(today);
        
        return hasSlots && notExpired;
    }
}