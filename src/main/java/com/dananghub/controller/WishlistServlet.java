package com.dananghub.controller;

import com.dananghub.dao.WishlistDAO;
import com.dananghub.dao.TourDAO;
import com.dananghub.entity.Tour;
import com.dananghub.entity.User;
import com.dananghub.entity.Wishlist;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    private final WishlistDAO wishlistDAO = new WishlistDAO();
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

        if ("api".equals(action)) {
            // API: Trả về JSON danh sách wishlist
            response.setContentType("application/json;charset=UTF-8");
            PrintWriter out = response.getWriter();
            JsonObject json = new JsonObject();

            List<Wishlist> wishlists = wishlistDAO.findByUserId(user.getUserId());
            JsonArray arr = new JsonArray();
            for (Wishlist w : wishlists) {
                JsonObject wj = new JsonObject();
                wj.addProperty("wishlistId", w.getWishlistId());
                wj.addProperty("tourId", w.getTour().getTourId());
                wj.addProperty("tourName", w.getTour().getTourName());
                wj.addProperty("price", w.getTour().getPrice());
                wj.addProperty("imageUrl", w.getTour().getImageUrl());
                wj.addProperty("note", w.getNote());
                arr.add(wj);
            }
            json.addProperty("success", true);
            json.add("wishlists", arr);
            json.addProperty("count", wishlists.size());
            out.print(json);
            return;

        } else if ("check".equals(action)) {
            // API: Kiểm tra tour có trong wishlist
            response.setContentType("application/json;charset=UTF-8");
            PrintWriter out = response.getWriter();
            JsonObject json = new JsonObject();

            String tourId = request.getParameter("tourId");
            if (tourId != null) {
                boolean exists = wishlistDAO.exists(user.getUserId(), Integer.parseInt(tourId));
                json.addProperty("success", true);
                json.addProperty("inWishlist", exists);
            } else {
                json.addProperty("success", false);
                json.addProperty("message", "Thiếu tourId");
            }
            out.print(json);
            return;
        }

        // Page: Hiển thị danh sách wishlist
        List<Wishlist> wishlists = wishlistDAO.findByUserId(user.getUserId());
        request.setAttribute("wishlists", wishlists);
        request.setAttribute("wishlistCount", wishlists.size());
        request.getRequestDispatcher("/views/wishlist/wishlist.jsp").forward(request, response);
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

        if ("add".equals(action)) {
            String tourIdStr = request.getParameter("tourId");
            if (tourIdStr == null) {
                json.addProperty("success", false);
                json.addProperty("message", "Thiếu tourId");
            } else {
                int tourId = Integer.parseInt(tourIdStr);
                if (wishlistDAO.exists(user.getUserId(), tourId)) {
                    json.addProperty("success", false);
                    json.addProperty("message", "Tour đã có trong danh sách yêu thích");
                } else {
                    Tour tour = tourDAO.findById(tourId);
                    if (tour == null) {
                        json.addProperty("success", false);
                        json.addProperty("message", "Tour không tồn tại");
                    } else {
                        Wishlist w = new Wishlist(user, tour);
                        String note = request.getParameter("note");
                        if (note != null) w.setNote(note);
                        boolean ok = wishlistDAO.add(w);
                        json.addProperty("success", ok);
                        json.addProperty("message", ok ? "Đã thêm vào yêu thích!" : "Lỗi khi thêm");
                        json.addProperty("count", wishlistDAO.countByUser(user.getUserId()));
                    }
                }
            }
        } else if ("remove".equals(action)) {
            String tourIdStr = request.getParameter("tourId");
            if (tourIdStr != null) {
                boolean ok = wishlistDAO.removeByUserAndTour(user.getUserId(), Integer.parseInt(tourIdStr));
                json.addProperty("success", ok);
                json.addProperty("message", ok ? "Đã xóa khỏi yêu thích" : "Không tìm thấy");
                json.addProperty("count", wishlistDAO.countByUser(user.getUserId()));
            }
        } else if ("toggle".equals(action)) {
            String tourIdStr = request.getParameter("tourId");
            if (tourIdStr != null) {
                int tourId = Integer.parseInt(tourIdStr);
                if (wishlistDAO.exists(user.getUserId(), tourId)) {
                    wishlistDAO.removeByUserAndTour(user.getUserId(), tourId);
                    json.addProperty("success", true);
                    json.addProperty("added", false);
                    json.addProperty("message", "Đã xóa khỏi yêu thích");
                } else {
                    Tour tour = tourDAO.findById(tourId);
                    if (tour != null) {
                        wishlistDAO.add(new Wishlist(user, tour));
                        json.addProperty("success", true);
                        json.addProperty("added", true);
                        json.addProperty("message", "Đã thêm vào yêu thích!");
                    }
                }
                json.addProperty("count", wishlistDAO.countByUser(user.getUserId()));
            }
        } else {
            json.addProperty("success", false);
            json.addProperty("message", "Hành động không hợp lệ");
        }

        out.print(json);
    }
}
