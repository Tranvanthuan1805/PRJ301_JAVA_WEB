package controller;

import model.entity.dao.ProviderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.entity.Provider;

@WebServlet("/admin/providers")
public class ProviderServlet extends HttpServlet {
    private ProviderDAO providerDAO = new ProviderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                listProviders(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "comparison":
                showComparison(request, response);
                break;
            default:
                listProviders(request, response);
        }
    }

    private void listProviders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Provider> providers = providerDAO.getAllProviders();
        request.setAttribute("providers", providers);
        request.setAttribute("activePage", "providers");
        request.getRequestDispatcher("/views/provider-management/provider-list.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Provider provider = providerDAO.getProviderById(id);
        request.setAttribute("provider", provider);
        request.getRequestDispatcher("/admin/provider-form.jsp").forward(request, response);
    }

    private void showComparison(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Prepare mock dynamic data for price comparison
        request.setAttribute("activePage", "comparison");
        request.getRequestDispatcher("/views/provider-management/price-comparison.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Logic for creating/updating providers

        // ... update logic
        response.sendRedirect(request.getContextPath() + "/admin/providers");
    }
}
