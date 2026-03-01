<%@ page import="com.dananghub.util.JPAUtil" %>
    <%@ page import="jakarta.persistence.EntityManager" %>
        <%@ page contentType="text/html;charset=UTF-8" %>
            <html>

            <body>
                <h2>JPA Connection Test</h2>
                <% try { EntityManager em=JPAUtil.getEntityManager(); if (em !=null && em.isOpen()) { out.println("<p
                    style='color:green'>SUCCESS: JPA EntityManager is open!</p>");
                    Object result = em.createNativeQuery("SELECT 1").getSingleResult();
                    out.println("<p style='color:green'>SUCCESS: Native Query SELECT 1 returned " + result + "</p>");
                    em.close();
                    } else {
                    out.println("<p style='color:red'>FAILURE: EntityManager is null or closed.</p>");
                    }
                    } catch (Exception e) {
                    out.println("<p style='color:red'>FAILURE: " + e.getMessage() + "</p>");
                    e.printStackTrace(new java.io.PrintWriter(out));
                    }
                    %>
            </body>

            </html>