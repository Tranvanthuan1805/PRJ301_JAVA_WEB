package dao;

import model.Tour;
import java.sql.SQLException;
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
}