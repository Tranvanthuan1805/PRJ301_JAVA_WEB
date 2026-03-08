package com.dananghub.controller;

import com.dananghub.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * One-time servlet to create Coupons and Reviews tables.
 * Access via: /init-tables
 */
@WebServlet("/init-tables")
public class InitTablesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<h2>Creating Coupons & Reviews tables...</h2>");

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            // Create Coupons table
            em.createNativeQuery("""
                CREATE TABLE IF NOT EXISTS "Coupons" (
                    "CouponId"       SERIAL PRIMARY KEY,
                    "Code"           VARCHAR(50) NOT NULL UNIQUE,
                    "DiscountType"   VARCHAR(20) NOT NULL DEFAULT 'percent',
                    "DiscountValue"  DOUBLE PRECISION NOT NULL DEFAULT 0,
                    "MinOrderAmount" DOUBLE PRECISION DEFAULT 0,
                    "MaxDiscount"    DOUBLE PRECISION DEFAULT NULL,
                    "UsageLimit"     INT DEFAULT NULL,
                    "UsedCount"      INT DEFAULT 0,
                    "StartDate"      TIMESTAMP DEFAULT NOW(),
                    "EndDate"        TIMESTAMP DEFAULT NULL,
                    "IsActive"       BOOLEAN DEFAULT TRUE,
                    "Description"    VARCHAR(255),
                    "CreatedAt"      TIMESTAMP DEFAULT NOW()
                )
            """).executeUpdate();
            out.println("<p>✅ Coupons table created</p>");

            // Create Reviews table
            em.createNativeQuery("""
                CREATE TABLE IF NOT EXISTS "Reviews" (
                    "ReviewId"   SERIAL PRIMARY KEY,
                    "TourId"     INT NOT NULL REFERENCES "Tours"("TourId") ON DELETE CASCADE,
                    "UserId"     INT NOT NULL REFERENCES "Users"("UserId") ON DELETE CASCADE,
                    "Rating"     INT NOT NULL CHECK ("Rating" >= 1 AND "Rating" <= 5),
                    "Comment"    TEXT,
                    "CreatedAt"  TIMESTAMP DEFAULT NOW(),
                    "UpdatedAt"  TIMESTAMP DEFAULT NOW(),
                    UNIQUE("TourId", "UserId")
                )
            """).executeUpdate();
            out.println("<p>✅ Reviews table created</p>");

            // Create indexes
            em.createNativeQuery("CREATE INDEX IF NOT EXISTS idx_reviews_tour ON \"Reviews\"(\"TourId\")").executeUpdate();
            em.createNativeQuery("CREATE INDEX IF NOT EXISTS idx_reviews_user ON \"Reviews\"(\"UserId\")").executeUpdate();
            em.createNativeQuery("CREATE INDEX IF NOT EXISTS idx_coupons_code ON \"Coupons\"(\"Code\")").executeUpdate();
            out.println("<p>✅ Indexes created</p>");

            // Insert sample coupons
            em.createNativeQuery("""
                INSERT INTO "Coupons" ("Code", "DiscountType", "DiscountValue", "MinOrderAmount", "MaxDiscount", "UsageLimit", "Description", "EndDate")
                VALUES
                    ('WELCOME10', 'percent', 10, 500000, 200000, 100, 'Giảm 10% cho khách hàng mới (tối đa 200K)', '2026-12-31 23:59:59'),
                    ('SUMMER50K', 'fixed', 50000, 300000, NULL, 200, 'Giảm 50,000đ cho đơn từ 300K', '2026-09-30 23:59:59'),
                    ('VIP20', 'percent', 20, 1000000, 500000, 50, 'Giảm 20% cho đơn từ 1 triệu (tối đa 500K)', '2026-12-31 23:59:59'),
                    ('FREESHIP', 'fixed', 100000, 0, NULL, 500, 'Giảm 100,000đ - Ưu đãi đặc biệt', '2026-06-30 23:59:59'),
                    ('DANANG2026', 'percent', 15, 200000, 300000, 1000, 'Giảm 15% mừng năm mới 2026', '2026-12-31 23:59:59')
                ON CONFLICT ("Code") DO NOTHING
            """).executeUpdate();
            out.println("<p>✅ Sample coupons inserted</p>");

            tx.commit();
            out.println("<h3>🎉 All done! Tables created successfully.</h3>");
            out.println("<p><a href='cart'>Go to Cart</a> | <a href='tour'>Browse Tours</a></p>");

        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            out.println("<p>❌ Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
