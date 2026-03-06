package com.dananghub.controller;

import com.dananghub.dao.CouponDAO;
import com.dananghub.entity.Coupon;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/api/validate-coupon")
public class CouponValidateServlet extends HttpServlet {

    private final CouponDAO couponDAO = new CouponDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Map<String, Object> result = new HashMap<>();

        String code = request.getParameter("code");
        String totalStr = request.getParameter("total");

        if (code == null || code.trim().isEmpty()) {
            result.put("valid", false);
            result.put("message", "Vui lòng nhập mã giảm giá");
            out.print(new Gson().toJson(result));
            return;
        }

        double orderTotal = 0;
        try {
            orderTotal = Double.parseDouble(totalStr);
        } catch (Exception e) {
            result.put("valid", false);
            result.put("message", "Lỗi hệ thống");
            out.print(new Gson().toJson(result));
            return;
        }

        Coupon coupon = couponDAO.findByCode(code.trim());

        if (coupon == null) {
            result.put("valid", false);
            result.put("message", "Mã giảm giá không tồn tại");
            out.print(new Gson().toJson(result));
            return;
        }

        if (!coupon.isValid()) {
            String reason = "Mã giảm giá đã hết hạn hoặc không còn hiệu lực";
            if (coupon.getUsageLimit() > 0 && coupon.getUsedCount() >= coupon.getUsageLimit()) {
                reason = "Mã giảm giá đã hết lượt sử dụng";
            }
            result.put("valid", false);
            result.put("message", reason);
            out.print(new Gson().toJson(result));
            return;
        }

        if (orderTotal < coupon.getMinOrderAmount()) {
            result.put("valid", false);
            result.put("message", String.format("Đơn hàng tối thiểu %,.0fđ để sử dụng mã này", coupon.getMinOrderAmount()));
            out.print(new Gson().toJson(result));
            return;
        }

        double discount = coupon.calculateDiscount(orderTotal);
        result.put("valid", true);
        result.put("discount", discount);
        result.put("discountDisplay", String.format("%,.0f", discount));
        result.put("newTotal", orderTotal - discount);
        result.put("newTotalDisplay", String.format("%,.0f", orderTotal - discount));
        result.put("message", "Áp dụng thành công: -" + String.format("%,.0f", discount) + "đ (" + coupon.getDiscountDisplay() + ")");

        out.print(new Gson().toJson(result));
    }
}
