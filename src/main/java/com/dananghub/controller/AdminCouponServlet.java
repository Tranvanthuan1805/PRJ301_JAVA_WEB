package com.dananghub.controller;

import com.dananghub.dao.CouponDAO;
import com.dananghub.entity.Coupon;
import com.dananghub.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "AdminCouponServlet", urlPatterns = {"/admin/coupons"})
public class AdminCouponServlet extends HttpServlet {

    private final CouponDAO couponDAO = new CouponDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "edit" -> editForm(request, response);
                default -> listCoupons(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            listCoupons(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "";

        try {
            switch (action) {
                case "create" -> createCoupon(request, response);
                case "update" -> updateCoupon(request, response);
                case "delete" -> deleteCoupon(request, response);
                case "toggle" -> toggleCoupon(request, response);
                default -> response.sendRedirect("coupons");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("coupons?error=system_error");
        }
    }

    private void listCoupons(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Coupon> coupons = couponDAO.findAll();
        request.setAttribute("coupons", coupons);
        request.setAttribute("activePage", "coupons");
        request.getRequestDispatcher("/views/admin/admin-coupons.jsp").forward(request, response);
    }

    private void editForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Coupon coupon = couponDAO.findById(id);
        if (coupon == null) {
            response.sendRedirect("coupons?error=not_found");
            return;
        }
        request.setAttribute("editCoupon", coupon);
        listCoupons(request, response);
    }

    private void createCoupon(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Coupon coupon = buildCouponFromRequest(request);
        if (coupon == null) {
            response.sendRedirect("coupons?error=invalid_data");
            return;
        }
        boolean success = couponDAO.create(coupon);
        response.sendRedirect("coupons?msg=" + (success ? "created" : "create_failed"));
    }

    private void updateCoupon(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("couponId"));
        Coupon existing = couponDAO.findById(id);
        if (existing == null) {
            response.sendRedirect("coupons?error=not_found");
            return;
        }

        Coupon updated = buildCouponFromRequest(request);
        if (updated == null) {
            response.sendRedirect("coupons?error=invalid_data");
            return;
        }
        updated.setCouponId(id);
        updated.setUsedCount(existing.getUsedCount());
        updated.setCreatedAt(existing.getCreatedAt());

        boolean success = couponDAO.update(updated);
        response.sendRedirect("coupons?msg=" + (success ? "updated" : "update_failed"));
    }

    private void deleteCoupon(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("couponId"));
        boolean success = couponDAO.delete(id);
        response.sendRedirect("coupons?msg=" + (success ? "deleted" : "delete_failed"));
    }

    private void toggleCoupon(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("couponId"));
        Coupon coupon = couponDAO.findById(id);
        if (coupon != null) {
            coupon.setIsActive(!coupon.getIsActive());
            couponDAO.update(coupon);
        }
        response.sendRedirect("coupons");
    }

    private Coupon buildCouponFromRequest(HttpServletRequest request) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Coupon c = new Coupon();
            c.setCode(request.getParameter("code").toUpperCase().trim());
            c.setDiscountType(request.getParameter("discountType"));
            c.setDiscountValue(Double.parseDouble(request.getParameter("discountValue")));

            String minStr = request.getParameter("minOrderAmount");
            c.setMinOrderAmount(minStr != null && !minStr.isEmpty() ? Double.parseDouble(minStr) : 0);

            String maxStr = request.getParameter("maxDiscount");
            c.setMaxDiscount(maxStr != null && !maxStr.isEmpty() ? Double.parseDouble(maxStr) : null);

            String limitStr = request.getParameter("usageLimit");
            c.setUsageLimit(limitStr != null && !limitStr.isEmpty() ? Integer.parseInt(limitStr) : 0);

            String startStr = request.getParameter("startDate");
            if (startStr != null && !startStr.isEmpty()) c.setStartDate(sdf.parse(startStr));

            String endStr = request.getParameter("endDate");
            if (endStr != null && !endStr.isEmpty()) c.setEndDate(sdf.parse(endStr));

            String activeStr = request.getParameter("isActive");
            c.setIsActive(activeStr != null);

            return c;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;
        User user = (User) session.getAttribute("user");
        if (user == null) return false;
        return "ADMIN".equalsIgnoreCase(user.getRoleName());
    }
}
