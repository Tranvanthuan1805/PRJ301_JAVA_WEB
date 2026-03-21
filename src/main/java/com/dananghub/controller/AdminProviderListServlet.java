package com.dananghub.controller;

import com.dananghub.dao.ProviderRegistrationDAO;
import com.dananghub.entity.ProviderRegistration;
import com.dananghub.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet load trang quản lý đơn đăng ký NCC cho admin.
 * URL: GET /admin/provider-requests
 * Forward đến admin/provider-requests.jsp
 */
@WebServlet("/admin/provider-requests")
public class AdminProviderListServlet extends HttpServlet {

    private final ProviderRegistrationDAO dao = new ProviderRegistrationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra quyền admin
        HttpSession session = request.getSession(false);
        User admin = session != null ? (User) session.getAttribute("user") : null;
        if (admin == null || !"ADMIN".equals(admin.getRoleName())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // Lọc theo tab
            String filter = request.getParameter("status");
            if (filter == null || filter.isBlank())
                filter = "all";

            List<ProviderRegistration> list;
            if (!"all".equals(filter)) {
                list = dao.findByStatus(filter);
            } else {
                list = dao.findAll();
            }
            if (list == null)
                list = new java.util.ArrayList<>();

            long pendingCount = dao.countPending();

            request.setAttribute("registrations", list);
            request.setAttribute("pendingCount", pendingCount);
            request.setAttribute("activeFilter", filter);
            request.setAttribute("activePage", "provider-requests");

            request.getRequestDispatcher("/admin/provider-requests.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("registrations", new java.util.ArrayList<>());
            request.setAttribute("pendingCount", 0L);
            request.setAttribute("activeFilter", "all");
            request.setAttribute("errorMessage", "Lỗi tải danh sách: " + e.getMessage());
            request.getRequestDispatcher("/admin/provider-requests.jsp")
                    .forward(request, response);
        }
    }
}
