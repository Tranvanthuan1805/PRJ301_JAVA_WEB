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

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private final CustomerDAO customerDAO = new CustomerDAO();
    private final ActivityDAO activityDAO = new ActivityDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {
            Customer customer = customerDAO.findById(user.getUserId());

            if (customer == null) {
                request.setAttribute("error", "Không tìm thấy thông tin khách hàng cho tài khoản: " + user.getUsername());
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            List<CustomerActivity> activities = activityDAO.findActivitiesByCustomer(customer.getCustomerId(), 20);
            long totalActivities = activityDAO.countActivities(customer.getCustomerId());
            long bookingCount = activityDAO.countActivitiesByType(customer.getCustomerId(), "BOOKING");
            long searchCount = activityDAO.countActivitiesByType(customer.getCustomerId(), "SEARCH");

            request.setAttribute("customer", customer);
            request.setAttribute("activities", activities);
            request.setAttribute("totalActivities", totalActivities);
            request.setAttribute("bookingCount", bookingCount);
            request.setAttribute("searchCount", searchCount);

            request.getRequestDispatcher("/profile.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {
            Customer customer = customerDAO.findById(user.getUserId());
            if (customer == null) {
                response.sendRedirect(request.getContextPath() + "/profile?error=notfound");
                return;
            }

            boolean updated = customerDAO.update(customer);

            if (updated) {
                try {
                    CustomerActivity activity = new CustomerActivity(
                        customer.getCustomerId(), "UPDATE_PROFILE", "Cập nhật thông tin cá nhân");
                    activityDAO.logActivity(activity);
                } catch (Exception activityError) {
                    System.out.println("Activity logging failed: " + activityError.getMessage());
                }
                response.sendRedirect(request.getContextPath() + "/profile?success=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/profile?error=updatefailed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/profile?error=exception");
        }
    }
}
