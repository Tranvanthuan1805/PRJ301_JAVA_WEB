package com.dananghub.controller;

import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.Connection;

@WebServlet("/dbtest")
public class DBTestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<html><head><title>DB Test</title>");
        out.println("<style>body{font-family:monospace;padding:30px;background:#0F172A;color:#E2E8F0}");
        out.println(".ok{color:#10B981;font-weight:bold} .err{color:#EF4444;font-weight:bold}");
        out.println("h2{color:#60A5FA} pre{background:#1E293B;padding:15px;border-radius:8px;overflow-x:auto}</style></head><body>");
        out.println("<h1>🔧 Database Connection Test</h1>");

        // Test 1: JDBC Driver
        out.println("<h2>1. JDBC Driver</h2>");
        try {
            Class.forName("org.postgresql.Driver");
            out.println("<p class='ok'>✅ PostgreSQL Driver loaded OK</p>");
        } catch (Exception e) {
            out.println("<p class='err'>❌ Driver NOT found: " + e.getMessage() + "</p>");
        }

        // Test 2: Raw JDBC connection
        out.println("<h2>2. JDBC Connection (raw)</h2>");
        try {
            String url = "jdbc:postgresql://aws-1-ap-northeast-2.pooler.supabase.com:5432/postgres?sslmode=require";
            Connection conn = DriverManager.getConnection(url, "postgres.cbbdijhwewpptvmgujcz", "dK6W6dygBt2%uTw");
            out.println("<p class='ok'>✅ JDBC Connection OK</p>");
            out.println("<p>Database: " + conn.getCatalog() + "</p>");
            conn.close();
        } catch (Exception e) {
            out.println("<p class='err'>❌ JDBC Connection FAILED</p>");
            out.println("<pre>" + e.getMessage() + "</pre>");
        }

        // Test 3: JPA
        out.println("<h2>3. JPA / Hibernate</h2>");
        String jpaError = JPAUtil.getInitError();
        if (jpaError != null) {
            out.println("<p class='err'>❌ JPA Init Error: " + jpaError + "</p>");
        }

        try {
            EntityManager em = JPAUtil.getEntityManager();
            out.println("<p class='ok'>✅ EntityManager created OK</p>");

            // Test query
            Object count = em.createNativeQuery("SELECT COUNT(*) FROM \"Users\"").getSingleResult();
            out.println("<p class='ok'>✅ Users table: " + count + " records</p>");

            Object roleCount = em.createNativeQuery("SELECT COUNT(*) FROM \"Roles\"").getSingleResult();
            out.println("<p class='ok'>✅ Roles table: " + roleCount + " records</p>");

            em.close();
        } catch (Exception e) {
            out.println("<p class='err'>❌ JPA Error: " + e.getMessage() + "</p>");
            Throwable root = e;
            while (root.getCause() != null) root = root.getCause();
            out.println("<pre>Root cause: " + root.getClass().getSimpleName() + "\n" + root.getMessage() + "</pre>");
        }

        out.println("<br><a href='" + request.getContextPath() + "/login' style='color:#60A5FA'>← Back to Login</a>");
        out.println("</body></html>");
    }
}
