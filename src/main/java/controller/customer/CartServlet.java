package controller.customer;

import java.io.IOException;
import java.sql.Timestamp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.CartItem;
import model.Tour;
import dao.TourDAO;

@WebServlet("/customer/cart")
public class CartServlet extends HttpServlet {
    private TourDAO tourDAO = new TourDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "view";
        
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart_obj");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart_obj", cart);
        }

        if (action.equals("add")) {
            try {
                int tourId = Integer.parseInt(request.getParameter("id"));
                int quantity = Integer.parseInt(request.getParameter("quantity") != null ? request.getParameter("quantity") : "1");
                String dateStr = request.getParameter("travelDate");
                
                Tour tour = tourDAO.getTourById(tourId);
                if (tour != null && dateStr != null) {
                    Timestamp travelDate = Timestamp.valueOf(dateStr + " 00:00:00");
                    
                    // Real-time slot validation
                    if (tourDAO.checkAvailability(tourId, travelDate, quantity)) {
                        cart.addItem(new CartItem(tour, quantity, travelDate));
                        session.setAttribute("cart_count", cart.getItemCount());
                    } else {
                        request.setAttribute("error", "Sorry, this tour is fully booked for the selected date.");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() + "/customer/cart?action=view");
            return;
        } else if (action.equals("remove")) {
            int tourId = Integer.parseInt(request.getParameter("id"));
            String date = request.getParameter("date");
            cart.removeItem(tourId, date);
            session.setAttribute("cart_count", cart.getItemCount());
        }

        request.setAttribute("activePage", "cart");
        request.getRequestDispatcher("/customer/cart.jsp").forward(request, response);
    }
}
