package com.dananghub.service;

import com.dananghub.dao.TourDAO;
import com.dananghub.dao.ActivityDAO;
import com.dananghub.entity.Tour;
import com.dananghub.entity.InteractionHistory;
import java.time.LocalDate;
import java.util.List;

public class TourService {

    private TourDAO tourDAO;
    private ActivityDAO activityDAO;

    public TourService() {
        this.tourDAO = new TourDAO();
        this.activityDAO = new ActivityDAO();
    }

    public Tour getTourById(int id) {
        return tourDAO.findById(id);
    }

    public List<Tour> getAllTours() {
        return tourDAO.findAll();
    }

    public List<Tour> getAllToursIncludeInactive() {
        return tourDAO.findAllIncludeInactive();
    }

    public boolean createTour(Tour tour) {
        return tourDAO.create(tour);
    }

    public boolean updateTour(Tour tour) {
        return tourDAO.update(tour);
    }

    public boolean deleteTour(int id) {
        return tourDAO.delete(id);
    }

    public List<Tour> searchTours(String keyword) {
        return tourDAO.search(keyword);
    }

    public List<Tour> getToursByCategory(int categoryId) {
        return tourDAO.findByCategory(categoryId);
    }

    public List<Tour> getToursByProvider(int providerId) {
        return tourDAO.findByProvider(providerId);
    }

    public void logTourSearch(int customerId, String keyword) {
        InteractionHistory ih = new InteractionHistory(customerId, "TOUR_SEARCH: " + keyword);
        activityDAO.logInteraction(ih);
    }

    public void logTourView(int customerId, int tourId) {
        InteractionHistory ih = new InteractionHistory(customerId, "TOUR_VIEWED: " + tourId);
        activityDAO.logInteraction(ih);
    }

    public double calculateSeasonalPrice(Tour tour) {
        double basePrice = tour.getPrice();
        int month = LocalDate.now().getMonthValue();
        if ((month >= 6 && month <= 8) || month == 12 || month <= 2) {
            return basePrice * 1.3;
        }
        return basePrice * 0.9;
    }
}
