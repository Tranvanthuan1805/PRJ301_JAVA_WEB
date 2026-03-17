package com.dananghub.controller;

import com.dananghub.entity.Category;
import com.dananghub.entity.User;
import com.dananghub.entity.Role;
import com.dananghub.util.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/crud/*")
public class AdminCrudServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check admin
        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;
        if (user == null || user.getRole() == null || !"ADMIN".equals(user.getRole().getRoleName())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) pathInfo = "";
        String action = request.getParameter("action");

        switch (pathInfo) {
            case "/customer-edit" -> showCustomerForm(request, response);
            case "/customer-delete" -> deleteCustomer(request, response);
            case "/customer-activate" -> activateCustomer(request, response);
            case "/category-edit" -> showCategoryForm(request, response);
            case "/category-delete" -> deleteCategory(request, response);
            default -> response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;
        if (user == null || user.getRole() == null || !"ADMIN".equals(user.getRole().getRoleName())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) pathInfo = "";

        switch (pathInfo) {
            case "/customer-save" -> saveCustomer(request, response);
            case "/category-save" -> saveCategory(request, response);
            default -> response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        }
    }

    // ═══════════════ CUSTOMER CRUD ═══════════════

    private void showCustomerForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        EntityManager em = JPAUtil.getEntityManager();
        try {
            if (idStr != null && !idStr.isEmpty()) {
                User u = em.find(User.class, Integer.parseInt(idStr));
                request.setAttribute("editUser", u);
                request.setAttribute("editMode", true);
            }
            // Load roles
            List<Role> roles = em.createQuery("SELECT r FROM Role r ORDER BY r.roleId", Role.class).getResultList();
            request.setAttribute("roles", roles);
        } finally {
            em.close();
        }
        request.setAttribute("activePage", "customers");
        request.getRequestDispatcher("/admin/customer-form.jsp").forward(request, response);
    }

    private void saveCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            String idStr = request.getParameter("userId");
            User u;
            if (idStr != null && !idStr.isEmpty() && !"0".equals(idStr)) {
                // Update
                u = em.find(User.class, Integer.parseInt(idStr));
                if (u != null) {
                    u.setFullName(request.getParameter("fullName"));
                    u.setEmail(request.getParameter("email"));
                    u.setPhoneNumber(request.getParameter("phoneNumber"));
                    u.setAddress(request.getParameter("address"));
                    String roleId = request.getParameter("roleId");
                    if (roleId != null && !roleId.isEmpty()) {
                        Role r = em.find(Role.class, Integer.parseInt(roleId));
                        if (r != null) u.setRole(r);
                    }
                    String isActive = request.getParameter("isActive");
                    u.setActive("true".equals(isActive) || "on".equals(isActive));
                    u.setUpdatedAt(new Date());
                    em.merge(u);
                }
            } else {
                // Create
                u = new User();
                u.setUsername(request.getParameter("username"));
                u.setEmail(request.getParameter("email"));
                u.setFullName(request.getParameter("fullName"));
                u.setPhoneNumber(request.getParameter("phoneNumber"));
                u.setAddress(request.getParameter("address"));
                // Hash password
                String pass = request.getParameter("password");
                if (pass != null && !pass.isEmpty()) {
                    u.setPasswordHash(com.dananghub.util.PasswordUtil.hashSHA256(pass));
                }
                String roleId = request.getParameter("roleId");
                if (roleId != null && !roleId.isEmpty()) {
                    Role r = em.find(Role.class, Integer.parseInt(roleId));
                    if (r != null) u.setRole(r);
                }
                u.setActive(true);
                u.setCreatedAt(new Date());
                em.persist(u);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
        response.sendRedirect(request.getContextPath() + "/admin/dashboard?success=saved");
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            EntityManager em = JPAUtil.getEntityManager();
            EntityTransaction tx = em.getTransaction();
            try {
                tx.begin();
                User u = em.find(User.class, Integer.parseInt(idStr));
                if (u != null) {
                    u.setActive(false);
                    u.setUpdatedAt(new Date());
                    em.merge(u);
                }
                tx.commit();
            } catch (Exception e) {
                if (tx.isActive()) tx.rollback();
                e.printStackTrace();
            } finally {
                em.close();
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/dashboard?success=deleted");
    }

    private void activateCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            EntityManager em = JPAUtil.getEntityManager();
            EntityTransaction tx = em.getTransaction();
            try {
                tx.begin();
                User u = em.find(User.class, Integer.parseInt(idStr));
                if (u != null) {
                    u.setActive(true);
                    u.setUpdatedAt(new Date());
                    em.merge(u);
                }
                tx.commit();
            } catch (Exception e) {
                if (tx.isActive()) tx.rollback();
                e.printStackTrace();
            } finally {
                em.close();
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/dashboard?success=activated");
    }

    // ═══════════════ CATEGORY CRUD ═══════════════

    private void showCategoryForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            EntityManager em = JPAUtil.getEntityManager();
            try {
                Category c = em.find(Category.class, Integer.parseInt(idStr));
                request.setAttribute("editCategory", c);
                request.setAttribute("editMode", true);
            } finally {
                em.close();
            }
        }
        request.setAttribute("activePage", "categories");
        request.getRequestDispatcher("/admin/category-form.jsp").forward(request, response);
    }

    private void saveCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            String idStr = request.getParameter("categoryId");
            Category c;
            if (idStr != null && !idStr.isEmpty() && !"0".equals(idStr)) {
                c = em.find(Category.class, Integer.parseInt(idStr));
                if (c != null) {
                    c.setCategoryName(request.getParameter("categoryName"));
                    c.setDescription(request.getParameter("description"));
                    c.setIconUrl(request.getParameter("iconUrl"));
                    em.merge(c);
                }
            } else {
                c = new Category();
                c.setCategoryName(request.getParameter("categoryName"));
                c.setDescription(request.getParameter("description"));
                c.setIconUrl(request.getParameter("iconUrl"));
                em.persist(c);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
        response.sendRedirect(request.getContextPath() + "/admin/dashboard?success=saved");
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            EntityManager em = JPAUtil.getEntityManager();
            EntityTransaction tx = em.getTransaction();
            try {
                tx.begin();
                Category c = em.find(Category.class, Integer.parseInt(idStr));
                if (c != null) {
                    em.remove(c);
                }
                tx.commit();
            } catch (Exception e) {
                if (tx.isActive()) tx.rollback();
                e.printStackTrace();
            } finally {
                em.close();
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/dashboard?success=deleted");
    }
}
