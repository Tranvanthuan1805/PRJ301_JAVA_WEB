package controller.admin;

import dao.TourDAO;
import dao.ProviderDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Tour;
import model.Provider;

@WebServlet("/admin/tours")
public class TourAdminServlet extends HttpServlet {
    private TourDAO tourDAO = new TourDAO();
    private ProviderDAO providerDAO = new ProviderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                listTours(request, response);
                break;
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteTour(request, response);
                break;
            default:
                listTours(request, response);
        }
    }

    private void listTours(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Tour> tours = tourDAO.getAllTours();
        request.setAttribute("tours", tours);
        request.setAttribute("activePage", "tours");
        request.getRequestDispatcher("/admin/tour-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Provider> providers = providerDAO.getAllProviders();
        request.setAttribute("providers", providers);
        request.setAttribute("activePage", "tours");
        request.getRequestDispatcher("/admin/tour-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Tour existingTour = tourDAO.getTourById(id);
        request.setAttribute("tour", existingTour);
        request.setAttribute("providers", providerDAO.getAllProviders());
        request.setAttribute("activePage", "tours");
        request.getRequestDispatcher("/admin/tour-form.jsp").forward(request, response);
    }

    private void deleteTour(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        tourDAO.deleteTour(id);
        response.sendRedirect("tours");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Logic for create/update using form parameters
        // ... abbreviated for brevity, uses tourDAO.createTour or updateTour
        response.sendRedirect("tours");
    }
}
