package controller;

import dao.ITourDAO;
import dao.TourDAO;
import model.Tour;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {

    private final ITourDAO tourDAO = new TourDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Lấy từ khóa người dùng nhập (Ví dụ: "Hội An")
        String keyword = request.getParameter("keyword");
        
        List<Tour> list;
        
        // 2. Nếu từ khóa trống -> Hiện tất cả. Nếu có chữ -> Tìm kiếm
        if (keyword == null || keyword.trim().isEmpty()) {
            list = tourDAO.getAllTours(); // Hàm này bạn đã có từ trước
        } else {
            list = tourDAO.searchTours(keyword);
        }
        
        // 3. Gửi danh sách kết quả về lại trang chủ (home.jsp)
        request.setAttribute("listTours", list);
        
        // Giữ lại từ khóa để hiện lại trên ô tìm kiếm (trải nghiệm người dùng)
        request.setAttribute("searchKeyword", keyword);
        
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}