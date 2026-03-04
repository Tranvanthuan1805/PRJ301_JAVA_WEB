package com.dananghub.controller;

import com.dananghub.dao.CustomerDAO;
import com.dananghub.dao.ActivityDAO;
import com.dananghub.dao.UserDAO;
import com.dananghub.entity.Customer;
import com.dananghub.entity.CustomerActivity;
import com.dananghub.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

        // Stats for dashboard
        long activeCount = customerDAO.countByStatus("active");
        long newThisMonth = 0; // TODO: implement if needed

        request.setAttribute("customers", customers);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("activeCount", activeCount);
        request.setAttribute("newThisMonth", newThisMonth);

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
        try {
            request.setCharacterEncoding("UTF-8");
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            Customer customer = customerDAO.findById(customerId);
            if (customer == null) {
                System.out.println("ERROR: Customer not found: " + customerId);
                response.sendRedirect(request.getContextPath() + "/admin/customers?error=notfound");
                return;
            }

            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String status = request.getParameter("status");
            String dobStr = request.getParameter("dateOfBirth");

            System.out.println("=== Admin Update Customer Debug ===");
            System.out.println("Customer ID: " + customerId);
            System.out.println("Email: " + email);
            System.out.println("FullName: " + fullName);
            System.out.println("Phone: " + phone);
            System.out.println("Address: " + address);
            System.out.println("Status: " + status);
            System.out.println("DOB: " + dobStr);
            System.out.println("Customer.User: " + (customer.getUser() != null ? "EXISTS" : "NULL"));

            // Update User info (so user profile shows updated data)
            if (customer.getUser() != null) {
                try {
                    // Check if email is being changed and if it's already taken
                    if (email != null && !email.trim().isEmpty()) {
                        if (!email.trim().equalsIgnoreCase(customer.getUser().getEmail())) {
                            UserDAO userDAO = new UserDAO();
                            User existingUser = userDAO.findByEmail(email.trim());
                            if (existingUser != null && existingUser.getUserId() != customer.getUser().getUserId()) {
                                System.out.println("ERROR: Email already exists");
                                response.sendRedirect(request.getContextPath() + "/admin/customers?action=edit&id=" + customerId + "&error=emailexists");
                                return;
                            }
                        }
                        customer.getUser().setEmail(email.trim());
                    }
                    
                    if (fullName != null && !fullName.trim().isEmpty()) {
                        customer.getUser().setFullName(fullName.trim());
                    }
                    if (phone != null && !phone.trim().isEmpty()) {
                        customer.getUser().setPhoneNumber(phone.trim());
                    }
                    
                    // SYNC: Update address in Users table too
                    if (address != null && !address.trim().isEmpty()) {
                        customer.getUser().setAddress(address.trim());
                        System.out.println("Syncing address to Users table: " + address.trim());
                    }
                    
                    // SYNC: Update DOB in Users table too
                    if (dobStr != null && !dobStr.trim().isEmpty()) {
                        try {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            Date dob = sdf.parse(dobStr.trim());
                            customer.getUser().setDateOfBirth(dob);
                            System.out.println("Syncing DOB to Users table: " + dob);
                        } catch (Exception e) {
                            System.out.println("Error parsing DOB: " + e.getMessage());
                        }
                    }
                    
                    customer.getUser().setUpdatedAt(new Date());
                    
                    // Update User entity
                    UserDAO userDAO = new UserDAO();
                    boolean userUpdated = userDAO.update(customer.getUser());
                    System.out.println("User update result: " + userUpdated);
                } catch (Exception e) {
                    System.out.println("ERROR updating User: " + e.getMessage());
                    e.printStackTrace();
                }
            } else {
                System.out.println("WARNING: Customer.User is NULL - cannot sync to Users table");
            }

            // Update Customer info (so admin sees updated data)
            if (address != null) customer.setAddress(address.trim());
            if (status != null) customer.setStatus(status);
            if (dobStr != null && !dobStr.trim().isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    customer.setDateOfBirth(sdf.parse(dobStr.trim()));
                } catch (Exception e) {
                    System.out.println("Error parsing Customer DOB: " + e.getMessage());
                }
            }

            boolean success = customerDAO.update(customer);
            System.out.println("Customer update result: " + success);
            System.out.println("===================================");
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/customers?action=view&id=" + customerId + "&success=updated");
            } else {
                System.out.println("ERROR: Customer update failed");
                response.sendRedirect(request.getContextPath() + "/admin/customers?action=view&id=" + customerId + "&error=updatefailed");
            }
        } catch (Exception e) {
            System.out.println("FATAL ERROR in handleUpdate: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/customers?action=view&id=" + request.getParameter("customerId") + "&error=updatefailed");
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
