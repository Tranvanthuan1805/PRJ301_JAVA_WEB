package dao;

import model.Tour;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

public interface ITourDAO {
    void addTour(Tour tour) throws SQLException;
    Tour getTourById(int id) throws SQLException;
    List<Tour> getAllTours() throws SQLException;
    void updateTour(Tour tour) throws SQLException;
    void deleteTour(int id) throws SQLException;
    List<Tour> getAvailableTours() throws SQLException;
    List<Tour> getToursByDestination(String destination) throws SQLException;
    void updateTourCapacity(int tourId, int newCapacity) throws SQLException;
    List<Tour> getPopularTours(int limit) throws SQLException;
    boolean checkAvailability(int tourId, LocalDate date, int quantity) throws SQLException;
    double getOccupancyRate(int tourId) throws SQLException;
    boolean checkAndUpdateStatus(int tourId) throws SQLException;
    List<Tour> getFeaturedTours(int limit) throws SQLException;
    List<Tour> getToursByMonth(int year, int month) throws SQLException;
    List<Tour> searchTours(String destination, Integer month, String priceRange) throws SQLException;
    List<Tour> getAllToursIncludingPast() throws SQLException; // Lấy tất cả tours kể cả cũ cho analytics
}