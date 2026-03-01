package com.dananghub.controller;

import com.dananghub.dao.OrderDAO;
import com.dananghub.dto.OrderDetailDTO;
import com.dananghub.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/history")
public class HistoryServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

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
            List<OrderDetailDTO> allOrders = orderDAO.getOrderDetailsByCustomer(user.getUserId());

            long totalOrders = allOrders.size();
            long completedCount = allOrders.stream().filter(o -> "Completed".equals(o.getStatus())).count();
            long cancelledCount = allOrders.stream().filter(o -> "Cancelled".equals(o.getStatus())).count();
            double totalSpent = allOrders.stream()
                    .filter(o -> "Completed".equals(o.getStatus()))
                    .mapToDouble(OrderDetailDTO::getTotalAmount)
                    .sum();

            request.setAttribute("bookingList", allOrders);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("completedCount", completedCount);
            request.setAttribute("cancelledCount", cancelledCount);
            request.setAttribute("totalSpent", totalSpent);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi tải lịch sử: " + e.getMessage());
        }

        request.getRequestDispatcher("/history.jsp").forward(request, response);
    }
}
