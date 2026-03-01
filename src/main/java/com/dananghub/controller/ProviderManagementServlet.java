package com.dananghub.controller;

import com.dananghub.dao.ProviderDAO;
import com.dananghub.entity.Provider;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * ProviderManagementServlet - Quản lý Nhà Cung Cấp Du Lịch
 * URL: /admin/providers
 * Hỗ trợ: Danh sách, Tìm kiếm, Lọc theo loại
 */
@WebServlet("/admin/providers")
public class ProviderManagementServlet extends HttpServlet {

    private ProviderDAO providerDAO = new ProviderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String action = request.getParameter("action");
            if (action == null) {
                action = "list";
            }

            switch (action) {
                case "detail":
                    showDetail(request, response);
                    break;
                case "comparison":
                    showComparison(request, response);
                    break;
                default:
                    listProviders(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    /**
     * Hiển thị danh sách providers với tìm kiếm và lọc
     */
    private void listProviders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String search = request.getParameter("search");
        String type = request.getParameter("type");

        List<Provider> providers;

        // Lấy dữ liệu từ DAO
        if (search != null && !search.trim().isEmpty()) {
            providers = providerDAO.searchByName(search.trim());
        } else if (type != null && !type.trim().isEmpty()) {
            providers = providerDAO.findByType(type);
        } else {
            providers = providerDAO.findAllActive();
        }

        // Đặt attributes cho JSP
        request.setAttribute("providers", providers);
        if (search != null) request.setAttribute("search", search);
        if (type != null) request.setAttribute("type", type);

        request.getRequestDispatcher("/views/provider-management/provider-list.jsp")
                .forward(request, response);
    }

    /**
     * Hiển thị chi tiết provider
     */
    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/providers");
            return;
        }

        try {
            int providerId = Integer.parseInt(idParam);
            Provider provider = providerDAO.findById(providerId);

            if (provider == null) {
                response.sendRedirect(request.getContextPath() + "/admin/providers");
                return;
            }

            request.setAttribute("provider", provider);
            request.getRequestDispatcher("/views/provider-management/provider-detail.jsp")
                    .forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/providers");
        }
    }

    /**
     * Hiển thị trang so sánh giá
     */
    private void showComparison(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idsParam = request.getParameter("ids");
        if (idsParam == null || idsParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/providers");
            return;
        }

        try {
            String[] idArray = idsParam.split(",");
            java.util.List<Integer> providerIds = new java.util.ArrayList<>();
            
            for (String id : idArray) {
                try {
                    providerIds.add(Integer.parseInt(id.trim()));
                } catch (NumberFormatException e) {
                    // Bỏ qua ID không hợp lệ
                }
            }

            if (providerIds.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/providers");
                return;
            }

            // Lấy providers để so sánh
            List<Provider> comparisonProviders = providerDAO.findByIds(providerIds);

            request.setAttribute("providers", comparisonProviders);
            request.setAttribute("ids", idsParam);
            request.getRequestDispatcher("/views/provider-management/provider-comparison.jsp")
                    .forward(request, response);
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin/providers");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if ("register".equals(action)) {
                registerProvider(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/providers");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi xử lý request: " + e.getMessage());
            doGet(request, response);
        }
    }

    /**
     * Xử lý đăng ký provider mới
     */
    private void registerProvider(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Trong thực tế, bạn sẽ:
        // 1. Validate dữ liệu từ form
        // 2. Tạo object Provider mới
        // 3. Lưu vào database qua DAO
        // 4. Redirect hoặc forward
        
        // Tạm thời: chuyển hướng về danh sách
        response.sendRedirect(request.getContextPath() + "/admin/providers?success=Đăng ký thành công!");
    }
}
