package com.dananghub.controller;

import com.dananghub.dao.TourDAO;
import com.dananghub.entity.*;
import com.dananghub.util.JPAUtil;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.file.*;
import java.util.*;

@WebServlet("/provider")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024) // 10MB
public class ProviderServlet extends HttpServlet {

    private final TourDAO tourDAO = new TourDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        if (action == null) action = "landing";

        switch (action) {
            case "dashboard" -> {
                response.sendRedirect(request.getContextPath() + "/provider/dashboard");
            }
            case "create-tour" -> {
                if (user == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
                showCreateTour(request, response, user);
            }
            case "bank-settings" -> {
                if (user == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
                showBankSettings(request, response, user);
            }
            default -> showLanding(request, response, user);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }

        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "register" -> registerProvider(request, response, user);
            case "submit-tour" -> submitTour(request, response, user);
            case "save-bank" -> saveBankSettings(request, response, user);
            default -> response.sendRedirect(request.getContextPath() + "/provider");
        }
    }

    private void showLanding(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        // Check if user is already a provider
        if (user != null) {
            Provider provider = findProvider(user.getUserId());
            if (provider != null && ("Approved".equals(provider.getStatus()) || "Active".equals(provider.getStatus()))) {
                response.sendRedirect(request.getContextPath() + "/provider/dashboard");
                return;
            }
            request.setAttribute("provider", provider);
        }
        request.getRequestDispatcher("/views/provider/landing.jsp").forward(request, response);
    }



    private void showCreateTour(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        Provider provider = findProvider(user.getUserId());
        if (provider == null || (!"Approved".equals(provider.getStatus()) && !"Active".equals(provider.getStatus()))) {
            response.sendRedirect(request.getContextPath() + "/provider");
            return;
        }
        // Categories
        EntityManager em = JPAUtil.getEntityManager();
        try {
            List<Category> categories = em.createQuery("SELECT c FROM Category c ORDER BY c.categoryName", Category.class).getResultList();
            request.setAttribute("categories", categories);
            request.setAttribute("provider", provider);
        } finally { em.close(); }

        request.getRequestDispatcher("/views/provider/create-tour.jsp").forward(request, response);
    }

    private void showBankSettings(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        Provider provider = findProvider(user.getUserId());
        if (provider == null || (!"Approved".equals(provider.getStatus()) && !"Active".equals(provider.getStatus()))) {
            response.sendRedirect(request.getContextPath() + "/provider");
            return;
        }
        
        com.dananghub.util.ProviderBankInfo bankInfo = com.dananghub.util.ProviderBankManager.getBankInfo(user.getUserId());
        request.setAttribute("bankInfo", bankInfo);
        request.setAttribute("provider", provider);
        request.getRequestDispatcher("/provider/bank-settings.jsp").forward(request, response);
    }

    private void saveBankSettings(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        String bankName = request.getParameter("bankName");
        String accountNumber = request.getParameter("accountNumber");
        String accountName = request.getParameter("accountName");

        com.dananghub.util.ProviderBankInfo info = new com.dananghub.util.ProviderBankInfo(user.getUserId(), bankName, accountNumber, accountName);
        com.dananghub.util.ProviderBankManager.saveBankInfo(info);
        
        request.getSession().setAttribute("success", "Đã lưu thông tin tài khoản ngân hàng thành công!");
        response.sendRedirect(request.getContextPath() + "/provider/dashboard");
    }

    private void registerProvider(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        String businessName = request.getParameter("businessName");
        String providerType = request.getParameter("providerType");
        String description = request.getParameter("description");
        String phone = request.getParameter("phone");

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            // Check if already registered
            Provider existing = em.find(Provider.class, user.getUserId());
            if (existing != null) {
                tx.rollback();
                response.sendRedirect(request.getContextPath() + "/provider");
                return;
            }

            em.createNativeQuery(
                "INSERT INTO \"Providers\" (\"ProviderId\",\"BusinessName\",\"ProviderType\",\"Description\",\"Status\",\"IsActive\",\"IsVerified\",\"JoinDate\",\"CreatedAt\",\"UpdatedAt\",\"Rating\",\"TotalTours\") " +
                "VALUES (?,?,?,?,'Pending',true,false,CURRENT_DATE,NOW(),NOW(),0,0)")
                .setParameter(1, user.getUserId())
                .setParameter(2, businessName)
                .setParameter(3, providerType)
                .setParameter(4, description)
                .executeUpdate();
            tx.commit();

            HttpSession session = request.getSession();
            session.setAttribute("success", "Đăng ký nhà cung cấp thành công! Chờ Admin duyệt.");
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally { em.close(); }
        response.sendRedirect(request.getContextPath() + "/provider");
    }

