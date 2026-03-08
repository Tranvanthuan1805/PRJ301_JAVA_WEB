package com.dananghub.controller;

import com.dananghub.dao.TourDAO;
import com.dananghub.entity.Tour;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Servlet cho So sánh giá tour - cho phép khách hàng so sánh side-by-side
 */
@WebServlet("/tour-compare")
public class TourCompareServlet extends HttpServlet {

    private final TourDAO tourDAO = new TourDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idsParam = request.getParameter("ids");
        String categoryParam = request.getParameter("category");

        // Lấy danh sách tất cả tour để hiển thị picker
        List<Tour> allTours = tourDAO.findAll();
        request.setAttribute("allTours", allTours);

        // Nếu có ids, load các tour đã chọn để so sánh
        if (idsParam != null && !idsParam.trim().isEmpty()) {
            String[] idArr = idsParam.split(",");
            List<Tour> compareTours = new ArrayList<>();
            for (String id : idArr) {
                try {
                    Tour t = tourDAO.findById(Integer.parseInt(id.trim()));
                    if (t != null) compareTours.add(t);
                } catch (NumberFormatException ignored) {}
            }
            request.setAttribute("compareTours", compareTours);

            // Tính min/max prices
            if (!compareTours.isEmpty()) {
                double minPrice = compareTours.stream().mapToDouble(Tour::getPrice).min().orElse(0);
                double maxPrice = compareTours.stream().mapToDouble(Tour::getPrice).max().orElse(0);
                double avgPrice = compareTours.stream().mapToDouble(Tour::getPrice).average().orElse(0);
                request.setAttribute("minPrice", minPrice);
                request.setAttribute("maxPrice", maxPrice);
                request.setAttribute("avgPrice", avgPrice);
            }
        }

        // Lấy danh sách categories
        Set<String> categories = allTours.stream()
            .filter(t -> t.getCategory() != null)
            .map(t -> t.getCategory().getCategoryName())
            .collect(Collectors.toCollection(TreeSet::new));
        request.setAttribute("categories", categories);

        // Filter theo category nếu có
        if (categoryParam != null && !categoryParam.isEmpty()) {
            List<Tour> filtered = allTours.stream()
                .filter(t -> t.getCategory() != null && categoryParam.equals(t.getCategory().getCategoryName()))
                .collect(Collectors.toList());
            request.setAttribute("filteredTours", filtered);
            request.setAttribute("selectedCategory", categoryParam);
        }

        request.getRequestDispatcher("/views/tour-compare/compare.jsp").forward(request, response);
    }
}
