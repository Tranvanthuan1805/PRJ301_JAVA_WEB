package controller;

import dao.ITourDAO;
import dao.TourDAO;
import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Tour;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home", ""})
public class HomeServlet extends HttpServlet {
    
    private final ITourDAO tourDao = new TourDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lay danh sach Tour tu DB
            List<Tour> list = tourDao.getAllTours();
           
            // Dem tong so luong Tour
            long totalTours = tourDao.countTours();
            
            // Gửi số liệu sang JSP
            request.setAttribute("listTours", list);
            request.setAttribute("totalTours", totalTours);
            
            // Chuyển hướng sang giao diện trang chủ
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            
            // --- THÊM ĐOẠN NÀY ĐỂ IN LỖI LÊN WEB ---
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<h1>BÁO LỖI HỆ THỐNG:</h1>");
            response.getWriter().println("<h3 style='color:red'>" + e.getMessage() + "</h3>");
            response.getWriter().println("<pre>");
            e.printStackTrace(response.getWriter());
            response.getWriter().println("</pre>");
            // ----------------------------------------
        } 
    }
}