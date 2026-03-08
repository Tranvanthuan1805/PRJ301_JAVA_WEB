package com.dananghub.controller;

import com.dananghub.dao.ReviewDAO;
import com.dananghub.dao.TourDAO;
import com.dananghub.entity.Review;
import com.dananghub.entity.Tour;
import com.dananghub.entity.User;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/review")
public class ReviewServlet extends HttpServlet {

    private final ReviewDAO reviewDAO = new ReviewDAO();
    private final TourDAO tourDAO = new TourDAO();

    /**
     * GET: Lấy danh sách đánh giá (JSON) cho AJAX
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        JsonObject json = new JsonObject();

        String tourIdStr = request.getParameter("tourId");
        if (tourIdStr == null) {
            json.addProperty("success", false);
            json.addProperty("message", "Thiếu tourId");
            out.print(json.toString());
            return;
        }

        int tourId = Integer.parseInt(tourIdStr);
        List<Review> reviews = reviewDAO.findByTourId(tourId);
        double avgRating = reviewDAO.getAverageRating(tourId);
        long totalReviews = reviewDAO.getReviewCount(tourId);
        int[] distribution = reviewDAO.getRatingDistribution(tourId);

        json.addProperty("success", true);
        json.addProperty("avgRating", avgRating);
        json.addProperty("totalReviews", totalReviews);

        JsonArray distArray = new JsonArray();
        for (int d : distribution) distArray.add(d);
        json.add("distribution", distArray);

        JsonArray reviewsArray = new JsonArray();
        for (Review r : reviews) {
            JsonObject rj = new JsonObject();
            rj.addProperty("reviewId", r.getReviewId());
            rj.addProperty("rating", r.getRating());
            rj.addProperty("comment", r.getComment());
            rj.addProperty("timeAgo", r.getTimeAgo());
            rj.addProperty("userName", r.getUser().getFullName() != null
                    ? r.getUser().getFullName() : r.getUser().getUsername());
            rj.addProperty("userAvatar", r.getUser().getAvatarUrl());
            reviewsArray.add(rj);
        }
        json.add("reviews", reviewsArray);

        // Kiểm tra user hiện tại đã đánh giá chưa
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            Review existingReview = reviewDAO.findByTourAndUser(tourId, user.getUserId());
            json.addProperty("userHasReviewed", existingReview != null);
            if (existingReview != null) {
                json.addProperty("userRating", existingReview.getRating());
                json.addProperty("userComment", existingReview.getComment());
            }
        }

        out.print(json.toString());
    }

    /**
     * POST: Gửi hoặc cập nhật đánh giá
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        JsonObject json = new JsonObject();

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            json.addProperty("success", false);
            json.addProperty("message", "Vui lòng đăng nhập để đánh giá");
            out.print(json.toString());
            return;
        }

        String tourIdStr = request.getParameter("tourId");
        String ratingStr = request.getParameter("rating");
        String comment = request.getParameter("comment");

        if (tourIdStr == null || ratingStr == null) {
            json.addProperty("success", false);
            json.addProperty("message", "Thiếu thông tin đánh giá");
            out.print(json.toString());
            return;
        }

        int tourId = Integer.parseInt(tourIdStr);
        int rating = Integer.parseInt(ratingStr);

        if (rating < 1 || rating > 5) {
            json.addProperty("success", false);
            json.addProperty("message", "Rating phải từ 1 đến 5");
            out.print(json.toString());
            return;
        }

        Tour tour = tourDAO.findById(tourId);
        if (tour == null) {
            json.addProperty("success", false);
            json.addProperty("message", "Tour không tồn tại");
            out.print(json.toString());
            return;
        }

        // Kiểm tra đã đánh giá chưa
        Review existing = reviewDAO.findByTourAndUser(tourId, user.getUserId());

        if (existing != null) {
            // Cập nhật đánh giá
            existing.setRating(rating);
            existing.setComment(comment);
            boolean updated = reviewDAO.update(existing);
            json.addProperty("success", updated);
            json.addProperty("message", updated
                    ? "Đã cập nhật đánh giá của bạn!"
                    : "Lỗi khi cập nhật đánh giá");
        } else {
            // Tạo đánh giá mới
            Review review = new Review(tour, user, rating, comment);
            boolean created = reviewDAO.create(review);
            json.addProperty("success", created);
            json.addProperty("message", created
                    ? "Cảm ơn bạn đã đánh giá!"
                    : "Lỗi khi gửi đánh giá");
        }

        // Trả về rating mới
        json.addProperty("newAvgRating", reviewDAO.getAverageRating(tourId));
        json.addProperty("newTotalReviews", reviewDAO.getReviewCount(tourId));

        out.print(json.toString());
    }
}
