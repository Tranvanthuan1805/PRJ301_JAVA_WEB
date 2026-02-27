package controller;

import dao.CustomerDAO;
import dao.CustomerActivityDAO;
import model.Customer;
import model.CustomerActivity;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    
    private CustomerDAO customerDAO;
    private CustomerActivityDAO activityDAO;
    
    @Override
    public void init() throws ServletException {
        customerDAO = new CustomerDAO();
        activityDAO = new CustomerActivityDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        System.out.println(">>> ProfileServlet: user=" + user.getUsername());
        System.out.println(">>> ProfileServlet: userId=" + user.getUserId());
        System.out.println(">>> ProfileServlet: role=" + user.getRoleName());
        
        try {
            // Get customer by user_id (linked via foreign key)
            Customer customer = customerDAO.getCustomerByUserId(user.getUserId());
            
            System.out.println(">>> ProfileServlet: customer=" + (customer == null ? "null" : customer.getFullName()));
            
            if (customer == null) {
                System.out.println(">>> ProfileServlet: Customer not found for userId=" + user.getUserId());
                request.setAttribute("error", "Không tìm thấy thông tin khách hàng cho tài khoản: " + user.getUsername());
                request.setAttribute("username", user.getUsername());
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }
            
            // Get customer activities
            List<CustomerActivity> activities = activityDAO.getActivitiesByCustomerId(customer.getId(), 20);
            
            // Calculate statistics
            int totalActivities = activityDAO.countActivitiesByCustomerId(customer.getId());
            int bookingCount = activityDAO.countActivitiesByType(customer.getId(), "BOOKING");
            int searchCount = activityDAO.countActivitiesByType(customer.getId(), "SEARCH");
            
            System.out.println(">>> ProfileServlet: totalActivities=" + totalActivities);
            
            // Set attributes
            request.setAttribute("customer", customer);
            request.setAttribute("activities", activities);
            request.setAttribute("totalActivities", totalActivities);
            request.setAttribute("bookingCount", bookingCount);
            request.setAttribute("searchCount", searchCount);
            
            // Forward to profile page
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(">>> ProfileServlet ERROR: " + e.getMessage());
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        try {
            // Get customer by user_id
            Customer customer = customerDAO.getCustomerByUserId(user.getUserId());
            
            if (customer == null) {
                response.sendRedirect(request.getContextPath() + "/profile?error=notfound");
                return;
            }
            
            // Update customer information
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String dobStr = request.getParameter("dateOfBirth");
            
            // Keep existing email (don't allow changing email)
            customer.setFullName(fullName);
            customer.setPhone(phone);
            customer.setAddress(address);
            // Email stays the same - don't update it
            
            if (dobStr != null && !dobStr.isEmpty()) {
                customer.setDateOfBirth(java.sql.Date.valueOf(dobStr));
            }
            
            boolean updated = customerDAO.updateCustomer(customer);
            
            if (updated) {
                // Log activity (optional - skip if causes error)
                try {
                    CustomerActivity activity = new CustomerActivity();
                    activity.setCustomerId(customer.getId());
                    activity.setActionType("UPDATE_PROFILE");
                    activity.setDescription("Cập nhật thông tin cá nhân");
                    activityDAO.addActivity(activity);
                } catch (Exception activityError) {
                    System.out.println(">>> Activity logging failed: " + activityError.getMessage());
                    // Continue anyway - activity logging is not critical
                }
                
                response.sendRedirect(request.getContextPath() + "/profile?success=updated");
            } else {
                System.out.println(">>> Update failed - customerDAO.updateCustomer returned false");
                response.sendRedirect(request.getContextPath() + "/profile?error=updatefailed");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(">>> ProfileServlet doPost ERROR: " + e.getMessage());
            System.out.println(">>> Error class: " + e.getClass().getName());
            if (e.getCause() != null) {
                System.out.println(">>> Cause: " + e.getCause().getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/profile?error=exception");
        }
    }
}
