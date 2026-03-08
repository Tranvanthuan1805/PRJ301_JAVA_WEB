package com.dananghub.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {

    private static final String PERSISTENCE_UNIT = "DaNangTravelHubPU";
    private static volatile EntityManagerFactory emf;
    private static String initError = null;
    private static int retryCount = 0;
    private static final int MAX_RETRIES = 3;

    private static synchronized void init() {
        if (emf != null && emf.isOpen()) return;
        
        // If previous init failed, wait before retry to let Supabase release connections
        if (retryCount > 0) {
            try {
                long waitMs = retryCount * 2000L; // 2s, 4s, 6s
                System.out.println(">>> JPAUtil: Retry " + retryCount + "/" + MAX_RETRIES + ", waiting " + waitMs + "ms...");
                Thread.sleep(waitMs);
            } catch (InterruptedException ie) {
                Thread.currentThread().interrupt();
            }
        }
        
        try {
            System.out.println(">>> JPAUtil: Dang khoi tao EntityManagerFactory...");
            
            // Close existing broken factory if any
            if (emf != null) {
                try { emf.close(); } catch (Exception e) { /* ignore */ }
                emf = null;
            }
            
            emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT);
            initError = null;
            retryCount = 0;
            System.out.println(">>> JPAUtil: EntityManagerFactory THANH CONG!");
        } catch (Exception e) {
            initError = e.getMessage();
            retryCount++;
            System.err.println(">>> JPAUtil: LOI khoi tao EntityManagerFactory! (retry " + retryCount + ")");
            System.err.println(">>> Chi tiet: " + e.getMessage());
            Throwable cause = e;
            while (cause.getCause() != null) {
                cause = cause.getCause();
                System.err.println(">>> Root cause: " + cause.getClass().getSimpleName() + " - " + cause.getMessage());
            }
        }
    }

    public static EntityManager getEntityManager() {
        if (emf == null || !emf.isOpen()) {
            // Try multiple times to establish connection
            for (int i = 0; i < MAX_RETRIES; i++) {
                init();
                if (emf != null && emf.isOpen()) break;
            }
        }
        if (emf == null || !emf.isOpen()) {
            throw new RuntimeException("JPA khong the ket noi database. Error: " + initError);
        }
        
        EntityManager em = emf.createEntityManager();
        return em;
    }

    /**
     * Reset the factory - forces reconnection on next getEntityManager() call.
     * Use this when connection errors are detected.
     */
    public static synchronized void reset() {
        System.out.println(">>> JPAUtil: Resetting EntityManagerFactory...");
        if (emf != null) {
            try { emf.close(); } catch (Exception e) { /* ignore */ }
            emf = null;
        }
        retryCount = 0;
        initError = null;
    }

    public static boolean isOpen() {
        return emf != null && emf.isOpen();
    }

    public static String getInitError() {
        return initError;
    }

    public static void shutdown() {
        if (emf != null && emf.isOpen()) {
            emf.close();
            System.out.println(">>> JPAUtil: EntityManagerFactory closed");
        }
    }
}
