package servlet;

import dao.SupplierDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.HotelComparison;
import model.PriceHistory;
import model.Supplier;
import model.TourComparison;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet xử lý các thao tác CRUD cho Supplier
 */
@WebServlet(name = "SupplierServlet", urlPatterns = {"/supplier"})
public class SupplierServlet extends HttpServlet {
    
    private SupplierDAO supplierDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        supplierDAO = new SupplierDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        try {
            switch (action) {
                case "list":
                    listSuppliers(request, response);
                    break;
                case "add":
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "view":
                    viewSupplier(request, response);
                    break;
                case "delete":
                    deleteSupplier(request, response);
                    break;
                case "search":
                    searchSuppliers(request, response);
                    break;
                case "compare":
                    compareSuppliers(request, response);
                    break;
                case "priceHistory":
                    showPriceHistory(request, response);
                    break;
                case "compareHotels":
                    compareHotels(request, response);
                    break;
                case "compareTours":
                    compareTours(request, response);
                    break;
                default:
                    listSuppliers(request, response);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi database: " + e.getMessage());
            request.getRequestDispatcher("/supplier/list.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "save":
                case "insert":
                    insertSupplier(request, response);
                    break;
                case "update":
                    updateSupplier(request, response);
                    break;
                default:
                    listSuppliers(request, response);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi database: " + e.getMessage());
            request.getRequestDispatcher("/supplier/list.jsp").forward(request, response);
        }
    }
    
    /**
     * Hiển thị danh sách tất cả nhà cung cấp
     */
    private void listSuppliers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            List<Supplier> suppliers = supplierDAO.selectAllSuppliers();
            System.out.println("DEBUG: Retrieved " + (suppliers != null ? suppliers.size() : "null") + " suppliers from database");
            
            if (suppliers != null && suppliers.size() > 0) {
                System.out.println("DEBUG: First supplier: " + suppliers.get(0).getSupplierName());
            }
            
            request.setAttribute("suppliers", suppliers);
            request.getRequestDispatcher("/supplier/list.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("ERROR in listSuppliers: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải danh sách nhà cung cấp: " + e.getMessage());
            request.getRequestDispatcher("/supplier/list.jsp").forward(request, response);
        }
    }
    
