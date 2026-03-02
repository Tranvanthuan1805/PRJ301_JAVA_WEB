package controller;

import dao.OrderDAO;
import model.CartItem;
import model.Order;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/order")
public class CheckoutServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/explore");
            return;
        }

        OrderDAO orderDAO = new OrderDAO();
        Order lastCreatedOrder = null;

        // Tao don hang cho moi item trong gio (hoac gom chung neu muon)
        // O day toi se tao moi item la 1 dong trong bang Orders nhu DB hien tai yeu cau
        for (CartItem item : cart) {
            Order order = new Order();
            order.setUserId(user.getUserId());
            order.setTourId(item.getTour().getTourId());
            order.setNumberOfPeople(item.getQuantity());
            order.setTotalPrice(item.getSubTotal());
            order.setStatus("Pending");
            order.setPaymentStatus("Unpaid");
            
            if (orderDAO.insertOrder(order)) {
                lastCreatedOrder = order;
            }
        }

        // Xoa gio hang sau khi dat
        session.removeAttribute("cart");

        // Neu chi co 1 don, hien thi QR cho don do. 
        // Neu nhieu don, tam thoi lay don cuoi cung de test payment
        if (lastCreatedOrder != null) {
            response.sendRedirect(request.getContextPath() + "/payment?orderId=" + lastCreatedOrder.getOrderId());
        } else {
            response.sendRedirect(request.getContextPath() + "/my-orders");
        }
    }
}
