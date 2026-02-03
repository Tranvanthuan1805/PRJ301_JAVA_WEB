package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.Tour;
import dao.TourDAO;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "view";
        
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        if (action.equals("add")) {
            int tourId = Integer.parseInt(request.getParameter("id"));
            TourDAO dao = new TourDAO();
            Tour tour = dao.getTourById(tourId);
            if (tour != null) {
                boolean exists = false;
                for (CartItem item : cart) {
                    if (item.getTour().getTourId() == tourId) {
                        item.setQuantity(item.getQuantity() + 1);
                        exists = true;
                        break;
                    }
                }
                if (!exists) {
                    cart.add(new CartItem(tour, 1));
                }
            }
            response.sendRedirect("cart?action=view"); // Redirect to avoid resubmit
            return;
        } else if (action.equals("remove")) {
            int tourId = Integer.parseInt(request.getParameter("id"));
            cart.removeIf(item -> item.getTour().getTourId() == tourId);
        }

        // Calculate total
        double total = 0;
        for (CartItem item : cart) total += item.getTotalPrice();
        request.setAttribute("cartTotal", total);

        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
}
