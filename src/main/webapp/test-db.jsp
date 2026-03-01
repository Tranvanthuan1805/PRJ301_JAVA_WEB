<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.dananghub.util.JPAUtil" %>
<%@ page import="jakarta.persistence.EntityManager" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html><head><title>DB Test</title></head>
<body style="font-family:monospace;padding:30px;background:#1e293b;color:#e2e8f0">
<h1 style="color:#60a5fa">🔍 Database Diagnostic</h1>
<%
    StringBuilder sb = new StringBuilder();
    try {
        sb.append("✅ JPAUtil.isOpen(): ").append(JPAUtil.isOpen()).append("<br>");
        if (JPAUtil.getInitError() != null) {
            sb.append("❌ Init Error: ").append(JPAUtil.getInitError()).append("<br>");
        }
        
        EntityManager em = JPAUtil.getEntityManager();
        sb.append("✅ EntityManager created<br>");
        
        // Test 1: Count Roles
        Long roleCount = (Long) em.createQuery("SELECT COUNT(r) FROM Role r").getSingleResult();
        sb.append("✅ Roles count: ").append(roleCount).append("<br>");
        
        // Test 2: List Roles
        List roles = em.createQuery("SELECT r.roleName FROM Role r").getResultList();
        sb.append("✅ Roles: ").append(roles).append("<br>");
        
        // Test 3: Count Users
        Long userCount = (Long) em.createQuery("SELECT COUNT(u) FROM User u").getSingleResult();
        sb.append("✅ Users count: ").append(userCount).append("<br>");
        
        // Test 4: List usernames
        List usernames = em.createQuery("SELECT u.username FROM User u").getResultList();
        sb.append("✅ Usernames: ").append(usernames).append("<br>");
        
        // Test 5: Check admin user hash
        try {
            Object[] adminInfo = (Object[]) em.createQuery(
                "SELECT u.username, u.passwordHash FROM User u WHERE u.username = 'admin'")
                .getSingleResult();
            sb.append("✅ Admin hash in DB: ").append(adminInfo[1]).append("<br>");
            
            // Expected hash for "123456"
            String expected = com.dananghub.util.PasswordUtil.hashSHA256("123456");
            sb.append("✅ Expected hash (123456): ").append(expected).append("<br>");
            sb.append("✅ Match: ").append(expected.equals(adminInfo[1])).append("<br>");
        } catch (Exception e) {
            sb.append("⚠️ Admin user not found: ").append(e.getMessage()).append("<br>");
        }
        
        // Test 6: Count Tours
        Long tourCount = (Long) em.createQuery("SELECT COUNT(t) FROM Tour t").getSingleResult();
        sb.append("✅ Tours count: ").append(tourCount).append("<br>");
        
        // Test 7: Count Orders
        Long orderCount = (Long) em.createQuery("SELECT COUNT(o) FROM Order o").getSingleResult();
        sb.append("✅ Orders count: ").append(orderCount).append("<br>");
        
        em.close();
        sb.append("<br><h2 style='color:#22c55e'>🎉 ALL TESTS PASSED!</h2>");
        
    } catch (Exception e) {
        sb.append("<br><h2 style='color:#ef4444'>❌ ERROR</h2>");
        sb.append("Type: ").append(e.getClass().getSimpleName()).append("<br>");
        sb.append("Message: ").append(e.getMessage()).append("<br>");
        Throwable root = e;
        while (root.getCause() != null) root = root.getCause();
        sb.append("Root: ").append(root.getClass().getSimpleName()).append(" - ").append(root.getMessage()).append("<br>");
    }
    out.println(sb.toString());
%>
</body></html>