package servlet;

import dao.SupplierDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Supplier;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

/**
 * Servlet để xử lý Dashboard và cung cấp dữ liệu thống kê
 */
@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard", "/"})
public class DashboardServlet extends HttpServlet {
    
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
            // Lấy dữ liệu thống kê
            loadDashboardStats(request);
            
            // Lấy danh sách nhà cung cấp gần đây
            loadRecentSuppliers(request);
            
            // Lấy top 3 nhà cung cấp vận chuyển giá rẻ nhất
            loadTopCheapestTransport(request);
            
            // Forward đến trang index.jsp
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            // Nếu có lỗi, vẫn forward với dữ liệu mặc định
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
    
    /**
     * Tải dữ liệu thống kê cho dashboard
     */
    private void loadDashboardStats(HttpServletRequest request) {
        try {
            // Tổng số nhà cung cấp
            List<Supplier> allSuppliers = supplierDAO.selectAllSuppliers();
            request.setAttribute("totalSuppliers", allSuppliers.size());
            
            // Số nhà cung cấp đang hoạt động
            long activeCount = allSuppliers.stream()
                .filter(s -> "Đang hợp tác".equals(s.getStatus()))
                .count();
            request.setAttribute("activeSuppliers", activeCount);
            
            // Giá vận chuyển rẻ nhất
            BigDecimal cheapestPrice = allSuppliers.stream()
                .filter(s -> "Vận chuyển".equals(s.getServiceType()))
                .map(Supplier::getBasePrice)
                .filter(price -> price != null)
                .min(BigDecimal::compareTo)
                .orElse(new BigDecimal("2200000"));
            request.setAttribute("cheapestTransportPrice", cheapestPrice);
            
            // Số nhà cung cấp mới thêm trong tháng (giả lập)
            request.setAttribute("newSuppliersThisMonth", 3);
            
            // Các thống kê khác
            request.setAttribute("serviceTypeCount", 5);
            request.setAttribute("avgPrice", "2.8M");
            request.setAttribute("contractsExpiring", 2);
            request.setAttribute("totalRatings", "4.2");
            
        } catch (Exception e) {
            e.printStackTrace();
            // Set default values nếu có lỗi
            request.setAttribute("totalSuppliers", 24);
            request.setAttribute("activeSuppliers", 18);
            request.setAttribute("cheapestTransportPrice", new BigDecimal("2200000"));
            request.setAttribute("newSuppliersThisMonth", 3);
        }
    }
    
    /**
     * Tải danh sách nhà cung cấp gần đây
     */
    private void loadRecentSuppliers(HttpServletRequest request) {
        try {
            List<Supplier> recentSuppliers = supplierDAO.selectAllSuppliers();
            // Giới hạn 5 nhà cung cấp gần nhất
            if (recentSuppliers.size() > 5) {
                recentSuppliers = recentSuppliers.subList(0, 5);
            }
            request.setAttribute("recentSuppliers", recentSuppliers);
        } catch (Exception e) {
            e.printStackTrace();
            // Không set attribute nếu có lỗi, JSP sẽ hiển thị dữ liệu mẫu
        }
    }
    
    /**
     * Tải top 3 nhà cung cấp vận chuyển giá rẻ nhất
     */
    private void loadTopCheapestTransport(HttpServletRequest request) {
        try {
            List<Supplier> allSuppliers = supplierDAO.selectAllSuppliers();
            List<Supplier> topCheapest = allSuppliers.stream()
                .filter(s -> "Vận chuyển".equals(s.getServiceType()))
                .filter(s -> s.getBasePrice() != null)
                .sorted((s1, s2) -> s1.getBasePrice().compareTo(s2.getBasePrice()))
                .limit(3)
                .collect(java.util.stream.Collectors.toList());
            
            request.setAttribute("topCheapestTransport", topCheapest);
        } catch (Exception e) {
            e.printStackTrace();
            // Không set attribute nếu có lỗi, JSP sẽ hiển thị dữ liệu mẫu
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}