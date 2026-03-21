package com.dananghub.controller;

import com.dananghub.dao.ProviderRegistrationDAO;
import com.dananghub.entity.Provider;
import com.dananghub.entity.ProviderRegistration;
import com.dananghub.entity.User;
import com.dananghub.util.EmailUtil;
import com.dananghub.util.JPAUtil;
import com.dananghub.websocket.NotificationWebSocket;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Servlet cho admin duyệt / từ chối đơn đăng ký NCC.
 * URL: POST /api/admin/provider
 * Body JSON: {"registrationId": 1, "action": "approve"/"reject", "adminNote":
 * "..."}
 * Response: {"success": true/false, "message": "..."}
 */
@WebServlet("/api/admin/provider")
public class AdminProviderServlet extends HttpServlet {

    private final ProviderRegistrationDAO dao = new ProviderRegistrationDAO();

    /**
     * GET /api/admin/provider?action=sync
     * Sync tất cả đơn đã approved → tạo Provider record nếu chưa có.
     * Dùng để fix data sau khi có lỗi trước đó.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        User admin = session != null ? (User) session.getAttribute("user") : null;
        if (admin == null || !"ADMIN".equals(admin.getRoleName())) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            out.print("{\"success\":false,\"message\":\"Không có quyền.\"}");
            return;
        }

        List<ProviderRegistration> approved = dao.findByStatus("approved");
        int created = 0, skipped = 0;

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            for (ProviderRegistration reg : approved) {
                // Reload với eager fetch user
                List<ProviderRegistration> regs = em.createQuery(
                        "SELECT r FROM ProviderRegistration r LEFT JOIN FETCH r.user WHERE r.id = :id",
                        ProviderRegistration.class)
                        .setParameter("id", reg.getId()).getResultList();
                if (regs.isEmpty())
                    continue;
                ProviderRegistration r = regs.get(0);
                User u = r.getUser();
                if (u == null) {
                    skipped++;
                    continue;
                }

                Provider existing = em.find(Provider.class, u.getUserId());
                if (existing == null) {
                    Provider p = new Provider();
                    p.setProviderId(u.getUserId());
                    p.setBusinessName(r.getBusinessName());
                    p.setProviderType(r.getCategory());
                    p.setDescription(r.getDescription());
                    p.setStatus("Approved");
                    p.setActive(true);
                    p.setVerified(false);
                    p.setRating(0.0);
                    p.setTotalTours(0);
                    p.setJoinDate(LocalDate.now());
                    p.setCreatedAt(LocalDateTime.now());
                    p.setUpdatedAt(LocalDateTime.now());
                    em.persist(p);
                    created++;
                } else {
                    skipped++;
                }
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive())
                tx.rollback();
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Lỗi: " + e.getMessage().replace("\"", "'") + "\"}");
            return;
        } finally {
            em.close();
        }

        out.print("{\"success\":true,\"created\":" + created + ",\"skipped\":" + skipped + "}");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Kiểm tra session admin
        HttpSession session = request.getSession(false);
        User admin = session != null ? (User) session.getAttribute("user") : null;
        if (admin == null || !"ADMIN".equals(admin.getRoleName())) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            out.print("{\"success\":false,\"message\":\"Không có quyền truy cập.\"}");
            return;
        }

        // Đọc JSON body
        StringBuilder sb = new StringBuilder();
        try (var reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null)
                sb.append(line);
        }
        String body = sb.toString();

        String idStr = extractJson(body, "registrationId");
        String action = extractJson(body, "action");
        String adminNote = extractJson(body, "adminNote");

        if (idStr == null || action == null) {
            out.print("{\"success\":false,\"message\":\"Thiếu tham số.\"}");
            return;
        }
        if (!action.equals("approve") && !action.equals("reject")) {
            out.print("{\"success\":false,\"message\":\"Action không hợp lệ.\"}");
            return;
        }

        int regId;
        try {
            regId = Integer.parseInt(idStr.trim());
        } catch (NumberFormatException e) {
            out.print("{\"success\":false,\"message\":\"ID không hợp lệ.\"}");
            return;
        }

        // Lấy đơn trước để lấy thông tin gửi email
        ProviderRegistration reg = dao.findById(regId);
        if (reg == null) {
            out.print("{\"success\":false,\"message\":\"Không tìm thấy đơn.\"}");
            return;
        }

        String newStatus = action.equals("approve") ? "approved" : "rejected";
        boolean ok = dao.updateStatus(regId, newStatus, adminNote, admin);

        if (!ok) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\":false,\"message\":\"Lỗi cập nhật DB.\"}");
            return;
        }

        // Nếu approve → tạo record trong bảng Providers
        if (action.equals("approve")) {
            User applicantUser = reg.getUser();
            if (applicantUser != null) {
                EntityManager em = JPAUtil.getEntityManager();
                EntityTransaction tx = em.getTransaction();
                try {
                    tx.begin();
                    // Kiểm tra đã có Provider chưa (tránh duplicate)
                    Provider existing = em.find(Provider.class, applicantUser.getUserId());
                    if (existing == null) {
                        Provider provider = new Provider();
                        provider.setProviderId(applicantUser.getUserId());
                        provider.setBusinessName(reg.getBusinessName());
                        provider.setProviderType(reg.getCategory());
                        provider.setDescription(reg.getDescription());
                        provider.setStatus("Approved");
                        provider.setActive(true);
                        provider.setVerified(false);
                        provider.setRating(0.0);
                        provider.setTotalTours(0);
                        provider.setJoinDate(LocalDate.now());
                        provider.setCreatedAt(LocalDateTime.now());
                        provider.setUpdatedAt(LocalDateTime.now());
                        em.persist(provider);
                    } else {
                        existing.setStatus("Approved");
                        existing.setActive(true);
                        existing.setUpdatedAt(LocalDateTime.now());
                        em.merge(existing);
                    }
                    tx.commit();
                } catch (Exception e) {
                    if (tx.isActive())
                        tx.rollback();
                    e.printStackTrace();
                    // Không block response — log lỗi nhưng vẫn trả success
                } finally {
                    em.close();
                }
            }
        }

        // Gửi email thông báo cho người đăng ký (async để không block response)
        User applicant = reg.getUser();
        if (applicant != null && applicant.getEmail() != null) {
            String email = applicant.getEmail();
            String name = applicant.getFullName() != null ? applicant.getFullName() : applicant.getUsername();
            String bizName = reg.getBusinessName();
            boolean approved = action.equals("approve");
            String note = adminNote;

            // Chạy trong thread riêng để không delay response
            new Thread(() -> EmailUtil.sendReviewResult(email, name, bizName, approved, note)).start();
        }

        // Broadcast WebSocket cập nhật badge cho các admin khác
        long pendingCount = dao.countPending();
        NotificationWebSocket.broadcastStatusUpdate(pendingCount);

        String msg = action.equals("approve") ? "Đã duyệt đơn thành công." : "Đã từ chối đơn.";
        out.print("{\"success\":true,\"message\":\"" + msg + "\",\"pendingCount\":" + pendingCount + "}");
    }

    private String extractJson(String json, String key) {
        String search = "\"" + key + "\"";
        int idx = json.indexOf(search);
        if (idx < 0)
            return null;
        int colon = json.indexOf(':', idx + search.length());
        if (colon < 0)
            return null;
        // Xử lý cả số (không có dấu ngoặc kép)
        int afterColon = colon + 1;
        while (afterColon < json.length() && json.charAt(afterColon) == ' ')
            afterColon++;
        if (afterColon >= json.length())
            return null;
        if (json.charAt(afterColon) == '"') {
            int start = afterColon;
            int end = json.indexOf('"', start + 1);
            while (end > 0 && json.charAt(end - 1) == '\\')
                end = json.indexOf('"', end + 1);
            if (end < 0)
                return null;
            return json.substring(start + 1, end).replace("\\\"", "\"");
        } else {
            // Số hoặc null
            int end = afterColon;
            while (end < json.length() && ",}".indexOf(json.charAt(end)) < 0)
                end++;
            return json.substring(afterColon, end).trim();
        }
    }
}
