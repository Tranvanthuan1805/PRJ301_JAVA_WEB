package controller.payment;

import dao.OrderDAO;
import model.Order;
import model.OrderDetailDTO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/payment")
public class TourPaymentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String orderIdStr = request.getParameter("orderId");
        if (orderIdStr == null || orderIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/my-orders");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);
            OrderDAO orderDAO = new OrderDAO();
            OrderDetailDTO orderDetail = orderDAO.getOrderDetailById(orderId);

            if (orderDetail == null || orderDetail.getUserId() != user.getUserId()) {
                response.sendRedirect(request.getContextPath() + "/my-orders");
                return;
            }

            // Cau hinh SePay/VietQR
            String bankAcc = "2806281106"; // MB Bank (vi du)
            String bankName = "MB";
            
            // Noi dung chuyen khoan duy nhat: TOUR_<ID>_<TIMESTAMP>
            String transCode = "TOUR" + orderId + "U" + user.getUserId();
            long amount = (long) orderDetail.getTotalPrice();

            // Link QR SePay VietQR
            String qrUrl = String.format("https://qr.sepay.vn/img?acc=%s&bank=%s&amount=%d&des=%s",
                    bankAcc, bankName, amount, transCode);

            request.setAttribute("qrUrl", qrUrl);
            request.setAttribute("order", orderDetail);
            request.setAttribute("transCode", transCode);
            request.setAttribute("amount", amount);

            request.getRequestDispatcher("/payment-qr.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/my-orders");
        }
    }
}
