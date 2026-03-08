package com.dananghub.controller;

import com.dananghub.dao.FeedbackDAO;
import com.dananghub.dao.OrderDAO;
import com.dananghub.dao.TourDAO;
import com.dananghub.entity.*;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/feedback")
public class FeedbackServlet extends HttpServlet {

    private final FeedbackDAO feedbackDAO = new FeedbackDAO();
    private final OrderDAO orderDAO = new OrderDAO();
    private final TourDAO tourDAO = new TourDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");

        if ("form".equals(action)) {
            // Show feedback form for a specific order
            String orderId = request.getParameter("orderId");
            if (orderId != null) {
                // Check if already gave feedback
                if (feedbackDAO.hasUserFeedback(user.getUserId(), Integer.parseInt(orderId))) {
                    request.setAttribute("error", "Bạn đã gửi feedback cho đơn hàng này rồi");
                }
                Order order = orderDAO.findById(Integer.parseInt(orderId));
                request.setAttribute("order", order);
            }
            request.getRequestDispatcher("/views/feedback/feedback-form.jsp").forward(request, response);

        } else if ("admin".equals(action)) {
            // Admin view: all feedbacks
            if (!"ADMIN".equalsIgnoreCase(user.getRoleName())) {
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }
            List<TourFeedback> feedbacks = feedbackDAO.findAll();
            long pending = feedbackDAO.countByStatus("PENDING");
            long approved = feedbackDAO.countByStatus("APPROVED");
            request.setAttribute("feedbacks", feedbacks);
            request.setAttribute("pendingCount", pending);
            request.setAttribute("approvedCount", approved);
            request.getRequestDispatcher("/views/feedback/feedback-admin.jsp").forward(request, response);

        } else if ("tour".equals(action)) {
            // View feedbacks for a specific tour
            String tourId = request.getParameter("tourId");
            if (tourId != null) {
                List<TourFeedback> feedbacks = feedbackDAO.findByTourId(Integer.parseInt(tourId));
                double avgRating = feedbackDAO.getAvgRatingByTour(Integer.parseInt(tourId));
                request.setAttribute("feedbacks", feedbacks);
                request.setAttribute("avgRating", avgRating);
                request.setAttribute("tour", tourDAO.findById(Integer.parseInt(tourId)));
            }
            request.getRequestDispatcher("/views/feedback/tour-feedback.jsp").forward(request, response);

        } else {
            // Default: show user's completed orders that need feedback
            List<Object[]> pendingFeedback = feedbackDAO.getCompletedOrdersWithoutFeedback(user.getUserId());
            request.setAttribute("pendingFeedback", pendingFeedback);
            request.getRequestDispatcher("/views/feedback/my-feedback.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        JsonObject json = new JsonObject();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            json.addProperty("success", false);
            json.addProperty("message", "Vui lòng đăng nhập");
            out.print(json);
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");

        if ("submit".equals(action)) {
            try {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                int tourId = Integer.parseInt(request.getParameter("tourId"));

                if (feedbackDAO.hasUserFeedback(user.getUserId(), orderId)) {
                    json.addProperty("success", false);
                    json.addProperty("message", "Bạn đã gửi feedback cho đơn này rồi");
                    out.print(json);
                    return;
                }

                Order order = orderDAO.findById(orderId);
                Tour tour = tourDAO.findById(tourId);

                if (order == null || tour == null) {
                    json.addProperty("success", false);
                    json.addProperty("message", "Thông tin không hợp lệ");
                    out.print(json);
                    return;
                }

                TourFeedback fb = new TourFeedback();
                fb.setOrder(order);
                fb.setUser(user);
                fb.setTour(tour);
                fb.setOverallRating(Integer.parseInt(request.getParameter("overallRating")));
                fb.setGuideRating(parseIntSafe(request.getParameter("guideRating")));
                fb.setTransportRating(parseIntSafe(request.getParameter("transportRating")));
                fb.setFoodRating(parseIntSafe(request.getParameter("foodRating")));
                fb.setValueRating(parseIntSafe(request.getParameter("valueRating")));
                fb.setComment(request.getParameter("comment"));
                fb.setWouldRecommend("true".equals(request.getParameter("wouldRecommend")));
                fb.setImprovementSuggestion(request.getParameter("improvement"));

                boolean ok = feedbackDAO.create(fb);
                json.addProperty("success", ok);
                json.addProperty("message", ok ? "Cảm ơn bạn đã gửi feedback!" : "Lỗi hệ thống");

            } catch (Exception e) {
                json.addProperty("success", false);
                json.addProperty("message", "Lỗi: " + e.getMessage());
            }

        } else if ("approve".equals(action) || "hide".equals(action)) {
            // Admin actions
            if (!"ADMIN".equalsIgnoreCase(user.getRoleName())) {
                json.addProperty("success", false);
                json.addProperty("message", "Không có quyền");
                out.print(json);
                return;
            }
            int feedbackId = Integer.parseInt(request.getParameter("feedbackId"));
            String status = "approve".equals(action) ? "APPROVED" : "HIDDEN";
            boolean ok = feedbackDAO.updateStatus(feedbackId, status);
            json.addProperty("success", ok);
            json.addProperty("message", ok ? "Đã cập nhật" : "Lỗi");
        }

        out.print(json);
    }

    private int parseIntSafe(String val) {
        try { return val != null ? Integer.parseInt(val) : 0; }
        catch (NumberFormatException e) { return 0; }
    }
}
