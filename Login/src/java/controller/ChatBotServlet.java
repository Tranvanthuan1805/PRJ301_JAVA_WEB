package controller;

import com.google.gson.Gson;
import dao.OrderDAO;
import dao.TourDAO;
import model.ChatMessage;
import model.Order;
import model.Tour;
import model.User;
import service.GrokApiService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/chatbot")
public class ChatBotServlet extends HttpServlet {

    private final TourDAO tourDAO = new TourDAO();
    private final OrderDAO orderDAO = new OrderDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("getTours".equals(action)) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            List<Tour> tours = tourDAO.getAllActiveTours();
            response.getWriter().print(gson.toJson(tours));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String message = request.getParameter("message");
        String action = request.getParameter("action");

        // Handle Clear Chat
        if ("clear".equals(action)) {
            session.removeAttribute("chatHistory");
            out.print("{\"success\": true}");
            return;
        }

        // Handle Booking from Form
        if ("bookTour".equals(action)) {
            try {
                int tourId = Integer.parseInt(request.getParameter("tourId"));
                int numPeople = Integer.parseInt(request.getParameter("numPeople"));
                String fullName = request.getParameter("fullName");
                String phone = request.getParameter("phone");

                Tour tour = tourDAO.getTourById(tourId);
                if (tour == null) {
                    out.print("{\"success\": false, \"error\": \"Tour không tồn tại\"}");
                    return;
                }

                if (user == null) {
                    out.print("{\"success\": false, \"error\": \"Bạn cần đăng nhập để đặt tour\"}");
                    return;
                }

                Order order = new Order();
                order.setUserId(user.getUserId());
                order.setTourId(tourId);
                order.setNumberOfPeople(numPeople);
                order.setTotalPrice(tour.getPrice() * numPeople);
                order.setStatus("Pending");
                order.setPaymentStatus("Unpaid");

                if (orderDAO.insertOrder(order)) {
                    String redirectUrl = request.getContextPath() + "/payment?orderId=" + order.getOrderId();
                    Map<String, Object> res = new HashMap<>();
                    res.put("success", true);
                    res.put("redirect", redirectUrl);
                    res.put("reply", "Tuyệt vời! Đơn hàng của bạn đã được tạo cho tour: " + tour.getTourName());
                    out.print(gson.toJson(res));
                } else {
                    out.print("{\"success\": false, \"error\": \"Không thể tạo đơn hàng\"}");
                }
            } catch (Exception e) {
                out.print("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
            }
            return;
        }

        if (message == null || message.trim().isEmpty()) {
            out.print("{\"success\": false, \"error\": \"No message\"}");
            return;
        }

        // Chat Logic with AI
        List<ChatMessage> history = (List<ChatMessage>) session.getAttribute("chatHistory");
        if (history == null) history = new ArrayList<>();

        try {
            // Cung cấp thông tin tour để AI tư vấn
            List<Tour> activeTours = tourDAO.getAllActiveTours();
            StringBuilder tourInfo = new StringBuilder("\nDANH SÁCH TOUR (ID - Tên - Giá): ");
            for(Tour t : activeTours) {
                tourInfo.append(t.getTourId()).append(": ").append(t.getTourName())
                        .append(" (").append(t.getPrice()).append("đ); ");
            }

            String aiReply = GrokApiService.chat(history, message + tourInfo.toString());
            String redirectUrl = null;
            boolean showForm = false;

            // Kiểm tra intent đặt tour của User (hoặc AI chủ động mời đặt)
            if (aiReply.contains("[[SHOW_BOOKING_FORM]]")) {
                showForm = true;
                aiReply = aiReply.replace("[[SHOW_BOOKING_FORM]]", "").trim();
            }

            history.add(new ChatMessage(history.size(), "user", message));
            history.add(new ChatMessage(history.size(), "assistant", aiReply));
            session.setAttribute("chatHistory", history);

            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("reply", aiReply);
            result.put("showForm", showForm);
            result.put("botTime", "Bây giờ");

            out.print(gson.toJson(result));

        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> err = new HashMap<>();
            err.put("success", false);
            err.put("error", e.getMessage());
            out.print(gson.toJson(err));
        }
    }
}
