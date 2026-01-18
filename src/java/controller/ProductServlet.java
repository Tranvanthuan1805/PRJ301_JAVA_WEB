package controller;

import model.Category;
import model.Product;
import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductServlet", urlPatterns = {"/products"})
public class ProductServlet extends HttpServlet {
    
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("MyUnit");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String idStr = req.getParameter("id");
        String search = req.getParameter("search"); // Lấy từ khóa tìm kiếm
        
        EntityManager em = emf.createEntityManager();
        
        try {
            // 1. DELETE
            if ("delete".equals(action) && idStr != null) {
                em.getTransaction().begin();
                Product p = em.find(Product.class, Integer.parseInt(idStr));
                if (p != null) em.remove(p);
                em.getTransaction().commit();
                resp.sendRedirect("products");
                return;
            }

            // 2. PREPARE EDIT
            if ("edit".equals(action) && idStr != null) {
                Product p = em.find(Product.class, Integer.parseInt(idStr));
                req.setAttribute("productEdit", p);
            }

            // 3. GET LIST CATEGORIES (Để hiển thị Dropdown)
            List<Category> cats = em.createQuery("SELECT c FROM Category c", Category.class).getResultList();
            req.setAttribute("categories", cats);

            // 4. GET LIST PRODUCTS (Có xử lý Tìm kiếm)
            String jpql = "SELECT p FROM Product p";
            if (search != null && !search.trim().isEmpty()) {
                jpql += " WHERE p.name LIKE :keyword";
            }
            
            TypedQuery<Product> query = em.createQuery(jpql, Product.class);
            if (search != null && !search.trim().isEmpty()) {
                query.setParameter("keyword", "%" + search + "%");
                req.setAttribute("searchKeyword", search); // Giữ lại từ khóa trên ô input
            }
            
            req.setAttribute("data", query.getResultList());
            req.getRequestDispatcher("product-list.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        String priceStr = req.getParameter("price");
        String catIdStr = req.getParameter("categoryId"); // Lấy ID danh mục từ dropdown

        EntityManager em = emf.createEntityManager();
        
        try {
            em.getTransaction().begin();
            
            // Tìm đối tượng Category dựa trên ID người dùng chọn
            Category cat = em.find(Category.class, Integer.parseInt(catIdStr));

            if (idStr != null && !idStr.isEmpty()) {
                // UPDATE
                Product p = em.find(Product.class, Integer.parseInt(idStr));
                p.setName(name);
                p.setPrice(Double.parseDouble(priceStr));
                p.setCategory(cat); // Cập nhật danh mục
            } else {
                // CREATE
                Product p = new Product(name, Double.parseDouble(priceStr), cat);
                em.persist(p);
            }
            
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
        resp.sendRedirect("products");
    }
}