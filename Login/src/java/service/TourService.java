package service;

import dao.TourDAO;
import model.Tour;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

public class TourService {
    private TourDAO tourDAO;
    
    public TourService(Connection connection) {
        this.tourDAO = new TourDAO();
    }
    
    public void createTour(Tour tour) throws SQLException {
        // TourDAO does not have addTour yet — stub
    }
    
    public Tour getTourById(int id) throws SQLException {
        return tourDAO.getTourById(id);
    }
    
    public List<Tour> getAllTours() throws SQLException {
        return tourDAO.getAllTours();
    }
    
    public void updateTour(Tour tour) throws SQLException {
        // TourDAO does not have updateTour yet — stub
    }
    
    public void deleteTour(int id) throws SQLException {
        // TourDAO does not have deleteTour yet — stub
    }
    
    public List<Tour> getAvailableTours() throws SQLException {
        return tourDAO.getAllActiveTours();
    }
    
    public List<Tour> searchToursByDestination(String destination) throws SQLException {
        // Filter from all tours
        List<Tour> all = tourDAO.getAllTours();
        return all.stream()
            .filter(t -> t.getStartLocation() != null && 
                         t.getStartLocation().toLowerCase().contains(destination.toLowerCase()))
            .collect(java.util.stream.Collectors.toList());
    }
    
    public boolean isTourAvailable(int tourId) throws SQLException {
        Tour tour = tourDAO.getTourById(tourId);
        return tour != null && tour.isActive();
    }
    
    public void incrementTourCapacity(int tourId) throws SQLException {
        // Stub — TourDAO does not have capacity update
    }
    
    public void decrementTourCapacity(int tourId) throws SQLException {
        // Stub — TourDAO does not have capacity update
    }
    
    public void logTourSearch(int customerId, String destination) throws SQLException {
        // Stub — removed InteractionHistoryDAO dependency for now
    }
    
    public void logTourView(int customerId, int tourId) throws SQLException {
        // Stub — removed InteractionHistoryDAO dependency for now
    }
    
    public double calculateSeasonalPrice(Tour tour) {
        LocalDate now = LocalDate.now();
        double basePrice = tour.getPrice();
        
        int month = now.getMonthValue();
        if ((month >= 6 && month <= 8) || month == 12 || month <= 2) {
            return basePrice * 1.3;
        }
        return basePrice * 0.9;
    }
    
    public List<Tour> getPopularTours(int limit) throws SQLException {
        List<Tour> all = tourDAO.getAllActiveTours();
        return all.subList(0, Math.min(limit, all.size()));
    }
    
    public void autoCloseTour(int tourId) throws SQLException {
        // Stub
    }
    
    public List<Tour> getFeaturedTours(int limit) throws SQLException {
        List<Tour> all = tourDAO.getAllActiveTours();
        return all.subList(0, Math.min(limit, all.size()));
    }
    
    public List<Tour> getToursByMonth(int year, int month) throws SQLException {
        return tourDAO.getAllActiveTours();
    }
    
    public List<Tour> searchTours(String destination, Integer month, String priceRange) throws SQLException {
        return searchToursByDestination(destination != null ? destination : "");
    }
    
    public List<Tour> getAllToursIncludingPast() throws SQLException {
        return tourDAO.getAllTours();
    }
}
