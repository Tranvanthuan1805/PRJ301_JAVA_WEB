package controller;

import dao.CustomerDAO;
import dao.CustomerActivityDAO;
import model.Customer;
import model.CustomerActivity;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet for Admin Customer Management
 * Handles: list, view, edit, lock/unlock customers
 */
@WebServlet("/admin/customers")
public class AdminCustomerServlet extends HttpServlet {
    
    private CustomerDAO customerDAO = new CustomerDAO();
    private CustomerActivityDAO activityDAO = new CustomerActivityDAO();
    
    private static final int PAGE_SIZE = 10;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        // Check authentication and authorization
        HttpSession session = request.getSession(false);
        User user = (session == null) ? null : (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        if (!"ADMIN".equalsIgnoreCase(user.roleName)) {
            response.sendRedirect(request.getContextPath() + "/error.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) action = "list";
        
        try {
            switch (action) {
                case "list":
                    handleList(request, response);
                    break;
                case "view":
                    handleView(request, response);
                    break;
                case "add":
                    handleAddForm(request, response);
                    break;
                case "edit":
                    handleEditForm(request, response);
                    break;
                case "delete":
                    handleDelete(request, response);
                    break;
                default:
                    handleList(request, response);
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
        
        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        // Check authentication and authorization
        HttpSession session = request.getSession(false);
        User user = (session == null) ? null : (User) session.getAttribute("user");
        
        if (user == null || !"ADMIN".equalsIgnoreCase(user.roleName)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "add":
                    handleAddCustomer(request, response);
                    break;
                case "update":
                    handleUpdate(request, response);
                    break;
                case "updateStatus":
                    handleUpdateStatus(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/customers");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/admin/customers.jsp").forward(request, response);
        }
    }
    
    /**
     * Handle customer list with search and filter
     */
    private void handleList(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String pageStr = request.getParameter("page");
        
        int currentPage = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }
        
        int offset = (currentPage - 1) * PAGE_SIZE;
        
        List<Customer> customers;
        int totalCustomers;
        
        // Search or filter
        if (keyword != null && !keyword.trim().isEmpty()) {
            customers = customerDAO.searchCustomers(keyword.trim(), offset, PAGE_SIZE);
            totalCustomers = customerDAO.getSearchCount(keyword.trim());
            request.setAttribute("keyword", keyword);
        } else if (status != null && !status.isEmpty()) {
            customers = customerDAO.filterByStatus(status, offset, PAGE_SIZE);
            totalCustomers = customerDAO.getCountByStatus(status);
            request.setAttribute("filterStatus", status);
        } else {
            customers = customerDAO.getAllCustomers(offset, PAGE_SIZE);
            totalCustomers = customerDAO.getTotalCustomers();
        }
        
        int totalPages = (int) Math.ceil((double) totalCustomers / PAGE_SIZE);
        
        request.setAttribute("customers", customers);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCustomers", totalCustomers);
        
        request.getRequestDispatcher("/admin/customers.jsp").forward(request, response);
    }
    
    /**
     * Handle view customer detail
     */
    private void handleView(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/customers");
            return;
        }
        
        int customerId = Integer.parseInt(idStr);
        Customer customer = customerDAO.getCustomerById(customerId);
        
        if (customer == null) {
            request.setAttribute("error", "Không tìm thấy khách hàng");
            response.sendRedirect(request.getContextPath() + "/admin/customers");
            return;
        }
        
        // Get activities
        List<CustomerActivity> activities = activityDAO.getActivitiesByCustomerId(customerId, 50);
        
        // Get activity stats
        int totalActivities = activityDAO.getActivityCount(customerId);
        int bookingCount = activityDAO.getCountByActionType(customerId, "BOOKING");
        int searchCount = activityDAO.getCountByActionType(customerId, "SEARCH");
        
        request.setAttribute("customer", customer);
        request.setAttribute("activities", activities);
        request.setAttribute("totalActivities", totalActivities);
        request.setAttribute("bookingCount", bookingCount);
        request.setAttribute("searchCount", searchCount);
        
        request.getRequestDispatcher("/admin/customer-detail.jsp").forward(request, response);
    }
    
    /**
     * Handle update customer information
     */
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        
        Customer customer = customerDAO.getCustomerById(customerId);
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/admin/customers?error=notfound");
            return;
        }
        
        // Update fields
        customer.setFullName(request.getParameter("fullName"));
        customer.setEmail(request.getParameter("email"));
        customer.setPhone(request.getParameter("phone"));
        customer.setAddress(request.getParameter("address"));
        
        String dobStr = request.getParameter("dateOfBirth");
        if (dobStr != null && !dobStr.isEmpty()) {
            customer.setDateOfBirth(java.sql.Date.valueOf(dobStr));
        }
        
        boolean success = customerDAO.updateCustomer(customer);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + 
                "/admin/customers?action=view&id=" + customerId + "&success=updated");
        } else {
            response.sendRedirect(request.getContextPath() + 
                "/admin/customers?action=view&id=" + customerId + "&error=updatefailed");
        }
    }
    
    /**
     * Handle lock/unlock customer account
     */
    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String newStatus = request.getParameter("status");
        
        boolean success = customerDAO.updateCustomerStatus(customerId, newStatus);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + 
                "/admin/customers?action=view&id=" + customerId + "&success=statusupdated");
        } else {
            response.sendRedirect(request.getContextPath() + 
                "/admin/customers?action=view&id=" + customerId + "&error=statusfailed");
        }
    }
    
    /**
     * Show add customer form
     */
    private void handleAddForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.getRequestDispatcher("/admin/customer-form.jsp").forward(request, response);
    }
    
    /**
     * Show edit customer form
     */
    private void handleEditForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/customers");
            return;
        }
        
        int customerId = Integer.parseInt(idStr);
        Customer customer = customerDAO.getCustomerById(customerId);
        
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/admin/customers?error=notfound");
            return;
        }
        
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/admin/customer-form.jsp").forward(request, response);
    }
    
    /**
     * Handle add new customer
     */
    private void handleAddCustomer(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        Customer customer = new Customer();
        customer.setFullName(request.getParameter("fullName"));
        customer.setEmail(request.getParameter("email"));
        customer.setPhone(request.getParameter("phone"));
        customer.setAddress(request.getParameter("address"));
        
        String dobStr = request.getParameter("dateOfBirth");
        if (dobStr != null && !dobStr.isEmpty()) {
            customer.setDateOfBirth(java.sql.Date.valueOf(dobStr));
        }
        
        customer.setStatus("active");
        
        boolean success = customerDAO.addCustomer(customer);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/customers?success=added");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/customers?error=addfailed");
        }
    }
    
    /**
     * Handle delete customer
     */
    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/customers");
            return;
        }
        
        int customerId = Integer.parseInt(idStr);
        boolean success = customerDAO.deleteCustomer(customerId);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/customers?success=deleted");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/customers?error=deletefailed");
        }
    }
}
