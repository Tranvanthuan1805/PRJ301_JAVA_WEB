package com.dananghub.controller;

import com.dananghub.dao.ProviderDAO;
import com.dananghub.dao.ProviderRegistrationDAO;
import com.dananghub.entity.Provider;
import com.dananghub.entity.ProviderPriceHistory;
import com.dananghub.entity.ProviderRegistration;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet xử lý các chức năng Nhà cung cấp (NCC)
 * - Danh sách NCC
 * - Lịch sử giá
 * - So sánh NCC
 * - Đăng ký làm NCC
 */
@WebServlet(name = "ProviderServlet", urlPatterns = { "/providers" })
public class ProviderServlet extends HttpServlet {

    private ProviderDAO providerDAO;
    private ProviderRegistrationDAO registrationDAO;

    @Override
    public void init() throws ServletException {
        providerDAO = new ProviderDAO();
        registrationDAO = new ProviderRegistrationDAO();
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
                    showProviderList(request, response);
                    break;
                case "history":
                    showProviderHistory(request, response);
                    break;
                case "compare":
                    showProviderComparison(request, response);
                    break;
                case "register":
                    showRegistrationForm(request, response);
                    break;
                default:
                    showProviderList(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            if ("register".equals(action)) {
                handleRegistrationSubmit(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/providers");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("/views/provider/provider-register.jsp").forward(request, response);
        }
    }

    /**
     * Hiển thị danh sách NCC với filter và search
     */
    private void showProviderList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            System.out.println("=== showProviderList called ===");

            String providerType = request.getParameter("type");
            String keyword = request.getParameter("search");

            System.out.println("Provider Type: " + providerType);
            System.out.println("Keyword: " + keyword);

            List<Provider> providers = new ArrayList<>();

            try {
                System.out.println("Attempting to fetch providers from DAO...");

                if (keyword != null && !keyword.trim().isEmpty()) {
                    // Tìm kiếm theo tên
                    providers = providerDAO.searchByName(keyword);
                } else if (providerType != null && !providerType.isEmpty()) {
                    // Lọc theo loại
                    providers = providerDAO.findByType(providerType);
                } else {
                    // Lấy tất cả
                    providers = providerDAO.findAllActive();
                }

                System.out.println("Fetched " + providers.size() + " providers");
            } catch (Exception e) {
                System.err.println("Error fetching providers: " + e.getMessage());
                e.printStackTrace();
                // Nếu lỗi, trả về list rỗng
                providers = new ArrayList<>();
            }

            request.setAttribute("providers", providers);
            request.setAttribute("selectedType", providerType);
            request.setAttribute("searchKeyword", keyword);
            request.setAttribute("totalProviders", providers.size());

            System.out.println("Forwarding to JSP...");

            request.getRequestDispatcher("/views/provider/provider-list.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Error in showProviderList: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error displaying provider list", e);
        }
    }