    private void submitTour(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException, ServletException {
        Provider provider = findProvider(user.getUserId());
        if (provider == null || (!"Approved".equals(provider.getStatus()) && !"Active".equals(provider.getStatus()))) {
            response.sendRedirect(request.getContextPath() + "/provider");
            return;
        }

        String tourName = request.getParameter("tourName");
        String shortDesc = request.getParameter("shortDesc");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String duration = request.getParameter("duration");
        String transport = request.getParameter("transport");
        String startLocation = request.getParameter("startLocation");
        String destination = request.getParameter("destination");
        String categoryIdStr = request.getParameter("categoryId");
        String itinerary = request.getParameter("itinerary");
        boolean enable3D = "on".equals(request.getParameter("enable3D"));

        double price = Double.parseDouble(priceStr);
        int categoryId = Integer.parseInt(categoryIdStr);

        // Handle image upload
        String imageUrl = "";
        Part imagePart = request.getPart("tourImage");
        if (imagePart != null && imagePart.getSize() > 0) {
            imageUrl = saveUploadedFile(imagePart, request);
        }

        // Handle 3D images (multiple)
        List<String> images3D = new ArrayList<>();
        if (enable3D) {
            Collection<Part> parts = request.getParts();
            for (Part part : parts) {
                if ("tourImages3D".equals(part.getName()) && part.getSize() > 0) {
                    String saved = saveUploadedFile(part, request);
                    if (saved != null) images3D.add(saved);
                }
            }
        }

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Category cat = em.find(Category.class, categoryId);

            Tour tour = new Tour();
            tour.setProvider(provider);
            tour.setCategory(cat);
            tour.setTourName(tourName);
            tour.setShortDesc(shortDesc);
            tour.setDescription(description);
            tour.setPrice(price);
            tour.setDuration(duration);
            tour.setTransport(transport);
            tour.setStartLocation(startLocation);
            tour.setDestination(destination);
            tour.setImageUrl(imageUrl);
            tour.setItinerary(itinerary);
            tour.setActive(false); // Pending approval!
            tour.setCreatedAt(new Date());
            tour.setUpdatedAt(new Date());
            tour.setMaxPeople(20);

            em.persist(tour);
            em.flush();

            // Save 3D images as TourImage entries
            if (!images3D.isEmpty()) {
                int idx = 0;
                for (String img : images3D) {
                    TourImage ti = new TourImage();
                    ti.setTour(tour);
                    ti.setImageUrl(img);
                    ti.setCaption("3D View " + (++idx));
                    ti.setSortOrder(idx);
                    em.persist(ti);
                }
            }

            tx.commit();

            HttpSession session = request.getSession();
            session.setAttribute("success", "Tour \"" + tourName + "\" đã được gửi! Chờ Admin duyệt để hiển thị trên Khám Phá.");
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi: " + e.getMessage());
        } finally { em.close(); }

        response.sendRedirect(request.getContextPath() + "/provider/dashboard");
    }

    private String saveUploadedFile(Part part, HttpServletRequest request) throws IOException {
        String fileName = UUID.randomUUID().toString() + "_" + getFileName(part);
        String uploadDir = request.getServletContext().getRealPath("/uploads/tours");
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        Path filePath = Paths.get(uploadDir, fileName);
        try (InputStream is = part.getInputStream()) {
            Files.copy(is, filePath, StandardCopyOption.REPLACE_EXISTING);
        }
        return request.getContextPath() + "/uploads/tours/" + fileName;
    }

    private String getFileName(Part part) {
        String cd = part.getHeader("content-disposition");
        for (String s : cd.split(";")) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "file";
    }

    private Provider findProvider(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Provider.class, userId);
        } finally { em.close(); }
    }
}
