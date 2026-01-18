package controller;

import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home", ""})
public class HomeServlet extends HttpServlet {
    
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("MyUnit");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();
        try {
            // Đếm số lượng Sản phẩm
            Long productCount = em.createQuery("SELECT COUNT(p) FROM Product p", Long.class).getSingleResult();
            
            // Đếm số lượng Danh mục
            Long categoryCount = em.createQuery("SELECT COUNT(c) FROM Category c", Long.class).getSingleResult();
            
            // Gửi số liệu sang JSP
            req.setAttribute("pCount", productCount);
            req.setAttribute("cCount", categoryCount);
            
            // Chuyển hướng sang giao diện trang chủ
            req.getRequestDispatcher("home.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}