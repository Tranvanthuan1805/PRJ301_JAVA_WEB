package controller.admin;

import dao.CustomerDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Customer;

@WebServlet("/admin/customers")
public class CustomerServlet extends HttpServlet {
    private CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                listCustomers(request, response);
                break;
            case "view":
                viewCustomerDetail(request, response);
                break;
            default:
                listCustomers(request, response);
        }
    }

    private void listCustomers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Customer> customers = customerDAO.getAllCustomers();
        request.setAttribute("customers", customers);
        request.setAttribute("activePage", "users");
        request.getRequestDispatcher("/admin/customer-list.jsp").forward(request, response);
    }

    private void viewCustomerDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Customer customer = customerDAO.getCustomerDetail(id);
        
        if (customer != null) {
            request.setAttribute("customer", customer);
            // Optionally fetch recent orders/bookings here if needed
            request.setAttribute("activePage", "users");
            request.getRequestDispatcher("/admin/customer-detail.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/customers");
        }
    }
}
