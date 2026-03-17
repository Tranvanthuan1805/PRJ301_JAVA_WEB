package com.dananghub.controller;

import com.dananghub.dao.CouponDAO;
import com.dananghub.entity.Coupon;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/admin/coupons")
public class AdminCouponServlet extends HttpServlet {

    private final CouponDAO dao = new CouponDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        try {
            if ("add".equals(action)) {
                Coupon c = new Coupon();
                c.setCode(req.getParameter("code").toUpperCase().trim());
                c.setDiscountType(req.getParameter("discountType"));
                c.setDiscountValue(Double.parseDouble(req.getParameter("discountValue")));

                String minOrder = req.getParameter("minOrderAmount");
                if (minOrder != null && !minOrder.isEmpty()) c.setMinOrderAmount(Double.parseDouble(minOrder));

                String maxDisc = req.getParameter("maxDiscount");
                if (maxDisc != null && !maxDisc.isEmpty()) c.setMaxDiscount(Double.parseDouble(maxDisc));

                String usageLimit = req.getParameter("usageLimit");
                if (usageLimit != null && !usageLimit.isEmpty()) c.setUsageLimit(Integer.parseInt(usageLimit));

                String desc = req.getParameter("description");
                if (desc != null) c.setDescription(desc);

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String sd = req.getParameter("startDate");
                if (sd != null && !sd.isEmpty()) c.setStartDate(sdf.parse(sd));
                String ed = req.getParameter("endDate");
                if (ed != null && !ed.isEmpty()) c.setEndDate(sdf.parse(ed));

                c.setActive(true);
                c.setUsedCount(0);
                c.setCreatedAt(new Date());

                dao.save(c);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                dao.delete(id);

            } else if ("toggle".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Coupon c = dao.findById(id);
                if (c != null) {
                    c.setActive(!c.isActive());
                    dao.update(c);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect based on source
        String redirect = req.getParameter("redirect");
        if ("dashboard".equals(redirect)) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard#coupons");
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        }
    }
}
