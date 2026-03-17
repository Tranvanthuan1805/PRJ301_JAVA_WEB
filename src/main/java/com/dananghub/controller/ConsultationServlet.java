package com.dananghub.controller;

import com.dananghub.dao.ConsultationDAO;
import com.dananghub.entity.Consultation;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/consultation")
public class ConsultationServlet extends HttpServlet {

    private final ConsultationDAO dao = new ConsultationDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        try {
            String name = req.getParameter("fullName");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String tourType = req.getParameter("tourType");
            String message = req.getParameter("message");

            if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty()) {
                resp.setStatus(400);
                out.print("{\"success\":false,\"message\":\"Vui lòng nhập họ tên và email\"}");
                return;
            }

            Consultation c = new Consultation();
            c.setFullName(name.trim());
            c.setEmail(email.trim());
            c.setPhone(phone != null ? phone.trim() : "");
            c.setTourType(tourType);
            c.setMessage(message != null ? message.trim() : "");

            dao.save(c);

            out.print("{\"success\":true,\"message\":\"Cảm ơn bạn! Chúng tôi sẽ liên hệ sớm nhất.\"}");
        } catch (Exception e) {
            resp.setStatus(500);
            out.print("{\"success\":false,\"message\":\"Lỗi hệ thống, vui lòng thử lại.\"}");
            e.printStackTrace();
        }
    }
}
