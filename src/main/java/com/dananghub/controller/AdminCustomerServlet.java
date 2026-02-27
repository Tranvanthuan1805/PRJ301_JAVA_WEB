package com.dananghub.controller;

import com.dananghub.dao.CustomerDAO;
import com.dananghub.dao.ActivityDAO;
import com.dananghub.entity.Customer;
import com.dananghub.entity.CustomerActivity;
import com.dananghub.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/customers")
public class AdminCustomerServlet extends HttpServlet {

    private final CustomerDAO customerDAO = new CustomerDAO();
    private final ActivityDAO activityDAO = new ActivityDAO();
    private static final int PAGE_SIZE = 10;

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
                case "view" -> handleView(request, response);
                case "edit" -> handleEditForm(request, response);
                case "delete" -> handleDelete(request, response);
                default -> handleList(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/admin/customers.jsp").forward(request, response);
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
        try {
            switch (action) {
                case "update" -> handleUpdate(request, response);
                case "updateStatus" -> handleUpdateStatus(request, response);
                default -> response.sendRedirect(request.getContextPath() + "/admin/customers");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/admin/customers.jsp").forward(request, response);
        }
    }

    private void handleList(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String pageStr = request.getParameter("page");

        int currentPage = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            try { currentPage = Integer.parseInt(pageStr); } catch (NumberFormatException e) { currentPage = 1; }
        }

        int offset = (currentPage - 1) * PAGE_SIZE;

        List<Customer> customers;
        long totalCustomers;

        if (keyword != null && !keyword.trim().isEmpty()) {
            customers = customerDAO.search(keyword.trim(), offset, PAGE_SIZE);
            totalCustomers = customerDAO.countSearch(keyword.trim());
            request.setAttribute("keyword", keyword);
        } else if (status != null && !status.isEmpty()) {
            customers = customerDAO.findByStatus(status, offset, PAGE_SIZE);
            totalCustomers = customerDAO.countByStatus(status);
            request.setAttribute("filterStatus", status);
        } else {
            customers = customerDAO.findAllPaginated(offset, PAGE_SIZE);
            totalCustomers = customerDAO.countAll();
        }

        int totalPages = (int) Math.ceil((double) totalCustomers / PAGE_SIZE);

        request.setAttribute("customers", customers);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCustomers", totalCustomers);

        request.getRequestDispatcher("/admin/customers.jsp").forward(request, response);
    }

    private void handleView(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/customers");
            return;
        }

        int customerId = Integer.parseInt(idStr);
        Customer customer = customerDAO.findById(customerId);

        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/admin/customers?error=notfound");
            return;
        }

        List<CustomerActivity> activities = activityDAO.findActivitiesByCustomer(customerId, 50);
        long totalActivities = activityDAO.countActivities(customerId);
        long bookingCount = activityDAO.countActivitiesByType(customerId, "BOOKING");
        long searchCount = activityDAO.countActivitiesByType(customerId, "SEARCH");

        request.setAttribute("customer", customer);
        request.setAttribute("activities", activities);
        request.setAttribute("totalActivities", totalActivities);
        request.setAttribute("bookingCount", bookingCount);
        request.setAttribute("searchCount", searchCount);

        request.getRequestDispatcher("/admin/customer-detail.jsp").forward(request, response);
    }

    private void handleEditForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/customers");
            return;
        }
        int customerId = Integer.parseInt(idStr);
        Customer customer = customerDAO.findById(customerId);
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/admin/customers?error=notfound");
            return;
        }
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/admin/customer-form.jsp").forward(request, response);
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        Customer customer = customerDAO.findById(customerId);
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/admin/customers?error=notfound");
            return;
        }

        boolean success = customerDAO.update(customer);
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/customers?action=view&id=" + customerId + "&success=updated");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/customers?action=view&id=" + customerId + "&error=updatefailed");
        }
    }

    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String newStatus = request.getParameter("status");
        boolean success = customerDAO.updateStatus(customerId, newStatus);
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/customers?action=view&id=" + customerId + "&success=statusupdated");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/customers?action=view&id=" + customerId + "&error=statusfailed");
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/customers");
            return;
        }
        int customerId = Integer.parseInt(idStr);
        boolean success = customerDAO.delete(customerId);
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/customers?success=deleted");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/customers?error=deletefailed");
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
