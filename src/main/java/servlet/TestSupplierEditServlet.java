package servlet;

import dao.SupplierDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Supplier;

import java.io.IOException;
import java.util.List;

/**
 * Test servlet để debug supplier edit functionality
 */
@WebServlet(name = "TestSupplierEditServlet", urlPatterns = {"/test-supplier-edit"})
public class TestSupplierEditServlet extends HttpServlet {
    
    private SupplierDAO supplierDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        supplierDAO = new SupplierDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                System.out.println("DEBUG: Testing supplier edit with ID: " + id);
                
                // Load supplier data
                Supplier supplier = supplierDAO.selectSupplier(id);
                
                if (supplier != null) {
                    System.out.println("DEBUG: Found supplier for edit: " + supplier.getSupplierName());
                    request.setAttribute("supplier", supplier);
                    
                    // Load dropdown data
                    List<String> serviceTypes = supplierDAO.getServiceTypes();
                    List<String> statuses = supplierDAO.getCooperationStatuses();
                    
                    System.out.println("DEBUG: Loaded " + serviceTypes.size() + " service types");
                    System.out.println("DEBUG: Loaded " + statuses.size() + " statuses");
                    
                    request.setAttribute("serviceTypes", serviceTypes);
                    request.setAttribute("statuses", statuses);
                } else {
                    System.out.println("DEBUG: No supplier found with ID: " + id);
                    request.setAttribute("error", "Không tìm thấy nhà cung cấp với ID: " + id);
                }
                
            } catch (NumberFormatException e) {
                System.err.println("ERROR: Invalid ID format: " + idParam);
                request.setAttribute("error", "ID không hợp lệ: " + idParam);
            } catch (Exception e) {
                System.err.println("ERROR: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("error", "Lỗi: " + e.getMessage());
            }
        } else {
            // Default to ID 1 for testing
            try {
                Supplier supplier = supplierDAO.selectSupplier(1);
                if (supplier != null) {
                    request.setAttribute("supplier", supplier);
                    
                    // Load dropdown data
                    List<String> serviceTypes = supplierDAO.getServiceTypes();
                    List<String> statuses = supplierDAO.getCooperationStatuses();
                    
                    request.setAttribute("serviceTypes", serviceTypes);
                    request.setAttribute("statuses", statuses);
                } else {
                    request.setAttribute("error", "Không tìm thấy supplier với ID 1");
                }
            } catch (Exception e) {
                request.setAttribute("error", "Lỗi khi load supplier mặc định: " + e.getMessage());
            }
        }
        
        request.getRequestDispatcher("/test-supplier-edit.jsp").forward(request, response);
    }
}