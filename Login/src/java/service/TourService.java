package service;

import dao.TourDAO;
import model.Tour;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public class TourService {
    private TourDAO tourDAO;
    
    public TourService(Connection connection) {
        this.tourDAO = new TourDAO(connection);
    }
    
    public void createTour(Tour tour) throws SQLException {
        tourDAO.addTour(tour);
    }
    
    public Tour getTourById(int id) throws SQLException {
        return tourDAO.getTourById(id);
    }
    
    public List<Tour> getAllTours() throws SQLException {
        return tourDAO.getAllTours();
    }
    
    public void updateTour(Tour tour) throws SQLException {
        tourDAO.updateTour(tour);
    }
    
    public void deleteTour(int id) throws SQLException {
        tourDAO.deleteTour(id);
    }
    
    public List<Tour> getAvailableTours() throws SQLException {
        return tourDAO.getAvailableTours();
    }
    
    public List<Tour> searchToursByDestination(String destination) throws SQLException {
        return tourDAO.getToursByDestination(destination);
    }
    
    public boolean isTourAvailable(int tourId) throws SQLException {
        Tour tour = tourDAO.getTourById(tourId);
        return tour != null && tour.isAvailable() && tour.getStartDate().isAfter(LocalDate.now());
    }
    
    public void incrementTourCapacity(int tourId) throws SQLException {
        Tour tour = tourDAO.getTourById(tourId);
        if (tour != null && tour.getCurrentCapacity() < tour.getMaxCapacity()) {
            tourDAO.updateTourCapacity(tourId, tour.getCurrentCapacity() + 1);
        }
    }
    
    public void decrementTourCapacity(int tourId) throws SQLException {
        Tour tour = tourDAO.getTourById(tourId);
        if (tour != null && tour.getCurrentCapacity() > 0) {
            tourDAO.updateTourCapacity(tourId, tour.getCurrentCapacity() - 1);
        }
    }
    
    public double calculateSeasonalPrice(Tour tour) {
        LocalDate now = LocalDate.now();
        double basePrice = tour.getPrice();
        
        // Mùa cao điểm (tháng 6-8, 12-2)
        int month = now.getMonthValue();
        if ((month >= 6 && month <= 8) || month == 12 || month <= 2) {
            return basePrice * 1.3; // Tăng 30%
        }
        
        // Mùa thấp điểm (tháng 3-5, 9-11)
        return basePrice * 0.9; // Giảm 10%
    }
    
    public List<Tour> getPopularTours(int limit) throws SQLException {
        return tourDAO.getPopularTours(limit);
    }
    
    public void autoCloseTour(int tourId) throws SQLException {
        Tour tour = tourDAO.getTourById(tourId);
        if (tour != null && (tour.getCurrentCapacity() >= tour.getMaxCapacity() || 
            tour.getStartDate().isBefore(LocalDate.now()))) {
            // Logic để đóng tour (có thể thêm trường status vào Tour model)
            // Hiện tại chỉ cập nhật capacity về max để không cho đặt thêm
            tourDAO.updateTourCapacity(tourId, tour.getMaxCapacity());
        }
    }
    
    public List<Tour> getFeaturedTours(int limit) throws SQLException {
        // Lấy tours nổi bật (giá cao, booking nhiều, còn chỗ)
        return tourDAO.getFeaturedTours(limit);
    }
    
    public List<Tour> getToursByMonth(int year, int month) throws SQLException {
        // Lấy tours theo tháng và năm
        return tourDAO.getToursByMonth(year, month);
    }
    
    public List<Tour> searchTours(String destination, Integer month, String priceRange) throws SQLException {
        // Tìm kiếm tours với nhiều tiêu chí
        return tourDAO.searchTours(destination, month, priceRange);
    }
    
    public List<Tour> getAllToursIncludingPast() throws SQLException {
        // Lấy TẤT CẢ tours kể cả cũ (cho analytics/history)
        return tourDAO.getAllToursIncludingPast();
    }
}
