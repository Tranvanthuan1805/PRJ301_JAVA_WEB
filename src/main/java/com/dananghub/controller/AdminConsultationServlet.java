package com.dananghub.controller;

import com.dananghub.dao.ConsultationDAO;
import com.dananghub.entity.Consultation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/consultations")
public class AdminConsultationServlet extends HttpServlet {

    private final ConsultationDAO dao = new ConsultationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String status = req.getParameter("status");
        List<Consultation> list;

        if (status != null && !status.isEmpty()) {
            list = dao.findByStatus(status);
        } else {
            list = dao.findAll();
        }

        long totalNew = dao.countByStatus("new");
        long totalContacted = dao.countByStatus("contacted");
        long totalDone = dao.countByStatus("done");
        long totalAll = dao.countAll();

        req.setAttribute("consultations", list);
        req.setAttribute("totalNew", totalNew);
        req.setAttribute("totalContacted", totalContacted);
        req.setAttribute("totalDone", totalDone);
        req.setAttribute("totalAll", totalAll);
        req.setAttribute("currentStatus", status);
        req.setAttribute("activePage", "consultations");

        req.getRequestDispatcher("/views/admin/consultations.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("updateStatus".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            String status = req.getParameter("status");
            String note = req.getParameter("note");
            dao.updateStatus(id, status, note);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/consultations");
    }
}