    /**
     * Hiển thị form thêm nhà cung cấp
     */
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/supplier/add.jsp").forward(request, response);
    }
    
    /**
     * Hiển thị form chỉnh sửa nhà cung cấp
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                request.setAttribute("error", "ID nhà cung cấp không hợp lệ");
                request.getRequestDispatcher("/supplier/list.jsp").forward(request, response);
                return;
            }
            
            int id = Integer.parseInt(idParam);
            System.out.println("DEBUG: Loading edit form for supplier ID: " + id);
            
            Supplier supplier = supplierDAO.selectSupplier(id);
            
            if (supplier == null) {
                System.out.println("DEBUG: No supplier found with ID: " + id);
                request.setAttribute("error", "Không tìm thấy nhà cung cấp với ID: " + id);
                request.getRequestDispatcher("/supplier/list.jsp").forward(request, response);
                return;
            }
            
            System.out.println("DEBUG: Found supplier for edit: " + supplier.getSupplierName() + 
                             " (" + supplier.getServiceType() + ") - " + supplier.getStatus());
            
            // Load dropdown data
            List<String> serviceTypes = supplierDAO.getServiceTypes();
            List<String> statuses = supplierDAO.getCooperationStatuses();
            
            System.out.println("DEBUG: Loaded " + serviceTypes.size() + " service types and " + 
                             statuses.size() + " statuses for dropdowns");
            
            request.setAttribute("supplier", supplier);
            request.setAttribute("serviceTypes", serviceTypes);
            request.setAttribute("statuses", statuses);
            request.getRequestDispatcher("/supplier/edit.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            System.err.println("ERROR: Invalid supplier ID format: " + request.getParameter("id"));
            request.setAttribute("error", "ID nhà cung cấp không hợp lệ");
            request.getRequestDispatcher("/supplier/list.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("ERROR in showEditForm: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải form chỉnh sửa: " + e.getMessage());
            request.getRequestDispatcher("/supplier/list.jsp").forward(request, response);
        }
    }
    
    /**
     * Xem chi tiết nhà cung cấp
     */
    private void viewSupplier(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                request.setAttribute("error", "ID nhà cung cấp không hợp lệ");
                request.getRequestDispatcher("/supplier/list.jsp").forward(request, response);
                return;
            }
            
            int id = Integer.parseInt(idParam);
            System.out.println("DEBUG: Viewing supplier with ID: " + id);
            
            Supplier supplier = supplierDAO.selectSupplier(id);
            
            if (supplier == null) {
                System.out.println("DEBUG: No supplier found with ID: " + id);
                request.setAttribute("error", "Không tìm thấy nhà cung cấp với ID: " + id);
                request.getRequestDispatcher("/supplier/list.jsp").forward(request, response);
                return;
            }
            
            System.out.println("DEBUG: Found supplier: " + supplier.getSupplierName() + 
                             " (" + supplier.getServiceType() + ") - " + supplier.getStatus());
            
            request.setAttribute("supplier", supplier);
            request.getRequestDispatcher("/supplier/view.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            System.err.println("ERROR: Invalid supplier ID format: " + request.getParameter("id"));
            request.setAttribute("error", "ID nhà cung cấp không hợp lệ");
            request.getRequestDispatcher("/supplier/list.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("ERROR in viewSupplier: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải thông tin nhà cung cấp: " + e.getMessage());
            request.getRequestDispatcher("/supplier/list.jsp").forward(request, response);
        }
    }
    
    /**
     * Thêm nhà cung cấp mới
     */
    private void insertSupplier(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        // Get form parameters matching the add.jsp form fields
        String supplierCode = request.getParameter("supplierCode");
        String supplierName = request.getParameter("supplierName");
        String description = request.getParameter("description");
        String contactPerson = request.getParameter("contactPerson");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String province = request.getParameter("province");
        String country = request.getParameter("country");
        String serviceTypeID = request.getParameter("serviceTypeID");
        String statusID = request.getParameter("statusID");
        String basePriceStr = request.getParameter("basePrice");
        String contractStartDate = request.getParameter("contractStartDate");
        String contractEndDate = request.getParameter("contractEndDate");
        String notes = request.getParameter("notes");
        
        // Convert price
        BigDecimal basePrice = null;
        if (basePriceStr != null && !basePriceStr.trim().isEmpty()) {
            try {
                basePrice = new BigDecimal(basePriceStr);
            } catch (NumberFormatException e) {
                basePrice = BigDecimal.ZERO;
            }
        }
        
        // Create supplier object with the new constructor
        Supplier supplier = new Supplier();
        supplier.setSupplierCode(supplierCode);
        supplier.setSupplierName(supplierName);
        supplier.setDescription(description);
        supplier.setContactPerson(contactPerson);
        supplier.setPhoneNumber(phoneNumber);
        supplier.setEmail(email);
        supplier.setAddress(address);
        supplier.setCity(city);
        supplier.setProvince(province);
        supplier.setCountry(country);
        supplier.setBasePrice(basePrice);
        supplier.setNotes(notes);
        
        // Set service type and status (convert to appropriate format)
        if (serviceTypeID != null && !serviceTypeID.isEmpty()) {
            // Map serviceTypeID to service type name - Updated for new database
            switch (serviceTypeID) {
                case "1": supplier.setServiceType("Khách sạn"); break;
                case "2": supplier.setServiceType("Nhà hàng"); break;
                case "3": supplier.setServiceType("Vận chuyển"); break;
                case "4": supplier.setServiceType("Hướng dẫn viên"); break;
                case "5": supplier.setServiceType("Vé tham quan"); break;
                case "6": supplier.setServiceType("Bảo hiểm"); break;
                case "7": supplier.setServiceType("Spa & Wellness"); break;
                case "8": supplier.setServiceType("Thuê xe"); break;
                default: supplier.setServiceType("Khác"); break;
            }
        }
        
        if (statusID != null && !statusID.isEmpty()) {
            // Map statusID to status name
            switch (statusID) {
                case "1": supplier.setStatus("Đang hợp tác"); break;
                case "2": supplier.setStatus("Tạm dừng"); break;
                case "3": supplier.setStatus("Ngừng hợp tác"); break;
                default: supplier.setStatus("Chưa xác định"); break;
            }
        }
        
        try {
            supplierDAO.insertSupplier(supplier);
            request.getSession().setAttribute("message", "Thêm nhà cung cấp thành công!");
            request.getSession().setAttribute("messageType", "success");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Lỗi khi thêm nhà cung cấp: " + e.getMessage());
            request.getSession().setAttribute("messageType", "error");
        }
        
        response.sendRedirect(request.getContextPath() + "/supplier?action=list");
    }
    
    /**
     * Cập nhật thông tin nhà cung cấp
     */
    private void updateSupplier(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        try {
            // Get form parameters
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                request.setAttribute("error", "ID nhà cung cấp không hợp lệ");
                request.getRequestDispatcher("/supplier/list.jsp").forward(request, response);
                return;
            }
            
            int id = Integer.parseInt(idParam);
            String supplierCode = request.getParameter("supplierCode");
            String supplierName = request.getParameter("supplierName");
            String description = request.getParameter("description");
            String contactPerson = request.getParameter("contactPerson");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String province = request.getParameter("province");
            String country = request.getParameter("country");
            String serviceType = request.getParameter("serviceType");
            String status = request.getParameter("status");
            String basePriceStr = request.getParameter("basePrice");
            String notes = request.getParameter("notes");
            
            // Convert price
            BigDecimal basePrice = null;
            if (basePriceStr != null && !basePriceStr.trim().isEmpty()) {
                try {
                    basePrice = new BigDecimal(basePriceStr);
                } catch (NumberFormatException e) {
                    basePrice = BigDecimal.ZERO;
                }
            }
            
            // Create updated supplier object
            Supplier supplier = new Supplier();
            supplier.setSupplierID(id);
            supplier.setSupplierCode(supplierCode);
            supplier.setSupplierName(supplierName);
            supplier.setDescription(description);
            supplier.setContactPerson(contactPerson);
            supplier.setPhoneNumber(phoneNumber);
            supplier.setEmail(email);
            supplier.setAddress(address);
            supplier.setCity(city);
            supplier.setProvince(province);
            supplier.setCountry(country);
            supplier.setServiceType(serviceType);
            supplier.setStatus(status);
            supplier.setBasePrice(basePrice);
            supplier.setNotes(notes);
            
            System.out.println("DEBUG: Updating supplier ID " + id + ": " + supplierName + 
                             " (" + serviceType + ") - " + status);
            
            boolean success = supplierDAO.updateSupplier(supplier);
            
            if (success) {
                request.getSession().setAttribute("message", "Cập nhật nhà cung cấp thành công!");
                request.getSession().setAttribute("messageType", "success");
                System.out.println("DEBUG: Successfully updated supplier ID " + id);
            } else {
                request.getSession().setAttribute("message", "Không thể cập nhật nhà cung cấp!");
                request.getSession().setAttribute("messageType", "error");
                System.out.println("DEBUG: Failed to update supplier ID " + id);
            }
            
            response.sendRedirect(request.getContextPath() + "/supplier?action=view&id=" + id);
            
        } catch (NumberFormatException e) {
            System.err.println("ERROR: Invalid supplier ID format: " + request.getParameter("id"));
            request.setAttribute("error", "ID nhà cung cấp không hợp lệ");
            request.getRequestDispatcher("/supplier/list.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("ERROR in updateSupplier: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("message", "Lỗi khi cập nhật nhà cung cấp: " + e.getMessage());
            request.getSession().setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/supplier?action=list");
        }
    }
    
    /**
     * Xóa nhà cung cấp
     */
    private void deleteSupplier(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                request.setAttribute("error", "ID nhà cung cấp không hợp lệ");
                request.getRequestDispatcher("/supplier/list.jsp").forward(request, response);
                return;
            }
            
            int id = Integer.parseInt(idParam);
            System.out.println("DEBUG: Attempting to delete supplier with ID: " + id);
            
            // First check if supplier exists
            Supplier supplier = supplierDAO.selectSupplier(id);
            if (supplier == null) {
                System.out.println("DEBUG: No supplier found with ID: " + id);
                request.getSession().setAttribute("message", "Không tìm thấy nhà cung cấp với ID: " + id);
                request.getSession().setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/supplier?action=list");
                return;
            }
            
            String supplierName = supplier.getSupplierName();
            System.out.println("DEBUG: Found supplier to delete: " + supplierName);
            
            boolean success = supplierDAO.deleteSupplier(id);
            
            if (success) {
                request.getSession().setAttribute("message", "Đã xóa nhà cung cấp '" + supplierName + "' thành công!");
                request.getSession().setAttribute("messageType", "success");
                System.out.println("DEBUG: Successfully deleted supplier: " + supplierName);
            } else {
                request.getSession().setAttribute("message", "Không thể xóa nhà cung cấp '" + supplierName + "'!");
                request.getSession().setAttribute("messageType", "error");
                System.out.println("DEBUG: Failed to delete supplier: " + supplierName);
            }
            
            response.sendRedirect(request.getContextPath() + "/supplier?action=list");
            
        } catch (NumberFormatException e) {
            System.err.println("ERROR: Invalid supplier ID format: " + request.getParameter("id"));
            request.getSession().setAttribute("message", "ID nhà cung cấp không hợp lệ");
            request.getSession().setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/supplier?action=list");
        } catch (Exception e) {
            System.err.println("ERROR in deleteSupplier: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("message", "Lỗi khi xóa nhà cung cấp: " + e.getMessage());
            request.getSession().setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/supplier?action=list");
        }
    }
    
    /**
     * Tìm kiếm nhà cung cấp
     */
    private void searchSuppliers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        List<Supplier> allSuppliers = supplierDAO.selectAllSuppliers();
        
        // Lọc theo keyword (tìm kiếm đơn giản)
        List<Supplier> filteredSuppliers = allSuppliers.stream()
            .filter(s -> s.getSupplierName().toLowerCase().contains(keyword.toLowerCase()) ||
                        s.getPhoneNumber().contains(keyword) ||
                        s.getEmail().toLowerCase().contains(keyword.toLowerCase()))
            .collect(java.util.stream.Collectors.toList());
        
        request.setAttribute("suppliers", filteredSuppliers);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/supplier/list.jsp").forward(request, response);
    }
    
    /**
     * So sánh giá nhà cung cấp
     */
    private void compareSuppliers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Updated service type names to match database
            List<Supplier> transportSuppliers = supplierDAO.getSuppliersByServiceType("Vận chuyển");
            List<Supplier> hotelSuppliers = supplierDAO.getSuppliersByServiceType("Khách sạn");
            List<Supplier> restaurantSuppliers = supplierDAO.getSuppliersByServiceType("Nhà hàng");
            List<Supplier> guideSuppliers = supplierDAO.getSuppliersByServiceType("Hướng dẫn viên");
            List<Supplier> ticketSuppliers = supplierDAO.getSuppliersByServiceType("Vé tham quan");
            List<Supplier> insuranceSuppliers = supplierDAO.getSuppliersByServiceType("Bảo hiểm");
            
            request.setAttribute("transportSuppliers", transportSuppliers);
            request.setAttribute("hotelSuppliers", hotelSuppliers);
            request.setAttribute("restaurantSuppliers", restaurantSuppliers);
            request.setAttribute("guideSuppliers", guideSuppliers);
            request.setAttribute("ticketSuppliers", ticketSuppliers);
            request.setAttribute("insuranceSuppliers", insuranceSuppliers);
            
            // For backward compatibility
            request.setAttribute("accommodationSuppliers", hotelSuppliers);
            request.setAttribute("foodSuppliers", restaurantSuppliers);
            
            System.out.println("DEBUG: Compare suppliers - Transport: " + transportSuppliers.size() + 
                             ", Hotels: " + hotelSuppliers.size() + 
                             ", Restaurants: " + restaurantSuppliers.size());
            
        } catch (Exception e) {
            System.err.println("ERROR in compareSuppliers: " + e.getMessage());
            e.printStackTrace();
            // Set empty lists to avoid JSP errors
            request.setAttribute("transportSuppliers", new ArrayList<Supplier>());
            request.setAttribute("hotelSuppliers", new ArrayList<Supplier>());
            request.setAttribute("restaurantSuppliers", new ArrayList<Supplier>());
            request.setAttribute("accommodationSuppliers", new ArrayList<Supplier>());
            request.setAttribute("foodSuppliers", new ArrayList<Supplier>());
        }
        
        request.getRequestDispatcher("/supplier/compare-prices.jsp").forward(request, response);
    }
    
    /**
     * Hiển thị lịch sử giá của nhà cung cấp
     */
    private void showPriceHistory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                request.getSession().setAttribute("message", "ID nhà cung cấp không hợp lệ");
                request.getSession().setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/supplier?action=list");
                return;
            }
            
            int id = Integer.parseInt(idParam);
            
            Supplier supplier = supplierDAO.selectSupplier(id);
            if (supplier == null) {
                request.getSession().setAttribute("message", "Không tìm thấy nhà cung cấp với ID: " + id);
                request.getSession().setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/supplier?action=list");
                return;
            }
            
            String fromDateStr = request.getParameter("fromDate");
            String toDateStr = request.getParameter("toDate");
            
            LocalDate fromDate = null;
            LocalDate toDate = null;
            
            if (fromDateStr != null && !fromDateStr.isEmpty()) {
                fromDate = LocalDate.parse(fromDateStr);
            }
            if (toDateStr != null && !toDateStr.isEmpty()) {
                toDate = LocalDate.parse(toDateStr);
            }
            
            List<PriceHistory> priceHistory = supplierDAO.getPriceHistory(id, fromDate, toDate);
            
            request.setAttribute("supplier", supplier);
            request.setAttribute("priceHistory", priceHistory);
            request.getRequestDispatcher("/supplier/price-history.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            System.err.println("ERROR: Invalid supplier ID format: " + request.getParameter("id"));
            request.getSession().setAttribute("message", "ID nhà cung cấp không hợp lệ");
            request.getSession().setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/supplier?action=list");
        } catch (Exception e) {
            System.err.println("ERROR in showPriceHistory: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("message", "Lỗi khi tải lịch sử giá: " + e.getMessage());
            request.getSession().setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/supplier?action=list");
        }
    }
    
    /**
     * So sánh giá khách sạn
     */
    private void compareHotels(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Get filter parameters
            String minPriceStr = request.getParameter("minPrice");
            String maxPriceStr = request.getParameter("maxPrice");
            String orderBy = request.getParameter("orderBy");
            String hotelCategory = request.getParameter("hotelCategory");
            
            // Set default values
            BigDecimal minPrice = BigDecimal.ZERO;
            BigDecimal maxPrice = new BigDecimal("999999999");
            
            if (minPriceStr != null && !minPriceStr.isEmpty()) {
                try {
                    minPrice = new BigDecimal(minPriceStr);
                } catch (NumberFormatException e) {
                    minPrice = BigDecimal.ZERO;
                }
            }
            
            if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                try {
                    maxPrice = new BigDecimal(maxPriceStr);
                } catch (NumberFormatException e) {
                    maxPrice = new BigDecimal("999999999");
                }
            }
            
            if (orderBy == null || orderBy.isEmpty()) {
                orderBy = "Rating";
            }
            
            // Get hotel comparison data
            List<HotelComparison> hotelComparisons;
            if (hotelCategory != null && !hotelCategory.isEmpty() && !hotelCategory.equals("all")) {
                hotelComparisons = supplierDAO.getHotelComparison(hotelCategory);
            } else {
                hotelComparisons = supplierDAO.compareHotelsByPriceRange(minPrice, maxPrice, orderBy);
            }
            
            // Get hotel categories for filter dropdown
            List<String> hotelCategories = supplierDAO.getHotelCategories();
            
            request.setAttribute("hotelComparisons", hotelComparisons);
            request.setAttribute("hotelCategories", hotelCategories);
            request.setAttribute("selectedCategory", hotelCategory);
            request.setAttribute("minPrice", minPriceStr);
            request.setAttribute("maxPrice", maxPriceStr);
            request.setAttribute("orderBy", orderBy);
            
            request.getRequestDispatcher("/supplier/compare-hotels.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("ERROR in compareHotels: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi so sánh khách sạn: " + e.getMessage());
            request.setAttribute("hotelComparisons", new ArrayList<HotelComparison>());
            request.setAttribute("hotelCategories", new ArrayList<String>());
            request.getRequestDispatcher("/supplier/compare-hotels.jsp").forward(request, response);
        }
    }
    
    /**
     * So sánh giá tour
     */
    private void compareTours(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Get filter parameter
            String tourType = request.getParameter("tourType");
            
            // Get tour comparison data
            List<TourComparison> tourComparisons;
            if (tourType != null && !tourType.isEmpty() && !tourType.equals("all")) {
                tourComparisons = supplierDAO.getTourComparison(tourType);
            } else {
                tourComparisons = supplierDAO.compareToursByType(null);
            }
            
            // Get tour types for filter dropdown
            List<String> tourTypes = supplierDAO.getTourTypes();
            
            request.setAttribute("tourComparisons", tourComparisons);
            request.setAttribute("tourTypes", tourTypes);
            request.setAttribute("selectedTourType", tourType);
            
            request.getRequestDispatcher("/supplier/compare-tours.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("ERROR in compareTours: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi so sánh tour: " + e.getMessage());
            request.setAttribute("tourComparisons", new ArrayList<TourComparison>());
            request.setAttribute("tourTypes", new ArrayList<String>());
            request.getRequestDispatcher("/supplier/compare-tours.jsp").forward(request, response);
        }
    }
}