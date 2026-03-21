package com.dananghub.controller;

import com.dananghub.dao.ProviderRegistrationDAO;
import com.dananghub.dao.TourDAO;
import com.dananghub.entity.*;
import com.dananghub.realtime.ProviderNotificationBus;
import com.dananghub.util.JPAUtil;

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
    private final ProviderRegistrationDAO regDAO = new ProviderRegistrationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        if (action == null)
            action = "landing";

        switch (action) {
            case "dashboard" -> {
                if (user == null) {
                    response.sendRedirect(request.getContextPath() + "/login.jsp");
                    return;
                }
                showDashboard(request, response, user);
            }
            case "create-tour" -> {
                if (user == null) {
                    response.sendRedirect(request.getContextPath() + "/login.jsp");
                    return;
                }
                showCreateTour(request, response, user);
            }
            default -> showLanding(request, response, user);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null)
            action = "";

        switch (action) {
            case "register" -> registerProvider(request, response, user);
            case "submit-tour" -> submitTour(request, response, user);
            default -> response.sendRedirect(request.getContextPath() + "/provider");
        }
    }

    private void showLanding(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        // Check if user is already a provider
        if (user != null) {
            Provider provider = findProvider(user.getUserId());
            if (provider != null && "Approved".equals(provider.getStatus())) {
                response.sendRedirect(request.getContextPath() + "/provider?action=dashboard");
                return;
            }
            request.setAttribute("provider", provider);

            // Nếu chưa có Provider record, kiểm tra xem có đơn đăng ký pending không
            // để hiển thị trạng thái "Đang chờ duyệt" trên landing page
            if (provider == null) {
                try {
                    boolean hasPending = regDAO.hasPendingByUser(user.getUserId());
                    if (hasPending) {
                        // Tạo fake provider object chỉ để JSP hiển thị pending state
                        Provider pendingDisplay = new Provider();
                        pendingDisplay.setStatus("Pending");
                        pendingDisplay.setBusinessName("đơn đăng ký của bạn");
                        request.setAttribute("provider", pendingDisplay);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        request.getRequestDispatcher("/views/provider/landing.jsp").forward(request, response);
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        Provider provider = findProvider(user.getUserId());
        if (provider == null || !"Approved".equals(provider.getStatus())) {
            response.sendRedirect(request.getContextPath() + "/provider");
            return;
        }

        // Get provider's tours
        EntityManager em = JPAUtil.getEntityManager();
        try {
            List<Tour> tours = em.createQuery(
                    "SELECT DISTINCT t FROM Tour t LEFT JOIN FETCH t.images WHERE t.provider.providerId = :pid ORDER BY t.createdAt DESC",
                    Tour.class)
                    .setParameter("pid", provider.getProviderId())
                    .getResultList();

            long pendingCount = tours.stream().filter(t -> !t.isActive()).count();
            long activeCount = tours.stream().filter(Tour::isActive).count();

            request.setAttribute("provider", provider);
            request.setAttribute("tours", tours);
            request.setAttribute("pendingCount", pendingCount);
            request.setAttribute("activeCount", activeCount);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("provider", provider);
            request.setAttribute("tours", new java.util.ArrayList<>());
            request.setAttribute("pendingCount", 0L);
            request.setAttribute("activeCount", 0L);
        } finally {
            em.close();
        }

        request.getRequestDispatcher("/views/provider/dashboard.jsp").forward(request, response);
    }

    private void showCreateTour(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        Provider provider = findProvider(user.getUserId());
        if (provider == null || !"Approved".equals(provider.getStatus())) {
            response.sendRedirect(request.getContextPath() + "/provider");
            return;
        }
        // Categories
        EntityManager em = JPAUtil.getEntityManager();
        try {
            List<Category> categories = em
                    .createQuery("SELECT c FROM Category c ORDER BY c.categoryName", Category.class).getResultList();
            request.setAttribute("categories", categories);
            request.setAttribute("provider", provider);
        } finally {
            em.close();
        }

        request.getRequestDispatcher("/views/provider/create-tour.jsp").forward(request, response);
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
                    "INSERT INTO \"Providers\" (\"ProviderId\",\"BusinessName\",\"ProviderType\",\"Description\",\"Status\",\"IsActive\",\"IsVerified\",\"JoinDate\",\"CreatedAt\",\"UpdatedAt\",\"Rating\",\"TotalTours\") "
                            +
                            "VALUES (?,?,?,?,'Pending',true,false,CURRENT_DATE,NOW(),NOW(),0,0)")
                    .setParameter(1, user.getUserId())
                    .setParameter(2, businessName)
                    .setParameter(3, providerType)
                    .setParameter(4, description)
                    .executeUpdate();
            tx.commit();

            // Publish realtime event cho admin
            String registeredAt = java.time.LocalDateTime.now()
                    .format(java.time.format.DateTimeFormatter.ISO_LOCAL_DATE_TIME);
            // Đếm tổng số provider đang chờ duyệt
            EntityManager em2 = JPAUtil.getEntityManager();
            int pendingCount = 1;
            try {
                Long cnt = em2.createQuery(
                        "SELECT COUNT(p) FROM Provider p WHERE p.status = 'Pending'", Long.class)
                        .getSingleResult();
                pendingCount = cnt.intValue();
            } finally {
                em2.close();
            }
            ProviderNotificationBus.getInstance().publish(
                    new ProviderNotificationBus.ProviderEvent(
                            user.getUserId(), businessName, providerType, registeredAt, pendingCount));

            HttpSession session = request.getSession();
            session.setAttribute("success", "Đăng ký nhà cung cấp thành công! Chờ Admin duyệt.");
        } catch (Exception e) {
            if (tx.isActive())
                tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
        response.sendRedirect(request.getContextPath() + "/provider");
    }

    private void submitTour(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException, ServletException {
        Provider provider = findProvider(user.getUserId());
        if (provider == null || !"Approved".equals(provider.getStatus())) {
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
                    if (saved != null)
                        images3D.add(saved);
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
            session.setAttribute("success",
                    "Tour \"" + tourName + "\" đã được gửi! Chờ Admin duyệt để hiển thị trên Khám Phá.");
        } catch (Exception e) {
            if (tx.isActive())
                tx.rollback();
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi: " + e.getMessage());
        } finally {
            em.close();
        }

        response.sendRedirect(request.getContextPath() + "/provider?action=dashboard");
    }

    private String saveUploadedFile(Part part, HttpServletRequest request) throws IOException {
        String fileName = UUID.randomUUID().toString() + "_" + getFileName(part);
        String uploadDir = request.getServletContext().getRealPath("/uploads/tours");
        File dir = new File(uploadDir);
        if (!dir.exists())
            dir.mkdirs();

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
        } finally {
            em.close();
        }
    }
}
