package dao;

import java.util.List;
import model.Tour;

public interface ITourDAO {
    // Chỉ khai báo tên hàm
    List<Tour> getAllTours();
    Tour getTourById(int id);
    long countTours();
    
    void insertTour(Tour t);
    void updateTour(Tour t);
    void deleteTour(int id);
    
    List<Tour> searchTours(String keyword);
}