package com.dananghub.controller;

import com.dananghub.dao.CouponDAO;
import com.dananghub.entity.CartItem;
import com.dananghub.entity.Coupon;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/coupon")
public class CouponServlet extends HttpServlet {

    private final CouponDAO couponDAO = new CouponDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        JsonObject json = new JsonObject();

        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if ("apply".equals(action)) {
            applyCoupon(request, session, json);
        } else if ("remove".equals(action)) {
            removeCoupon(session, json);
        } else {
            json.addProperty("success", false);
            json.addProperty("message", "Hành động không hợp lệ");
        }

        out.print(json.toString());
        out.flush();
    }

    private void applyCoupon(HttpServletRequest request, HttpSession session, JsonObject json) {
        String code = request.getParameter("code");

        if (code == null || code.trim().isEmpty()) {
            json.addProperty("success", false);
            json.addProperty("message", "Vui lòng nhập mã giảm giá");
            return;
        }

        // Tính subtotal từ giỏ hàng
        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            json.addProperty("success", false);
            json.addProperty("message", "Giỏ hàng trống");
            return;
        }

        double subtotal = cart.stream().mapToDouble(CartItem::getTotalPrice).sum();

        // Tìm mã giảm giá
        Coupon coupon = couponDAO.findByCode(code.trim());
        if (coupon == null) {
            json.addProperty("success", false);
            json.addProperty("message", "Mã giảm giá không tồn tại");
            return;
        }

        // Kiểm tra hợp lệ
        if (!coupon.isValid(subtotal)) {
            if (!coupon.isActive()) {
                json.addProperty("message", "Mã giảm giá đã hết hạn");
            } else if (subtotal < coupon.getMinOrderAmount()) {
                json.addProperty("message",
                    String.format("Đơn hàng tối thiểu %,.0fđ để sử dụng mã này", coupon.getMinOrderAmount()));
            } else if (coupon.getUsageLimit() != null && coupon.getUsedCount() >= coupon.getUsageLimit()) {
                json.addProperty("message", "Mã giảm giá đã hết lượt sử dụng");
            } else {
                json.addProperty("message", "Mã giảm giá không hợp lệ");
            }
            json.addProperty("success", false);
            return;
        }

        // Tính giảm giá
        double discount = coupon.calculateDiscount(subtotal);
        double finalTotal = subtotal - discount;

        // Lưu vào session
        session.setAttribute("appliedCoupon", coupon);
        session.setAttribute("couponDiscount", discount);

        json.addProperty("success", true);
        json.addProperty("message", "Áp dụng mã thành công!");
        json.addProperty("couponCode", coupon.getCode());
        json.addProperty("discountLabel", coupon.getDiscountLabel());
        json.addProperty("description", coupon.getDescription());
        json.addProperty("discount", discount);
        json.addProperty("discountFormatted", String.format("%,.0f", discount));
        json.addProperty("finalTotal", finalTotal);
        json.addProperty("finalTotalFormatted", String.format("%,.0f", finalTotal));
    }

    private void removeCoupon(HttpSession session, JsonObject json) {
        session.removeAttribute("appliedCoupon");
        session.removeAttribute("couponDiscount");

        json.addProperty("success", true);
        json.addProperty("message", "Đã xóa mã giảm giá");
    }
}