    /**
     * Hiển thị lịch sử giá của một NCC
     */
    private void showProviderHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String providerIdStr = request.getParameter("id");
            if (providerIdStr != null && !providerIdStr.isEmpty()) {
                int providerId = Integer.parseInt(providerIdStr);
                Provider provider = providerDAO.findById(providerId);

                if (provider != null) {
                    List<ProviderPriceHistory> priceHistory = providerDAO.getPriceHistory(providerId);
                    request.setAttribute("provider", provider);
                    request.setAttribute("priceHistory", priceHistory);
                    request.getRequestDispatcher("/views/provider/provider-history.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "Không tìm thấy nhà cung cấp với ID: " + providerId);
                    request.getRequestDispatcher("/error.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/providers");
            }
        } catch (Exception e) {
            System.err.println("Error in showProviderHistory: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi tải lịch sử nhà cung cấp: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    /**
     * Hiển thị so sánh giữa các NCC
     */
    private void showProviderComparison(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            System.out.println("=== showProviderComparison called ===");

            String[] providerIdsStr = request.getParameterValues("providerIds");
            List<Provider> compareProviders = new ArrayList<>();

            // Nếu có chọn providers để so sánh
            if (providerIdsStr != null && providerIdsStr.length >= 2 && providerIdsStr.length <= 3) {
                System.out.println("Provider IDs selected: " + String.join(", ", providerIdsStr));
                List<Integer> providerIds = new ArrayList<>();
                for (String idStr : providerIdsStr) {
                    try {
                        providerIds.add(Integer.parseInt(idStr));
                    } catch (NumberFormatException e) {
                        System.err.println("Invalid provider ID: " + idStr);
                    }
                }

                if (!providerIds.isEmpty()) {
                    System.out.println("Fetching providers by IDs...");
                    compareProviders = providerDAO.findByIds(providerIds);
                    System.out.println("Found " + compareProviders.size() + " providers for comparison");
                }
            } else {
                System.out.println("No provider IDs selected, showing selection form");
            }

            // Lấy tất cả providers để chọn
            System.out.println("Fetching all providers...");
            List<Provider> allProviders = providerDAO.findAllActive();
            System.out.println("Found " + allProviders.size() + " total providers");

            request.setAttribute("compareProviders", compareProviders);
            request.setAttribute("allProviders", allProviders);

            System.out.println("Forwarding to compare JSP...");
            request.getRequestDispatcher("/views/provider/provider-compare.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("ERROR in showProviderComparison: " + e.getMessage());
            e.printStackTrace();

            // Show error page instead of redirect
            request.setAttribute("errorMessage", "Không thể tải trang so sánh: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    /**
     * Hiển thị form đăng ký làm NCC
     */
    private void showRegistrationForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/views/provider/provider-register.jsp").forward(request, response);
    }

    /**
     * Xử lý submit form đăng ký
     */
    private void handleRegistrationSubmit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy dữ liệu từ form
        String businessName = request.getParameter("businessName");
        String businessLicense = request.getParameter("businessLicense");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String providerType = request.getParameter("providerType");
        String description = request.getParameter("description");

        // Validation
        StringBuilder errorMsg = new StringBuilder();

        if (businessName == null || businessName.trim().isEmpty() || businessName.length() < 3) {
            errorMsg.append("Tên doanh nghiệp phải từ 3-200 ký tự. ");
        }
        if (businessLicense == null || businessLicense.trim().isEmpty() || businessLicense.length() < 5) {
            errorMsg.append("Giấy phép kinh doanh phải từ 5-50 ký tự. ");
        }
        if (email == null || !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            errorMsg.append("Email không hợp lệ. ");
        }
        if (phone == null || !phone.matches("^[0-9]{10,11}$")) {
            errorMsg.append("Số điện thoại phải có 10-11 chữ số. ");
        }
        if (address == null || address.trim().isEmpty() || address.length() < 10) {
            errorMsg.append("Địa chỉ phải từ 10-500 ký tự. ");
        }
        if (providerType == null || providerType.isEmpty()) {
            errorMsg.append("Vui lòng chọn loại dịch vụ. ");
        }

        // Kiểm tra email đã đăng ký chưa
        if (email != null && registrationDAO.isEmailRegistered(email)) {
            errorMsg.append("Email này đã được đăng ký trước đó. ");
        }

        if (errorMsg.length() > 0) {
            request.setAttribute("error", errorMsg.toString());
            request.getRequestDispatcher("/views/provider/provider-register.jsp").forward(request, response);
            return;
        }

        // Tạo đơn đăng ký mới
        ProviderRegistration registration = new ProviderRegistration();
        registration.setBusinessName(businessName);
        registration.setBusinessLicense(businessLicense);
        registration.setEmail(email);
        registration.setPhoneNumber(phone);
        registration.setAddress(address);
        registration.setProviderType(providerType);
        registration.setDescription(description);

        registrationDAO.save(registration);

        // Chuyển đến trang thành công
        request.setAttribute("registration", registration);
        request.getRequestDispatcher("/views/provider/registration-success.jsp").forward(request, response);
    }
}
