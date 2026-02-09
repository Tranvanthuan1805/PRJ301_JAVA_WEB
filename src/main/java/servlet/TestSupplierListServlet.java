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
 * Test servlet để debug supplier list display
 */
@WebServlet(name = "TestSupplierListServlet", urlPatterns = {"/test-supplier-list"})
public class TestSupplierListServlet extends HttpServlet {
    
    private SupplierDAO supplierDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        supplierDAO = new SupplierDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            System.out.println("DEBUG: Testing supplier list display");
            
            // Load all suppliers
            List<Supplier> suppliers = supplierDAO.selectAllSuppliers();
            
            if (suppliers != null) {
                System.out.println("DEBUG: Loaded " + suppliers.size() + " suppliers for list test");
                
                // Log first few suppliers for debugging
                for (int i = 0; i < Math.min(3, suppliers.size()); i++) {
                    Supplier s = suppliers.get(i);
                    System.out.println("DEBUG: Supplier " + (i+1) + ": " + s.getSupplierName() + 
                                     " | Service Type: '" + s.getServiceType() + "'" +
                                     " | Status: '" + s.getStatus() + "'" +
                                     " | Price: " + s.getBasePrice());
                }
                
                request.setAttribute("suppliers", suppliers);
            } else {
                System.out.println("DEBUG: No suppliers loaded - suppliers list is null");
                request.setAttribute("error", "Không thể load danh sách nhà cung cấp");
            }
            
        } catch (Exception e) {
            System.err.println("ERROR in TestSupplierListServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/test-supplier-list.jsp").forward(request, response);
    }
}