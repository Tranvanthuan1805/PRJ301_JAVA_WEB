package servlet;

import dao.CustomerDAO;
import dao.CustomerActivityDAO;
import model.Customer;
import model.CustomerActivity;
import util.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/customers")
public class AdminCustomerServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check admin access
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        
        if (username == null || !"ADMIN".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            if (action == null || action.equals("list")) {
                listCustomers(request, response);
            } else if (action.equals("view")) {
                viewCustomer(request, response);
            } else if (action.equals("delete")) {
                deleteCustomer(request, response);
            } else if (action.equals("toggleStatus")) {
                toggleCustomerStatus(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if (action != null && action.equals("update")) {
                updateCustomer(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
    
    private void listCustomers(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        Connection conn = DatabaseConnection.getNewConnection();
        CustomerDAO customerDAO = new CustomerDAO(conn);
        
        // Get filter parameters
        String searchQuery = request.getParameter("search");
        String statusFilter = request.getParameter("status");
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        
        // Get pagination parameters
        int page = 1;
        int pageSize = 10;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        // Get all customers
        List<Customer> allCustomers = customerDAO.getAllCustomers();
        
        // Apply filters
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            allCustomers = allCustomers.stream()
                .filter(c -> c.getFullName().toLowerCase().contains(searchQuery.toLowerCase()) ||
                           c.getEmail().toLowerCase().contains(searchQuery.toLowerCase()))
                .collect(java.util.stream.Collectors.toList());
        }
        
        if (statusFilter != null && !statusFilter.isEmpty() && !statusFilter.equals("all")) {
            allCustomers = allCustomers.stream()
                .filter(c -> c.getStatus().equalsIgnoreCase(statusFilter))
                .collect(java.util.stream.Collectors.toList());
        }
        
        // Apply sorting
        if (sortBy != null && !sortBy.isEmpty()) {
            boolean ascending = sortOrder == null || sortOrder.equals("asc");
            
            switch (sortBy) {
                case "name":
                    allCustomers.sort((c1, c2) -> ascending ? 
                        c1.getFullName().compareTo(c2.getFullName()) : 
                        c2.getFullName().compareTo(c1.getFullName()));
                    break;
                case "email":
                    allCustomers.sort((c1, c2) -> ascending ? 
                        c1.getEmail().compareTo(c2.getEmail()) : 
                        c2.getEmail().compareTo(c1.getEmail()));
                    break;
                case "date":
                    allCustomers.sort((c1, c2) -> ascending ? 
                        c1.getCreatedAt().compareTo(c2.getCreatedAt()) : 
                        c2.getCreatedAt().compareTo(c1.getCreatedAt()));
                    break;
            }
        }
        
        // Calculate pagination
        int totalCustomers = allCustomers.size();
        int totalPages = (int) Math.ceil((double) totalCustomers / pageSize);
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalCustomers);
        
        List<Customer> customers = allCustomers.subList(startIndex, endIndex);
        
        // Set attributes
        request.setAttribute("customers", customers);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);
        
        request.getRequestDispatcher("/admin/customers.jsp").forward(request, response);
    }
    
    private void viewCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        Connection conn = DatabaseConnection.getNewConnection();
        CustomerDAO customerDAO = new CustomerDAO(conn);
        CustomerActivityDAO activityDAO = new CustomerActivityDAO(conn);
        
        Customer customer = customerDAO.getCustomerById(id);
        List<CustomerActivity> activities = activityDAO.getActivitiesByCustomerId(id);
        
        request.setAttribute("customer", customer);
        request.setAttribute("activities", activities);
        
        request.getRequestDispatcher("/admin/customer-detail.jsp").forward(request, response);
    }
    
    private void updateCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        Connection conn = DatabaseConnection.getNewConnection();
        CustomerDAO customerDAO = new CustomerDAO(conn);
        
        Customer customer = customerDAO.getCustomerById(id);
        if (customer != null) {
            customer.setFullName(fullName);
            customer.setPhone(phone);
            customer.setAddress(address);
            customerDAO.updateCustomer(customer);
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/customers?action=view&id=" + id + "&success=updated");
    }
    
    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        Connection conn = DatabaseConnection.getNewConnection();
        CustomerDAO customerDAO = new CustomerDAO(conn);
        
        customerDAO.deleteCustomer(id);
        
        response.sendRedirect(request.getContextPath() + "/admin/customers?success=deleted");
    }
    
    private void toggleCustomerStatus(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        Connection conn = DatabaseConnection.getNewConnection();
        CustomerDAO customerDAO = new CustomerDAO(conn);
        
        Customer customer = customerDAO.getCustomerById(id);
        if (customer != null) {
            String newStatus = customer.getStatus().equals("ACTIVE") ? "LOCKED" : "ACTIVE";
            customerDAO.updateCustomerStatus(id, newStatus);
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/customers?success=statusUpdated");
    }
}
