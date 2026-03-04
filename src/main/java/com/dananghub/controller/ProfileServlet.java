package com.dananghub.controller;

import com.dananghub.dao.UserDAO;
import com.dananghub.dao.CustomerDAO;
import com.dananghub.entity.User;
import com.dananghub.entity.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private final CustomerDAO customerDAO = new CustomerDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        // Reload from DB for fresh data
        User freshUser = userDAO.findById(user.getUserId());
        
        if (freshUser != null) {
            session.setAttribute("user", freshUser);
            request.setAttribute("profileUser", freshUser);
        } else {
            request.setAttribute("profileUser", user);
        }
        
        // Load customer data if user is a customer (for additional info if needed)
        if ("CUSTOMER".equalsIgnoreCase(user.getRoleName())) {
            Customer customer = customerDAO.findById(user.getUserId());
            request.setAttribute("customer", customer);
        }
        
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String dobStr = request.getParameter("dateOfBirth");

        // Debug logging
        System.out.println("=== Profile Update Debug ===");
        System.out.println("Email: " + email);
        System.out.println("FullName: " + fullName);
        System.out.println("Phone: " + phone);
        System.out.println("Address: " + address);
        System.out.println("DOB: " + dobStr);
        System.out.println("User ID: " + user.getUserId());
        System.out.println("User Role: " + user.getRoleName());
        System.out.println("===========================");

        try {
            // Validate email
            if (email == null || email.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/profile?error=2"); // Email required
                return;
            }
            
            // Check if email is already taken by another user
            if (!email.trim().equalsIgnoreCase(user.getEmail())) {
                User existingUser = userDAO.findByEmail(email.trim());
                if (existingUser != null && existingUser.getUserId() != user.getUserId()) {
                    response.sendRedirect(request.getContextPath() + "/profile?error=3"); // Email already exists
                    return;
                }
            }
            
            // Update User info
            user.setEmail(email.trim());
            
            if (fullName != null && !fullName.trim().isEmpty()) {
                user.setFullName(fullName.trim());
            }
            if (phone != null && !phone.trim().isEmpty()) {
                user.setPhoneNumber(phone.trim());
            }
            if (address != null && !address.trim().isEmpty()) {
                user.setAddress(address.trim()); // Update address in Users table
            }
            
            if (dobStr != null && !dobStr.trim().isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    user.setDateOfBirth(sdf.parse(dobStr.trim()));
                } catch (Exception e) {
                    System.out.println("Error parsing date: " + e.getMessage());
                }
            }

            user.setUpdatedAt(new Date());
            boolean userUpdated = userDAO.update(user);
            
            System.out.println("User update result: " + userUpdated);

            // If user is a customer, also update Customer table (only Customer-specific fields)
            boolean customerUpdated = true;
            String roleName = user.getRoleName();
            System.out.println("User role: " + roleName);
            if ("CUSTOMER".equalsIgnoreCase(roleName) || "USER".equalsIgnoreCase(roleName)) {
                Customer customer = customerDAO.findById(user.getUserId());
                System.out.println("Found customer: " + (customer != null));
                
                if (customer == null) {
                    // Create new Customer record if not exists
                    System.out.println("Creating new Customer record for user ID: " + user.getUserId());
                    customer = new Customer();
                    customer.setCustomerId(user.getUserId());
                    customer.setAddress(address != null ? address.trim() : "");
                    customer.setStatus("active");
                    
                    if (dobStr != null && !dobStr.trim().isEmpty()) {
                        try {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            customer.setDateOfBirth(sdf.parse(dobStr.trim()));
                        } catch (Exception e) {
                            System.out.println("Error parsing date: " + e.getMessage());
                        }
                    }
                    
                    customerUpdated = customerDAO.create(customer);
                    System.out.println("Customer create result: " + customerUpdated);
                } else {
                    System.out.println("Current customer address: " + customer.getAddress());
                    boolean changed = false;
                    
                    // Update address (Customer table field)
                    if (address != null && !address.trim().isEmpty()) {
                        System.out.println("Updating customer address to: " + address.trim());
                        customer.setAddress(address.trim());
                        changed = true;
                    }
                    
                    // Update date of birth (Customer table field)
                    if (dobStr != null && !dobStr.trim().isEmpty()) {
                        try {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            customer.setDateOfBirth(sdf.parse(dobStr.trim()));
                            changed = true;
                        } catch (Exception e) {
                            System.out.println("Error parsing customer date: " + e.getMessage());
                        }
                    }
                    
                    if (changed) {
                        customerUpdated = customerDAO.update(customer);
                        System.out.println("Customer update result: " + customerUpdated);
                        System.out.println("Updated customer address: " + customer.getAddress());
                    } else {
                        System.out.println("No changes to customer, skipping update");
                    }
                }
            }

            if (userUpdated && customerUpdated) {
                // Reload user session
                User freshUser = userDAO.findById(user.getUserId());
                if (freshUser != null) {
                    session.setAttribute("user", freshUser);
                }
                response.sendRedirect(request.getContextPath() + "/profile?success=1");
            } else {
                System.out.println("Update failed - User: " + userUpdated + ", Customer: " + customerUpdated);
                response.sendRedirect(request.getContextPath() + "/profile?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Exception during update: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/profile?error=1");
        }
    }
}
